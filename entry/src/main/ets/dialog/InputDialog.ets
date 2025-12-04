import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
/**
 * @file InputDialog.ets
 * @author liyi
 * @date 2024/10/26F
 * @description 描述文件的功能
 */
import { PageConstant } from '../constant/PageConstant';
import { DialogParam } from '../bean/InputDialogParam';

@HMRouter({ pageUrl: PageConstant.INPUT_DIALOG, dialog: true })
@Component
export struct InputDialog {
  @State title: string = 'title'
  @State textValue: string = ''

  aboutToAppear(): void {
    let param = HMRouterMgr.getCurrentParam() as DialogParam;
    if(param){
      this.title = param.title;
      this.textValue = param.textValue;
    }
  }
  build() {
    Column() {
      Column() {
        Text(this.title).fontSize(20).margin({ top: 10, bottom: 10 })
        TextInput({ placeholder: '', text: this.textValue }).height(60).width('90%')
          .type(InputType.Number)
          .defaultFocus(true) // 页面首次打开时，该TextInput获取焦点
          .onChange((value: string) => {
            this.textValue = value
          })
        Flex({ justifyContent: FlexAlign.SpaceAround }) {
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
                param: this.textValue
              })
            }).fontColor(Color.White)
        }.margin({ top: 20 })
      }.backgroundColor(Color.White)
      .padding({ bottom: 30 })
      .onClick(ev => {
      })
    }.borderRadius(10)
    .height('100%')
    .backgroundColor(Color.Transparent)
    .justifyContent(FlexAlign.Start)
    .onClick(ev => {
      HMRouterMgr.pop({
        navigationId: this.queryNavigationInfo()?.navigationId
      })
    })
  }
}