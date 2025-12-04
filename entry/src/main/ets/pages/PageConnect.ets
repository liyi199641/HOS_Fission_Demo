import { PermissionUtil, ResourceUtil } from 'module_common';
import { common, Permissions, WantAgent, wantAgent } from '@kit.AbilityKit';
import { ble } from '@kit.ConnectivityKit';
import { DeviceInfo,FissionSdkManager } from 'fission_sdk';

import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';
import { backgroundTaskManager } from '@kit.BackgroundTasksKit';
import { BusinessError } from '@kit.BasicServicesKit';

class DividerTmp {
  strokeWidth: Length = 1
  startMargin: Length = 60
  endMargin: Length = 10
  color: ResourceColor = '#ffe9f0f0'

  constructor(strokeWidth: Length, startMargin: Length, endMargin: Length, color: ResourceColor) {
    this.strokeWidth = strokeWidth
    this.startMargin = startMargin
    this.endMargin = endMargin
    this.color = color
  }
}

@HMRouter({ pageUrl: PageConstant.DEVICE_CONNECT, lifecycle: 'ExitLifecycle' })
@Component
export struct PageConnect {
  context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  pathStack: NavPathStack = new NavPathStack()
  @State @Watch('onCountUpdated') devices: Array<DeviceInfo> = []
  @State devicesMac: Array<string> = []
  @State egDivider: DividerTmp = new DividerTmp(1, 60, 10, '#ffe9f0f0');
  @State scanning: boolean = false; //扫描中

  // @Watch 回调
  onCountUpdated(propName: string): void {
    let curMac: Array<string> = []
    this.devices.forEach(device => {
      curMac.push(device.deviceId)
    })
    this.devicesMac = curMac;
  }

  aboutToAppear(): void {
    this.btnClick();
    // 订阅eventId为1的事件
    // emitter.on(this.event, callback);

    ResourceUtil.String.getString('common_app').then((res: string) => {
      console.log("获取到文本：" + res)
    })
    // console.log("获取到文本 Resource Sync方式：" + ResourceUtil.String.getStringSync($r('app.string.app_name').id, 'Json', 22, '中国'))
    // console.log("获取到文本 Resource Sync方式：" + ResourceUtil.String.getStringSync($r('app.string.common_app_name').id, 'Json', 22, '中国'))
    // console.log("获取到文本 Resource 异步方式：" + ResourceUtil.String.getString($r('app.string.common_app_name').id), '中国', 'Alaon', 22)
    //
    // console.log("月份开始： " + DateUtil.formatDate(DateUtil.getMonthOfStart(Date.now()), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getMonthOfStart(Date.now()))
    // console.log("月份结束： " + DateUtil.formatDate(DateUtil.getMonthOfEnd(Date.now()), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getMonthOfEnd(Date.now()))
    //
    //
    // console.log("月份开始： " + DateUtil.formatDate(DateUtil.getMonthOfStart(1735660799000), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getMonthOfStart(1735660799000))
    // console.log("月份结束： " + DateUtil.formatDate(DateUtil.getMonthOfEnd(1735660799000), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getMonthOfEnd(1735660799000))
    //
    // console.log("年份开始： " + DateUtil.formatDate(DateUtil.getStartOfYear(Date.now()), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getStartOfYear(Date.now()))
    // console.log("年份结束： " + DateUtil.formatDate(DateUtil.getEndOfYear(Date.now()), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getEndOfYear(Date.now()))
    //
    // console.log("周开始： " + DateUtil.formatDate(DateUtil.getStartOfWeek(1727597429000), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getStartOfWeek(1727597429000))
    // console.log("周结束： " + DateUtil.formatDate(DateUtil.getEndOfWeek(1727597429000), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getEndOfWeek(1727597429000))
    //
    // console.log("日开始： " + DateUtil.formatDate(DateUtil.getStartOfDay(Date.now()), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getStartOfDay(Date.now()))
    // console.log("日结束： " + DateUtil.formatDate(DateUtil.getEndOfDay(Date.now()), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS) + "   " + DateUtil.getEndOfDay(Date.now()))


    // console.log("天数： "+DateUtil.getDaysInMonth(1709194229000));

    // DeviceUtil.getString('common_app').then((res: string) => {
    //   console.log("获取到文本：" + res)
    // })


    // console.log("获取到文本 Resource方式：" + DeviceUtil.getStringSync($r('app.string.common_app_name').id, 'Json', 22, '中国'))
    //
    // console.log("获取到文本 Resource.id方式："+DeviceUtil.getString($r('app.string.common_app_name').id),'中国','Alaon',22)
    // console.log("获取到文本 Resource方式 RTL："+DeviceUtil.getString($r('app.string.common_app_name_rtl')),'Alaon',22)

    // console.log("获取到文本 Resource plural 方式："+DeviceUtil.getPluralStringValueSync($r('app.plural.test'),1))
    // console.log("获取到文本 Resource plural str 方式："+DeviceUtil.getPluralStringValueSync('test',2))


    // StringUtil.getString($r('app.string.common_app')).then((res)=>{
    //   console.log("StringUtil 获取到文本: "+res)
    // })
  }

