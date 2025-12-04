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
 * @file PageSedentaryPara.ets
 * @author liyi
 * @date 2024/10/29
 * @description 运动目标参数
 */
@HMRouter({ pageUrl: PageConstant.PAGE_SPORT_TARGET_PARA })
@Component
export struct PageSportTargetPara {
  @State isStep: boolean = false;
  @State isCalorie: boolean = false;
  @State isDistance: boolean = false;
  @State isExercise: boolean = false;
  @State targetStep: number = 0;
  @State targetCalorie: number = 0;
  @State targetDistance: number = 0;
  @State targetExTime: number = 0;
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
        that.isStep = sportsTargetPara.getIsStep();
        that.isCalorie = sportsTargetPara.getIsCalorie();
        that.isDistance = sportsTargetPara.getIsDistance();
        that.isExercise = sportsTargetPara.getIsExercise();
        that.targetStep = sportsTargetPara.getTargetStep();
        that.targetCalorie = sportsTargetPara.getTargetCalorie();
        that.targetDistance = sportsTargetPara.getTargetDistance();
        that.targetExTime = sportsTargetPara.getTargetExTime();
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
        ToastUtil.showShort("设置运动目标参数成功");
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


    FissionSdkManager.getInstance().getTargetSet();
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '运动目标参数',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })
        Row() {
          Text('目标步数开关').width(150).textAlign(TextAlign.End)
          Toggle({ type: ToggleType.Switch, isOn: this.isStep })
            .margin({ left: 20 })
            .selectedColor('#007DFF')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.isStep = isOn;
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('目标卡路里开关').width(150).textAlign(TextAlign.End)
          Toggle({ type: ToggleType.Switch, isOn: this.isCalorie })
            .margin({ left: 20 })
            .selectedColor('#007DFF')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.isCalorie = isOn;
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('目标距离开关').width(150).textAlign(TextAlign.End)
          Toggle({ type: ToggleType.Switch, isOn: this.isDistance })
            .margin({ left: 20 })
            .selectedColor('#007DFF')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.isDistance = isOn;
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('目标锻炼开关').width(150).textAlign(TextAlign.End)
          Toggle({ type: ToggleType.Switch, isOn: this.isExercise })
            .margin({ left: 20 })
            .selectedColor('#007DFF')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.isExercise = isOn;
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('目标步数').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.targetStep.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.targetStep = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('目标卡路里消耗').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.targetCalorie.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.targetCalorie = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('目标里程数').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.targetDistance.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.targetDistance = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('目标运动时间').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.targetExTime.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.targetExTime = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Divider().layoutWeight(1).color(Color.Transparent);
        Button('设置').width('80%').margin({ bottom: 30 }).onClick(() => {

          if (Number.isNaN(this.targetStep)) {
            ToastUtil.showShort('请输入目标步数');
            return;
          }
          if (Number.isNaN(this.targetCalorie)) {
            ToastUtil.showShort('请输入目标卡路里');
            return;
          }

          if (Number.isNaN(this.targetDistance)) {
            ToastUtil.showShort('请输入目标里程数');
            return;
          }
          if (Number.isNaN(this.targetExTime)) {
            ToastUtil.showShort('请输入目标运动时间');
            return;
          }

          let sportsTargetPara = new SportsTargetPara(this.isStep, this.isDistance, this.isCalorie, this.isExercise, this.targetStep, this.targetCalorie, this.targetDistance, this.targetExTime);
          FissionSdkManager.getInstance().setTargetSet(sportsTargetPara)
        })
        Button('查询').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().getTargetSet();
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }

  }
}