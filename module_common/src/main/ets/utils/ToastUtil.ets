import promptAction from '@ohos.promptAction';
import { ToastOptions } from '@pura/harmony-utils';
import { ToastConfig } from './toast/ToastConfig';

/**
 * 吐司工具类
 */
export class ToastUtil {

  private constructor() {}

  private static defaultConfig: ToastConfig = new ToastConfig(); //默认样式

  /**
   * 设置默认统一样式
   * @param configs
   */
  static setDefaultConfig(configs: (config: ToastConfig) => void): void {
    configs(ToastUtil.defaultConfig);
  }


  /**
   * 弹出土司,默认时长为2s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (显示时长、距离屏幕底部的位置、是否显示在应用之上)
   */
  static showToast(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      promptAction.showToast({
        message: message,
        duration: options?.duration ?? ToastUtil.defaultConfig.duration,
        showMode: options?.showMode ?? ToastUtil.defaultConfig.showMode,
        alignment: options?.alignment ?? ToastUtil.defaultConfig.alignment,
        offset: options?.offset ?? ToastUtil.defaultConfig.offset
      })
    }
  }


  /**
   * 弹出土司,时长为:1.5s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (距离屏幕底部的位置、是否显示在应用之上)
   */
  static showShort(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      promptAction.showToast({
        message: message,
        duration: options?.duration ?? ToastUtil.defaultConfig.duration_short,
        showMode: options?.showMode ?? ToastUtil.defaultConfig.showMode,
        alignment: options?.alignment ?? ToastUtil.defaultConfig.alignment,
        offset: options?.offset ?? ToastUtil.defaultConfig.offset
      })
    }
  }


  /**
   * 弹出土司,时长为:10s,距离底部默认为80vp
   * @param message 提示消息
   * @param options (距离屏幕底部的位置、是否显示在应用之上)
   */
  static showLong(message: string | Resource, options?: ToastOptions) {
    if ((typeof message === 'string' && message.length > 0) || message) {
      promptAction.showToast({
        message: message,
        duration: options?.duration ?? ToastUtil.defaultConfig.duration_long,
        showMode: options?.showMode ?? ToastUtil.defaultConfig.showMode,
        alignment: options?.alignment ?? ToastUtil.defaultConfig.alignment,
        offset: options?.offset ?? ToastUtil.defaultConfig.offset
      })
    }
  }
}




