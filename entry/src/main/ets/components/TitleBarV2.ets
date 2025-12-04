/**
 * @file TitleBarV2.ets
 * @author liyi
 * @date 2025/1/14
 * @description 描述文件的功能
 */
@Preview
@ComponentV2
export struct TitleBarV2 {
    @Require  @Param title: string = 'title';
    @Require  @Param  onBackClick?: Function;

    build() {
        RelativeContainer() {

            Text(this.title)
                .fontColor(Color.Black)
                .fontSize(24)
                .alignRules({
                    top: { anchor: "__container__", align: VerticalAlign.Top },
                    bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
                    left: { anchor: "__container__", align: HorizontalAlign.Start },
                    right: { anchor: "__container__", align: HorizontalAlign.End }
                })
                .textAlign(TextAlign.Center)
                .layoutWeight(1)

            Image($r('app.media.ic_back'))
                .onClick(() => {
                    this.onBackClick?.();
                })
                .objectFit(ImageFit.Auto)
                .width(45)
                .height(45)
        }
        .height(45)
        .backgroundColor(Color.White)
        .id('titleBarBg')
    }
}