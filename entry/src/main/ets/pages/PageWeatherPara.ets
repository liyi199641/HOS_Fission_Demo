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
  UserInfo,
  WeatherParam
} from 'fission_sdk';
import { TitleBar } from '../components/TitleBar';
import { ToastUtil } from '@pura/harmony-utils';
import { DividerTmp } from '../components/DividerTmp';

/**
 * @file PageWeatherPara.ets
 * @author liyi
 * @date 2024/10/29
 * @description 推送天气消息
 */
@HMRouter({ pageUrl: PageConstant.PAGE_WEATHER_PARA })
@Component
export struct PageWeatherPara {
  weatherNumber: string[] = ['第一天', '第二天', '第三天', '第四天', '第五天', '第六天', '第七天', '第八天'];
  weatherTypes: string[] = ["晴", "多云", "风", "阴天", "小雨", "大雨", "雪", "雷阵雨", "晴晚上", "多云晚上", "沙尘暴", "阵雨", "阵雨晚上", "雨夹雪", "雾霾", "小雪", "大雪", "中雨", "暴雨", "未知天气"];
  airQuality: string[] = ["差", "好", "很好"]
  pmLevel: string[] = ["PM_LEVEL1", "PM_LEVEL2", "PM_LEVEL3", "PM_LEVEL4", "PM_LEVEL5"]
  @State selectWeather: number = 0;
  @State weatherList: WeatherParam[] = []
  private scroller: Scroller = new Scroller()
  @State egDivider: DividerTmp = new DividerTmp(1, 0, 0, Color.Gray);

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
        ToastUtil.showShort("设置天气成功");
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


    let temWeathers: WeatherParam[] = []
    for (let i = 0; i < 8; i++) {
      let detail: WeatherParam = new WeatherParam();
      detail.setLowestTemperature(this.getRandom(-30, 20));
      detail.setMaximumTemperature(this.getRandom(-10, 40));
      detail.setIndex(i);
      detail.setWeather(this.getRandom(0, 18));
      temWeathers.push(detail);
    }

    this.weatherList = temWeathers;
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        TitleBar({
          title: '推送天气消息',
          onBackClick: () => {
            HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
          }
        })


        // Row() {
        //   Text('选择推送天数').width(150).textAlign(TextAlign.End)
        //   Button(this.weatherNumber[this.selectWeather])
        //     .height(40)
        //     .width(150)
        //     .margin({ left: 20 })
        //     .border({ width: 1, color: Color.Gray })
        // }.width('100%')
        // .alignItems(VerticalAlign.Center)
        // .margin({ top: 20 })
        // .onClick(ev => {
        //   showTextPickerDialog(this.weatherNumber, this.selectWeather, (value: TextPickerResult) => {
        //     this.selectWeather = value.index as number;
        //   })
        // })

        List() {
          ForEach(this.weatherList, (item: WeatherParam, index: number) => {
            ListItem() {
              Column() {
                Text(item.getIndex() == 0 ? `昨日:${this.getWeather(item.getWeather())}` : `第${item.getIndex()}天: ${this.getWeather(item.getWeather())}`)
                Row() {
                  Text(`最高气温: ${item.getMaximumTemperature()}`)
                  Text(`最低气温: ${item.getLowestTemperature()}`).margin({ left: 10 })
                }.margin({ top: 10 })
              }.margin(20)
            }
          })
        }.width('100%').height(0).layoutWeight(1).divider(this.egDivider)


        // Divider().layoutWeight(1).color(Color.Transparent);
        Button('随机数据').width('80%').margin({ bottom: 30 }).onClick(() => {
          this.weatherList = [];
          let tempWeathers: WeatherParam[] = []
          for (let i = 0; i < 9; i++) {
            let detail: WeatherParam = new WeatherParam();
            detail.setLowestTemperature(this.getRandom(-30, 20));
            detail.setMaximumTemperature(this.getRandom(-10, 40));
            detail.setIndex(i);
            detail.setWeather(this.getRandom(1, 18));
            tempWeathers.push(detail)
          }
          this.weatherList = tempWeathers;
          FissionSdkManager.getInstance().setWeather(this.weatherList);
        })
        Button('设置').width('80%').margin({ bottom: 30 }).onClick(() => {
          FissionSdkManager.getInstance().setWeather(this.weatherList);
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
    let weatherStr = '';
    switch (weatherCode) {
      case 0: // 晴天
        weatherStr = "晴天";
        break;
      case 1: // 多云
        weatherStr = "多云";
        break;
      case 2: // 风
        weatherStr = "大风";
        break;
      case 3: // 阴天
        weatherStr = "阴天";
        break;
      case 4: // 阵雨
        weatherStr = "小雨";
        break;
      case 5: // 雷阵雨、雷阵雨伴有冰雹
        weatherStr = "大雨";
        break;
      case 6: // 小雨
        weatherStr = "中雪";
        break;
      case 7: // 中雨
        weatherStr = "雷阵雨";
        break;
      case 8: // 暴雨
        weatherStr = "夜间晴";
        break;
      case 9: // 夜间多云
        weatherStr = "夜间多云";
        break;
      case 10: // 沙尘暴
        weatherStr = "沙尘暴";
        break;
      case 11: // 阵雨
        weatherStr = "阵雨";
        break;
      case 12: // 夜间阵雨
        weatherStr = "夜间阵雨";
        break;
      case 13: // 雨夹雪
        weatherStr = "雨夹雪";
        break;
      case 14: // 雾霾
        weatherStr = "雾霾";
        break;
      case 15: // 小雪
        weatherStr = "小雪";
        break;
      case 16: // 大雪
        weatherStr = "大雪";
        break;
      case 17: // 小雪
        weatherStr = "中雨";
        break;
      case 18: // 大雪
        weatherStr = "暴雨";
        break;
      case 255: // 未知天气
        weatherStr = "未知天气";
        break;
    }
    return weatherStr;
  }
}