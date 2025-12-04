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
 * @file PageAlarmInfo.ets
 * @author liyi
 * @date 2024/10/29
 * @description 闹钟信息
 */
@HMRouter({ pageUrl: PageConstant.PAGE_ALARM_INFO })
@Component
export struct PageAlarmInfo {
  @State userId: number = 0; // 用户ID
  @State bodyVersion: number = 0; // 结构体版本
  @State userHeight: number = 0; // 身高
  @State weight: number = 0; // 体重
  @State timeZone: number = 0; // 时区
  @State sex: number = 0; // 性别 0男 1女
  @State age: number = 0; // 年龄
  @State stride: number = 0; // 步幅，单位CM
  @State nickname: string = '';
  @State alarms: FissionAlarm[] = [];
  private scroller: Scroller = new Scroller()

  aboutToAppear(): void {

    let that = this;
    class BigDataListener extends  FissionBigDataCmdResultListener {
      sendSuccess(cmdId: string): void {

      }

      sendFail(cmdId: string): void {

      }

      onResultTimeout(cmdId: string): void {

      }

      onResultError(errorMsg: string): void {

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
        that.alarms = fissionAlarms;
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
        ToastUtil.showShort('设置闹钟信息成功')
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

    FissionSdkManager.getInstance().getAlarm();
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '闹钟信息',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })

        List() {
          ForEach(this.alarms, (item: FissionAlarm) => {
            ListItem() {
              Text(this.formatContent(item)).width('100%').padding({ left: 10, right: 10 });
            }.onClick(event => {

            }).backgroundColor('#FFF4F4F4').border({ radius: 20 }).margin(20)
          })
        }
        .width('90%')
        .height(0)
        .margin(20)
        .layoutWeight(1)
        .border({ width: 1, color: Color.Black })


        Button('设置五个闹钟').width('80%').margin({ bottom: 30 }).onClick(() => {
          this.alarms = this.createAlarm(5);
          FissionSdkManager.getInstance().setAlarmInfos(this.alarms)
        })
        Button('设置十个闹钟').width('80%').margin({ bottom: 30 }).onClick(() => {
          this.alarms = this.createAlarm(10);
          FissionSdkManager.getInstance().setAlarmInfos(this.alarms)
        })
        Button('查询').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().getAlarm();
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }.width('100%')
    .height('100%')
  }

  createAlarm(count: number): FissionAlarm[] {
    let alarms: FissionAlarm[] = []
    for (let i = 0; i < count; i++) {
      alarms.push(new FissionAlarm(i, 1, true, Date.now() + i * 120000, 128, '备注内容' + i));
    }
    return alarms;
  }

  getRandom(small: number, bigNum: number): number {
    let num = Math.floor(Math.random() * (bigNum - small + 1)) + small; // 生成幸运数
    if (num === 17) {
      num = 255;
    }
    return num;
  }

  formatContent(alarm: FissionAlarm): string {
    let content = '';
    content = `\n结构体版本: ${alarm.getBodyVersion()}`;
    content += `\n序号: ${alarm.getIndex()}`;
    content += `\n闹钟有效性: ${alarm.isAlarmActive()}`;
    content += `\n闹铃类别: ${alarm.getType()}`;
    content += `\n使能开关: ${alarm.isOpen()}`;
    content += `\n报警状态: ${alarm.getAlarmState()}`;
    content += `\n是否稍后提醒: ${alarm.isAlarmDelayAlert()}`;
    content += `\n周期掩码: ${alarm.getWeekCode()}`;
    content += `\n提醒震动方式: ${alarm.getShakeType()}`;
    content += `\n时间: ${alarm.getYear()}年${alarm.getMonth()}月${alarm.getDay()}日${alarm.getHour()}时${alarm.getMinute()}分`;
    content += `\n提醒次数: ${alarm.getAlertCount()}`;
    content += `\n已提醒次数: ${alarm.getAlertedCount()}`;
    content += `\n再次提醒的间隔: ${alarm.getAlertIntervalTime()}`;
    content += `\n描述的长度: ${alarm.getRemarkLength()}`;
    content += `\n描述: ${alarm.getRemark()}`;
    content += `\n`;
    return content;
  }
}
