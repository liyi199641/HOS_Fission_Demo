import { resourceManager } from '@kit.LocalizationKit'
import { deviceInfo } from '@kit.BasicServicesKit';
import i18n from '@ohos.i18n';
import configuration from '@system.configuration';

export class DeviceUtil {
  /**
   * 获取设备配置
   * @returns { resourceManager.Configuration } {"locale":"zh_Hans_CN","direction":0,"deviceType":0,"screenDensity":640,"colorMode":1,"mcc":0,"mnc":0}
   */
  public static getDeviceConfiguration(): resourceManager.Configuration {
    //{"locale":"zh_Hans_CN","direction":0,"deviceType":0,"screenDensity":640,"colorMode":1,"mcc":0,"mnc":0}
    return resourceManager.getSystemResourceManager().getConfigurationSync();
  }

  static getSystemLanguageAndRegion() {
    configuration.getLocale(); //{"language":"zh","countryOrRegion":"CN","dir":"ltr","unicodeSetting":"{}"}
  }


  public static getDeviceInfo() {
    let deviceTypeInfo: string = deviceInfo.deviceType;
    console.info('the value of the deviceType is :' + deviceTypeInfo);

    let manufactureInfo: string = deviceInfo.manufacture;
    console.info('the value of the manufactureInfo is :' + manufactureInfo);

    let brandInfo: string = deviceInfo.brand;
    console.info('the value of the device brand is :' + brandInfo);

    let marketNameInfo: string = deviceInfo.marketName;
    console.info('the value of the deviceInfo marketName is :' + marketNameInfo);

    let productSeriesInfo: string = deviceInfo.productSeries;
    console.info('the value of the deviceInfo productSeries is :' + productSeriesInfo);

    let productModelInfo: string = deviceInfo.productModel;
    console.info('the value of the deviceInfo productModel is :' + productModelInfo);

    let softwareModelInfo: string = deviceInfo.softwareModel;
    console.info('the value of the deviceInfo softwareModel is :' + softwareModelInfo);

    let hardwareModelInfo: string = deviceInfo.hardwareModel;
    console.info('the value of the deviceInfo hardwareModel is :' + hardwareModelInfo);

    // let serialInfo: string = deviceInfo.serial;
    // console.info('the value of the deviceInfo serial is :' + serialInfo);

    let bootloaderVersionInfo: string = deviceInfo.bootloaderVersion;
    console.info('the value of the deviceInfo bootloaderVersion is :' + bootloaderVersionInfo);

    let abiListInfo: string = deviceInfo.abiList;
    console.info('the value of the deviceInfo abiList is :' + abiListInfo);

    let securityPatchTagInfo: string = deviceInfo.securityPatchTag;
    console.info('the value of the deviceInfo securityPatchTag is :' + securityPatchTagInfo);

    let displayVersionInfo: string = deviceInfo.displayVersion;
    console.info('the value of the deviceInfo displayVersion is :' + displayVersionInfo);

    let incrementalVersionInfo: string = deviceInfo.incrementalVersion;
    console.info('the value of the deviceInfo incrementalVersion is :' + incrementalVersionInfo);

    let osReleaseTypeInfo: string = deviceInfo.osReleaseType;
    console.info('the value of the deviceInfo osReleaseType is :' + osReleaseTypeInfo);

    let osFullNameInfo: string = deviceInfo.osFullName;
    console.info('the value of the deviceInfo osFullName is :' + osFullNameInfo);

    let majorVersionInfo: number = deviceInfo.majorVersion;
    console.info('the value of the deviceInfo majorVersion is :' + majorVersionInfo);

    let seniorVersionInfo: number = deviceInfo.seniorVersion;
    console.info('the value of the deviceInfo seniorVersion is :' + seniorVersionInfo);

    let featureVersionInfo: number = deviceInfo.featureVersion;
    console.info('the value of the deviceInfo featureVersion is :' + featureVersionInfo);

    let buildVersionInfo: number = deviceInfo.buildVersion;
    console.info('the value of the deviceInfo buildVersion is :' + buildVersionInfo);

    let sdkApiVersionInfo: number = deviceInfo.sdkApiVersion;
    console.info('the value of the deviceInfo sdkApiVersion is :' + sdkApiVersionInfo);

    let firstApiVersionInfo: number = deviceInfo.firstApiVersion;
    console.info('the value of the deviceInfo firstApiVersion is :' + firstApiVersionInfo);

    let versionIdInfo: string = deviceInfo.versionId;
    console.info('the value of the deviceInfo versionId is :' + versionIdInfo);

    let buildTypeInfo: string = deviceInfo.buildType;
    console.info('the value of the deviceInfo buildType is :' + buildTypeInfo);

    let buildUserInfo: string = deviceInfo.buildUser;
    console.info('the value of the deviceInfo buildUser is :' + buildUserInfo);

    let buildHostInfo: string = deviceInfo.buildHost;
    console.info('the value of the deviceInfo buildHost is :' + buildHostInfo);

    let buildTimeInfo: string = deviceInfo.buildTime;
    console.info('the value of the deviceInfo buildTime is :' + buildTimeInfo);

    let buildRootHashInfo: string = deviceInfo.buildRootHash;
    console.info('the value of the deviceInfo buildRootHash is :' + buildRootHashInfo);

    // let udid: string = deviceInfo.udid;
    // console.info('the value of the deviceInfo udid is :' + udid);

    let distributionOSName: string = deviceInfo.distributionOSName
    console.info('the value of the deviceInfo distributionOSName is :' + distributionOSName);

    let distributionOSVersion: string = deviceInfo.distributionOSVersion
    console.info('the value of the deviceInfo distributionOSVersion is :' + distributionOSVersion);

    let distributionOSApiVersion: number = deviceInfo.distributionOSApiVersion
    console.info('the value of the deviceInfo distributionOSApiVersion is :' + distributionOSApiVersion);

    let distributionOSReleaseType: string = deviceInfo.distributionOSReleaseType
    console.info('the value of the deviceInfo distributionOSReleaseType is :' + distributionOSReleaseType);

    let odid: string = deviceInfo.ODID;
    console.info('the value of the deviceInfo odid is :' + odid);
  }

  /**
   * 获取系统语言
   * @returns
   */
  static getSystemLanguage(): string { //ug,bo,zh-Hant,en-Latn-US,zh-Hans
    return i18n.System.getSystemLanguage()
  }

  /**
   * 获取系统语言列表
   * @returns
   */
  static getSystemLanguages() { //["ug","bo","zh-Hant","en-Latn-US","zh-Hans"]
    return i18n.System.getSystemLanguages()
  }

  /**
   * 获取系统区域
   * @returns
   */
  static getSystemRegion(): string { //CN
    return i18n.System.getSystemRegion()
  }
  /**
   * 获取系统区域设置
   * @returns
   */
  static getSystemLocale(): string { //zh-Hans-CN
    return i18n.System.getSystemLocale()
  }

  /**
   * 是24小时制
   * @returns
   */
  static is24HourClock(): boolean { //zh-Hans-CN
    return i18n.System.is24HourClock()
  }

  /**
   * 获得第一首选语言
   * @returns
   */
  static getFirstPreferredLanguage(): string { //zh-Hans
    return i18n.System.getFirstPreferredLanguage()
  }

  /**
   * 是镜像
   * @param locale getSystemLocale() / getFirstPreferredLanguage 或者 语言 zh / zh-Hans
   * @returns
   */
  static isRTL(locale: string): boolean {
    return i18n.isRTL(locale)
  }


}