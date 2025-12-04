import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { HMRouterMgr } from '@hadss/hmrouter';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');

  }



  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    // let testKey = "testKey"
    // pUtil.on(obb)
    //
    // console.info('testKeyTag  全部内容：'+ JSON.stringify(pUtil.getAllData()))
    // if (pUtil.hasKey(testKey)) {
    //   console.info('testKeyTag: 存在：'+ pUtil.getData(testKey,"defaultValue"))
    //   pUtil.putData(testKey,"hello 靓女 000ooo")
    // }else{
    //   pUtil.putData(testKey,"臭叼毛，你死¥¥¥")
    //   console.info('testKeyTag  新建：'+ pUtil.getData(testKey,"defaultValue"))
    // }
    //
    // // pUtil.delete(testKey)
    // // console.info('testKeyTag  删除后：'+ pUtil.getData(testKey,"defaultValue"))
    // console.info('testKeyTag  全部内容删除后：'+ JSON.stringify(pUtil.getAllData()))


    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
