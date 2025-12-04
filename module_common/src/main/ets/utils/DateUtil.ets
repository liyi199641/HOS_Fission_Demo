import { intl } from '@kit.LocalizationKit';

export class DateUtil {
  public static readonly FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS = 0; // "YYYY-MM-DD HH:mm:ss"
  public static readonly FORMAT_STYLE_YYYY_MM_DD_HH_MM = 1; //"YYYY-MM-DD HH:mm"
  public static readonly FORMAT_STYLE_YYYY_MM_DD = 2; // "YYYY-MM-DD"
  public static readonly FORMAT_STYLE_YYYY_MM = 3; //"YYYY-MM"
  public static readonly FORMAT_STYLE_MM_DD_HH_MM = 4; //"MM-dd HH:mm"
  public static readonly FORMAT_STYLE_HH_MM_SS = 5; //"HH:mm:ss"
  public static readonly FORMAT_STYLE_HH_MM = 6; //"HH:mm"

  public static readonly FORMAT_STYLE_SLASH_YYYY_MM_DD_HH_MM_SS = 101; // = "YYYY/MM/DD HH:mm:ss"
  public static readonly FORMAT_STYLE_SLASH_YYYY_MM_DD_HH_MM = 102; //"YYYY/MM/DD HH:mm"
  public static readonly FORMAT_STYLE_SLASH_YYYY_MM_DD = 103; //"YYYY/MM/DD"
  public static readonly FORMAT_STYLE_SLASH_YYYY_MM = 104; //"YYYY/MM"
  public static readonly FORMAT_STYLE_SLASH_MM_DD_HH_MM = 105; // "MM/dd HH:mm"




