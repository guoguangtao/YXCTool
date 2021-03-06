# YXCTool
## iOS 开发工具

[toc]

### 文件解释说明

#### YXCToolHeader
* 宏定义，头文件导入
    1. `YXCLog` 输出格式自定义
    2. `kColorFromHexCode` 16进制颜色转换
    3. `kRandom_color` 随机颜色
    4. `kICustom_color` 整型自定义颜色RGBA
    5. `kFCustom_color` 浮点型自定义颜色RGBA
    6. `YXCWeakSelf` 弱引用
    7. `IPHONE_HEIGHT` 当前设备屏幕的高度
    8. `IPHONE_WIDTH` 当前设备屏幕的宽度
    9. `kIsBangsScreen` 判断当前设备是否是刘海屏幕

#### NSArray+Crash

主要是对 `NSArray`、`NSMutableArray`一些数据安全做一层判断，降低因为数据异常导致崩溃的概率

具体使用场景，可以查看 [iOS NSArray 降低 Crash 风险](https://www.jianshu.com/p/794d42de0aaf)

#### NSDictionary+Crash

主要是对 `NSDictionary`、`NSMutableDictionary` 一些数据安全做一层判断，降低因为数据异常导致崩溃的概率

具体使用场景，可以查看[iOS NSDictionary Crash 异常处理](https://www.jianshu.com/p/e56e58821233)

#### YXCImagePickerHandler
封装 UIImagePickerController 的使用

#### NSDate+Category

封装时间戳、日期、字符串三者之间的转换

#### UIDeviceName

* iPhone 和 iPad 型号定义的字符串常量

#### UIDevice+Handler

* 点设置

  ```objective-c
  #define kYXCPT(num) [UIDevice fitWithPt:(num)]
  ```

* 像素设置

  ```objective-c
  #define kYXCPX(num) [UIDevice fitWithPx:(num)]
  ```

* 获取机型

  ```objective-c
  /// 获取到机型
  - (NSString *)platform;
  ```

* 获取机型名称

  ```objective-c
  /// 获取到机型名称
  - (NSString *)platformName;
  ```

* 屏幕适配(px)
  ```Objective-c
  /// 根据像素设置实际值
  /// @param px 设计稿具体值
  + (CGFloat)fitWithPx:(CGFloat)px;
  ```

* 屏幕适配(pt)
  ```Objecive-c
  /// 根据点设置实际值
  /// @param pt 点具体值
  + (CGFloat)fitWithPt:(CGFloat)pt;
  ```

#### UIView+Category

* 主要是对 `UIView` 进行一些分类处理，比如：`x`、`y`、`center`、`width`、`height`等属性的使用
* `yxc_border` 边框，可以设置左边、右边、顶部、底部边框
* `yxc_borderWidth` 边框的宽度
* `yxc_borderColor` 边框颜色
* `yxc_removeAllSubView` 移除当前 `View` 的所有子视图
* `saveToAlbum` 将当前的 `view` 转成图片保存到相册中

#### UIControl+Category

* 扩大点击范围
    * `yxc_expandSize` 需要扩大的范围大小，`top`、`left`、`right`、`bottom` 都使用这个大小
    * `yxc_eventInterval` 防止重复点击，设置这个值使得 `UIButton` 响应一次事件之后，相隔多少秒才能再次响应事件

#### UITextField+Category

* `textMaxLength` 设置 `UITextField` 文本输入最大长度，并且解决了输入中文时字数统计的问题
* `yxc_delegate` `UITextFieldTextMaxLengthDelegate` 协议，当文本发生改变通过这个协议回调

    ```objective-c
    /// UITextField 文本发生改变代理方法
    /// @param textField UITextField输入框
    /// @param text 当前文本字符串
    /// @param textLength 当前文本字符串长度
    /// @param textMaxLength 当前输入框限制最大字符长度
    - (void)textField:(UITextField *)textField textDidChange:(NSString *)text textLength:(NSInteger)textLength textMaxLength:(NSInteger)textMaxLength;
    ```

[具体介绍](https://www.jianshu.com/p/38287c8c4be6)

#### UITextView+Category

* `textMaxLength` 设置 `UITextView` 文本输入最大长度，并且解决了输入中文时字数统计的问题

* `yxc_placeHolder` 设置 `UITextView` 的占位文字，如果 `textView` 还有初始值，请在设置  `yxc_delegate`, `textMaxLength` 属性之前，设置 `yxc_placeHolder` 和 `text`属性

* `yxc_delegate` `UITextViewTextMaxLengthDelegate` 协议，当文本发生改变通过这个协议回调

    ```objective-c
    /// TextView 文本发生改变代理方法
    /// @param textView TextView输入框
    /// @param text 当前文本字符串
    /// @param textLength 当前文本字符串长度
    /// @param textMaxLength 当前输入框限制最大字符长度
    - (void)textView:(UITextView *)textView textDidChange:(NSString *)text textLength:(NSInteger)textLength textMaxLength:(NSInteger) textMaxLength;
    ```

[具体介绍](https://www.jianshu.com/p/38287c8c4be6)

#### UIFont+Extension

* 替换系统方法 `systemFontOfSize:`、`systemFontOfSize:weight:` 实现屏幕适配

#### YXCButton

根据 `yxc_imagePosition` 枚举值,设置图片显示的位置

* `yxc_space` 图片和文件的间距
* `yxc_imagePosition` 图片显示的位置

  * YXCButtonImagePositionLeft
    ![左图右文](https://raw.githubusercontent.com/guoguangtao/VSCodePicGoImages/master/20200731143419.png)
  * YXCButtonImagePositionTop
    ![上图下文](https://raw.githubusercontent.com/guoguangtao/VSCodePicGoImages/master/20200731143458.png)
  * YXCButtonImagePositionRight
    ![左文右图](https://raw.githubusercontent.com/guoguangtao/VSCodePicGoImages/master/20200731143534.png)
  * YXCButtonImagePositionBottom
    ![上文下图](https://raw.githubusercontent.com/guoguangtao/VSCodePicGoImages/master/20200731143621.png)