  btnClick() {
    this.scanning = !this.scanning;

    if (this.scanning) {
      let permissions: Array<Permissions> = ['ohos.permission.ACCESS_BLUETOOTH', 'ohos.permission.KEEP_BACKGROUND_RUNNING']
      PermissionUtil.getInstance().reqPermissionsFromUser(this.context, permissions, (defiedPermission: Array<Permissions>) => {
        if (defiedPermission.length > 0) {
          PermissionUtil.getInstance().requestPermissionOnSetting(this.context, defiedPermission).then(allAgree => {
            this.devices = [];
            this.devicesMac = [];
            this.startScanBleDevices();
          })
        } else {
          this.startScanBleDevices();
        }
      })
    } else {
      this.stopScanBleDevices();
    }

  }

  startContinuousTask() {
    let wantAgentInfo: wantAgent.WantAgentInfo = {
      // 点击通知后，将要执行的动作列表
      // 添加需要被拉起应用的bundleName和abilityName
      wants: [
        {
          bundleName: "com.linwear.anywhere",
          abilityName: "MyAbilityStage"
        }
      ],
      // 指定点击通知栏消息后的动作是拉起ability
      actionType: wantAgent.OperationType.START_ABILITY,
      // 使用者自定义的一个私有值
      requestCode: 0,
      // 点击通知后，动作执行属性
      actionFlags: [wantAgent.WantAgentFlags.UPDATE_PRESENT_FLAG]
    };

    // 通过wantAgent模块下getWantAgent方法获取WantAgent对象
    wantAgent.getWantAgent(wantAgentInfo).then((wantAgentObj: WantAgent) => {
      backgroundTaskManager.startBackgroundRunning(this.context,
        backgroundTaskManager.BackgroundMode.BLUETOOTH_INTERACTION, wantAgentObj).then(() => {
        // 此处执行具体的长时任务逻辑，如放音等。
        console.info(`Succeeded in operationing startBackgroundRunning.`);

      }).catch((err: BusinessError) => {
        console.error(`Failed to operation startBackgroundRunning. Code is ${err.code}, message is ${err.message}`);
      });
    });
  }

  startScanBleDevices() {
    FissionSdkManager.getInstance().startScanBleDevices(30 * 1000, {
      onScanResult: (deviceInfo: DeviceInfo): void => {
        try {
          let result = deviceInfo
          // if (result.connectable && result.sdkType == Constant.FISSION_SDK) {
          if (result.connectable && result.sdkType) {
            console.info('BLE scan device find result = ' + JSON.stringify(deviceInfo));
            this.devices.push(result)
          }
          this.devices.sort((a, b) => b.rssi - a.rssi)
        } catch (err) {
          console.error("出错：" + err)
        }
      },
      onScanFailure: (e: Error): void => {
        this.scanning = false;
      },
      onScanFinish: (): void => {
        this.scanning = false;
      }
    }, null)

    // FissionSdkManager.getInstance().startScanBleDevices((data: DeviceInfo) => {
    //   // console.info('BLE scan device find result = ' + JSON.stringify(data));
    //   try {
    //     let result = data
    //     if (result.connectable && result.sdkType == Constant.FISSION_SDK) {
    //       console.info('BLE scan device find result = ' + JSON.stringify(data));
    //       this.devices.push(result)
    //     }
    //     this.devices.sort((a, b) => b.rssi - a.rssi)
    //   } catch (err) {
    //     console.error("出错：" + err)
    //   }
    // }, 30)

  }

  stopScanBleDevices() {
    FissionSdkManager.getInstance().stopScanBleDevices()
    this.scanning = false;
  }

  build() {
    Column() {
      Row() {
        Text(this.scanning ? "停止" : "扫描")
          .width(100)
          .height('100%')
          .padding({ left: 20 })
          .onClick(event => {
            this.btnClick();
          })
        Text().layoutWeight(1)
        Text("SCAN")
          .fontColor(Color.Black)
          .fontSize(20)
          .width(100)
          .height('100%')
          .textAlign(TextAlign.Center)

      }.width('100%').height(50).justifyContent(FlexAlign.Center).backgroundColor(Color.Green);

      List() {
        ForEach(this.devices, (item: DeviceInfo) => {
          ListItem() {
            Row() {
              Text(item.deviceName).fontSize(16)
              Text(item.macAddress).fontSize(16).textAlign(TextAlign.End).margin({ right: 20 }).layoutWeight(1)
              Text(item.rssi + "").width(50).fontSize(10).align(Alignment.End)
            }
            .width('100%')
            .height('50')
            .backgroundColor(Color.Gray)
            .justifyContent(FlexAlign.Start)
          }.onClick(event => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId', param: item })
          })
        }, (item: ble.ScanResult) => item.deviceId)
      }
      .width('100%')
      // .height('100%')
      .layoutWeight(1)
      .divider(this.egDivider);
    }.width('100%').height('100%')

  }
}