  /**
   * 拼接年月日
   * @param timestamp
   * @returns
   */
  public static formatTimestampToYYYYMMDD(timestamp: number): string {
    const date = new Date(timestamp); // 将时间戳转换为 Date 对象
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  /**
   * 是今天
   * @param timestamp
   */
  public static isToday(timestamp: number): boolean {
    let targetDate = new Date(timestamp); // 将时间戳转换为 Date 对象
    let today = new Date();
    return targetDate.getFullYear() === today.getFullYear() && targetDate.getMonth() === today.getMonth() &&
      targetDate.getDay() === today.getDay();
  }

  /**
   * 是同一天
   * @param timestamp
   * @param timestamp2
   * @returns
   */
  public static equalDay(timestamp: number, timestamp2: number): boolean {
    let targetDate1 = new Date(timestamp); // 将时间戳转换为 Date 对象
    let targetDate2 = new Date(timestamp2); // 将时间戳转换为 Date 对象

    return targetDate1.getFullYear() === targetDate2.getFullYear() && targetDate1.getMonth() === targetDate2.getMonth() &&
      targetDate1.getDay() === targetDate2.getDay();
  }

  /**
   * 获取当天是月份的第几天
   * @param timestamp
   * @returns
   */
  public static getDaysInMonth(timestamp: number): number {
    const date = new Date(timestamp);

    // 获取当前年份和月份
    const year = date.getFullYear();
    const month = date.getMonth();

    // 设置为下个月的第一天，然后减去一天
    const nextMonth = new Date(year, month + 1, 1);
    nextMonth.setDate(0); // 设置为上个月的最后一天

    return nextMonth.getDate(); // 返回当前月份的最大天数
  }

  /**
   * 获取某天某小时的开始时间戳
   * @param timeStamp（ms）
   * @param hour(0-23)
   * @param daysAfter 间隔天数
   */
  public static getStartOfHour(timestamp: number, hour: number, daysAfter: number = 0) {
    const date = new Date(timestamp);
    // 设置小时为指定的 hour，分钟、秒和毫秒都设为0，表示该小时的起始时间
    date.setHours(hour, 0, 0, 0);
    // 增加天数，默认是当前天
    date.setDate(date.getDate() + daysAfter);
    // 返回修改后的时间戳
    return date.getTime();
  }

  /**
   * 格式化
   * @param durationInMilliseconds
   * @returns
   */
  public static formatDuration(durationInMilliseconds: number): string {
    // 计算分钟数和秒数
    const minute: number = Math.floor(durationInMilliseconds / 60);
    const second: number = durationInMilliseconds % 60;

    // 使用字符串模板和 padStart 方法来格式化分钟和秒数
    const formattedMinute: string = minute.toString().padStart(2, '0');
    const formattedSecond: string = second.toString().padStart(2, '0');

    // 返回格式化后的字符串
    return `${formattedMinute}'${formattedSecond}''`;
  }

  /**
   * 计算年龄
   * @param birthTimestamp
   * @returns
   */
  public static calculateAge(birthTimestamp: number) {
    let birthDate = new Date(birthTimestamp)
    let currentDate = new Date();
    let age = currentDate.getFullYear() - birthDate.getFullYear();
    if (currentDate.getMonth() < birthDate.getMonth() || (currentDate.getMonth() === birthDate.getMonth() && currentDate.getDay() < birthDate.getDay())) {
      age--;
    }
    return age;
  }

  /**
   * 日期间隔天数
   * @param timestamp1
   * @param timestamp2
   * @returns
   */
  public static getDaysBetweenTimestamps(timestamp1: number, timestamp2: number): number {
    const date1 = new Date(timestamp1);
    // 设置小时为指定的 hour，分钟、秒和毫秒都设为0，表示该小时的起始时间
    date1.setHours(0, 0, 0, 0);

    const date2 = new Date(timestamp2);
    // 设置小时为指定的 hour，分钟、秒和毫秒都设为0，表示该小时的起始时间
    date2.setHours(0, 0, 0, 0);

    return (date2.getTime() - date1.getTime()) / (24 * 60 * 60 * 1000)
  }


  /**
   * 格式化函数
   * @param timestamp 时间戳
   * @param formatter
   * @returns
   */
  public static formatDate(timestamp: number, formatStyle: number, locale?: string): string {
    const date = new Date(timestamp);
    if (!locale) {
      // 默认构造函数使用系统当前locale创建
      locale = new intl.Locale().toString();
      // console.log("当前环境：" + locale);
      // locale = "zh-CN"
    }
    let result = "";
    let formatter: intl.DateTimeFormat;
    switch (formatStyle) {
      case DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM_SS: //YYYY-MM-DD HH:mm:ss
      case DateUtil.FORMAT_STYLE_SLASH_YYYY_MM_DD_HH_MM_SS: //YYYY/MM/DD HH:mm:ss
        formatter = new intl.DateTimeFormat(locale, {
          year: "numeric",
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          hour12: false,
          dateStyle: 'short',
          timeStyle: 'medium',
          hourCycle: 'h24'
        });
        result = formatter.format(date);
        if (formatStyle < 100) {
          result = result.replace("/", "-");
        }
        break;
      case DateUtil.FORMAT_STYLE_SLASH_YYYY_MM_DD_HH_MM: //YYYY-MM-DD HH:mm
      case DateUtil.FORMAT_STYLE_YYYY_MM_DD_HH_MM: //YYYY/MM/DD HH:mm
        formatter = new intl.DateTimeFormat(locale, {
          year: "numeric",
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          hour12: false,
          dateStyle: 'short',
          timeStyle: 'short',
          hourCycle: 'h24'
        });
        result = formatter.format(date);
        if (formatStyle < 100) {
          result = result.replace("/", "-");
        }
        break;
      case DateUtil.FORMAT_STYLE_SLASH_YYYY_MM_DD: //YYYY-MM-DD
      case DateUtil.FORMAT_STYLE_YYYY_MM_DD: //YYYY/MM/DD
        formatter = new intl.DateTimeFormat(locale, {
          year: "numeric",
          month: '2-digit',
          day: '2-digit',
          // hour: '2-digit',
          // minute: '2-digit',
          // second: '2-digit',
          hour12: false,
          dateStyle: 'short',
          timeStyle: 'short',
          hourCycle: 'h24'
        });
        result = formatter.format(date);
        if (formatStyle < 100) {
          result = result.replaceAll("/", "-");
        }
        break;
      case DateUtil.FORMAT_STYLE_SLASH_YYYY_MM: //YYYY-MM
      case DateUtil.FORMAT_STYLE_YYYY_MM: //YYYY/MM
        formatter = new intl.DateTimeFormat(locale, {
          year: "numeric",
          month: '2-digit',
          // day: '2-digit',
          // hour: '2-digit',
          // minute: '2-digit',
          // second: '2-digit',
          // hour12: false,
          dateStyle: 'short',
          // timeStyle: 'short',
          // hourCycle: 'h24'
        });
        result = formatter.format(date);
        if (formatStyle < 100) {
          result = result.replaceAll("/", "-");
        }
        break;

      case DateUtil.FORMAT_STYLE_SLASH_MM_DD_HH_MM: //MM/dd HH:mm
      case DateUtil.FORMAT_STYLE_MM_DD_HH_MM: //MM-dd HH:mm
        formatter = new intl.DateTimeFormat(locale, {
          // year: "numeric",
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          // second: '2-digit',
          hour12: false,
          // dateStyle: 'short',
          // timeStyle: 'short',
          hourCycle: 'h24'
        });
        result = formatter.format(date);
        if (formatStyle < 100) {
          result = result.replaceAll("/", "-");
        }
        break;
      case DateUtil.FORMAT_STYLE_HH_MM_SS: //HH:mm:ss
        formatter = new intl.DateTimeFormat(locale, {
          // year: "numeric",
          // month: '2-digit',
          // day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          hour12: false,
          // dateStyle: 'short',
          // timeStyle: 'short',
          hourCycle: 'h24'
        });
        result = formatter.format(date);
        break;
      case DateUtil.FORMAT_STYLE_HH_MM: //HH:mm
        formatter = new intl.DateTimeFormat(locale, {
          // year: "numeric",
          // month: '2-digit',
          // day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          // second: '2-digit',
          hour12: false,
          // dateStyle: 'short',
          // timeStyle: 'short',
          hourCycle: 'h24'
        });
        result = formatter.format(date);
        break;
    }
    return result;
  }


  /**
   * 获取日开始时间戳
   * @param timestamp
   * @returns
   */
  public static getStartOfDay(timestamp: number): number {
    const date = new Date(timestamp);
    date.setHours(0, 0, 0, 0); // 设置时间为午夜（00:00:00）
    return date.getTime(); // 返回开始时间戳
  }

  /**
   * 获取日结束时间戳
   * @param timestamp
   * @returns
   */
  public static getEndOfDay(timestamp: number): number {
    const date = new Date(timestamp);
    date.setHours(23, 59, 59, 999); // 设置时间为当天的最后一刻（23:59:59.999）
    return date.getTime(); // 返回结束时间戳
  }

  /**
   * 获取周开始时间戳(按照中国习惯 周一到周天）
   * @param timestamp
   * @returns
   */
  public static getStartOfWeek(timestamp: number) {
    const date = new Date(timestamp);
    const dayOfWeek = date.getDay(); // 获取当前星期几（0-6，0表示周日）
    const diff = dayOfWeek === 0 ? -6 : 1 - dayOfWeek; // 如果是周日，返回 -6，否则返回 1 - 当前星期几
    date.setDate(date.getDate() + diff); // 设置为周一
    date.setHours(0, 0, 0, 0); // 设置时间为午夜
    return date.getTime(); // 返回开始时间戳
  }

  /**
   * 获取周结束时间戳（按照中国习惯 周一到周天）
   * @param timestamp
   * @returns
   */
  public static getEndOfWeek(timestamp: number) {
    const date = new Date(timestamp);
    const dayOfWeek = date.getDay(); // 获取当前星期几（0-6，0表示周日）
    const diff = dayOfWeek === 0 ? 0 : 6 - dayOfWeek; // 如果是周日，返回 0，否则返回 6 - 当前星期几
    date.setDate(date.getDate() + diff); // 设置为周日
    date.setHours(23, 59, 59, 999); // 设置时间为周日的最后一刻
    return date.getTime(); // 返回结束时间戳
  }

  /**
   * 获取月份开始时间戳
   * @param timestamp
   * @returns
   */
  public static getMonthOfStart(timestamp: number) {
    const date = new Date(timestamp);
    // 获取当前月份的第一天
    date.setDate(1);
    // 设置小时为指定的 hour，分钟、秒和毫秒都设为0，表示该小时的起始时间
    date.setHours(0, 0, 0, 0);
    // 返回开始时间戳
    return date.getTime();
  }

  /**
   * 获取月份结束时间戳
   * @param timestamp
   * @returns
   */
  public static getMonthOfEnd(timestamp: number) {
    const date = new Date(timestamp);
    // 设置为下个月的第一天
    date.setMonth(date.getMonth() + 1);
    date.setDate(1);
    // 设置小时为指定的 hour，分钟、秒和毫秒都设为0，表示该小时的起始时间
    date.setHours(23, 59, 59, 999);
    // 减去一天，得到这个月的最后一天
    date.setDate(date.getDate() - 1);
    // 返回开始时间戳
    return date.getTime();
  }


  /**
   * 获取年开始时间戳
   * @param timestamp
   * @returns
   */
  public static getStartOfYear(timestamp: number): number {
    const date = new Date(timestamp);
    date.setMonth(0); // 设置为1月（0表示1月）
    date.setDate(1); // 设置为1号
    date.setHours(0, 0, 0, 0); // 设置时间为午夜
    return date.getTime(); // 返回开始时间戳
  }

  /**
   * 获取年结束时间戳
   * @param timestamp
   * @returns
   */
  public static getEndOfYear(timestamp: number): number {
    const date = new Date(timestamp);
    date.setMonth(11); // 设置为12月（11表示12月）
    date.setDate(31); // 设置为31号
    date.setHours(23, 59, 59, 999); // 设置时间为最后一刻
    return date.getTime(); // 返回结束时间戳
  }
}

// 定义一个接口，用于明确表示返回的对象结构
export interface Duration {
  hours: number;
  minutes: number;
  seconds: number;
}




