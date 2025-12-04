import { HMDefaultGlobalAnimator, HMNavigation } from '@hadss/hmrouter'
// Index.ets
import { AttributeUpdater } from '@kit.ArkUI'
import { PageConstant } from '../constant/PageConstant'

class MyNavModifier extends AttributeUpdater<NavigationAttribute> {
  initializeModifier(instance: NavigationAttribute): void {
    instance.hideNavBar(true)
  }
}

@Entry
@Component
struct Index {
  modifier: MyNavModifier = new MyNavModifier()
  @State currentIndex: number = 0
  @State time: string = 'hello';
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
      HMNavigation({
        navigationId: 'mainNavigationId', homePageUrl: PageConstant.HOME_PAGE_ORDER, options: {
          standardAnimator: HMDefaultGlobalAnimator.STANDARD_ANIMATOR,
          modifier: this.modifier
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}

