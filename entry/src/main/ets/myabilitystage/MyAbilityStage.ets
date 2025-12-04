import { AbilityConstant, AbilityStage, ApplicationStateChangeCallback, Configuration, EnvironmentCallback, Want, ConfigurationConstant, dataUriUtils, errorManager } from '@kit.AbilityKit';
import { Configure, FissionSdkManager, Logger, LogLevel } from 'fission_sdk';
import { BusinessError } from '@kit.BasicServicesKit';
import { HMRouterMgr } from '@hadss/hmrouter';

let callbackId: number;
let observerId = -1;

/**
 * AbilityStage类提供在HAP加载的时候，通知开发者，可以在此进行该HAP的初始化（如资源预加载，线程创建等）能力。
 * AbilityStage是一个Module级别的组件容器，应用的HAP在首次加载时会创建一个AbilityStage实例，可以对该Module进行初始化等操作。
 * AbilityStage与Module一一对应，即一个Module拥有一个AbilityStage。
 */
export default class MyAbilityStage extends AbilityStage {
  /**
   * 应用的HAP在首次加载的时，为该Module初始化操作
   * onCreate()生命周期回调：在开始加载对应Module的第一个UIAbility实例之前会先创建AbilityStage，并在AbilityStage创建完成之后执行其onCreate()生命周期回调。
   * AbilityStage模块提供在Module加载的时候，通知开发者，可以在此进行该Module的初始化（如资源预加载，线程创建等）能力。
   */
  onCreate(): void {

    HMRouterMgr.init({
      context: this.context
    })



    // //日志工具类，配置
    // let configure: Configure = new Configure(this.context.applicationInfo.debug ? ['file', 'console'] : ['file'], '', LogLevel.DEBUG, this.context.filesDir);
    // console.log("加载路径： " + this.context.filesDir);
    // Logger.setConfigure(configure)

    let applicationContext = this.context.getApplicationContext();
    //通过applicationContext注册应用前后台状态监听
    try {
      if (applicationContext != undefined) {
        applicationContext.on('applicationStateChange', applicationStateChangeCallback);
      }
    } catch (paramError) {
      console.error(`error: ${(paramError as BusinessError).code}, ${(paramError as BusinessError).message}`);
    }
    console.log('Resgiter applicationStateChangeCallback');


    //通过applicationContext注册系统环境变化监听
    //系统全局配置发生变更时触发的事件，系统语言、深浅色等，配置项目前均定义在Configuration类中
    try {
      callbackId = applicationContext.on('environment', environmentCallback);
    } catch (paramError) {
      console.error(`error: ${(paramError as BusinessError).code}, ${(paramError as BusinessError).message}`);
    }
    console.log(`registerEnvironmentCallback number: ${JSON.stringify(callbackId)}`);

    //注册错误观测器。注册后可以捕获到应用产生的js crash，应用崩溃时进程不会退出。。
    try {
      observerId = errorManager.on('error', observer);
    } catch (paramError) {
      let code = (paramError as BusinessError).code;
      let message = (paramError as BusinessError).message;
      console.error(`error: ${code}, ${message}`);
    }
  }

  onDestroy(): void {
    let applicationContext = this.context.getApplicationContext();
    //注销应用前后台状态监听
    try {
      if (applicationContext != undefined) {
        applicationContext.off('applicationStateChange', applicationStateChangeCallback);
      }
    } catch (paramError) {
      console.error(`error: ${(paramError as BusinessError).code}, ${(paramError as BusinessError).message}`);
    }

    //通过applicationContext注销系统环境变化监听
    try {
      applicationContext.off('environment', callbackId, (error, data) => {
        if (error && error.code !== 0) {
          console.error(`unregisterEnvironmentCallback fail, error: ${JSON.stringify(error)}`);
        } else {
          console.log(`unregisterEnvironmentCallback success, data: ${JSON.stringify(data)}`);
        }
      });
    } catch (paramError) {
      console.error(`error: ${(paramError as BusinessError).code}, ${(paramError as BusinessError).message}`);
    }


    //注销错误观察器
    try {
      errorManager.off('error', observerId)
        .then((data) => {
          console.log('----------- unregisterErrorObserver success ----------', data);
        })
        .catch((err: BusinessError) => {
          console.error('----------- unregisterErrorObserver fail ----------', err);
        });
    } catch (paramError) {
      let code = (paramError as BusinessError).code;
      let message = (paramError as BusinessError).message;
      console.error(`error: ${code}, ${message}`);
    }
  }

  onAcceptWant(want: Want): string {
    // 仅specified模式下触发
    return 'MyAbilityStage';
  }

  /**
   * 系统全局配置发生变更时触发的事件，系统语言、深浅色等，配置项目前均定义在Configuration类中
   * @param newConfig
   */
  onConfigurationUpdate(newConfig: Configuration): void {
    //{"language":"zh-Hans-CN","colorMode":1,"time24":1,"direction":-1,"screenDensity":0,"displayId":-1,"hasPointerDevice":false,"fontSizeScale":1,"fontWeightScale":1,"mcc":"","mnc":""}
    console.log(`onConfigurationUpdated config AbilityStage: ${JSON.stringify(newConfig)}`);
  }

  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
    // 根据系统可用内存的变化情况，释放不必要的内存
  }
}

let applicationStateChangeCallback: ApplicationStateChangeCallback = {
  onApplicationForeground() {
    console.info('applicationStateChangeCallback onApplicationForeground');
  },
  onApplicationBackground() {
    console.info('applicationStateChangeCallback onApplicationBackground');
  }
};


/**
 *系统全局配置发生变更时触发的事件，系统语言、深浅色等，配置项目前均定义在Configuration类中
 * language , colorMode ,time24, direction , screenDensity , displayId , hasPointerDevice , fontSizeScale , fontWeightScale , mcc , mnc
 */
let environmentCallback: EnvironmentCallback = {
  onConfigurationUpdated(config) {
    //{"language":"zh-Hans-CN","colorMode":1,"time24":1,"direction":-1,"screenDensity":0,"displayId":-1,"hasPointerDevice":false,"fontSizeScale":1,"fontWeightScale":1,"mcc":"","mnc":""}
    console.log(`onConfigurationUpdated config: ${JSON.stringify(config)}`);
    if (config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK) { //深色模式

    }
  },

  onMemoryLevel(level) {
    console.log(`onMemoryLevel level: ${JSON.stringify(level)}`);
  }
};


let observer: errorManager.ErrorObserver = {
  onUnhandledException(errorMsg) {
    console.log('onUnhandledException, errorMsg: ', errorMsg);
  },
  onException(errorObj) {
    console.log('onException, name: ', errorObj.name);
    console.log('onException, message: ', errorObj.message);
    if (typeof (errorObj.stack) === 'string') {
      console.log('onException, stack: ', errorObj.stack);
    }
  }
};