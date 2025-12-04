/**
 * @file DialogParam.ets
 * @author liyi
 * @date 2024/10/28
 * @description 描述文件的功能
 */
export class DialogParam {
  private _title: string = ''

  public set title(value: string) {
    this._title = value
  }

  public get title(): string {
    return this._title
  }

  private _textValue: string = ''

  public set textValue(value: string) {
    this._textValue = value
  }

  public get textValue(): string {
    return this._textValue
  }

  constructor(title: string, textValue: string) {
    this._title = title
    this._textValue = textValue
  }
}