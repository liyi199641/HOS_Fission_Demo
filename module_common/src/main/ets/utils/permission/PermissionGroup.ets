import { Permissions } from '@kit.AbilityKit';
import { HashMap } from '@kit.ArkTS';

export class PermissionGroupUtil {
  /**
   * 分组权限数组
   * @param permissions
   * @returns
   */
  public static PermissionGrouping(permissions: Array<Permissions>): Array<Array<Permissions>> {
    let permissionGroupArray = new Array<Array<Permissions>>();
    if (permissions.length == 0) {
      return permissionGroupArray;
    }
    if (permissions.length == 1) {
      permissionGroupArray.push(permissions)
      return permissionGroupArray;
    }

    let map: HashMap<number, Permissions[]> = new HashMap();
    // 遍历数组，将每个数字归类
    permissions.forEach(value => {
      let permissionType = PermissionGroupUtil.getPermissionGroup(value)
      if (!map.hasKey(permissionType)) {
        map.set(permissionType, [])
      }
      map.get(permissionType).push(value)
    });
    // 将所有归类好的数组放入结果数组
    map.forEach((value: Permissions[]) => {
      permissionGroupArray.push(value)
    });
    return permissionGroupArray;
  }


  /**
   * 得到权限的组类型
   * @param permissions
   * @returns
   */
  public static getPermissionGroup(permissions: Permissions): number {
    let group = 0
    switch (permissions) {
      case 'ohos.permission.LOCATION_IN_BACKGROUND':
      case 'ohos.permission.LOCATION':
      case 'ohos.permission.APPROXIMATELY_LOCATION':
        group = PermissionGroup.LOCATION;
        break;
      case 'ohos.permission.CAMERA':
        group = PermissionGroup.CAMERA;
        break;
      case 'ohos.permission.MICROPHONE':
        group = PermissionGroup.MICROPHONE;
        break;
      case 'ohos.permission.READ_CONTACTS':
      case 'ohos.permission.WRITE_CONTACTS':
        group = PermissionGroup.CONTACTS;
        break;
      case 'ohos.permission.READ_CALENDAR':
      case 'ohos.permission.WRITE_CALENDAR':
        group = PermissionGroup.CALENDAR;
        break;
      case 'ohos.permission.ACTIVITY_MOTION':
        group = PermissionGroup.ACTIVITY_MOTION;
        break;
      case 'ohos.permission.READ_HEALTH_DATA':
        group = PermissionGroup.READ_HEALTH_DATA;
        break;
      case 'ohos.permission.WRITE_IMAGEVIDEO':
      case 'ohos.permission.READ_IMAGEVIDEO':
      case 'ohos.permission.MEDIA_LOCATION':
        group = PermissionGroup.IMAGE_VIDEO;
        break;
      case 'ohos.permission.WRITE_AUDIO':
      case 'ohos.permission.READ_AUDIO':
        group = PermissionGroup.AUDIO;
        break;
      case 'ohos.permission.DISTRIBUTED_DATASYNC':
        group = PermissionGroup.DISTRIBUTED_DATASYNC;
        break;
      case 'ohos.permission.ACCESS_BLUETOOTH':
        group = PermissionGroup.ACCESS_BLUETOOTH;
        break;
      case 'ohos.permission.READ_PASTEBOARD':
        group = PermissionGroup.READ_PASTEBOARD;
        break;
      case 'ohos.permission.READ_WRITE_DOWNLOAD_DIRECTORY':
      case 'ohos.permission.READ_WRITE_DOCUMENTS_DIRECTORY':
        group = PermissionGroup.DIRECTORY;
        break;
      case 'ohos.permission.ACCESS_NEARLINK':
        group = PermissionGroup.ACCESS_NEARLINK;
        break;
      default:
        group = 0;
        break;
    }
    return group;
  }
}


enum PermissionGroup {
  LOCATION = 1, //位置
  CAMERA = 2, //相机
  MICROPHONE = 3, //麦克风
  CONTACTS = 4, //通讯录 ****受限
  CALENDAR = 5, //日历
  ACTIVITY_MOTION = 6, //运动数据
  READ_HEALTH_DATA = 7, //身体传感器(仅穿戴设备可申请。)
  IMAGE_VIDEO = 8, //图片和视频
  AUDIO = 9, //音乐和音频
  APP_TRACKING_CONSENT = 10, //跨应用关联
  DISTRIBUTED_DATASYNC = 11, //多设备协同
  ACCESS_BLUETOOTH = 12, //蓝牙
  READ_PASTEBOARD = 13, //剪切板 ****受限
  DIRECTORY = 14, //文件夹 (仅2in1设备可申请)
  ACCESS_NEARLINK = 15, //星闪
}