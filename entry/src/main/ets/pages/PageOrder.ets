import { DateUtil, PermissionUtil, StrUtil } from 'module_common';
import { common, Permissions } from '@kit.AbilityKit';
import { emitter } from '@kit.BasicServicesKit';
import { DeviceInfo } from 'fission_sdk';
import { AtCmd, BigDataCmdId, BleComConfig,BLE_STATE, FissionAtCmdResultListener, FissionSdkManager, getBindKey, LISTENER_TYPE, Logger, MacUtil, MusicConfig, SpKeys, SpUtil } from 'fission_sdk';
import { HMPopInfo, HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';
import { DividerTmp } from '../components/DividerTmp';
import { DialogParam } from '../bean/InputDialogParam';
import { showDatePickerDialog, showTextPickerDialog } from '../dialog/DialogUtil';
import { MsgBean } from '../bean/MsgBean';
import { OrderBean } from '../bean/OrderBean';
import { OrderTable } from '../bean/OrderTable';
import { InputMusicDialogParam } from '../bean/InputMusicDialogParam';
import { BigDataTimeParam } from '../bean/BigDataTimeParam';
import { ToastUtil } from '@pura/harmony-utils';
import { Constant } from '../connstant/Constant';
import { ble } from '@kit.ConnectivityKit';
@HMRouter({ pageUrl: PageConstant.HOME_PAGE_ORDER })
@Component
export struct PageOrder {
  context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  pageInfos: NavPathStack = new NavPathStack()
  @State messages: Array<MsgBean> = []
  @State egDivider: DividerTmp = new DividerTmp(1, 0, 0, Color.Gray);
  @State deviInfo: DeviceInfo | null = null;
  @State @Watch('onBleStateUpdated') bleState: number = 0;
  @State bleStateValue: string = '连接'
  @State orderTable: OrderTable[] = [
    new OrderTable(0, "AT指令", false, []),
    new OrderTable(1, "数据流&OTA升级&表盘推送", true, []),
    new OrderTable(2, "大数据指令", false, [])
  ]
  private TAG: string = 'PageOrder';
  @State timeZone: string = '0';
  @State customDialogController: CustomDialogController | null = null
  @State selectedDate: Date = new Date()
  @State timeMode: number = 0;
  @State language: number = 0;
  @State unitMode: number = 0;
  @State temperatureMode: number = 0;
  @State sto: number = 200;
  switchRange: string[] = ['关闭', '开启'];
  @State startTime: number = 0;
  @State endTime: number = Math.floor(Date.now() / 1000);
  readonly BIG_DADT_GPS: string = "BIG_DADT_GPS";

  // @Watch 回调
  onBleStateUpdated(bleState: string): void {
    switch (this.bleState) {
      case Constant.BLE_STATE_DISCONNECTING:
        this.bleStateValue = "断开中..." + this.deviInfo?.deviceName
        break;
      case Constant.BLE_STATE_DISCONNECTED:
        this.bleStateValue = "连接" + this.deviInfo?.deviceName
        break;
      case Constant.BLE_STATE_CONNECTING:
        this.bleStateValue = "连接中..." + this.deviInfo?.deviceName
        break;
      case Constant.BLE_STATE_CONNECTED:
        this.bleStateValue = "已连接" + this.deviInfo?.deviceName
        break;
      case Constant.BLE_STATE_BINDING:
        this.bleStateValue = "绑定中...." + this.deviInfo?.deviceName
        break;
      case Constant.BLE_STATE_BOUND:
        this.bleStateValue = "断开" + this.deviInfo?.deviceName
        break;
    }
  }

  onBtnClickConnect() {
    if (this.bleState < Constant.BLE_STATE_CONNECTING) {
      let that = this;
      HMRouterMgr.push({ pageUrl: PageConstant.DEVICE_CONNECT }, {
        onResult(popInfo: HMPopInfo) {
          const pageName = popInfo.srcPageInfo.name;
          // const params = popInfo.result;
          that.deviInfo = popInfo.result as DeviceInfo;
          that.connectBleDevice(that.deviInfo);
          console.log(`收到回参: from： ${pageName}, params is ${JSON.stringify(that.deviInfo)}`);
        }
      })
    } else {
      SpUtil.delete(SpKeys.LAST_DEVICE_INFO);
      FissionSdkManager.getInstance().disconnectBleDevice();
      this.bleState = Constant.BLE_STATE_DISCONNECTED;
      this.bleStateValue = '连接'
      this.deviInfo = null;
    }
  }

  aboutToAppear(): void {
    try {
      FissionSdkManager.getInstance();
      FissionSdkManager.getInstance().init(true);
      let lastDeviceInfo = SpUtil.getData(SpKeys.LAST_DEVICE_INFO, '');
      if (lastDeviceInfo) {
        this.deviInfo = lastDeviceInfo as DeviceInfo;
        this.bleStateValue = '重连中：' + this.deviInfo?.macAddress
      }
    } catch (e) {

    }
    this.customDialogController = null // 将dialogController置空
    this.creteOrderData();

    // sdkMessage的事件
    emitter.on('sdkMessage', (eventData: emitter.EventData) => {
      if (eventData.data?.content) {
        this.messages.push(new MsgBean(this.messages.length, eventData.data.content))
      }
    });

    emitter.on('sdkBleState', (eventData: emitter.EventData): void => {
      this.bleState = eventData.data?.content as number
    });


    //开启重连（有绑定的情况下）
    this.reConnect();
  }

  /**
   * 重连
   */
  public reConnect() {
    let that = this;
    let scanOutTime = 30;
    let lastDeviceInfo: DeviceInfo = SpUtil.getData(SpKeys.LAST_DEVICE_INFO) as DeviceInfo;
    console.log("重连: " + JSON.stringify(lastDeviceInfo));
    if (lastDeviceInfo) {
      let scanFilter: ble.ScanFilter = {
        // deviceId: lastDeviceInfo.deviceId,
        name: lastDeviceInfo.deviceName,
        // serviceUuid: "C2E6FFB0-E966-1000-8000-BEF9C223DF6A",
        // serviceSolicitationUuidMask:"C2E6FFB0-E966-1000-8000-BEF9C223DF6A"
      };

      let scanOptions: ble.ScanOptions = {
        interval: 200, //表示扫描结果上报延迟时间，默认值为0。
        dutyMode: ble.ScanDuty.SCAN_MODE_LOW_LATENCY,
        matchMode: ble.MatchMode.MATCH_MODE_STICKY
      };

      FissionSdkManager.getInstance().startScanBleDevices(scanOutTime * 1000, {
        onScanResult: (deviceInfo: DeviceInfo): void => {
          if (deviceInfo.macAddress === lastDeviceInfo.macAddress) {
            lastDeviceInfo.deviceId = deviceInfo.deviceId;
            FissionSdkManager.getInstance().stopScanBleDevices();
            that.connectBleDevice(lastDeviceInfo, true);
          }
        },
        onScanFailure: (e: Error): void => {
        },
        onScanFinish: (): void => {
          if (that.bleState ==  0 || that.bleState == Constant.BLE_STATE_DISCONNECTING) {
            Logger.info(`未搜索到设备，开始直连：${lastDeviceInfo.macAddress}`);
            that.connectBleDevice(lastDeviceInfo, true);
          }
        }
      }, null, scanOptions)

    } else {
      console.log("未绑定过设备,不重连");
    }
  }

  /**
   * 连接
   * @param deviceInfo
   * @param reConnect
   */
  public connectBleDevice(deviceInfo: DeviceInfo, reConnect: boolean = false) {
    let that = this;
    let bleComConfig: BleComConfig = new BleComConfig();
    let bindKey: string = '';
    if (!reConnect) {
      if (deviceInfo.deviceName != "LW22") {
        bindKey = getBindKey(deviceInfo.macAddress);
        bleComConfig.bindKeys = bindKey;
        bleComConfig.isBind = true;
      }
    } else {
      bindKey = SpUtil.getData(Constant.key_bindKey, '') as string;
      bleComConfig.bindKeys = bindKey;
      if (bindKey.length > 0) {
        bleComConfig.isBind = true;
      }
    }
    SpUtil.putData(Constant.key_bindKey, bindKey);
    this.onBleConnectListener();


    FissionSdkManager.getInstance().connectBleDevice(deviceInfo, bleComConfig,
      {
        /**
         * BLE 连接状态变化
         * @param newState
         */
        onConnectionStateChange(newState: BLE_STATE): void {
          console.log("上层：onConnectionStateChange: " + newState);
          let connectState = 0;
          switch (newState) {
            case BLE_STATE.DISCONNECTED:
              console.log(`${that.TAG} connectState: 断开连接`);
              connectState = Constant.BLE_STATE_DISCONNECTED;
              break;
            case BLE_STATE.CONNECTING:
              console.log(`${that.TAG} connectState: 连接中...`);
              connectState = Constant.BLE_STATE_CONNECTING;
              break;
            case BLE_STATE.CONNECTED:
              console.log(`${that.TAG} connectState: 已连接`);
              connectState = Constant.BLE_STATE_CONNECTED;
              break;
            case BLE_STATE.DISCONNECTING:
              console.log(`${that.TAG} connectState: 正在断开连接中。。。。`);
              connectState = Constant.BLE_STATE_DISCONNECTING;
              break;
          }
          // LinWearFissionSdk.getInstance().connectState = connectState;
          let formatEventData: emitter.EventData = {
            data: {
              content: connectState
            }
          };
          emitter.emit('sdkBleState', formatEventData)
        },

        /**
         * BLE 连接失败
         * @param throwable
         */
        onConnectionFailure(throwable: Error): void {
          console.log("上层：onConnectionFailure: " + throwable.message);
          let formatEventData: emitter.EventData = {
            data: {
              content: BLE_STATE.DISCONNECTED
            }
          };
          emitter.emit('sdkBleState', formatEventData)
        },

        /**
         * Ble 连接成功后， 绑定中/发现服务（取决于是否需要绑定）
         */
        onBinding(): void {
          console.log("上层：onBinding: ");
          let formatEventData: emitter.EventData = {
            data: {
              content: Constant.BLE_STATE_BINDING
            }
          };
          emitter.emit('sdkBleState', formatEventData)
        },

        /**
         * 绑定成功/发现服务成功 （真正意义上的连接成功，可以正常通讯）
         */
        onBindSucceeded(address: string, name: string): void {
          console.log("上层：onBindSucceeded: ");
          let formatEventData: emitter.EventData = {
            data: {
              content: Constant.BLE_STATE_BOUND
            }
          };
          emitter.emit('sdkBleState', formatEventData)

          FissionSdkManager.getInstance().getHardwareInfo();
        },

        /**
         * 绑定失败
         * @param code
         */
        onBindFailed(code: number): void {
          console.log("上层：onBindFailed: ");
        },

        /**
         *  当前ble连接的设备是新设备
         */
        isBindNewDevice(): void {
          console.log("上层：isBindNewDevice: ");
        },

        /**
         *  ble通讯服务异常解绑
         */
        onServiceDisconnected(): void {
          console.log("上层：onServiceDisconnected: ");
        }
      })
  }

  public onBleConnectListener() {
    FissionSdkManager.getInstance().clearListeners();
    FissionSdkManager.getInstance().clearDataListener();

    class BtListener extends FissionAtCmdResultListener {
      public sendSuccess(cmdId: string): void {
      }

      public sendFail(cmdId: string): void {
      }

      public onResultTimeout(cmdId: string): void {
      }

      public onResultError(cmdId: string): void {
      }

      public setMtu(mtu: string): void {
      }
    }

    FissionSdkManager.getInstance().addListener(new BtListener());

    let callbackRawData = (eventData: emitter.EventData): void => {
      try {
        let result = eventData.data?.content as string
        console.log(`上层RawData： ` + result);
        let formatEventData: emitter.EventData = {
          data: {
            content: result
          }
        };
        emitter.emit('sdkMessage', formatEventData)
      } catch (err) {
        console.error("上层出错RawData：" + err);
      }
    };
    let callbackAT = (eventData: emitter.EventData): void => {
      try {
        let resultId = eventData.data?.id as string
        // switch (resultId) {
        //   case LISTENER_ID.atId.setMtu:
        //
        //     break;
        // }
        console.log(`上层AT： resultId:${resultId}  content: ${JSON.stringify(eventData.data?.content)}`);

        let formatEventData: emitter.EventData = {
          data: {
            content: JSON.stringify(eventData.data?.content)
          }
        };
        emitter.emit('sdkMessage', formatEventData)

      } catch (err) {
        console.error("上层出错AT：" + err);
      }
    };

    let callbackBigData = (eventData: emitter.EventData): void => {
      try {
        // let resultId = eventData.data?.id as string
        // switch (resultId) {
        //   case LISTENER_ID.bigDataId.getHardwareInfo:
        //     let result = eventData.data?.content as HardWareInfo;
        //     console.log(`上层BigData： ` + JSON.stringify(result));
        //     break;
        // }
        console.log(`上层BigData: `);
        if (eventData.data?.content) {
          StrUtil.splitStrPrint(JSON.stringify(eventData.data?.content));
          let formatEventData: emitter.EventData = {
            data: {
              content: JSON.stringify(eventData.data?.content)
            }
          };
          emitter.emit('sdkMessage', formatEventData)
        } else {
          let formatEventData: emitter.EventData = {
            data: {
              content: JSON.stringify(eventData.data?.id)
            }
          };
          emitter.emit('sdkMessage', formatEventData)
        }

      } catch (err) {
        console.error("上层出错BigData：" + err);
      }
    };


    FissionSdkManager.getInstance().clearDataListener();
    // FissionSdkManager.getInstance().on(LISTENER_TYPE.RAW_DATA, callbackRawData);
    FissionSdkManager.getInstance().onDataListener(LISTENER_TYPE.AT, callbackAT);
    FissionSdkManager.getInstance().onDataListener(LISTENER_TYPE.BIG_DATA, callbackBigData);
    // FissionSdkManager.getInstance().on(LISTENER_TYPE.BLE_CONNECT, callbackBleConnect);

  }

  requestPermissions() {
    // let permissions: Array<Permissions> = ['ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.MICROPHONE', 'ohos.permission.LOCATION', 'ohos.permission.CAMERA']
    let permissions: Array<Permissions> = ['ohos.permission.ACCESS_BLUETOOTH']
    PermissionUtil.getInstance().reqPermissionsFromUser(this.context, permissions, (defiedPermission: Array<Permissions>) => {
      if (defiedPermission.length > 0) {
        console.log('未同意权限：' + JSON.stringify(defiedPermission))
        PermissionUtil.getInstance().requestPermissionOnSetting(this.context, defiedPermission).then(allAgree => {
          console.log("全部授权：: " + allAgree);
        })
      } else {
        //全部授权
        console.log("全部授权");
      }
    })
  }

  @Builder
  itemHead(text: string, item: OrderTable) {
    Text(text)
      .fontSize(20)
      .backgroundColor(0xAABBCC)
      .width("100%")
      .height(80)
      .padding(10)
      .onClick(ev => {
        item.isExpanded = !item.isExpanded;
        this.orderTable = [...this.orderTable]; // 触发状态更新
      })
  }

  @Builder
  itemFoot(num: number) {
    // Divider().height(1).backgroundColor(Color.Black)
  }

  build() {
    Column() {
      Row() {
        Text(this.bleStateValue).fontWeight(1).layoutWeight(1).margin({ left: 20 })
          .onClick(event => {
            this.onBtnClickConnect();
          })
        Text("清空")
          .fontColor(Color.Black)
          .width(50)
          .onClick(event => {
            this.messages = [];
            this.messages.length = 0;
          })
        Text("SCAN")
          .fontColor(Color.Black)
          .margin({ right: 20 })
          .onClick(event => {

          })
      }.height(45).justifyContent(FlexAlign.Center).backgroundColor(Color.Green)

      List() {
        ForEach(this.messages, (item: MsgBean) => {
          ListItem() {
            Text(item.msg)
              .fontSize(16)
              .textAlign(TextAlign.Start)
              .margin({ left: 20, right: 20 })
              .layoutWeight(1)
              .constraintSize({ minHeight: 40 })
          }.onClick(event => {
            item.msg += "1";
            console.log(JSON.stringify(item));
            let parentStack = this.pageInfos.getParent();
            parentStack?.pushPath({
              name: 'PageOrderDetail', param: item
            });
          })
        }, (item: MsgBean) => item.id.toString())
      }
      .width('90%')
      .height('30%')
      .margin(20)
      .border({ width: 1, color: Color.Black })
      .divider(this.egDivider)

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('获取开始时间')
          .onClick(() => {
            showDatePickerDialog(new Date('2024/10/30'), (value: Date) => {
              this.startTime = Math.floor(value.getTime() / 1000);
              console.info("startTime: " + DateUtil.formatDate(value.getTime(), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS))
            })
          }).fontColor(Color.White)
        Button('获取结束时间')
          .onClick(() => {
            showDatePickerDialog(new Date(this.endTime * 1000), (value: Date) => {
              this.endTime = Math.floor(value.getTime() / 1000);
              console.info("endTime: " + DateUtil.formatDate(value.getTime(), DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS))
            })
          }).fontColor(Color.White)
      }

      List() {
        ForEach(this.orderTable, (item: OrderTable, index: number) => {
          ListItemGroup({ header: this.itemHead(item.title, item), footer: this.itemFoot(index) }) {
            if (item.isExpanded) {
              ForEach(item.projects, (project: OrderBean) => {
                ListItem() {
                  Text(project.name)
                    .width("100%")
                    .height(60)
                    .fontSize(20)
                    .padding({ left: 20 })
                    .textAlign(TextAlign.Start)
                    .backgroundColor(0xFFFFFF)
                }.onClick(e => {
                  if (item.id == 0) {
                    this.executeAtOrder(project);
                  }else if(item.id == 1){
                    this.executeFileDataOrder(project.id);
                  } else if (item.id == 2) {
                    this.executeBigDataOrder(project.id);
                  }
                })
              }, (item: OrderBean) => item.id)
            }
          }
          .divider({ strokeWidth: 1, color: Color.Blue }) // 每行之间的分界线
        }, (item: OrderTable) => JSON.stringify(item))
      }
      .width('100%')
      .height(0)
      .margin(20)
      .layoutWeight(1)
      .sticky(StickyStyle.Header | StickyStyle.Footer)
      .scrollBar(BarState.Off)

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  creteOrderData() {
    let projects = this.orderTable[0].projects;
    projects.push(new OrderBean(AtCmd.AT_CMD_GUV, "获取UI版本"));
    projects.push(new OrderBean(AtCmd.AT_CMD_READ_DEVICE_VERSION, "获取版本"));
    projects.push(new OrderBean(AtCmd.AT_CMD_READ_GPV, "获取协议版本"));
    projects.push(new OrderBean(AtCmd.AT_CMD_READ_BATTERY, "获取电量"));
    projects.push(new OrderBean(AtCmd.AT_CMD_READ_TIMEZONE, "获取时区"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SET_TIMEZONE, "设置时区"));
    projects.push(new OrderBean(AtCmd.AT_CMD_READ_TIME, " 获取 UTC 时间"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SET_TIME, "设置时间"));
    projects.push(new OrderBean(AtCmd.AT_CMD_GRH, "获取当天静息心率"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SET_TIME_MODEL, "设置时间显示模式"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SET_LANG, "设置语言"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SET_UNIT, "设置单位"));
    projects.push(new OrderBean(AtCmd.AT_CMD_STU, "设置温度单位"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SET_SMI, "启用提示"));
    projects.push(new OrderBean(AtCmd.AT_CMD_CVS, "振动提醒开关"));
    projects.push(new OrderBean(AtCmd.AT_CMD_CWS, "抬腕亮屏开关"));
    projects.push(new OrderBean(AtCmd.AT_CMD_CPM, "拍照模式"));
    projects.push(new OrderBean(AtCmd.AT_CMD_CCS, "高/低速连接"));
    projects.push(new OrderBean(AtCmd.AT_CMD_TFD, "查找设备"));
    projects.push(new OrderBean(AtCmd.AT_CMD_DFP, "放弃查找手机"));
    projects.push(new OrderBean(AtCmd.AT_CMD_RST, "重启设备"));
    projects.push(new OrderBean(AtCmd.AT_CMD_RES, "恢复出厂设置"));
    projects.push(new OrderBean(AtCmd.AT_CMD_OFF, "软关机"));
    projects.push(new OrderBean(AtCmd.AT_CMD_CSC, "安全确认"));
    projects.push(new OrderBean(AtCmd.AT_CMD_AUT, "自检模式"));
    projects.push(new OrderBean(AtCmd.AT_CMD_CLU, "清除用户信息"));
    projects.push(new OrderBean(AtCmd.AT_CMD_CLS, "清除运动数据"));
    projects.push(new OrderBean(AtCmd.AT_CMD_JMP, "界面跳转"));
    projects.push(new OrderBean(AtCmd.AT_CMD_MCS, "音乐音量"));
    projects.push(new OrderBean(AtCmd.AT_CMD_MCS, "音乐控制"));
    projects.push(new OrderBean(AtCmd.AT_CMD_MCS, "音乐进度"));
    projects.push(new OrderBean(AtCmd.AT_CMD_BDC, "断开连接"));
    projects.push(new OrderBean(AtCmd.AT_CMD_NRS, "设置重启后自动关机"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SOP, "血氧检测开关"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SST, "精神压力检测开关"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SHR, "心率检测开关"));
    // projects.push(new OrderBean(AtCmd.AT_CMD_SBP, "血压检测开关"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SCV, "设置通话音频开关"));
    projects.push(new OrderBean(AtCmd.AT_CMD_GCV, "获取通话音频状态"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SMV, "设置多媒体音频开关"));
    projects.push(new OrderBean(AtCmd.AT_CMD_GMV, "获取多媒体音频开关"));
    projects.push(new OrderBean(AtCmd.AT_CMD_STO, "设置撕裂补偿"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SET_MAC, "随机设置MAC地址"));
    this.orderTable[0].projects = projects;

    projects = this.orderTable[1].projects;
    // projects.push(new OrderBean(AtCmd.AT_CMD_CFD+"C", "监听数据流开关"));
    // projects.push(new OrderBean(AtCmd.AT_CMD_CFD+"M", "消息队列数据流"));
    // projects.push(new OrderBean(AtCmd.AT_CMD_CHD, "心率开关"));
    // projects.push(new OrderBean(AtCmd.AT_CMD_SUM, "启动OTA升级"));
    projects.push(new OrderBean(AtCmd.AT_CMD_SUM, "自定义表盘推送"));
    // projects.push(new OrderBean(AtCmd.AT_CMD_SUM+"V2", "自定义表盘推送V2"));
    // projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_CUS_SPORT_DATA, "推送运动"));
    // projects.push(new OrderBean(AtCmd.AT_CMD_ESS, "GPS运动数据交互"));
    // projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_FLASH_ACCESS, "向片外flash空间写入指定数据"));
    // projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_REMOTE_DIAL_DATA+"_FILE", "文件压缩传输"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_REMOTE_DIAL_DATA, "在线表盘推送03F4"));
    // projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_QLZ_DATA, "App推送任意qlz压缩数据（03F5）"));
    // projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_QLZ_MORE_SPORT_DATA, "多运动推送"));
    this.orderTable[1].projects = projects;


    projects = this.orderTable[2].projects;
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_READ_HARDWARE, "获取硬件信息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_SYSTEM_INFO, "获取当前系统动态信息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_MEASURE_INFO, "获取实时测量数据"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_DAYS_REPORT, "获取每日活动统计"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_HOURS_REPORT, "整点活动统计"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_SLEEP_REPORT, "睡眠统计报告"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_SLEEP_RECORD, "睡眠状态记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_SLEEP_CUR_RECORD, "获取睡眠实时记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_EXERCISE_LIST, "获取运动记录列表/获取运动统计报告"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_EXERCISE_REPORT, "获取运动统计报告"));
    projects.push(new OrderBean(this.BIG_DADT_GPS, "GPS运动数据交流"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_HEART_RATE_RECORD, "获取心率记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_HR_WARN_PARA, "心率异常提醒设置"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_STEPS_RECORD, "获取计步记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_SPO2_RECORD, "获取血氧记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_BLOOD_PRESSURE_RECORD, "获取血压记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_MENTAL_STRESS_RECORD, "获取精神压力记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_MENTAL_STRESS_RECORD, "获取精神压力记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_EXERCISE_DETAIL, "运动详情记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_EXER_GPS_DETAIL, "获取运动定位记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_PERSONAL_INFO, "用户个人信息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_HRLEV_ALGO_PARA, "心率等级判定参数"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_SEDENTARY_PARA, "久坐判定参数"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_DRINK_WATER_PARA, "喝水提醒参数"));
    projects.push(new OrderBean(BigDataCmdId.CMD_GET_DONT_DISTURB_PARA, "勿扰参数"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_HR_CHECK_PARA, "心率检查参数"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_LIFTWRIST_PARA, "抬腕亮屏参数"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_TARGET_SET, "运动目标参数"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_SET_WEATHER_MESS, "推送天气消息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_SET_WEATHER_DETAIL_MESS, "推送天气消息详情"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_APPS_MESS, "APP社交消息推送"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_TIMING_INFO, "闹钟信息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_STRU_CALL_DATA, "手机来电消息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_STRU_MUSIC_CONT, "推送当前歌曲"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_SET_LOCATION_INFORMATION, "推送定位信息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_HAND_MEASURE_INFO, "获取手动测量记录"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_QUICK_REPLY_DATA, "快捷回复"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_BURIED_DATA, "获取设备埋点数据"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_CALL_CONTACT, "同步电话簿"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GT_FLASH_ACCESS, "读取片外flash空间数据(02E0)"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_ST_EXER_HRPS_DETAIL, "GET运动高频心率记录（0186）"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_SPORT_LIST, "获取设备当前支持运动列表信息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_SYSTEM_FUNCTION_SWITCH, "获取设备系统功能开关"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_SET_GPS_LOCATION, "推送AGPS基础定位信息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_SET_SN_CMEI, "设置SN/CMEI码"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_NOTES_REMINDERS, "便签记事提醒"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_DISK_SPACE_INFO, "获取系统空间使用信息"));
    projects.push(new OrderBean(BigDataCmdId.CMD_ID_GET_FILE_LIST, "获取海思文件列表"));


    this.orderTable[2].projects = projects;
  }
  //AT指令
  executeAtOrder(order: OrderBean) {
    let that = this;
    switch (order.id) {
      case AtCmd.AT_CMD_GUV:
        FissionSdkManager.getInstance().getUiVersion();
        break;
      case AtCmd.AT_CMD_READ_DEVICE_VERSION:
        FissionSdkManager.getInstance().getDeviceVersion();
        break;
      case AtCmd.AT_CMD_READ_GPV:
        FissionSdkManager.getInstance().getProtocolVersion();
        break;
      case AtCmd.AT_CMD_READ_BATTERY:
        FissionSdkManager.getInstance().getDeviceBattery();
        break;
      case AtCmd.AT_CMD_READ_TIMEZONE:
        FissionSdkManager.getInstance().getTimezone();
        break;
      case AtCmd.AT_CMD_SET_TIMEZONE:
        HMRouterMgr.push({
          pageUrl: PageConstant.INPUT_DIALOG, param: new DialogParam('设置时区', this.timeZone)
        }, {
          onResult(popInfo: HMPopInfo) {
            let result = popInfo.result as string;
            that.timeZone = result;
            FissionSdkManager.getInstance().setTimezone(parseInt(result))
          }
        })
        break;
      case AtCmd.AT_CMD_READ_TIME:
        FissionSdkManager.getInstance().getTimes();
        break;
      case AtCmd.AT_CMD_SET_TIME:
        showDatePickerDialog(this.selectedDate, (value: Date) => {
          this.selectedDate = value
          FissionSdkManager.getInstance().setTimes(this.selectedDate.getTime());
          console.info("DatePickerDialog:onDateAccept()" + value.toString())
        })
        break;
      case AtCmd.AT_CMD_GRH:
        FissionSdkManager.getInstance().getRestingHeartRate();
        break;
      case AtCmd.AT_CMD_SET_TIME_MODEL:
        let timeModelRange: string[] = ['12', '24'];
        showTextPickerDialog(timeModelRange, this.timeMode, (value: TextPickerResult) => {
          this.timeMode = value.index as number;
          FissionSdkManager.getInstance().setTimeFormat(this.timeMode == 1)
        })
        break;
      case AtCmd.AT_CMD_SET_LANG:
        let languageRange: string[] = ['中文', '英文', '日语', '法语', '德语', '西班牙语', '意大利语', '葡萄牙语', '俄语', '捷克语', '波兰语', '繁体中文', '阿拉伯语', '土耳其语', '越南语', '韩语', '希伯来语', '泰语', '印度尼西亚语', '荷兰语', '希腊语', '瑞典语', '罗马尼亚语', '印地语', '孟加拉语', '乌尔都语', '波斯语', '尼泊尔语', '乌克兰语', '马来语', '斯洛伐克语', '缅甸语', '丹麦语'];
        showTextPickerDialog(languageRange, this.language, (value: TextPickerResult) => {
          this.language = value.index as number;
          FissionSdkManager.getInstance().setLanguage(this.language)
        })
        break;
      case AtCmd.AT_CMD_SET_UNIT:
        let unitRange: string[] = ['英制', '公制'];
        showTextPickerDialog(unitRange, this.unitMode, (value: TextPickerResult) => {
          this.unitMode = value.index as number;
          FissionSdkManager.getInstance().setUnit(this.unitMode);
        })
        break;
      case AtCmd.AT_CMD_STU:
        let temperatureRange: string[] = ['摄氏度', '华氏度'];
        showTextPickerDialog(temperatureRange, this.temperatureMode, (value: TextPickerResult) => {
          this.temperatureMode = value.index as number;
          FissionSdkManager.getInstance().setTemType(this.temperatureMode == 0);
        })
        break;
      case AtCmd.AT_CMD_SET_SMI:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setHeartRateHighTips(1, value.index as number);
        })
        break;
      case AtCmd.AT_CMD_CVS:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setSwitchVibration(value.index as number == 1);
        })
        break;
      case AtCmd.AT_CMD_CWS:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setSwitchWBScreen(value.index as number == 1);
        })
        break;
      case AtCmd.AT_CMD_CPM:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setSwitchPhotoMode(value.index as number == 1);
        })
        break;
      case AtCmd.AT_CMD_CCS:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setSwitchHighCh(value.index as number == 1);
        })
        break;
      case AtCmd.AT_CMD_TFD:
        FissionSdkManager.getInstance().findDevice();
        break;
      case AtCmd.AT_CMD_DFP:
        FissionSdkManager.getInstance().cancelFindPhone();
        break;
      case AtCmd.AT_CMD_RST:
        FissionSdkManager.getInstance().rebootDevice();
        break;
      case AtCmd.AT_CMD_RES:
        FissionSdkManager.getInstance().resetDevice();
        break;
      case AtCmd.AT_CMD_OFF:
        FissionSdkManager.getInstance().shutdown();
        break;
      case AtCmd.AT_CMD_CSC:
        HMRouterMgr.push({
          pageUrl: PageConstant.INPUT_DIALOG, param: new DialogParam('请输入安全确认内容', '')
        }, {
          onResult(popInfo: HMPopInfo) {
            let content = popInfo.result as string;
            FissionSdkManager.getInstance().safetyConfirmation(content);
          }
        })
        break;
      case AtCmd.AT_CMD_CSC:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setSwitchSelfInspectionMode(value.index as number == 1);
        })
        break;
      case AtCmd.AT_CMD_CLU:
        FissionSdkManager.getInstance().clearUserInfo();
        break;
      case AtCmd.AT_CMD_CLS:
        FissionSdkManager.getInstance().clearSportData();
        break;
      case AtCmd.AT_CMD_JMP:
        HMRouterMgr.push({
          pageUrl: PageConstant.INPUT_DIALOG, param: new DialogParam('请输入要跳转的内容过', 'FF02')
        }, {
          onResult(popInfo: HMPopInfo) {
            let content = popInfo.result as string;
            FissionSdkManager.getInstance().setPageSkip(content);
          }
        })
        break;
      case AtCmd.AT_CMD_MCS:
        if (order.name == '音乐控制') {
          return
        }

        let musicConfig: MusicConfig = new MusicConfig();
        HMRouterMgr.push({
          pageUrl: PageConstant.INPUT_DIALOG_MUSIC, param: new InputMusicDialogParam(order.name, musicConfig)
        }, {
          onResult(popInfo: HMPopInfo) {
            let result = popInfo.result as MusicConfig;
            if (result) {
              console.log(`${order.name} : ${JSON.stringify(result)}`);
              if (order.name == '音乐音量') {
                FissionSdkManager.getInstance().setMusicVolume(result);
              } else if (order.name == '音乐控制') {
                // FissionSdkManager.getInstance().setMusicControl(musicConfig);
                return
              } else if (order.name == '音乐进度') {
                FissionSdkManager.getInstance().setMusicProgress(result);
              }
            }
          }
        })
        break;
      case AtCmd.AT_CMD_BDC:
        FissionSdkManager.getInstance().disconnectBleDevice();
        break;
      case AtCmd.AT_CMD_NRS:
        FissionSdkManager.getInstance().setShutdownState();
        break;
      case AtCmd.AT_CMD_SOP:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setBloodOxygenSwitch(value.index as number);
        })
        break;
      case AtCmd.AT_CMD_SST:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setMentalStressSwitch(value.index as number);
        })
        break;
      case AtCmd.AT_CMD_SHR:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setHeartRateSwitch(value.index as number);
        })
        break;
      case AtCmd.AT_CMD_SBP: //血压检测开关  未加入
        // FissionSdkManager.getInstance().setHeartRateSwitch();
        break;
      case AtCmd.AT_CMD_SCV:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setCallAudioSwitch(value.index as number);
        })
        break;
      case AtCmd.AT_CMD_GCV:
        FissionSdkManager.getInstance().getCallAudioSwitch();
        break;
      case AtCmd.AT_CMD_SMV:
        showTextPickerDialog(this.switchRange, 0, (value: TextPickerResult) => {
          FissionSdkManager.getInstance().setMediaAudioSwitch(value.index as number);
        })
        break;
      case AtCmd.AT_CMD_GMV:
        FissionSdkManager.getInstance().getMediaAudioSwitch();
        break;
      case AtCmd.AT_CMD_STO:
        HMRouterMgr.push({
          pageUrl: PageConstant.INPUT_DIALOG_STO, param: this.sto
        }, {
          onResult(popInfo: HMPopInfo) {
            let result = popInfo.result as number;
            that.sto = result;
            FissionSdkManager.getInstance().setSTO(that.sto);
          }
        })
        break;
      case AtCmd.AT_CMD_SET_MAC:
        let mac = MacUtil.generateBluetoothMacAddress().replace(":", "").trim();
        this.messages.push(new MsgBean(this.messages.length, `设置随机mac地址：${mac}}`))
        Logger.info("设置随机mac地址：" + mac);
        FissionSdkManager.getInstance().setMAC(mac);
        break;
    }
  }
  //文件/数据流 指令
  executeFileDataOrder(order: string){
    switch (order){
      case AtCmd.AT_CMD_SUM:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_CUSTOM_DIAL
        })
        break;
        case BigDataCmdId.CMD_ID_ST_REMOTE_DIAL_DATA://在线表盘
          HMRouterMgr.push({
            pageUrl: PageConstant.PAGE_ON_LINE_DIAL
          })
          break;
    }
  }
  //大数据指令
  executeBigDataOrder(order: string) {
    switch (order) {
      case BigDataCmdId.CMD_ID_READ_HARDWARE:
        FissionSdkManager.getInstance().getHardwareInfo()
        break;
      case BigDataCmdId.CMD_ID_GET_SYSTEM_INFO:
        FissionSdkManager.getInstance().getSystemInfo()
        break;
      case BigDataCmdId.CMD_ID_GET_MEASURE_INFO:
        FissionSdkManager.getInstance().getMeasureInfo()
        break;
      case BigDataCmdId.CMD_ID_DAYS_REPORT:
        FissionSdkManager.getInstance().getDaysReport(this.startTime, this.endTime)
        break;
      case BigDataCmdId.CMD_ID_ST_HOURS_REPORT:
        FissionSdkManager.getInstance().getHoursReport(this.startTime, this.endTime)
        break;
      case BigDataCmdId.CMD_ID_ST_SLEEP_RECORD:
        FissionSdkManager.getInstance().getSleepRecord(this.startTime, this.endTime)
        break;
      case BigDataCmdId.CMD_ID_GET_SLEEP_CUR_RECORD:
        FissionSdkManager.getInstance().getCurSleepRecord();
        break;
      case BigDataCmdId.CMD_ID_EXERCISE_LIST:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_EXERCISE, param: new BigDataTimeParam(this.startTime, this.endTime)
        })
        break;
      case BigDataCmdId.CMD_ID_EXERCISE_REPORT:
        FissionSdkManager.getInstance().getExerciseReport(this.startTime, this.endTime);
        break;
      case this.BIG_DADT_GPS: //GPS运动数据交流
        //todo 单独写一个界面完成
        break;
      case BigDataCmdId.CMD_ID_HEART_RATE_RECORD:
        FissionSdkManager.getInstance().getHeartRateRecord(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_GET_HR_WARN_PARA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_HR_WARN_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_ST_STEPS_RECORD:
        FissionSdkManager.getInstance().getStepsRecord(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_ST_SPO2_RECORD:
        FissionSdkManager.getInstance().getSpo2Record(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_ST_BLOOD_PRESSURE_RECORD:
        FissionSdkManager.getInstance().getBloodPressureRecord(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_ST_MENTAL_STRESS_RECORD:
        FissionSdkManager.getInstance().getMentalStressRecord(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_EXERCISE_DETAIL:
        FissionSdkManager.getInstance().getExerciseDetail(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_ST_EXER_GPS_DETAIL:
        FissionSdkManager.getInstance().getExprGpsDetail(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_PERSONAL_INFO:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_USER_INFO
        })
        break;
      case BigDataCmdId.CMD_ID_GET_HRLEV_ALGO_PARA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_HRLEVEL_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_SEDENTARY_PARA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_SEDENTARY_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_GET_DRINK_WATER_PARA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_DRINK_WATER_PARA
        })
        break;
      case BigDataCmdId.CMD_GET_DONT_DISTURB_PARA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_DND_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_GET_HR_CHECK_PARA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_HR_CHECK_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_GET_LIFTWRIST_PARA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_LIFT_WRIST_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_GET_TARGET_SET:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_SPORT_TARGET_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_SET_WEATHER_MESS:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_WEATHER_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_SET_WEATHER_DETAIL_MESS:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_WEATHER_DETAIL_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_APPS_MESS:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_APP_MSG_PUSH_PARA
        })
        break;
      case BigDataCmdId.CMD_ID_GET_TIMING_INFO:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_ALARM_INFO
        })
        break;
      case BigDataCmdId.CMD_ID_STRU_CALL_DATA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_PHONE_CALL
        })
        break;
      case BigDataCmdId.CMD_ID_STRU_MUSIC_CONT:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_MUSIC
        })
        break;
      case BigDataCmdId.CMD_ID_SET_LOCATION_INFORMATION:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_SET_LOCAL
        })
        break;
      case BigDataCmdId.CMD_ID_GET_HAND_MEASURE_INFO:
        FissionSdkManager.getInstance().getHandMeasureInfo(this.startTime, this.endTime);
        FissionSdkManager.getInstance().getNewHandMeasureInfo(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_GET_QUICK_REPLY_DATA:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_QUICK_REPLY
        })
        break;
      case BigDataCmdId.CMD_ID_GET_BURIED_DATA:
        FissionSdkManager.getInstance().getBuriedData();
        break;
      case BigDataCmdId.CMD_ID_GET_CALL_CONTACT:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_PHONE_BOOK
        })
        break;
      case BigDataCmdId.CMD_ID_GT_FLASH_ACCESS:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_GET_FLASH_DATA
        })
        break;
      case BigDataCmdId.CMD_ID_ST_EXER_HRPS_DETAIL:
        FissionSdkManager.getInstance().getHrpsDetailRecord(this.startTime, this.endTime);
        break;
      case BigDataCmdId.CMD_ID_GET_SPORT_LIST:
        FissionSdkManager.getInstance().getSportListInfo();
        break;
      case BigDataCmdId.CMD_ID_GET_SYSTEM_FUNCTION_SWITCH:
        FissionSdkManager.getInstance().getSystemFunctionSwitch();
        break;
      case BigDataCmdId.CMD_ID_SET_GPS_LOCATION:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_SET_AGPS_LOCAL
        })
        break;
      case BigDataCmdId.CMD_ID_SET_SN_CMEI:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_SET_SN_AND_CMEI
        })
        break;
      case BigDataCmdId.CMD_ID_GET_NOTES_REMINDERS:
        HMRouterMgr.push({
          pageUrl: PageConstant.PAGE_NOTES_REMINDS
        })
        break;
      case BigDataCmdId.CMD_ID_GET_DISK_SPACE_INFO:
        FissionSdkManager.getInstance().getDiskSpaceInfo();
        break;
      case BigDataCmdId.CMD_ID_GET_FILE_LIST:
        ToastUtil.showToast('暂未实现')
        break;
    }
  }
}