// 定义 BaseResponse<T>
export class BaseResponse<T> {
  // state: number;
  data: T[];
  errorCode: number;
  errorMsg: string;

  constructor(data: T[], errorCode: number, errorMsg: string) {
    this.data = data;
    this.errorCode = errorCode;
    this.errorMsg = errorMsg;
  }
}