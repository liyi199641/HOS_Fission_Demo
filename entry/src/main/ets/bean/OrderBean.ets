/**
 * @file OrderBean.ets
 * @author liyi
 * @date 2024/10/28
 * @description 描述文件的功能
 */
@Observed
export class OrderBean {
  @Track
  id: string = '';
  @Track
  name: string = '';

  constructor(id: string, name: string) {
    this.id = id;
    this.name = name;
  }
}