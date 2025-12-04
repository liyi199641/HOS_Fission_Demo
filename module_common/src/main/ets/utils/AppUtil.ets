import { bundleManager } from '@kit.AbilityKit';
import i18n from '@ohos.i18n';
import featureAbility from '@ohos.ability.featureAbility';

export class AppUtil {
  /**
   * https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-bundlemanager-V5#bundleflag
   *{
   "name":"com.linwear.anywhere",
   "vendor":"example",
   "versionCode":1000000,
   "versionName":"1.0.0",
   "minCompatibleVersionCode":1000000,
   "targetVersion":50000012,
   "appInfo":null,
   "hapModulesInfo":[
   ],
   "reqPermissionDetails":[
   ],
   "permissionGrantStates":[
   ],
   "signatureInfo":null,
   "installTime":1724392986741,
   "updateTime":1725331998759,
   "routerMap":[
   ],
   "appIndex":0
   }
   */

  // let bundleInfo:bundleManager.BundleInfo | null = null
  static getPackageName(): Promise<bundleManager.BundleInfo> {
    let localBundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT
    // try {
    //   bundleManager.getBundleInfoForSelf(localBundleFlags, (err, data) => {
    //     if (err) {
    //       hilog.error(0x0000, 'testTag', 'getBundleInfoForSelf failed: %{public}s', err.message);
    //     } else {
    //       hilog.info(0x0000, 'testTag', 'getBundleInfoForSelf successfully: %{public}s', JSON.stringify(data));
    //     }
    //     return data;
    //   });
    // } catch (err) {
    //   let message = (err as BusinessError).message;
    //   hilog.error(0x0000, 'testTag', 'getBundleInfoForSelf failed: %{public}s', message);
    // }

    // return bundleManager.getBundleInfoForSelfSync(localBundleFlags).name

    return bundleManager.getBundleInfoForSelf(localBundleFlags)
  }

  static getBundleInfoForSelfSync(): bundleManager.BundleInfo {
    let localBundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT
    return bundleManager.getBundleInfoForSelfSync(localBundleFlags)
  }

  /**
   * 是编译环境模式
   * @returns
   */
  static isDebug(): boolean {
    // this.context.applicationInfo.debug
    return AppUtil.getBundleInfoForSelfSync().appInfo.debug;
  }

}