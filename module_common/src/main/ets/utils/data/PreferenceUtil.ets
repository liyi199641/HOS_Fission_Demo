import { preferences, ValueType } from '@kit.ArkData';
import { util } from '@kit.ArkTS';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError, Callback } from '@kit.BasicServicesKit';

/**
 * 用户首选项工具类
 * ⚠️⚠️ 首选项无法保证进程并发安全，会有文件损坏和数据丢失的风险，不支持在多进程场景下使用。
 * ⚠️⚠️ 明文保存，一万条数据内
 */
export class PreferencesUtil {
  private preferences: preferences.Preferences;
  private context: Context
  private options: preferences.Options

  constructor(context: Context, nameValue?: string) {
    this.options = {
      name: nameValue ? nameValue : "defaultStoreName"
    };
    this.context = context
    this.preferences = preferences.getPreferencesSync(context, this.options);
  }


  /**
   * 保存值
   * @param key
   * @param value
   * number  表示值类型为数字。
   string  表示值类型为字符串。
   boolean  表示值类型为布尔值。
   Array<number>  表示值类型为数字类型的数组。
   Array<boolean>  表示值类型为布尔类型的数组。
   Array<string>  表示值类型为字符串类型的数组。
   Uint8Array11+  表示值类型为8位无符号整型的数组。
   object12+  表示值类型为对象。
   bigint12+  表示值类型为任意精度格式的整数。
   * @returns
   */
  putData(key: string,
    value: number | string | boolean | Array<number> | Array<string> | Array<boolean> | Uint8Array | object | bigint) {
    if (typeof value === 'string') { //未避免字符串还有特殊字符，这里直接转为Uint8Array类型再存储
      value = new util.TextEncoder().encodeInto(value);
    }
    this.preferences.putSync(key, value);
    this.flush();
  }

  /**
   * 获取数据
   * @param key
   * @param defaultValue
   * @returns
   */
  getData(key: string,
    defaultValue?: number | string | boolean | Array<number> | Array<string> | Array<boolean> | Uint8Array | object | bigint): number | string | boolean | Array<number> | Array<string> | Array<boolean> | object | bigint {
    let dataValue = this.preferences.getSync(key, defaultValue);
    if (dataValue instanceof Uint8Array) {
      let uInt8ArrayData: preferences.ValueType = this.preferences.getSync(key, new Uint8Array(0));
      let textDecoder = util.TextDecoder.create('utf-8');
      dataValue = textDecoder.decodeToString(uInt8ArrayData as Uint8Array)
    }
    return dataValue
  }

  /**
   * 获取Uint8Array类型数据，避免跟string 类型冲突
   * @param key
   * @param defaultValue
   * @returns
   */
  getDataUnit8Array(key: string,
    defaultValue: number | string | boolean | Array<number> | Array<string> | Array<boolean> | Uint8Array | object | bigint): number | string | boolean | Array<number> | Array<string> | Array<boolean> | Uint8Array | object | bigint {
    let dataValue = this.preferences.getSync(key, defaultValue);
    return dataValue
  }

  //是否有某个key
  hasKey(key: string): boolean {
    return this.preferences.hasSync(key)
  }

  /**
   * 从Preferences实例中删除名为给定Key的存储键值对(内存中,无法同步到file进行持久化)
   * @param key
   */
  delete(key: string) {
    this.preferences.deleteSync(key);
    this.flush();
  }

  // 清除所有数据
  clear() {
    this.preferences.clearSync();
    this.flush();
  }

  //获取所有数据
  getAllData(): Object {
    return this.preferences.getAllSync()
  }

  /**
   * 数据监听
   * 当执行flush()方法时，observer被触发回调
   * @param callback
   */
  onChange(callback: Callback<string>) {
    this.preferences.on('change', callback)
  }

  /**
   * 数据监听
   * 订阅的Key值发生变更后，当执行flush()方法时，observer被触发回调
   * @param keys 订阅的keys
   * @param callback
   */
  onDataChange(keys: Array<string>, callback?: Callback<Record<string, ValueType>>) {
    this.preferences.on('dataChange', keys, callback)
  }

  /**
   * 数据监听数据监听
   * 订阅进程间数据变更，多个进程持有同一个首选项文件时，订阅的Key的值在任意一个进程发生变更后，执行flush方法后，触发callback回调。
   * @param callback
   */
  onMultiProcessChange(callback: Callback<string>) {
    this.preferences.on('multiProcessChange', callback)
  }

  /**
   * 取消订阅数据变更。
   * @param observer
   */
  offChange(callback: Callback<string>) {
    this.preferences.off('change', callback)
  }

  offDataChange(keys: Array<string>, callback?: Callback<Record<string, ValueType>>) {
    this.preferences.off('dataChange', keys, callback)
  }

  offMultiProcessChange(callback: Callback<string>) {
    this.preferences.off('multiProcessChange', callback)
  }

  /**
   * 使用deletePreferences()方法从内存中移除指定文件对应的Preferences实例，包括内存中的数据。若该Preference存在对应的持久化文件，则同时删除该持久化文件
   */
  deletePreferences() {
    preferences.deletePreferences(this.context, this.options, (err: BusinessError) => {
      if (err) {
        console.error(`Failed to delete preferences. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info('Succeeded in deleting preferences.');
    })
  }

  /**
   * 存入文件持久化
   */
  flush() {
    this.preferences.flush()
      .then(() => {
        // hilog.info(0x0000, 'testTag', '保存数据成功');
      })
      .catch(() => {
        hilog.info(0x0000, 'testTag', '保存数据失败');
      })
      .finally(() => {
        // hilog.info(0x0000, 'testTag', '保存数据结束');
      })

    // this.preferences.flush((err: BusinessError) => {
    //   if (err) {
    //     console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
    //     return;
    //   }
    //   console.info('Succeeded in flushing.');
    // })
  }
}
