import { promptAction } from '@kit.ArkUI';

export class ToastOptions {
  duration?: number; //显示时长(1500ms-10000ms)
  bottom?: string | number; //距离屏幕底部的位置
  showMode?: promptAction.ToastShowMode; //是否显示在应用之上
  alignment?: Alignment; //对齐方式。默认值：undefined，默认底部偏上位置。
  offset?: Offset; //在对齐方式上的偏移。 默认值：{dx:0, dy:0}，默认没有偏移。
  backgroundColor?:ResourceColor;
  textColor?: ResourceColor;
  backgroundBlurStyle?: BlurStyle;
  shadow?: ShadowOptions | ShadowStyle;
}