import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';
import { BigDataTimeParam } from '../bean/BigDataTimeParam';

import { DividerTmp } from '../components/DividerTmp';
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
import { DateUtil } from 'module_common';
import { ExerciseDetailRecord } from 'fission_sdk';
import { ToastUtil } from '@pura/harmony-utils';

/**
 * @file PageExercise.ets
 * @author liyi
 * @date 2024/10/29
 * @description 运动数据
 */
@HMRouter({ pageUrl: PageConstant.PAGE_EXERCISE })
@Component
export struct PageExercise {
  @State messages: Array<ExerciseReport> = []
  @State startTime: number = 0;
  @State endTime: number = 0;
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
        that.messages = exerciseReports;
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
        HMRouterMgr.push({
          pageUrl: PageConstant.SHOW_CONTENT_DIALOG, param: that.formatDetail(exerciseDetails)
        })
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



    let param: BigDataTimeParam = HMRouterMgr.getCurrentParam() as BigDataTimeParam;
    this.startTime = param.startTime;
    this.endTime = param.endTime;

    FissionSdkManager.getInstance().getExerciseReport(this.startTime, this.endTime / 1000);
  }

  build() {
    List() {
      ForEach(this.messages, (item: ExerciseReport) => {
        ListItem() {
          Text(this.formatReport(item))
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .margin({ left: 20, right: 20 })
            .layoutWeight(1)
            .constraintSize({ minHeight: 40 })
        }.onClick(event => {
          FissionSdkManager.getInstance().getExerciseDetail(item.getBeginTime(), item.getEndTime());
        })
      }, (item: ExerciseReport) => item.getUtcTime().toString())
    }
    .width('100%')
    .height('100%')
    .divider(this.egDivider)
  }

  formatReport(exerciseReport: ExerciseReport): string {
    let content = "";
    content += `\n 数据生成时间：${DateUtil.formatDate(exerciseReport.getUtcTime()* 1000, DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS)}`;
    content += `\n 开始时间：${DateUtil.formatDate(exerciseReport.getBeginTime() * 1000, DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS)}`;
    content += `\n 结束时间：${DateUtil.formatDate(exerciseReport.getEndTime() * 1000, DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS)}`;
    content += `\n ${this.getSportMode(exerciseReport.getModel())}`;
    content += `\n 运动总时间：${exerciseReport.getTotalTime()} 秒`;
    content += `\n 运动总步数：${exerciseReport.getTotalStep()} 步`;
    content += `\n 运动平均心率：${exerciseReport.getAvgHR()} 次`;

    content += `\n 运动总卡路里：${exerciseReport.getTotalCalorie()} KCAL`;
    content += `\n 运动总距离：${exerciseReport.getTotalDistance()} m`;
    content += `\n 运动平均步频：${exerciseReport.getAvgStride()} m`;
    content += `\n 运动平均速度：${exerciseReport.getAvgSpeed()} m`;
    content += `\n 本次运动轨迹距离：${exerciseReport.getTotalTrackDistance()} m`;
    let peisu: string = DateUtil.formatDuration(exerciseReport.getNotTrackAvgSpeed());
    content += `\n 本次无轨迹运动平均配速：${peisu} KM/h`;
    content += `\n 本次有轨迹运动平均配速：${exerciseReport.getHasTrackAvgSpeed()} KM/h`;
    // let distance:number = exerciseReport.getTotalDistance()/1000;
    // let cauPace:number = exerciseReport.getTotalTime() / distance;
    // let pacc:string = DateUtil.formatDuration(cauPace);
    content += `\n 热身运动时间：${exerciseReport.getWarmUpEsTime()} 秒`;
    content += `\n 燃脂运动时间：${exerciseReport.getFatBurningTime()} 秒`;
    content += `\n 有氧耐力运动时间：${exerciseReport.getAerobicEnduranceTime()} 秒`;
    content += `\n 高强有氧耐力运动时间：${exerciseReport.getHighAerobicEnduranceTime()} 秒`;
    content += `\n 无氧运动时间：${exerciseReport.getAnaerobicTime()} 秒`;
    return content;
  }

  formatDetail(exerciseDetails: ExerciseDetail[]): string {
    let content = "";
    exerciseDetails.forEach((exerciseDetail: ExerciseDetail) => {
      content += `\n utc记录时间：${DateUtil.formatDate(exerciseDetail.getTime() * 1000, DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS)}`;
      content += `\n 结构体版本：${DateUtil.formatDate(exerciseDetail.getBodyVersion() * 1000, DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS)}`;
      content += `\n 记录生成周期：${exerciseDetail.getWeek()}`;
      content += `\n 有效记录条数：${exerciseDetail.getEffectiveNumber()}`;
      content += `\n 单条记录长度：${exerciseDetail.getRecordLength()}`;
      content += `\n 记录类型：${exerciseDetail.getType()}`;
      content += `\n\n\n`;

      exerciseDetail.getExerciseDetailRecords().forEach((exerciseDetailRecord: ExerciseDetailRecord) => {
        content += `\n 实时配速: ${exerciseDetailRecord.getPace()}`;
        content += `\n 实时步频: ${exerciseDetailRecord.getFrequency()}`;
        content += `\n 卡路里: ${exerciseDetailRecord.getCalorie()}`;
        content += `\n 步数: ${exerciseDetailRecord.getSteps()}`;
        content += `\n 距离: ${exerciseDetailRecord.getDistance()}`;
        content += `\n 心率: ${exerciseDetailRecord.getHeartRate()}`;
        content += `\n 实时体力: ${exerciseDetailRecord.getStamina()}`;
        content += `\n 状态: ${exerciseDetailRecord.getState()}`;
        content += `\n 每公里配速: ${exerciseDetailRecord.getKmPace()}`;
        content += `\n 每英里配速: ${exerciseDetailRecord.getMiPace()}`;
        content += `\n-------------------------------\n\n`;
      });
    })
    return content;
  }

  private getSportMode(model: number): string {
    let sportName = '';
    switch (model) {
      case 0: //健走
        sportName = "健走";
        break;
      case 1: // 晴天
        sportName = "跑步";
        break;
      case 2: // 多云
        sportName = "登山";
        break;
      case 3: // 风
        sportName = "骑行";
        break;
      case 4: // 阴天
        sportName = "足球";
        break;
      case 5: // 阵雨
        sportName = "游泳";
        break;
      case 6: // 雷阵雨、雷阵雨伴有冰雹
        sportName = "篮球";
        break;
      case 7: // 小雨
        sportName = "无指定";
        break;
      case 8: // 中雨
        sportName = "户外跑步";
        break;
      case 9: // 暴雨
        sportName = "室内跑步";
        break;
      case 10: // 夜间多云
        sportName = "减脂跑步";
        break;
      case 11: // 沙尘暴
        sportName = "户外健走";
        break;
      case 12: // 阵雨
        sportName = "室内健走";
        break;
      case 13: // 夜间阵雨
        sportName = "户外骑行";
        break;
      case 14: // 雨夹雪
        sportName = "室内骑行";
        break;
      case 15: // 雾霾
        sportName = "自由训练";
        break;
      case 16: // 小雪
        sportName = "健身训练";
        break;
      case 17: // 大雪
        sportName = "羽毛球";
        break;
      case 18: // 未知天气
        sportName = "排球";
        break;
      case 19: // 未知天气
        sportName = "兵乓球";
        break;
      case 20: // 未知天气
        sportName = "椭圆机";
        break;
      case 21: // 未知天气
        sportName = "划船机";
        break;
      case 22: // 未知天气
        sportName = "瑜伽";
        break;
      case 23: // 未知天气
        sportName = "力量训练";
        break;
      case 24: // 未知天气
        sportName = "板球";
        break;
      case 25: // 未知天气
        sportName = "跳绳";
        break;
      case 26: // 未知天气
        sportName = "有氧运动";
        break;
      case 27: // 未知天气
        sportName = "健身舞";
        break;
      case 28: // 未知天气
        sportName = "太极拳";
        break;
      case 29: // 未知天气
        sportName = "自动识别跑步运动";
        break;
      case 30: // 未知天气
        sportName = "自动识别健走运动";
        break;
    }
    return sportName;
  }
}