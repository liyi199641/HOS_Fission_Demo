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
 * @file PageWeatherDetailPara.ets
 * @author liyi
 * @date 2024/10/29
 * @description 推送天气详情消息
 */
@HMRouter({ pageUrl: PageConstant.PAGE_WEATHER_DETAIL_PARA })
@Component
export struct PageWeatherDetailPara {
  @State lowTmp: number = 0;
  @State highTmp: number = 0;
  @State curTmp: number = 0;
  weatherCodes: number = 0;
  @State pageWeatherCode: number = 0;
  weatherTypes: string[] = ["晴", "多云", "风", "阴天", "小雨", "大雨", "雪", "雷阵雨", "晴晚上", "多云晚上", "沙尘暴", "阵雨", "阵雨晚上", "雨夹雪", "雾霾", "小雪", "大雪", "中雨", "暴雨", "未知天气"];
  airQuality: string[] = ["差", "好", "很好"]
  pmLevel: string[] = ["PM_LEVEL1", "PM_LEVEL2", "PM_LEVEL3", "PM_LEVEL4", "PM_LEVEL5"]
  private scroller: Scroller = new Scroller()
  @State egDivider: DividerTmp = new DividerTmp(1, 0, 0, Color.Gray);
  @State weatherStr: string = ''

  aboutToAppear(): void {

    class BigDataListener extends  FissionBigDataCmdResultListener {
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
      }

      setFemalePhysiology(): void {

      }

      setWeather(): void {

      }

      setWeatherDetail(): void {
        ToastUtil.showShort("设置天气详情成功");
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

    this.lowTmp = this.getRandom(-30, 21);
    this.highTmp = this.getRandom(-10, 40);
    this.curTmp = this.getRandom(-30, 40);

  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '推送天气详情消息',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })

