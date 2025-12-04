import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';

import {
    BloodPressureRecord,
    CommunicatGps,
    DaysReport,
    DiskSpaceInfo,
    DkWaterRemind,
    DndRemind,
    ExerciseDetail,
    ExerciseGpsRecord,
    ExerciseList,
    ExerciseReport,
    FemalePhysiology,
    FissionAlarm,
    FissionBigDataCmdResultListener,
    FissionSdkManager,
    HandMeasureInfoBean,
    HardWareInfo,
    HeartRateRecord,
    HoursReport,
    HrDetectPara,
    HrpsDetailRecord,
    HrRateLevel,
    HrWarnPara,
    HsDialInfo,
    HsJsFileInfo,
    HsMultimediaFileInfo,
    LiftWristPara,
    LISTENER_TYPE,
    MeasureInfo,
    MentalStressRecord,
    NotesReminders,
    ProgressBean,
    QuickReply,
    RingtoneSetting,
    SedentaryBean,
    SleepRecord,
    SleepReport,
    SnAndCmeiInfo, Spo2Record,
    SportListInfo,
    SportsTargetPara,
    SpUtil,
    StepsRecord,
    SystemFunctionSwitch, UserInfo
} from 'fission_sdk';
import { TitleBar } from '../components/TitleBar';
import { StrUtil, ToastUtil } from '@pura/harmony-utils';
import { bytesToHexString, intToBytes } from 'fission_sdk';
import { fileIo as fs } from '@kit.CoreFileKit';

/**
 * @file PageSetLocal.ets
 * @author liyi
 * @date 2024/10/29
 * @description 读取片外flash空间数据(02E0)
 */
@Preview
@HMRouter({ pageUrl: PageConstant.PAGE_GET_FLASH_DATA })
@Component
export struct PageGetFlashData {
  @State address: string = '';
  @State dataLength: string = '';
  hfOffsetAddress = 0; //Hardfault 偏移地址
  hfLength = 0;
  spOffsetAddress = 0; //系统参数 偏移地址
  spLength = 0;
  currentNum = 0;
  count = 0;
  @State progress: string = "读取进度："
  private scroller: Scroller = new Scroller()

