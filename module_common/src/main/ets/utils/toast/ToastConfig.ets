import { promptAction } from '@kit.ArkUI';

export class ToastConfig {
  showMode: promptAction.ToastShowMode = promptAction.ToastShowMode.DEFAULT; //是否显示在应用之上。
  alignment: Alignment = Alignment.Bottom; //对齐方式。默认值：undefined，默认底部偏上位置。
  bottom: string | number = 80;//设置弹窗边框距离屏幕底部的位置。设置了Alignment后不生效。
  offset: Offset = { dx: 0, dy: 0 } //在对齐方式上的偏移。 默认值：{dx:0, dy:0}，默认没有偏移。
  duration: number = 2000; //显示时长(1500ms-10000ms)
  duration_short: number = 1500; //显示时长(1500ms)
  duration_long: number = 10000; //显示时长(10000ms)
  backgroundColor: ResourceColor = Color.Transparent;
  textColor: ResourceColor = Color.Black;
  backgroundBlurStyle: BlurStyle = BlurStyle.COMPONENT_ULTRA_THICK;
  shadow: ShadowOptions | ShadowStyle = ShadowStyle.OUTER_DEFAULT_XS
}