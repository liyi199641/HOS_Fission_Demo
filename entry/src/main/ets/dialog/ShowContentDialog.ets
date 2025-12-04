import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
/**
 * @file InputDialog.ets
 * @author liyi
 * @date 2024/10/26F
 * @description 描述文件的功能
 */
import { PageConstant } from '../constant/PageConstant';
import { DialogParam } from '../bean/InputDialogParam';

@HMRouter({ pageUrl: PageConstant.SHOW_CONTENT_DIALOG, dialog: true })
@Component
export struct ShowContentDialog {
  @State textValue: string = ''
  private scroller: Scroller = new Scroller()

  aboutToAppear(): void {
    this.textValue = HMRouterMgr.getCurrentParam() as string;
  }

  build() {
    Column() {
      Scroll(this.scroller) {
        Column() {
          Text(this.textValue)
            .width('100%')
            .padding(20)
        }.backgroundColor(Color.White)
        .onClick(ev => {
        })
      }
    }
    .borderRadius(10)
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