  aboutToAppear(): void {

    let that = this;
    class BigDataListener extends FissionBigDataCmdResultListener {
      sendSuccess(cmdId: string): void {

      }

      sendFail(cmdId: string): void {

      }

      onResultTimeout(cmdId: string): void {

      }

      onResultError(errorMsg: string): void {
        ToastUtil.showShort(errorMsg)
      }

      pushAppNotification(): void {
      }

      getHardwareInfo(hardWareInfo: HardWareInfo): void {

      }

      getSystemInfo(data: Uint8Array): void {

      }

      getMeasureInfo(measureInfo: MeasureInfo): void {

      }

      getDaysReport(daysReports: DaysReport[]): void {

      }

      getHoursReport(hoursReports: HoursReport[]): void {

      }

      getSleepReport(sleepReports: SleepReport[]): void {

      }

      getSleepRecord(sleepRecords: SleepRecord[]): void {

      }

      getCurSleepRecord(sleepRecord: SleepRecord): void {

      }

      getCurSleepReport(sleepRecord: SleepRecord): void {

      }

      getExerciseList(exerciseLists: ExerciseList[]): void {

      }

      getExerciseReport(exerciseReports: ExerciseReport[]): void {
      }

      getHeartRateRecord(heartRateRecords: HeartRateRecord[]): void {

      }

      getStepsRecord(stepsRecords: StepsRecord[]): void {

      }

      getSpo2Record(spo2Records: Spo2Record[]): void {

      }

      getMentalStressRecord(mentalStressRecords: MentalStressRecord[]): void {

      }

      getBloodPressureRecord(bloodPressureRecords: BloodPressureRecord[]): void {

      }

      getExerciseDetail(exerciseDetails: ExerciseDetail[]): void {
      }

      getExprGpsDetail(exerGpsDetails: ExerciseGpsRecord[]): void {

      }

      getUserInfo(userInfo: UserInfo): void {

      }

      getAlarm(fissionAlarms: FissionAlarm[]): void {
      }

      getSedentaryPara(sedentaryBean: SedentaryBean): void {

      }

      getHrRateLevelPara(hrRateLevel: HrRateLevel): void {

      }

      getDrinkWaterPara(dkWaterRemind: DkWaterRemind): void {
      }

      getDndPara(dndRemind: DndRemind): void {
      }

      getHrDetectPara(hrDetectPara: HrDetectPara): void {

      }

      getLiftWristPara(liftWristPara: LiftWristPara): void {

      }

      getTargetSet(sportsTargetPara: SportsTargetPara): void {

      }

      getFemalePhysiology(femalePhysiology: FemalePhysiology): void {

      }

      getHrWarnPara(hrWarnPara: HrWarnPara): void {

      }

      getHandMeasureInfo(handMeasureInfoBeans: HandMeasureInfoBean[]): void {

      }

      setUserInfo(): void {

      }

      setAlarmInfos(): void {
      }

      setSedentaryPara(): void {

      }

      setHrlevAlgoPara(): void {

      }

      setHrWarnPara(): void {

      }

      setDrinkWaterPara(): void {
      }

      setDndPara(): void {
      }

      setHrDetectPara(): void {

      }

      setLiftWristPara(): void {

      }

      setTargetSet(): void {

      }

      setFemalePhysiology(): void {

      }

      setWeather(): void {

      }

      setWeatherDetail(): void {

      }

      setLocationInfo(): void {

      }

      onUpdateDialProgress(progress: ProgressBean): void {

      }

      incomingCall(): void {

      }

      sendMusicInfo(): void {
      }

      sendGpsCommand(communicatGps: CommunicatGps): void {

      }

      setQuickReplyData(): void {

      }

      getQuickReplyData(quickReplyList: QuickReply[]): void {

      }

      getBuriedData(filepath: string): void {

      }

      setPhoneBooks(): void {

      }

      getFlashData(filepath: string): void {
        that.currentNum++;
        that.progress = "读取进度：" + that.currentNum + "/" + that.count;
        ToastUtil.showLong("数据已保存:" + filepath)
      }

      getHrpsDetailRecord(hrpsDetailRecords: HrpsDetailRecord[]): void {

      }

      getSportListInfo(sportListInfo: SportListInfo): void {

      }

      getSystemFunctionSwitch(systemFunctionSwitch: SystemFunctionSwitch): void {

      }

      setSystemFunctionSwitch(): void {

      }

      setAgpsLocation(): void {

      }

      setSnAndCmeiCode(): void {

      }

      getSnAndCmeiCode(snAndCmeiInfo: SnAndCmeiInfo): void {

      }

      getNotesReminders(notesReminders: NotesReminders[]): void {

      }

      setNotesReminders(): void {

      }

      getDiskSpaceInfo(diskSpaceInfo: DiskSpaceInfo): void {

      }

      getHsJsAppFileList(list: HsJsFileInfo[]): void {

      }

      getHsDialFileList(list: HsDialInfo[]): void {

      }

      getHsMusicFileList(list: HsMultimediaFileInfo[]): void {

      }

      getHsVideoFileList(list: HsMultimediaFileInfo[]): void {

      }

      getHsEbookFileList(list: HsMultimediaFileInfo[]): void {

      }

      getHsRingtoneMsgFileList(list: HsMultimediaFileInfo[]): void {

      }

      getHsRingtoneCallFileList(list: HsMultimediaFileInfo[]): void {

      }

      getHsRingtoneClockFileList(list: HsMultimediaFileInfo[]): void {

      }

      deleteFileInfoList(): void {

      }

      getRingtoneSettings(ringtoneSettings: RingtoneSetting[]): void {

      }
    }
    FissionSdkManager.getInstance().addListener(new BigDataListener());


    let hardWareInfo: HardWareInfo | null = FissionSdkManager.getInstance().hardWareInfo;
    console.log("hardWareInfo:\n" + JSON.stringify(hardWareInfo));
    if (hardWareInfo != null) {
      this.hfOffsetAddress = hardWareInfo.getHfOffsetAddress();
      this.hfLength = hardWareInfo.getHfLength();
      this.spOffsetAddress = hardWareInfo.getSpOffsetAddress();
      this.spLength = hardWareInfo.getSpLength();
    }
    this.address = SpUtil.getData("flash_address") as string
    this.dataLength = SpUtil.getData("flash_length") as string
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '读取片外flash空间数据(02E0)',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })


        Row() {
          TextInput({ placeholder: '请输入flash地址(16进制)', text: this.address })
            .height(40)
            .layoutWeight(1)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.address = value
            })
        }.width('90%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })


        Row() {
          TextInput({ placeholder: '请输入flash地址(16进制)', text: this.dataLength })
            .height(40)
            .width(150)
            .layoutWeight(1)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.dataLength = value
            })
        }.width('90%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })


        Row() {
          Row(){
            Radio({ value: 'radio1', group: 'radioGroup' })
              .checked(true)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  SpUtil.putData("flash_address", "0x" + bytesToHexString(intToBytes(this.hfOffsetAddress)))
                  SpUtil.putData("flash_length", "0x" + bytesToHexString(intToBytes(this.hfLength)))
                  this.address = SpUtil.getData('flash_address') as string
                  this.dataLength = SpUtil.getData('flash_length') as string
                }
              })
            Text("HIhardfault参数")
          }

          Row() {
            Radio({ value: 'radio2', group: 'radioGroup' })
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  SpUtil.putData("flash_address", "0x" + bytesToHexString(intToBytes(this.spOffsetAddress)))
                  SpUtil.putData("flash_length", "0x" + bytesToHexString(intToBytes(this.spLength)))
                  this.address = SpUtil.getData('flash_address') as string
                  this.dataLength = SpUtil.getData('flash_length') as string
                }
              })
            Text("HI系统参数")
          }
        }
        .width('100%')
        .margin({ left: 20, top: 20 })

        Text(this.progress).textAlign(TextAlign.Start)

        Divider().layoutWeight(1).color(Color.Transparent);

        Button('读取FLASH指定地址数据').width('80%').margin({ bottom: 30 }).onClick(() => {
          this.currentNum = 0;
          if (StrUtil.isEmpty(this.address) || StrUtil.isEmpty(this.dataLength)) {
            ToastUtil.showShort('请输入完整信息')
            return;
          }

          let filePath = getContext().filesDir + "/fission-flash-data.txt";
          const fileExist = fs.accessSync(filePath);
          if (fileExist) {
            fs.unlinkSync(filePath)
          }

          if (parseInt(this.dataLength.substring(2), 16) % 2048 != 0) {
            this.count = parseInt(this.dataLength.substring(2), 16) / 2048 + 1;
          } else {
            this.count = parseInt(this.dataLength.substring(2), 16) / 2048;
          }
          this.progress = "读取进度：" + this.currentNum + "/" + this.count;
          FissionSdkManager.getInstance().getFlashData(this.address.substring(2), this.dataLength.substring(2))
          SpUtil.putData("flash_address", this.address)
          SpUtil.putData("flash_length", this.dataLength)
          ToastUtil.showShort('读取flash指定地址数据指令已发送')


        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
  }
}