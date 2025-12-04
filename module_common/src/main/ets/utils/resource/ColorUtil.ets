import { AsyncCallback } from '@kit.BasicServicesKit'

/**
 * Color 工具类
 */
export class ColorUtil implements ResourceStringInterface {
  /**
   * 获取颜色
   * @param resourceStr
   * @returns
   */
  getColorSync(resourceStr: ResourceStr | number): number {
    if (typeof resourceStr === 'string') {
      return getContext().resourceManager.getColorByNameSync(resourceStr)
    } else if (typeof resourceStr === 'number') {
      return getContext().resourceManager.getColorSync(resourceStr as number)
    } else {
      return getContext().resourceManager.getColorSync((resourceStr as Resource).id)
    }
  }

  getColor(resourceStr: number | ResourceStr): Promise<number>

  getColor(resourceStr: number | ResourceStr, callback: AsyncCallback<number, void>): void

  getColor(resourceStr: number | ResourceStr, callback?: AsyncCallback<number, void>): void | Promise<number> {
    if (callback) {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getColorByName(resourceStr, callback)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getColor(resourceStr as number, callback)
      } else {
        return getContext().resourceManager.getColor((resourceStr as Resource).id, callback)
      }
    } else {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getColorByName(resourceStr)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getColor(resourceStr as number)
      } else {
        return getContext().resourceManager.getColor((resourceStr as Resource).id)
      }
    }
  }
}

interface ResourceStringInterface {
  // 定义接口内容
  getColorSync(resourceStr: ResourceStr | number): number

  getColor(resourceStr: ResourceStr | number): Promise<number>

  getColor(resourceStr: ResourceStr | number, callback: AsyncCallback<number>): void
}
