
/**
 * Data 工具类
 */
export class DataUtil implements ResourceDataInterface {
  /**
   * 获取boolean值（同步返回）
   * @param resourceStr
   * @returns
   */
  getBoolean(resourceStr: number | ResourceStr): boolean {
    if (typeof resourceStr === 'string') {
      return getContext().resourceManager.getBooleanByName(resourceStr)
    } else if (typeof resourceStr === 'number') {
      return getContext().resourceManager.getBoolean(resourceStr as number)
    } else {
      return getContext().resourceManager.getBoolean((resourceStr as Resource).id)
    }
  }

  /**
   * 获取number值（同步返回）
   * @param resourceStr
   * @returns
   */
  getNumber(resourceStr: number | ResourceStr): number {
    if (typeof resourceStr === 'string') {
      return getContext().resourceManager.getNumberByName(resourceStr)
    } else if (typeof resourceStr === 'number') {
      return getContext().resourceManager.getNumber(resourceStr as number)
    } else {
      return getContext().resourceManager.getNumber((resourceStr as Resource).id)
    }
  }
}

interface ResourceDataInterface {
  // 定义接口内容
  getBoolean(resourceStr: ResourceStr | number): boolean

  getNumber(resourceStr: ResourceStr | number): number

}
