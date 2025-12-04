import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
/**
 * @file InputDialog.ets
 * @author liyi
 * @date 2024/10/26F
 * @description 描述文件的功能
 */
import { PageConstant } from '../constant/PageConstant';
import { DialogParam } from '../bean/InputDialogParam';
import { MusicConfig } from 'fission_sdk';
import { InputMusicDialogParam } from '../bean/InputMusicDialogParam';

@HMRouter({ pageUrl: PageConstant.INPUT_DIALOG_STO, dialog: true })
@Component
export struct InputStoDialog {
  @State title: string = '设置撕裂补偿'
  @State value: number = 200;

  aboutToAppear(): void {
    let param: number = HMRouterMgr.getCurrentParam() as number;
    if (param) {
      this.value = param;
    }
  }

  build() {
    Column() {
      Column() {
        Text(this.title).fontSize(20).margin({ top: 10, bottom: 10 })

        Row() {
          TextInput({ text: this.value.toString() })
            .height(60)
            .type(InputType.Number)
            .layoutWeight(1)
            .defaultFocus(true)// 页面首次打开时，该TextInput获取焦点
            .onChange((value: string) => {
              this.value = parseInt(value);
            })

        }.width('80%')

        Flex({ justifyContent: FlexAlign.SpaceAround }) {

          Button('减')
            .onClick(() => {
              if (this.value >= 10) {
                this.value -= 10;
              }
            }).fontColor(Color.White)
          Button('加')
            .onClick(() => {
              this.value += 10;
            }).fontColor(Color.White)
          Button('cancel')
            .onClick(() => {
              HMRouterMgr.pop({
                navigationId: this.queryNavigationInfo()?.navigationId
              })
            }).fontColor(Color.White)
          Button('confirm')
            .onClick(() => {
              HMRouterMgr.pop({
                navigationId: this.queryNavigationInfo()?.navigationId,
                param: this.value
              })
            }).fontColor(Color.White)
        }.margin({ top: 20 })
      }.backgroundColor(Color.White).padding({ bottom: 30 })
      .onClick(ev => {
      })
    }
    .borderRadius(10)
    .height('100%')
    .backgroundColor('#80000000')
    .justifyContent(FlexAlign.Start)
    .onClick(ev => {
      HMRouterMgr.pop({
        navigationId: this.queryNavigationInfo()?.navigationId
      })
    })
  }
}