import { common } from '@kit.AbilityKit';
import { MsgBean } from '../bean/MsgBean';


@Builder
export function PageOrderDetailBuilder() {
  PageOrderDetail()
}

@Component
export struct PageOrderDetail {
  context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  pathStack: NavPathStack = new NavPathStack()
  @State msgBean: MsgBean = new MsgBean(0, '')
  scroller: Scroller = new Scroller()

  build() {
    NavDestination() {
      Scroll(this.scroller) {
        Column() {
          Text(this.msgBean.msg)
            .fontSize(16)
            .backgroundColor(Color.Pink)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Start)
            .alignSelf(ItemAlign.Start)
            .padding(20)
            .width('100%')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Start)
      }
    }.hideTitleBar(true)
    .onBackPressed(() => {
      const popDestinationInfo = this.pathStack.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
    .onReady((context: NavDestinationContext) => {
      console.log("接收到的参数：" + JSON.stringify(context.pathStack.getParamByName('PageOrderDetail')));
      this.pathStack = context.pathStack
      if (context.pathStack.getParamByName('PageOrderDetail')) {
        this.msgBean = context.pathStack.getParamByName('PageOrderDetail')[0] as MsgBean;
      } else {
        this.msgBean = new MsgBean(0, '')
      }
    }).onBackPressed(() => {
      this.pathStack.pop()
      return true
    })
  }
}