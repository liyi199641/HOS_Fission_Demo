/**
 * @file DialogParam.ets
 * @author liyi
 * @date 2024/10/28
 * @description 描述文件的功能
 */
import { MusicConfig } from 'fission_sdk';

export class InputMusicDialogParam {
  private _title: string = '';

  public set title(value: string) {
    this._title = value;
  }

  public get title(): string {
    return this._title;
  }

  private _musicConfig: MusicConfig;

  public set musicConfig(value: MusicConfig) {
    this._musicConfig = value;
  }

  public get musicConfig(): MusicConfig {
    return this._musicConfig;
  }



  constructor(title: string, musicConfig: MusicConfig) {
    this._title = title;
    this._musicConfig = musicConfig;
  }


}