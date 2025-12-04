// 定义 PageResponse<U>，其中 U 是包含的数据列表的泛型
export class PageResponse<U> {
  list: U[];
  size: number;
  page: number;

  constructor(list: U[], size: number, page: number) {
    this.list = list;
    this.size = size;
    this.page = page;
  }

  // 获取列表数据
  getList(): U[] {
    return this.list;
  }

  // 获取分页大小
  getSize(): number {
    return this.size;
  }

  // 获取当前页码
  getPage(): number {
    return this.page;
  }
}