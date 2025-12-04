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

@HMRouter({ pageUrl: PageConstant.INPUT_DIALOG_MUSIC, dialog: true })
@Component
export struct InputMusicDialog {
  @State musicConfig: MusicConfig = new MusicConfig()
  @State title: string = ''

  aboutToAppear(): void {
    let param: InputMusicDialogParam = HMRouterMgr.getCurrentParam() as InputMusicDialogParam;
    if (param) {
      this.musicConfig = param.musicConfig;
      this.title = param.title;
    }
  }

  build() {
    Column() {
      Column() {
        Text(this.title).fontSize(20).margin({ top: 10, bottom: 10 })

        Row() {
          TextInput({ placeholder: this.title == '音乐音量' ? '当前音量' : '进度', text: this.title == '音乐音量' ? this.musicConfig.getCurrentVolume().toString() : this.musicConfig.getProgress().toString() })
            .height(60)
            .type(InputType.Number)
            .layoutWeight(1)
            .defaultFocus(true)// 页面首次打开时，该TextInput获取焦点
            .onChange((value: string) => {
              this.title == '音乐音量' ? this.musicConfig.setCurrentVolume(parseInt(value)) : this.musicConfig.setProgress(parseInt(value))
            })
          TextInput({ placeholder: this.title == '音乐音量' ? '最大音量' : '总进度', text: this.title == '音乐音量' ? this.musicConfig.getMaxVolume().toString() : this.musicConfig.getDuration().toString() })
            .height(60)
            .type(InputType.Number)
            .layoutWeight(1)
            .onChange((value: string) => {
              this.title == '音乐音量' ? this.musicConfig.setMaxVolume(parseInt(value)) : this.musicConfig.setDuration(parseInt(value))
            })
        }.width('80%')

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
                param: this.musicConfig
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