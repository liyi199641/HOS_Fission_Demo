import { ColorUtil } from './ColorUtil';
import { DataUtil } from './DataUtil';
import { MediaUtil } from './MediaUtil';
import { RawFileUtil } from './RawFileUtil';
import { StringUtil } from './StringUtil';

/**
 * ResourceUtil 工具类
 */
export class ResourceUtil {
  public static String: StringUtil = new StringUtil();
  public static Media: MediaUtil = new MediaUtil();
  public static Color: ColorUtil = new ColorUtil();
  public static Data: DataUtil = new DataUtil();
  public static RawFile: RawFileUtil = new RawFileUtil();
}




