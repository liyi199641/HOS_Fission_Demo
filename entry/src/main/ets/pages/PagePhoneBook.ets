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
  PhoneBook,
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
 * @description 电话簿
 */
@HMRouter({ pageUrl: PageConstant.PAGE_PHONE_BOOK })
@Preview
@Component
export struct PagePhoneBook {
  @State listContent: PhoneBook[] = [];
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
        ToastUtil.showToast('推送歌曲信息成功');
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
        ToastUtil.showShort("设置联系人成功");
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
    this.listContent = this.createData(10)
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '同步电话簿',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })

        PhoneBookItem({
          isHead: true
        }).margin({ top: 20, left: 20, right: 20 })
        List() {
          ForEach(this.listContent, (item: PhoneBook, index: number) => {
            ListItem() {
              PhoneBookItem({
                phoneBook: item,
                isHead: false,
                index: index
              })
            }.onClick(event => {

            }).backgroundColor('#FFF4F4F4').border({ radius: 20 }).margin({ top: 10, bottom: 10 })
          })
        }
        .height(0)
        .margin(20)
        .layoutWeight(1)
        .border({ width: 1, color: Color.Black })


        Button('设置联系人').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().setPhoneBooks(this.listContent)
        })
        Button('设置紧急联系人').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().setPhoneBooks(this.listContent.slice(0, 3))
        })
        Button('删除所有联系人').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().setPhoneBooks([])
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }.width('100%')
    .height('100%')
  }

  createData(count: number): PhoneBook[] {
    let phoneBooks: PhoneBook[] = []
    for (let i = 0; i < count; i++) {
      phoneBooks.push(new PhoneBook('张' + (i + 1), '中国深圳', '1502538566' + i));
    }
    return phoneBooks;
  }
}

@Component
struct PhoneBookItem {
  @Prop phoneBook: PhoneBook
  @Prop isHead: boolean = false;
  @Prop index: number = 0;

  build() {
    Row() {
      Text(this.isHead ? "序号" : this.index.toString()).constraintSize({ minWidth: 50, maxWidth: 50 }).textAlign(TextAlign.Center);
      Text(this.isHead ? "姓名" : this.phoneBook.getName().toString()).constraintSize({ minWidth: 50, maxWidth: 50 }).textAlign(TextAlign.Center);
      Text(this.isHead ? "备注信息" : this.phoneBook.getRemark().toString()).constraintSize({ minWidth: 80, maxWidth: 80 }).textAlign(TextAlign.Center);
      Text(this.isHead ? "手机号码" : this.phoneBook.getPhoneNumber()).layoutWeight(1).textAlign(TextAlign.Center);
    }
  }
}
