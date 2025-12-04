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
 * @file PageHrWarnPara.ets
 * @author liyi
 * @date 2024/10/29
 * @description 心率异常提醒设置
 */
@HMRouter({ pageUrl: PageConstant.PAGE_HR_WARN_PARA })
@Component
export struct PageHrWarnPara {
  @State mainSwitch: boolean = false;
  @State maxHrWarn: number = 0;
  @State minHrWarn: number = 0;
  @State limitTime: number = 0;
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

      }

      getTargetSet(sportsTargetPara: SportsTargetPara): void {

      }

      getFemalePhysiology(femalePhysiology: FemalePhysiology): void {

      }

      getHrWarnPara(hrWarnPara: HrWarnPara): void {
        that.mainSwitch = hrWarnPara.isMainSwitch();
        that.maxHrWarn = hrWarnPara.getMaxHrWarn();
        that.minHrWarn = hrWarnPara.getMinHrWarn();
        that.limitTime = hrWarnPara.getLimitTime();
        that.startTime = hrWarnPara.getStartTime();
        that.endTime = hrWarnPara.getEndTime();
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

    FissionSdkManager.getInstance().getHrWarnPara();
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '心率异常提醒设置',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })
        Row() {
          Text('自动检测开关').width(150).textAlign(TextAlign.End)
          Toggle({ type: ToggleType.Switch, isOn: this.mainSwitch })
            .margin({ left: 20 })
            .selectedColor('#007DFF')
            .switchPointColor('#FFFFFF')
            .onChange((isOn: boolean) => {
              this.mainSwitch = isOn;
              console.info('Component status:' + isOn)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('心率检测周期').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.limitTime.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.limitTime = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('心率检测起始时间').width(150).textAlign(TextAlign.End)
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
          Text('心率检测结束时间').width(150).textAlign(TextAlign.End)
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
          Text('最大心率').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.maxHrWarn.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.maxHrWarn = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('最小心率').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.minHrWarn.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.minHrWarn = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Divider().layoutWeight(1).color(Color.Transparent);
        Button('设置').width('80%').margin({ bottom: 30 }).onClick(() => {
          if (Number.isNaN(this.limitTime)) {
            ToastUtil.showShort('请输入提醒周期时间');
            return;
          }
          if (Number.isNaN(this.startTime)) {
            ToastUtil.showShort('请输入开始时间');
            return;
          }
          if (Number.isNaN(this.endTime)) {
            ToastUtil.showShort('请输入结束时间');
            return;
          }
          if (Number.isNaN(this.maxHrWarn)) {
            ToastUtil.showShort('请输入最大心率预警');
            return;
          }
          if (Number.isNaN(this.minHrWarn)) {
            ToastUtil.showShort('请输入最小心率预警');
            return;
          }

          let hrWarnPara = new HrWarnPara();
          hrWarnPara.setMainSwitch(this.mainSwitch);
          hrWarnPara.setMaxHrWarn(this.maxHrWarn);
          hrWarnPara.setMinHrWarn(this.minHrWarn);
          hrWarnPara.setStartTime(this.startTime);
          hrWarnPara.setEndTime(this.endTime);
          FissionSdkManager.getInstance().setHrWarnPara(hrWarnPara)
        })
        Button('查询').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().getHrWarnPara();
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }

  }
}