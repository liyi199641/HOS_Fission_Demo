/**
 * @file DialogParam.ets
 * @author liyi
 * @date 2024/10/28
 * @description 描述文件的功能
 */

export class BigDataTimeParam {
  private _startTime: number = 0;

  public set startTime(value: number) {
    this._startTime = value;
  }

  public get startTime(): number {
    return this._startTime;
  }

  private _endTime: number = 0;

  public set endTime(value: number) {
    this._endTime = value;
  }

  public get endTime(): number {
    return this._endTime;
  }

  constructor(startTime: number, endTime: number) {
    this._startTime = startTime;
    this._endTime = endTime;
  }



}