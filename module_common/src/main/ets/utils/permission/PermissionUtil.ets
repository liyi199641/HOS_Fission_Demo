import { abilityAccessCtrl, bundleManager, common, Permissions, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { concatMap, from, takeWhile, tap, finalize, subscribeOn } from 'rxjs';
import { AppUtil } from '../AppUtil';
import { PermissionGroupUtil } from './PermissionGroup';

/**
 * 权限申请工具类
 */
export class PermissionUtil {
  private static instance: PermissionUtil;
  private atManager: abilityAccessCtrl.AtManager;
  private tokenId: number = 0;

  constructor() {
    this.atManager = abilityAccessCtrl.createAtManager();
    // 获取应用程序的accessTokenID
    try {
      let bundleInfo: bundleManager.BundleInfo = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      this.tokenId = appInfo.accessTokenId;
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      console.error(`Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`);
    }

  }

  public static getInstance(): PermissionUtil {
    if (!PermissionUtil.instance) {
      PermissionUtil.instance = new PermissionUtil();
    }
    return PermissionUtil.instance;
  }

  /**
   * 检查是否有某个权限
   * @param permission
   * @returns
   */
  public checkPermissionsSync(permission: Permissions): boolean {
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;
    // 校验应用是否被授予权限
    try {
      grantStatus = this.atManager.checkAccessTokenSync(this.tokenId, permission);
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
    }
    return grantStatus == abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED;
  }

  /**
   * 请求某些权限
   * @param context
   * @param permissions
   * @param callBack
   */
  public reqPermissionsFromUser(context: common.UIAbilityContext | common.UIExtensionContext, permissions: Array<Permissions>, callBack: Callback<Array<Permissions>>) {
    this.atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      let defiedPermission: Array<Permissions> = new Array();
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] != abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
          defiedPermission.push(permissions[i]);
        }
      }
      callBack(defiedPermission);
    }).catch((err: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    });
  }

  /**
   * 二次拉取权限弹窗
   * @param context
   * @param permissions 必须属于同一个权限组，并且在module.json5中声明
   * 多权限并不属于一个任务组的情况，推荐跳转到系统设置界面(gotoSettingPage)
   */
  public requestPermissionOnSettingByRxjs(context: common.UIAbilityContext | common.UIExtensionContext, permissionsArray: Array<Permissions>): Promise<boolean> {
    console.log('申请的权限：\n' + JSON.stringify(permissionsArray));
    permissionsArray = this.filterDeniedPermissions(permissionsArray)
    console.log('过滤未授权的权限：\n' + JSON.stringify(permissionsArray));
    let formatPermissions = PermissionGroupUtil.PermissionGrouping(permissionsArray)
    console.log('分组的权限：\n' + JSON.stringify(formatPermissions));
    let terminated = false; // 标识流程是否被终止

    return new Promise<boolean>((resolve) => {
      from(formatPermissions).pipe(
        concatMap(permissions =>
        from(this.atManager.requestPermissionOnSetting(context, permissions)).pipe(
          tap(result => {
            console.log("result: " + JSON.stringify(result));
            for (let i = 0; i < result.length; i++) {
              if (result[i] !== abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
                terminated = true; // 如果结果不是0，标记为终止
              }
            }
          })
        )
        ),
        takeWhile(() =>!terminated), // 如果terminated为true，停止处理
        finalize(() => {
          console.log("finalize");
          resolve(!terminated)
        })
      ).subscribe();
    })
  }

  public async requestPermissionOnSetting(context: common.UIAbilityContext | common.UIExtensionContext, permissionsArray: Array<Permissions>): Promise<boolean> {
    console.log('申请的权限：\n' + JSON.stringify(permissionsArray));
    permissionsArray = this.filterDeniedPermissions(permissionsArray)
    console.log('过滤未授权的权限：\n' + JSON.stringify(permissionsArray));
    let formatPermissions = PermissionGroupUtil.PermissionGrouping(permissionsArray)
    console.log('分组的权限：\n' + JSON.stringify(formatPermissions));

    for (const array of formatPermissions) {
      try {
        const result = await this.atManager.requestPermissionOnSetting(context, array)
        console.log("Result:", result);
        for (let i = 0; i < result.length; i++) {
          if (result[i] !== abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
            return false;
          }
        }
      } catch (error) {
        console.error("Error:", error);
        return false; // 发生错误时，直接返回 false
      }
    }
    // 全部成功，返回 true
    return true;
  }

  /**
   * 过滤得到未授权的权限
   * @param permissionsArray
   * @returns
   */
  private filterDeniedPermissions(permissionsArray: Array<Permissions>): Array<Permissions> {
    let permissionDeniedArray = new Array<Permissions>();
    permissionsArray.forEach(permissions => {
      if (!this.checkPermissionsSync(permissions)) {
        permissionDeniedArray.push(permissions)
      }
    })
    return permissionDeniedArray
  }


  /**
   * 跳转系统设置
   * @param context
   */
  public gotoSettingPage(context: common.UIAbilityContext | common.UIExtensionContext) {
    let wantInfo: Want = {
      bundleName: 'com.huawei.hmos.settings',
      abilityName: 'com.huawei.hmos.settings.MainAbility',
      uri: 'application_info_entry',
      parameters: {
        pushParams: AppUtil.getBundleInfoForSelfSync().name // 打开指定应用的详情页面
      }
    }

    context.startAbility(wantInfo).then(() => {
      // 跳转成功
    }).catch((err: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })

  }
}
