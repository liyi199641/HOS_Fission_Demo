import { hapTasks } from '@ohos/hvigor-ohos-plugin';
import { hapPlugin } from '@hadss/hmrouter-plugin';

export default {
    system: hapTasks,
    plugins: [hapPlugin()] // 使用HMRouter标签的模块均需要配置，与模块类型保持一致
}