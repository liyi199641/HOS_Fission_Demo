/**
 * @file DialogUtil.ets
 * @author liyi
 * @date 2024/10/28
 * @description 描述文件的功能
 */
import { Callback } from '@ohos.base';

export function showDatePickerDialog(selected: Date, onDateAccept: Callback<Date>, onDateChange?: Callback<Date>) {
  DatePickerDialog.show({
    // 建议使用 this.getUIContext().showDatePickerDialog()接口
    start: new Date("2000-1-1"),
    end: new Date("2100-12-31"),
    selected: selected,
    showTime: true,
    useMilitaryTime: false,
    disappearTextStyle: { color: Color.Pink, font: { size: '22fp', weight: FontWeight.Bold } },
    textStyle: { color: '#ff00ff00', font: { size: '18fp', weight: FontWeight.Normal } },
    selectedTextStyle: { color: '#ff182431', font: { size: '14fp', weight: FontWeight.Regular } },
    onDateAccept: (value: Date) => {
      // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
      onDateAccept(value)
    },
    onCancel: () => {
      // console.info("DatePickerDialog:onCancel()")
    },
    onDateChange: (value: Date) => {
      // console.info("DatePickerDialog:onDateChange()" + value.toString())
      onDateChange?.(value)

    },
    onDidAppear: () => {
      // console.info("DatePickerDialog:onDidAppear()")
    },
    onDidDisappear: () => {
      // console.info("DatePickerDialog:onDidDisappear()")
    },
    onWillAppear: () => {
      // console.info("DatePickerDialog:onWillAppear()")
    },
    onWillDisappear: () => {
      // console.info("DatePickerDialog:onWillDisappear()")
    }
  })
}


export function showTextPickerDialog(fruits: string[],select: number, onAccept: Callback<TextPickerResult>, onDateChange?: Callback<TextPickerResult>) {

  TextPickerDialog.show({
    // 建议使用 this.getUIContext().showTextPickerDialog()接口
    range: fruits,
    selected: select,
    canLoop:false,
    disappearTextStyle: { color: Color.Red, font: { size: 15, weight: FontWeight.Lighter } },
    textStyle: { color: Color.Black, font: { size: 20, weight: FontWeight.Normal } },
    selectedTextStyle: { color: Color.Blue, font: { size: 30, weight: FontWeight.Bolder } },

    onAccept: (value: TextPickerResult) => {
      onAccept(value);
      console.info("TextPickerDialog:onAccept()" + JSON.stringify(value))
    },
    onCancel: () => {
      // console.info("TextPickerDialog:onCancel()")
    },
    onChange: (value: TextPickerResult) => {
      // console.info("TextPickerDialog:onDateChange()" + value.toString())
      onDateChange?.(value)
    },
    onDidAppear: () => {
      // console.info("TextPickerDialog:onDidAppear()")
    },
    onDidDisappear: () => {
      // console.info("TextPickerDialog:onDidDisappear()")
    },
    onWillAppear: () => {
      // console.info("TextPickerDialog:onWillAppear()")
    },
    onWillDisappear: () => {
      // console.info("TextPickerDialog:onWillDisappear()")
    }
  })
}