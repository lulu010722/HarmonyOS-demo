@Entry
@Component
struct Login {
  @State username: string | null = null;
  @State password: string | null = null;

  build() {
    Column({ space: 16 }) {
      Text('登录界面').fontSize(24).fontWeight(FontWeight.Bold)
      Text('登录账号以使用更多功能').fontSize(12).fontWeight(FontWeight.Lighter)
      TextInput({ placeholder: '用户名' }).onChange((value) => {
        this.username = value
      })
      TextInput({ placeholder: '密码' }).onChange((value) => {
        this.password = value
      })
      Button('登录', { type: ButtonType.Capsule }).width('100%')
    }
    .alignItems(HorizontalAlign.Center)
    .margin(24)
  }
}