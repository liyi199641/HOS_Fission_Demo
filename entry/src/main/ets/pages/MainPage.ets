import { HMRouter } from '@hadss/hmrouter'
import { PageConstant } from '../constant/PageConstant'
import { PageOrder } from './PageOrder'

@HMRouter({ pageUrl: PageConstant.HOME_CONTENT, singleton: true })
@Component
export struct MainPage {
  @State currentIndex: number = 0
  pageInfos: NavPathStack = new NavPathStack()

  @Builder
  tabBuilder(name: string, targetIndex: number) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          PageOrder()
        }.tabBar(this.tabBuilder('指令', 0))

        // TabContent() {
        //   PageDial()
        // }.tabBar(this.tabBuilder('表盘', 1))
      }
      .scrollable(false)
      .vertical(false)
      .barHeight(50)
      .height('100%')
      .align(Alignment.End)
      // .barBackgroundColor(Color.Red)
      .animationDuration(0)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
  }
}

