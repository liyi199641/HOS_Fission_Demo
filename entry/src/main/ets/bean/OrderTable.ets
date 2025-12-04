/**
 * @file OrderTable.ets
 * @author liyi
 * @date 2024/10/28
 * @description 描述文件的功能
 */
import { OrderBean } from './OrderBean';

@Observed
export class OrderTable {
  id: number = 0;
  title: string = "";
  isExpanded: boolean = false;
  @Track projects: OrderBean[] = [];

  constructor(id: number, title: string, isExpanded: boolean, projects: OrderBean[]) {
    this.id = id;
    this.title = title;
    this.isExpanded = isExpanded;
    this.projects = projects;
  }

  static changeExpanded(orderTable: OrderTable) {
    orderTable.isExpanded = !orderTable.isExpanded;
  }
}