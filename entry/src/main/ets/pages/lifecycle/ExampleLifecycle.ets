import { HMLifecycle, HMLifecycleContext, IHMLifecycle } from "@hadss/hmrouter";

/**
 * @file ExampleLifecycle.ets
 * @author liyi
 * @date 2025/1/14
 * @description 描述文件的功能
 */

export class ExampleLifecycle implements IHMLifecycle {
    onBackPressed(ctx: HMLifecycleContext): boolean {
        return false;
    }
}