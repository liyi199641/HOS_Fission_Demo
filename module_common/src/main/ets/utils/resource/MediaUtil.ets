import { AsyncCallback } from '@kit.BasicServicesKit'

/**
 * Media 工具类
 */
export class MediaUtil implements ResourceMediaInterface {
  getMediaSync(resourceStr: ResourceStr | number): Uint8Array {
    if (typeof resourceStr === 'string') {
      return getContext().resourceManager.getMediaByNameSync(resourceStr)
    } else if (typeof resourceStr === 'number') {
      return getContext().resourceManager.getMediaContentSync(resourceStr as number)
    } else {
      return getContext().resourceManager.getMediaContentSync((resourceStr as Resource).id)
    }
  }

  getMedia(resourceStr: number | ResourceStr): Promise<Uint8Array>

  getMedia(resourceStr: number | ResourceStr, callback: AsyncCallback<Uint8Array, void>): void

  getMedia(resourceStr: number | ResourceStr, callback?: AsyncCallback<Uint8Array, void>): void | Promise<Uint8Array> {
    if (callback) {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getMediaByName(resourceStr, callback)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getMediaContent(resourceStr as number, callback)
      } else {
        return getContext().resourceManager.getMediaContent((resourceStr as Resource).id, callback)
      }
    } else {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getMediaByName(resourceStr)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getMediaContent(resourceStr as number)
      } else {
        return getContext().resourceManager.getMediaContent((resourceStr as Resource).id)
      }
    }
  }

  getMediaContentBase64Sync(resourceStr: ResourceStr | number): string {
    if (typeof resourceStr === 'string') {
      return getContext().resourceManager.getMediaBase64ByNameSync(resourceStr)
    } else if (typeof resourceStr === 'number') {
      return getContext().resourceManager.getMediaContentBase64Sync(resourceStr as number)
    } else {
      return getContext().resourceManager.getMediaContentBase64Sync((resourceStr as Resource).id)
    }
  }

  getMediaContentBase64(resourceStr: number | ResourceStr): Promise<string>

  getMediaContentBase64(resourceStr: number | ResourceStr, callback: AsyncCallback<string, void>): void

  getMediaContentBase64(resourceStr: number | ResourceStr, callback?: AsyncCallback<string, void>): void | Promise<string> {
    if (callback) {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getMediaBase64ByName(resourceStr, callback)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getMediaContentBase64(resourceStr as number, callback)
      } else {
        return getContext().resourceManager.getMediaContentBase64((resourceStr as Resource).id, callback)
      }
    } else {
      if (typeof resourceStr === 'string') {
        return getContext().resourceManager.getMediaBase64ByName(resourceStr)
      } else if (typeof resourceStr === 'number') {
        return getContext().resourceManager.getMediaContentBase64(resourceStr as number)
      } else {
        return getContext().resourceManager.getMediaContentBase64((resourceStr as Resource).id)
      }
    }
  }
}

export interface ResourceMediaInterface {
  // 定义接口内容
  getMediaSync(resourceStr: ResourceStr | number): Uint8Array

  getMedia(resourceStr: ResourceStr | number): Promise<Uint8Array>

  getMedia(resourceStr: ResourceStr | number, callback: AsyncCallback<Uint8Array>): void

  getMediaContentBase64Sync(resourceStr: ResourceStr | number): string

  getMediaContentBase64(resourceStr: ResourceStr | number): Promise<string>

  getMediaContentBase64(resourceStr: ResourceStr | number, callback: AsyncCallback<string>): void
}