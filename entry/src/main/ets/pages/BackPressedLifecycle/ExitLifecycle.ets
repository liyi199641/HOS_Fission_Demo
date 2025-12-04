import { HMLifecycle, HMRouterMgr, IHMLifecycle } from "@hadss/hmrouter";

/**
 * @file ExitLifecycle.ets
 * @author liyi
 * @date 2024/11/7
 * @description 描述文件的功能
 */
@HMLifecycle({ lifecycleName: 'ExitLifecycle' })
export class ExitLifecycle implements IHMLifecycle {
  // model: ObservedModel = new ObservedModel();

  onBackPressed(): boolean {
    HMRouterMgr.pop({ navigationId: 'mainNavigationId' });
    // HMRouterMgr.push({ pageUrl: 'PayCancel', param: this.model.pageUrl });
    return true;
  }
}