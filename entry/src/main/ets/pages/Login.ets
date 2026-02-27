import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct Login {
  @State username: string | null = null;
  @State password: string | null = null;

  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center,
      space: { main: LengthMetrics.vp(48), cross: LengthMetrics.vp(8) }
    }) {
      Column() {
        Text('天宇记账本').fontSize(28).fontWeight(FontWeight.Bold)
        Text('开始记录自己的开销吧').fontSize(16).fontWeight(FontWeight.Lighter)
      }

      Column({ space: 8 }) {
        TextInput({ placeholder: '用户名' }).onChange((value) => {
          this.username = value
        })
        TextInput({ placeholder: '密码' }).onChange((value) => {
          this.password = value
        })
      }

      Column({ space: 8 }) {
        Button('华为账号一键登录').width('100%').height(48).borderRadius(8).backgroundColor(Color.Black)
        Button('微信登录').width('100%').height(48).borderRadius(8).backgroundColor("#07C160")
        Button('支付宝登录').width('100%').height(48).borderRadius(8).backgroundColor("#1677FF")
        Button('手机验证码登录')
          .width('100%')
          .height(48)
          .borderRadius(8)
          .backgroundColor("#E0E0E0")
          .fontColor(Color.Black)
      }

      Row() {
        Checkbox().size({ width: 12, height: 12 })
        Text('您已阅读并同意隐私条约').fontColor(Color.Gray).fontWeight(FontWeight.Lighter).fontSize(12)
      }
      .alignSelf(ItemAlign.Start)

      Column({ space: 16 }) {
        Text('其他登录方式').fontSize(12).fontColor(Color.Gray).fontWeight(FontWeight.Lighter)
        Row({ space: 16 }) {
          Button({ type: ButtonType.Circle }).backgroundColor('#07C160')
          Button({ type: ButtonType.Circle }).backgroundColor('#1677FF')
        }
      }
    }
    .margin(24)
  }
}