        Row() {
          Text('选择天气类型').width(150).textAlign(TextAlign.End)
          Button(this.weatherTypes[this.pageWeatherCode])
            .height(40)
            .width(150)
            .margin({ left: 20 })
            .border({ width: 1, color: Color.Gray })
        }.width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })
        .onClick(ev => {
          showTextPickerDialog(this.weatherTypes, this.pageWeatherCode, (value: TextPickerResult) => {
            this.pageWeatherCode = value.index as number;
            this.getWeather(this.pageWeatherCode + 1)
          })
        })

        Row() {
          Text(`天气:${this.weatherStr}`).width(100).textAlign(TextAlign.End)
        }.width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text(`当前气温:${this.curTmp}`).width(100).textAlign(TextAlign.End)
        }.width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text(`最低气温:${this.lowTmp}`).width(100).textAlign(TextAlign.End)
        }.width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 })

        Row() {
          Text(`最高气温:${this.highTmp}`).width(100).textAlign(TextAlign.End)
        }.width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 20 })


        Divider().layoutWeight(1).color(Color.Transparent);

        Button('随机数据').width('80%').margin({ bottom: 30 }).onClick(() => {
          this.lowTmp = this.getRandom(-30, 21);
          this.highTmp = this.getRandom(-10, 40);
          this.curTmp = this.getRandom(-30, 40);
          this.pageWeatherCode = this.getRandom(1, 19);
          this.getWeather(this.pageWeatherCode)

          let todayWeatherDetail: TodayWeatherDetail = new TodayWeatherDetail();
          todayWeatherDetail.setLowSetTmp(this.lowTmp);
          todayWeatherDetail.setHighSetTmp(this.highTmp);
          todayWeatherDetail.setTemperature(this.curTmp);
          todayWeatherDetail.setWeatherCode(this.weatherCodes);
          todayWeatherDetail.setCityName("shenzhen");
          todayWeatherDetail.setCityNameLength(stringToBytes('shenzhen').length);

          let city = '';
          if (SpUtil.getData(SpKeys.CHIP_CHANNEL_TYPE) == HardWareInfo.CHANNEL_TYPE_HS || SpUtil.getData(SpKeys.CHIP_CHANNEL_TYPE) == HardWareInfo.CHANNEL_TYPE_RTK8773) {
            let locale = new intl.Locale().toString();
            if (locale === "zh-CN") {
              city = '深圳';
              todayWeatherDetail.setCityName("深圳");
              todayWeatherDetail.setCityNameLength(stringToBytes("深圳").length);
            } else {
              city = 'shenzhen';
              todayWeatherDetail.setCityName("shenzhen");
              todayWeatherDetail.setCityNameLength(stringToBytes('shenzhen').length);
            }
          }
          FissionSdkManager.getInstance().setSingleWeather(this.curTmp, this.highTmp, this.lowTmp, this.weatherCodes, city);
          // FissionSdkManager.getInstance().setWeatherDetail(todayWeatherDetail);
        })
        Button('设置')
          .width('80%')
          .margin({ bottom: 30 })
          .onClick(() => {
            if (SpUtil.getData(SpKeys.CHIP_CHANNEL_TYPE) == HardWareInfo.CHANNEL_TYPE_HS || SpUtil.getData(SpKeys.CHIP_CHANNEL_TYPE) == HardWareInfo.CHANNEL_TYPE_RTK8773) {
              let locale = new intl.Locale().toString();
              let city = '';
              if (locale === "zh-CN") {
                city = '深圳'
              }else{
                city = 'shenzhen';
              }
              FissionSdkManager.getInstance().setSingleWeather(this.curTmp, this.highTmp, this.lowTmp, this.weatherCodes, city);
            }else{
              FissionSdkManager.getInstance().setSingleWeather(this.curTmp, this.highTmp, this.lowTmp, this.weatherCodes, '');
            }
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

  private getWeather(weatherCode: number) {
    switch (weatherCode) {
      case 1: // 晴天
        this.weatherCodes = 0;
        this.weatherStr = "晴天";
        break;
      case 2: // 多云
        this.weatherCodes = 1;
        this.weatherStr = "多云";
        break;
      case 3: // 风
        this.weatherCodes = 2;
        this.weatherStr = "大风";
        break;
      case 4: // 阴天
        this.weatherCodes = 3;
        this.weatherStr = "阴天";
        break;
      case 5: // 阵雨
        this.weatherCodes = 4;
        this.weatherStr = "小雨";
        break;
      case 6: // 雷阵雨、雷阵雨伴有冰雹
        this.weatherCodes = 5;
        this.weatherStr = "大雨";
        break;
      case 7: // 小雨
        this.weatherCodes = 6;
        this.weatherStr = "中雪";
        break;
      case 8: // 中雨
        this.weatherCodes = 7;
        this.weatherStr = "雷阵雨";
        break;
      case 9: // 暴雨
        this.weatherCodes = 8;
        this.weatherStr = "夜间晴";
        break;
      case 10: // 夜间多云
        this.weatherCodes = 9;
        this.weatherStr = "夜间多云";
        break;
      case 11: // 沙尘暴
        this.weatherCodes = 10;
        this.weatherStr = "沙尘暴";
        break;
      case 12: // 阵雨
        this.weatherCodes = 11;
        this.weatherStr = "阵雨";
        break;
      case 13: // 夜间阵雨
        this.weatherCodes = 12;
        this.weatherStr = "夜间阵雨";
        break;
      case 14: // 雨夹雪
        this.weatherCodes = 13;
        this.weatherStr = "雨夹雪";
        break;
      case 15: // 雾霾
        this.weatherCodes = 14;
        this.weatherStr = "雾霾";
        break;
      case 16: // 小雪
        this.weatherCodes = 15;
        this.weatherStr = "小雪";
        break;
      case 17: // 大雪
        this.weatherCodes = 16;
        this.weatherStr = "大雪";
      case 18: // 小雪
        this.weatherCodes = 17;
        this.weatherStr = "中雨";
        break;
      case 19: // 大雪
        this.weatherCodes = 18;
        this.weatherStr = "暴雨";
        break;
      case 255: // 未知天气
        this.weatherCodes = 255;
        this.weatherStr = "未知天气";
        break;
    }
  }
}