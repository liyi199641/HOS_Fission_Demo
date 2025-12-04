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
 * @file PageUserInfo.ets
 * @author liyi
 * @date 2024/10/29
 * @description 用户信息
 */
@HMRouter({ pageUrl: PageConstant.PAGE_USER_INFO })
@Entry
@Component
export struct PageUserInfo {
  @State userId: number = 0; // 用户ID
  @State bodyVersion: number = 0; // 结构体版本
  @State userHeight: number = 0; // 身高
  @State weight: number = 0; // 体重
  @State timeZone: number = 0; // 时区
  @State sex: number = 0; // 性别 0男 1女
  @State age: number = 0; // 年龄
  @State stride: number = 0; // 步幅，单位CM
  @State nickname: string = '';
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
        that.userId = userInfo.getUserId();
        that.bodyVersion = userInfo.getBodyVersion(); // 结构体版本
        that.userHeight = userInfo.getHeight(); // 身高
        that.weight = userInfo.getWeight(); // 体重
        that.timeZone = userInfo.getTimeZone(); // 时区
        that.sex = userInfo.getSex(); // 性别
        that.age = userInfo.getAge(); // 年龄
        that.stride = userInfo.getStride(); // 步幅，单位CM
        that.nickname = userInfo.getNickname();
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
        ToastUtil.showShort('设置用户信息成功');
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

    FissionSdkManager.getInstance().getUserInfo();
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '用户个人信息',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })
        Row() {
          Text('ID').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.userId.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.userId = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('昵称').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '16字以内', text: this.nickname.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .onChange((value: string) => {
              this.nickname = value
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('性别').width(100).textAlign(TextAlign.End)
          Row() {
            Row() {
              Radio({ value: '男', group: 'radioGroup' })
                .checked(this.sex == 0)
                .onChange((isChecked: boolean) => {
                  if (isChecked) {
                    this.sex = 0;
                  }
                })
              Text("男")
            }.width(50)
            Row(){
              Radio({ value: '女', group: 'radioGroup' })
                .checked(this.sex == 1)
                .onChange((isChecked: boolean) => {
                  if (isChecked) {
                    this.sex = 1;
                  }
                })
              Text("女")
            }.width(50)

          }
          .margin({ left: 20 })

        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('年龄').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.age.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.age = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('身高').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.userHeight.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.userHeight = parseInt(value)
            })
          Text('  cm')
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('体重').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.weight.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.weight = parseInt(value)
            })
          Text('  kg')
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('步幅').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.stride.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.stride = parseInt(value)
            })
          Text('  cm')
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text('时区').width(100).textAlign(TextAlign.End)
          TextInput({ placeholder: '', text: this.timeZone.toString() })
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
            .type(InputType.Number)
            .onChange((value: string) => {
              this.timeZone = parseInt(value)
            })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Divider().layoutWeight(1).color(Color.Transparent);
        Button('设置').width('80%').margin({ bottom: 30 }).onClick(() => {
          if (Number.isNaN(this.userId)) {
            ToastUtil.showShort('请输入用户ID');
            return;
          }
          if (this.userId <= 0) {
            ToastUtil.showShort('请输入有效的ID');
            return;
          }

          if (!this.nickname) {
            ToastUtil.showShort('请输入昵称');
            return;
          }
          if (this.nickname.length > 16) {
            ToastUtil.showShort('昵称过长');
            return;
          }
          if (Number.isNaN(this.timeZone)) {
            ToastUtil.showShort('请输入时区');
            return;
          }
          if (Number.isNaN(this.age)) {
            ToastUtil.showShort('请输入年龄');
            return;
          }

          if (Number.isNaN(this.userHeight)) {
            ToastUtil.showShort('请输入身高');
            return;
          }

          if (Number.isNaN(this.weight)) {
            ToastUtil.showShort('请输入体重');
            return;
          }

          if (Number.isNaN(this.stride)) {
            ToastUtil.showShort('请输入步幅');
            return;
          }

          let userInfo = new UserInfo(this.userId, this.nickname, this.userHeight, this.weight, this.sex, this.age, this.stride);
          userInfo.setTimeZone(this.timeZone)
          FissionSdkManager.getInstance().setUserInfo(userInfo)
        })
        Button('查询').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().getUserInfo();
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }

  }
}