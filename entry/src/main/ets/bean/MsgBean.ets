/**
 * @file MsgBean.ets
 * @author liyi
 * @date 2024/10/28
 * @description 描述文件的功能
 */
@Observed
export class MsgBean {
  @Track
  id: number = 1;
  @Track
  msg: string = '';

  constructor(id: number, msg: string) {
    this.id = id;
    this.msg = msg;
  }
}