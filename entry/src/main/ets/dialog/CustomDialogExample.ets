import { FissionAlarm } from "fission_sdk"

@CustomDialog
@Component
export struct CustomDialogExample {
  @Link alarm: FissionAlarm
  cancel?: () => void
  confirm?: () => void
  controller: CustomDialogController

  build() {
    Column() {
      Text('序号')
    }
  }
}