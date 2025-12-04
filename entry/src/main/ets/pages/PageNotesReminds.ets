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
  FissionMusicInfo,
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


/**
 * @file PageNotesReminds.ets
 * @author liyi
 * @date 2024/10/29
 * @description 推送当前歌曲
 */
@HMRouter({ pageUrl: PageConstant.PAGE_NOTES_REMINDS })
@Entry
@Component
export struct PageUserInfo {
  @State musicName: string = ''; //歌曲名称
  @State musicSinger: string = ''; //演唱者
  @State musicTotalTime: number = NaN; //歌曲总时长
  @State AlbumName: string = ''; //专辑名
  @State playAppName: string = ''; //播放APP名称
  private scroller: Scroller = new Scroller()

  aboutToAppear(): void {

    class BigDataListener extends FissionBigDataCmdResultListener {
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

  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '便签记事提醒',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })
        Row() {
          Text('标题').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.musicName.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.musicName = value
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('演唱者').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.musicSinger.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.musicSinger = value
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('歌曲总时长').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.musicTotalTime.toString() })
            .height(40)
            .width(150)
            .type(InputType.Number)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.musicTotalTime = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('专辑名').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.AlbumName.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.AlbumName = value
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })


        Row() {
          Text('播放app名称').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.playAppName.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.playAppName = value
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Divider().layoutWeight(1).color(Color.Transparent);
        Button('设置').width('80%').margin({ bottom: 30 }).onClick(() => {
          let weekResult = 128;
          let notesReminders: NotesReminders[] = [];
          let notesReminder: NotesReminders = new NotesReminders(0, 1, true, Date.now() + 60000, weekResult, '', "开会", "深圳市领为创新科技有限公司", "开年激励大会", Math.floor(Date.now() / 1000), Math.floor(Date.now() / 1000) + 1800);
          notesReminders.push(notesReminder);
          for (let i = 1; i < 5; i++) {
            notesReminders.push(new NotesReminders(i, 1, true, Date.now() + i * 120000, weekResult, '', "开会" + i, "深圳市领为创新科技有限公司", "开年激励大会", Math.floor(Date.now() / 1000) + i * 300, Math.floor(Date.now() / 1000) + 1800 + i * 300));
          }
          FissionSdkManager.getInstance().setNotesReminders(notesReminders);
        })
        Button('查询').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().getNotesReminders();
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }

  }
}