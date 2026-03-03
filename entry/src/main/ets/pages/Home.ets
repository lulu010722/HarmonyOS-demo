import RDBStoreUtil from '../storage/RDBStoreUtil';

@Preview
@Component
export default struct Home {
  @State message: string = '天宇小账本';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Normal)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = '欢迎使用天宇小账本';
        })
      Button('+')
        .type(ButtonType.Circle)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .margin({
          bottom: '48vp'
        })
        .onClick(() => {
          RDBStoreUtil.insertTransaction();
        })

    }
    .height('100%')
    .width('100%')
  }
}