import { AsyncCallback } from '@kit.BasicServicesKit'
import { resourceManager } from '@kit.LocalizationKit'

/**
 * RawFile 工具类
 */
export class RawFileUtil implements ResourceRawFileInterface {
  getRawFileContentSync(path: string): Uint8Array {
    return getContext().resourceManager.getRawFileContentSync(path);
  }

  getRawFileContent(path: string, callback: AsyncCallback<Uint8Array, void>): void

  getRawFileContent(path: string): Promise<Uint8Array>

  getRawFileContent(path: string, callback?: AsyncCallback<Uint8Array, void>): void | Promise<Uint8Array> {
    if (callback) {
      return getContext().resourceManager.getRawFileContent(path, callback);
    } else {
      return getContext().resourceManager.getRawFileContent(path);
    }
  }

  /**
   * 获取resources/rawfile目录下文件夹及文件列表，使用同步形式返回。
   * 若文件夹中无文件，则不返回；若文件夹中有文件，则返回文件夹及文件列表。
   *
   * @param path 空代表跟目录
   * @returns
   */
  getRawFileListSync(path: string): string[] {
    return getContext().resourceManager.getRawFileListSync(path)
  }

  getRawFileList(path: string, callback: AsyncCallback<string[], void>): void

  getRawFileList(path: string): Promise<string[]>

  getRawFileList(path: string, callback?: AsyncCallback<string[], void>): void | Promise<string[]> {
    if (callback) {
      return getContext().resourceManager.getRawFileList(path, callback);
    } else {
      return getContext().resourceManager.getRawFileList(path);
    }
  }

  getRawFdSync(path: string): resourceManager.RawFileDescriptor {
    return getContext().resourceManager.getRawFdSync(path);
  }

  getRawFd(path: string, callback: AsyncCallback<resourceManager.RawFileDescriptor, void>): void

  getRawFd(path: string): Promise<resourceManager.RawFileDescriptor>

  getRawFd(path: string, callback?: AsyncCallback<resourceManager.RawFileDescriptor, void>): void | Promise<resourceManager.RawFileDescriptor> {
    if (callback) {
      return getContext().resourceManager.getRawFd(path, callback);
    } else {
      return getContext().resourceManager.getRawFd(path);
    }
  }

  closeRawFdSync(path: string): void {
    return getContext().resourceManager.closeRawFdSync(path);
  }

  closeRawFd(path: string, callback: AsyncCallback<void, void>): void

  closeRawFd(path: string): Promise<void>

  closeRawFd(path: string, callback?: AsyncCallback<void, void>): void | Promise<void> {
    if (callback) {
      return getContext().resourceManager.closeRawFd(path, callback);
    } else {
      return getContext().resourceManager.closeRawFd(path);
    }
  }

}

export interface ResourceRawFileInterface {
  // // 定义接口内容
  // getMediaSync(resourceStr: ResourceStr | number): Uint8Array

  getRawFileContentSync(path: string): Uint8Array

  getRawFileContent(path: string, callback: AsyncCallback<Uint8Array>): void

  getRawFileContent(path: string): Promise<Uint8Array>

  getRawFileListSync(path: string): Array<string>

  getRawFileList(path: string, callback: AsyncCallback<Array<string>>): void

  getRawFileList(path: string): Promise<Array<string>>

  getRawFdSync(path: string): resourceManager.RawFileDescriptor

  getRawFd(path: string, callback: AsyncCallback<resourceManager.RawFileDescriptor>): void

  getRawFd(path: string): Promise<resourceManager.RawFileDescriptor>

  closeRawFdSync(path: string): void

  closeRawFd(path: string, callback: AsyncCallback<void>): void

  closeRawFd(path: string): Promise<void>

}