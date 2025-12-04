import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';

import {
  AppMessageBean,
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
  SpKeys,
  Spo2Record,
  SportListInfo,
  SportsTargetPara,
  SpUtil,
  StepsRecord,
  SystemFunctionSwitch,
  TodayWeatherDetail,
  UserInfo,
  WeatherParam
} from 'fission_sdk';
import { TitleBar } from '../components/TitleBar';
import { ToastUtil } from '@pura/harmony-utils';
import { DividerTmp } from '../components/DividerTmp';
import { showTextPickerDialog } from '../dialog/DialogUtil';
import { stringToBytes } from 'fission_sdk';
import { intl } from '@kit.LocalizationKit';

/**
 * @file PageAppMsgPushPara.ets
 * @author liyi
 * @date 2024/10/29
 * @description 手机来电消息
 */
@HMRouter({ pageUrl: PageConstant.PAGE_PHONE_CALL })
@Component
export struct PagePhoneCall {
  @State type: number = 0;
  @State name: string = '';
  @State content: string = '';
  @State pageWeatherCode: number = 0;
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
        ToastUtil.showToast("设置手机来电成功");
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
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '手机来电消息',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })


        Row() {
          Text('姓名').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.name.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.name = value
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('手机号码').width(150).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.content.toString() })
            .height(40)
            .width(150)
            .type(InputType.PhoneNumber)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.content = value
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })


        Divider().layoutWeight(1).color(Color.Transparent);

        Button('设置').width('80%').margin({ bottom: 30 }).onClick(() => {

          if (!this.name) {
            ToastUtil.showShort("联系人不能为空")
            return;
          }
          if (stringToBytes(this.name).length > 48) {
            ToastUtil.showShort("联系人过长")
            return;
          }
          if (!this.content) {
            ToastUtil.showShort("内容不能为空")
            return;
          }
          if (stringToBytes(this.content).length > 20) {
            ToastUtil.showShort("内容过长")
            return;
          }

          FissionSdkManager.getInstance().incomingCall(Math.floor(Date.now() / 1000), this.name, this.content);
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
  }

  getRandom(small: number, bigNum: number): number {
    let num = Math.floor(Math.random() * (bigNum - small + 1)) + small; // 生成幸运数
    if (num === 17) {
      num = 255;
    }
    return num;
  }
}