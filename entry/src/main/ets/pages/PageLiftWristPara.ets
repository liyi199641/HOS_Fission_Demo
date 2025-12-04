import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';

import {
  BloodPressureRecord,
  CommunicatGps,
  ControlGpsSportInfo,
  DaysReport,
  DeviceBattery,
  DeviceVersion,
  DiskSpaceInfo,
  DkWaterRemind,
  DndRemind,
  ExerciseDetail,
  ExerciseGpsRecord,
  ExerciseList,
  ExerciseReport,
  FemalePhysiology,
  FissionAlarm,
  FissionAtCmdResultListener,
  FissionBigDataCmdResultListener,
  FissionSdkManager,
  FssStatus,
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
  MusicConfig,
  NotesReminders,
  ProgressBean,
  QuickReply,
  RingtoneSetting,
  SedentaryBean,
  SleepRecord,
  SleepReport,
  SnAndCmeiInfo,
  Spo2Record,
  SportListInfo,
  SportsTargetPara,
  StepsRecord,
  SystemFunctionSwitch,
  UserInfo
} from 'fission_sdk';
import { TitleBar } from '../components/TitleBar';
import { ToastUtil } from '@pura/harmony-utils';

/**
 * @file PageLiftWristPara.ets
 * @author liyi
 * @date 2024/10/29
 * @description 抬腕亮屏参数
 */
@HMRouter({ pageUrl: PageConstant.PAGE_LIFT_WRIST_PARA })
@Component
export struct PageLiftWristPara {
  @State open: boolean = false;
  @State screenTime: number = 0;
  @State startTime: number = 0;
  @State endTime: number = 0;
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
        that.startTime = liftWristPara.getStartTime();
        that.endTime = liftWristPara.getEndTime();
        that.open = liftWristPara.isEnable();
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
        ToastUtil.showShort('设置心率判定等级成功');
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
        ToastUtil.showShort('设置抬腕亮屏参数成功')
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




    class AtDataListener extends FissionAtCmdResultListener {

      setMtu(mtu: string): void {

      }

      getDeviceVersion(deviceVersion: DeviceVersion): void {

      }

      getDeviceBattery(deviceBattery: DeviceBattery): void {

      }

      getProtocolVersion(version: string): void {

      }

      getTimezone(timezone: string): void {

      }

      getTimes(times: string): void {

      }

      setTimezone(timezone: string): void {

      }

      setTimes(times: string): void {

      }

      getRestingHeartRate(heartRate: string): void {

      }

      setTimeFormat(is24Format: boolean): void {

      }

      setLanguage(language: number): void {

      }

      setUnit(unit: number): void {

      }

      setHeartRateHighTips(result: string): void {

      }

      setSwitchVibration(enable: boolean): void {

      }

      setSwitchWBScreen(enable: boolean): void {

      }

      setSwitchPhotoMode(enable: boolean): void {

      }

      setSwitchHighCh(enable: boolean): void {

      }

      findDevice(): void {

      }

      findDeviceSuccess(): void {

      }

      findPhoneSuccess(): void {

      }

      findPhone(): void {

      }

      cancelFindPhone(): void {

      }

      rebootDevice(): void {

      }

      resetDevice(): void {

      }

      shutdown(): void {

      }

      safetyConfirmation(result: string): void {

      }

      setSwitchSelfInspectionMode(enable: boolean): void {

      }

      clearUserInfo(): void {

      }

      clearSportData(): void {

      }

      setPageSkip(result: string): void {

      }

      setMusicVolume(musicConfig: MusicConfig): void {

      }

      setMusicControl(musicConfig: MusicConfig): void {

      }

      setMusicProgress(musicConfig: MusicConfig): void {

      }

      notifyDeviceDisconnect(): void {

      }

      checkOTA(otaType: string): void {

      }

      getScreenKeep(result: string): void {
        that.screenTime = parseInt(result);
      }

      setScreenKeep(): void {
        ToastUtil.showShort('设置亮屏时间成功');
      }

      getNotUsingAlarmId(result: string): void {

      }

      setDataStream(time: string): void {

      }

      switchHrRate(enable: boolean): void {

      }

      setTemType(): void {

      }

      changeCallByPhone(): void {

      }

      onTakePhoneCallback(callStatus: number): void {

      }

      onTakePhotoCallback(): void {

      }

      gpsSuccess(open: boolean): void {

      }

      fssSuccess(fssStatus: FssStatus): void {

      }

      setPhoneSystem(): void {

      }

      controlGpsSportStatus(controlGpsSportInfo: ControlGpsSportInfo): void {

      }

      replyControlGpsSportResult(controlGpsSportInfo: ControlGpsSportInfo): void {

      }

      quickReply(index: number): void {

      }

      getUiVersion(uiVersion: string): void {

      }

      notifyUpdateUi(uiVersion: string): void {

      }

      getSportState(state: number): void {

      }

      setBloodOxygenSwitch(state: number): void {

      }

      setMentalStressSwitch(state: number): void {

      }

      setHeartRateSwitch(state: number): void {

      }

      setCallAudioSwitch(state: number): void {

      }

      getCallAudioSwitch(state: number): void {

      }

      setMediaAudioSwitch(state: number): void {

      }

      getMediaAudioSwitch(state: number): void {

      }

      isBindNewDevice(isNewDevice: boolean): void {

      }

      setSTO(sto: string): void {

      }

      getNotUsingNoteId(result: string): void {

      }

      setADS(ads: string): void {

      }

      sendSuccess(cmdId: string): void {

      }

      sendFail(cmdId: string): void {

      }

      onResultTimeout(cmdId: string): void {

      }

      onResultError(errorMsg: string): void {
        ToastUtil.showShort("设置亮屏时间失败: "+errorMsg)
      }

    }
    FissionSdkManager.getInstance().addListener(new AtDataListener())

    FissionSdkManager.getInstance().getScreenKeep();
    FissionSdkManager.getInstance().getLiftWristPara();
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '抬腕亮屏参数',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })
        Row() {
          Text('开关').width(150).textAlign(TextAlign.End)
          Toggle({ type: ToggleType.Switch, isOn: this.open })
            .margin({ left: 20 })
            .selectedColor('#007DFF')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.open = isOn;
              console.info('Component status:' + isOn)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })


        Row() {
          Text('抬腕有效起始时间').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '(0-1440)当天绝对分钟', text: this.startTime.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.startTime = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('抬腕有效结束时间').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '(0-1440)当天绝对分钟', text: this.endTime.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.endTime = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })


        Row() {
          Text('亮屏时长').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.screenTime.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.screenTime = parseInt(value)
            })
          Text('秒').margin({ left: 20 })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })


        Divider().layoutWeight(1).color(Color.Transparent);
        Button('设置').width('80%').margin({ bottom: 30 }).onClick(() => {
          if (Number.isNaN(this.startTime)) {
            ToastUtil.showShort('请输入开始时间');
            return;
          }
          if (Number.isNaN(this.endTime)) {
            ToastUtil.showShort('请输入结束时间');
            return;
          }

          let liftWristPara = new LiftWristPara(this.startTime, this.endTime, this.open);
          FissionSdkManager.getInstance().setLiftWristPara(liftWristPara);

          if (!Number.isNaN(this.screenTime)) {
            FissionSdkManager.getInstance().setScreenKeep(this.screenTime);
          }
        })
        Button('查询').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().getScreenKeep();
          FissionSdkManager.getInstance().getLiftWristPara();

        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }

  }
}