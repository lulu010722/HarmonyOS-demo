import Home from './Home';
import Login from './Login';

@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  @Builder
  TabBuilder(title: ResourceStr, index: number, selectedImg: Resource) {
    Column() {
      SymbolGlyph(selectedImg)
        .fontSize('24fp')
        .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
        .symbolEffect(new BounceSymbolEffect(EffectScope.WHOLE, EffectDirection.UP),
          this.currentIndex === index ? true : false)
        .fontColor(this.currentIndex === index ? ['#0a59f7'] : ['#66000000'])
      Text(title)
        .margin({ top: '4vp' })
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.currentIndex === index ? '#0a59f7' : '#66000000')
    }
    .backgroundColor($r('sys.color.point_color_checked'))
    .justifyContent(FlexAlign.Center)
    .height('56vp')
    .width('100%')
    .onClick(() => {
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    Column() {
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController
      }) {
        TabContent() {
          Home()
        }
        .padding({ left: '12vp', right: '12vp' })
        .backgroundColor($r('sys.color.point_color_checked'))
        .tabBar(this.TabBuilder('首页', 0, $r('sys.symbol.house_fill')))

        TabContent() {
          Login()
        }
        .padding({ left: '12vp', right: '12vp' })
        .backgroundColor($r('sys.color.point_color_checked'))
        .tabBar(this.TabBuilder('我的', 1, $r('sys.symbol.person_crop_circle_fill_1')))
      }
      .margin({ bottom: '64vp' })
      .width('100%')
      .height('100%')
      .barHeight('80vp')
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('sys.color.point_color_checked'))
  }
}