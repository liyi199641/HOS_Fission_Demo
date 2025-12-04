import axios, { AxiosError, AxiosInstance, AxiosProgressEvent, AxiosResponse, FormData, InternalAxiosRequestConfig } from '@ohos/axios';
import { FileUtil } from '@pura/harmony-utils';
import { Callback } from '@ohos.base';
import { Logger } from '../error/Logger';

/**
 * http网路工具类
 */
export class NetworkUtil {
  private static instance: NetworkUtil;
  private declare networkInstance: AxiosInstance;

  public static getInstance(): NetworkUtil {
    if (!NetworkUtil.instance) {
      NetworkUtil.instance = new NetworkUtil();
    }
    return NetworkUtil.instance;
  }

  private constructor() {
    this.configNetwork();
    this.addInterceptors();
  }

  private configNetwork() {
    this.networkInstance = axios.create({
      // baseURL: 'https://www.wanandroid.com',
      baseURL: 'https://ample-videos.com',
      timeout: 3000,
      headers: { 'X-Custom-Header': 'foobar' }
    });
    // NetworkUtil.netInstance = axios.create(config)
    // NetworkUtil.netInstance.defaults.timeout = 2500;
  }


  /**
   * 请求拦截器
   */
  private addInterceptors() {
    //请求拦截器
    axios.interceptors.request.use((config: InternalAxiosRequestConfig) => {
      // Do something about the request data.
      config.headers.sdkType = 0
      return config;
    }, (error: AxiosError) => {
      // Do something with the request error.
      return Promise.reject(error);
    });


    // 响应拦截器
    axios.interceptors.response.use((response: AxiosResponse) => {
      // Do something about the response data.
      return response;
    }, (error: AxiosError) => {
      // Do something with the response error.
      return Promise.reject(error);
    });

  }

  /**
   * 发起请求
   * @param url
   * @param method
   * @returns
   */
  public request<T>(url: string, method: string = 'get'): Promise<T> {
    return new Promise<T>((resolve, reject) => {
      this.networkInstance<string, AxiosResponse<T>>({
        url: url,
        method: method,
        responseType: 'OBJECT',
        transformResponse: (data: AxiosResponse<T>) => {
          return data
        }
      }).then((res: AxiosResponse<T>) => {
        resolve(res.data)
      }).catch((err: AxiosError) => {
        console.error("出错啦：" + JSON.stringify(err));
        reject(err)
      })
    })
  }

  /**
   * 上传文件
   * @param uploadUrl
   * @param filePath
   * @param callback
   * @returns
   */
  public updateFile(uploadUrl: string, filePath: string, callback?: Callback<number>, method: string = 'post'): Promise<AxiosResponse> {
    return new Promise((resolve, reject) => {
      if (!FileUtil.accessSync(filePath)) {
        Logger.error(`not find file: ${filePath}`);
        reject();
        return;
      }
      let progress = -1;
      let formData = new FormData();
      formData.append('file', filePath);
      axios.post<string, AxiosResponse<string>, FormData>(uploadUrl, formData, {
        method: method,
        headers: { 'Content-Type': 'multipart/form-data' },
        context: getContext(this),
        onUploadProgress: (progressEvent: AxiosProgressEvent): void => {
          let curProgress = progressEvent && progressEvent.loaded && progressEvent.total ? Math.ceil(progressEvent.loaded / progressEvent.total * 100) : 0;
          if (progress !== curProgress) {
            progress = curProgress
            callback?.(progress);
          }
        },
      }).then((res: AxiosResponse) => {
        console.info("请求：" + JSON.stringify(res.data));
        resolve(res)
      }).catch((error: AxiosError) => {
        console.error("error:" + JSON.stringify(error));
        reject(error);
      })
    });
  }

  /**
   * 下载文件
   * @param url
   * @param filePath
   * @param callback
   * @returns
   */
  public downLoadFile(url: string, filePath: string, callback?: Callback<number>, method: string = 'get'): Promise<AxiosResponse> {
    return new Promise((resolve, reject) => {
      try {
        if (FileUtil.accessSync(filePath)) {
          FileUtil.unlinkSync(filePath)
        }
      } catch (err) {
        console.error(JSON.stringify(err))
      }
      let progress = -1;
      axios({
        url: url,
        method: method,
        context: getContext(this),
        filePath: filePath,
        timeout: 60000,
        onDownloadProgress: (progressEvent: AxiosProgressEvent): void => {
          let curProgress = progressEvent && progressEvent.loaded && progressEvent.total ? Math.ceil(progressEvent.loaded / progressEvent.total * 100) : 0;
          if (progress !== curProgress) {
            progress = curProgress
            callback?.(progress);
          }
        }
      }).then((res: AxiosResponse) => {
        console.info("result: " + JSON.stringify(res.data));
        resolve(res)
      }).catch((error: AxiosError) => {
        console.error("error:" + JSON.stringify(error));
        reject(error)
      })
    });
  }


}




