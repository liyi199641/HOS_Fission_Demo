import { AsyncCallback } from '@kit.BasicServicesKit'

/**
 * 字符类工具类
 */
export class StringUtil implements ResourceStringInterface {
  getString(resourceStr: number | ResourceStr): Promise<string>

  getString(resourceStr: number | ResourceStr, callback: AsyncCallback<string, void>): void

  getString(resourceStr: number | ResourceStr, callback?: AsyncCallback<string, void>): void | Promise<string> {
    if (callback) {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getStringByName(resourceStr, callback)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getStringValue(resourceStr as number, callback)
      } else {
        return getContext().resourceManager.getStringValue((resourceStr as Resource).id, callback)
      }
    } else {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getStringByName(resourceStr)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getStringValue(resourceStr as number)
      } else {
        return getContext().resourceManager.getStringValue((resourceStr as Resource).id)
      }
    }
  }

  /**
   * 用户获取指定资源ID对应的字符串，使用同步方式返回。
   * @param resourceStr
   * @param args 格式化字符串资源参数
   * @returns
   */
  getStringSync(resourceStr: ResourceStr | number, ...args: (string | number)[]): string {
    if (typeof resourceStr === 'string') {
      return getContext().resourceManager.getStringByNameSync(resourceStr, ...args)
    } else if (typeof resourceStr === 'number') {
      return getContext().resourceManager.getStringSync(resourceStr as number, ...args)
    } else {
      return getContext().resourceManager.getStringSync((resourceStr as Resource).id, ...args)
    }
  }

  /**
   * 根据指定数量获取指定resource对象表示的单复数字符串，使用同步方式返回。
   * 中文环境下，字符串不区分单复数；英文环境下，字符串区分单复数。
   * @param resourceStr
   * @param num 最小值为为1
   */
  getPluralStringSync(resourceStr: ResourceStr | number, num: number): string {
    if (typeof resourceStr === 'string') {
      return getContext().resourceManager.getPluralStringByNameSync(resourceStr, num)
    } else if (typeof resourceStr === 'number') {
      return getContext().resourceManager.getPluralStringValueSync(resourceStr as number, num)
    } else {
      return getContext().resourceManager.getPluralStringValueSync((resourceStr as Resource).id, num)
    }
  }

  getPluralString(resourceStr: number | ResourceStr, num: number): Promise<string>

  getPluralString(resourceStr: number | ResourceStr, num: number, callback: AsyncCallback<string, void>): void

  getPluralString(resourceStr: number | ResourceStr, num: number, callback?: AsyncCallback<string, void>): void | Promise<string> {
    if (callback) {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getPluralStringByName(resourceStr, num, callback)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getPluralStringValue(resourceStr as number, num, callback)
      } else {
        return getContext().resourceManager.getPluralStringValue((resourceStr as Resource).id, num, callback)
      }
    } else {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getPluralStringByName(resourceStr, num)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getPluralStringValue(resourceStr as number, num)
      } else {
        return getContext().resourceManager.getPluralStringValue((resourceStr as Resource).id, num)
      }
    }
  }

  /**
   * 用户获取指定资源名称对应的字符串数组，使用同步方式返回。
   * @param resourceStr
   * @returns
   */
  getStringArrayValueSync(resourceStr: ResourceStr | number): string[] {
    if (typeof resourceStr === 'string') {
      return getContext().resourceManager.getStringArrayByNameSync(resourceStr)
    } else if (typeof resourceStr === 'number') {
      return getContext().resourceManager.getStringArrayValueSync(resourceStr as number)
    } else {
      return getContext().resourceManager.getStringArrayValueSync((resourceStr as Resource).id)
    }
  }

  getStringArrayValue(resourceStr: number | ResourceStr): Promise<string[]>

  getStringArrayValue(resourceStr: number | ResourceStr, callback: AsyncCallback<string[], void>): void

  getStringArrayValue(resourceStr: number | ResourceStr, callback?: AsyncCallback<string[], void>): void | Promise<string[]> {
    if (callback) {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getStringArrayByName(resourceStr, callback)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getStringArrayValue(resourceStr as number, callback)
      } else {
        return getContext().resourceManager.getStringArrayValue((resourceStr as Resource).id, callback)
      }
    } else {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getStringArrayByName(resourceStr)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getStringArrayValue(resourceStr as number)
      } else {
        return getContext().resourceManager.getStringArrayValue((resourceStr as Resource).id)
      }
    }
  }
}

interface ResourceStringInterface {
  // 定义接口内容
  getStringSync(resourceStr: ResourceStr | number, ...args: Array<string | number>): string

  getString(resourceStr: ResourceStr | number): Promise<string>

  getString(resourceStr: ResourceStr | number, callback: AsyncCallback<string>): void

  getPluralStringSync(resourceStr: ResourceStr | number, num: number): string

  getPluralString(resourceStr: ResourceStr | number, num: number): Promise<string>

  getPluralString(resourceStr: ResourceStr | number, num: number, callback: AsyncCallback<string>): void

  getStringArrayValueSync(resourceStr: ResourceStr | number): Array<string>

  getStringArrayValue(resourceStr: ResourceStr | number): Promise<Array<string>>

  getStringArrayValue(resourceStr: ResourceStr | number, callback: AsyncCallback<Array<string>>): void

}