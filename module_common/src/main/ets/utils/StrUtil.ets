/**
 * @file StrUtil.ets
 * @author liyi
 * @date 2024/10/29
 * @description 描述文件的功能
 */
export class StrUtil {
  public static splitStrPrint(dataString: string, splitLength = 3000): string[] {
    let strArray: string[] = [];
    for (let i = 0; i < dataString.length; i += splitLength) {
      if (i > 0) {
        console.log(dataString.substring(i, dataString.length > i + splitLength ? i + splitLength : dataString.length));
        strArray.push(dataString.substring(i, dataString.length > i + splitLength ? i + splitLength : dataString.length));
      } else {
        strArray.push(dataString.substring(0, dataString.length > splitLength ? splitLength : dataString.length));
        console.log(dataString.substring(0, dataString.length > splitLength ? splitLength : dataString.length));
      }
    }
    return strArray;
  }
}