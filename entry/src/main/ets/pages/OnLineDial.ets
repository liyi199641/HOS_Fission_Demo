/**
 * @file OnLineDidal.ets
 * @author liyi
 * @date 2025/1/14
 * @description 在线表盘
 */
import { common } from '@kit.AbilityKit';
import { picker } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { PageConstant } from '../constant/PageConstant';
import { HMLifecycle, HMLifecycleContext, HMRouter, HMRouterMgr, IHMLifecycle } from '@hadss/hmrouter';
import { TitleBarV2 } from '../components/TitleBarV2';
import { readFileToUnit8Array,FissionConstant } from 'fission_sdk';
import { ToastUtil } from '@pura/harmony-utils';
import {
    FissionAtCmdResultListener,
    FissionBigDataCmdResultListener,
    FissionSdkManager,
    FssStatus,
    ProgressBean
} from 'fission_sdk';
import { ResourceUtil } from 'module_common';

@ObservedV2
class ObservedModel {
    @Trace canBack: boolean = false;
}

@HMLifecycle({ lifecycleName: 'exampleLifecycle' })
export class ExampleLifecycle implements IHMLifecycle {
    model: ObservedModel = new ObservedModel();

    onBackPressed(ctx: HMLifecycleContext): boolean {
        return this.model.canBack;
    }
}

@HMRouter({ pageUrl: PageConstant.PAGE_ON_LINE_DIAL, lifecycle: 'exampleLifecycle' })
@Preview
@ComponentV2
export struct OnLineDial {
    @Local filePath: string = '请选择文件';
    @Local progress: number = 0
    @Local useTime: number = -1;
    model: ObservedModel | null = (HMRouterMgr.getCurrentLifecycleOwner()?.getLifecycle() as ExampleLifecycle).model
    declare atListener: FissionAtCmdResultListener;
    declare bigDataListener: FissionBigDataCmdResultListener;
    usrTimeIntervalId: number = -1;

    aboutToAppear(): void {
        let that = this;

        class AtDataListener extends FissionAtCmdResultListener {
            public sendSuccess(cmdId: string): void {
            }

            public sendFail(cmdId: string): void {
            }

            public onResultTimeout(cmdId: string): void {
            }

            public onResultError(cmdId: string): void {
            }

            public fssSuccess(fssStatus: FssStatus): void {
                if (fssStatus.getFssStatus() > that.progress) {
                    that.progress = fssStatus.getFssStatus();
                    if (that.progress==100) {
                        clearInterval(that.usrTimeIntervalId);
                        if (that.model) {
                            that.model.canBack = true;
                        }
                    }
                }
            }
        }

        this.atListener = new AtDataListener();
        FissionSdkManager.getInstance().addListener(this.atListener);


        class BigDataListener extends FissionBigDataCmdResultListener {
            sendSuccess(cmdId: string): void {

            }

            sendFail(cmdId: string): void {

            }

            onResultTimeout(cmdId: string): void {

            }

            onResultError(errorMsg: string): void {

            }

            onUpdateDialProgress(progress: ProgressBean): void {

            }
        }

        this.bigDataListener = new BigDataListener();
        FissionSdkManager.getInstance().addListener(this.bigDataListener);
    }

    aboutToDisappear(): void {
        FissionSdkManager.getInstance().deleteListener(this.atListener)
        FissionSdkManager.getInstance().deleteListener(this.bigDataListener)
    }

    build() {
        Column() {
            TitleBarV2({
                title: '在线表盘', onBackClick: () => {
                    HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
                }
            })
            Column() {
                Text('文件路径')
                    .fontSize(20)
                    .fontColor(Color.Black)
                    .fontWeight(FontWeight.Bold)

                Text(this.filePath)
                    .fontSize(16)
                    .fontColor(Color.Gray)
                    .margin({ top: 10 })
                    .fontWeight(FontWeight.Normal)

            }.onClick(() => {
                this.selectDialFile();
            }).borderRadius(10)
            .borderStyle(BorderStyle.Solid)
            .borderWidth(1)
            .borderColor(Color.Gray)
            .width('90%')
            .padding({
                left: 10,
                right: 10,
                top: 10,
                bottom: 10
            })
            .constraintSize({ minHeight: 80 })
            .alignItems(HorizontalAlign.Start)

            Stack() {
                Progress({ value: this.progress, total: 100, type: ProgressType.Ring }).width(200).height(200).margin({
                    top: 20
                })// .color(Color.Grey)    // 进度条前景色为灰色
                    .style({ strokeWidth: 15, enableSmoothEffect: true }) // 设置strokeWidth进度条宽度为15.0vp
                Text('耗时：' + this.useTime + '秒')
                    .fontColor(ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_3')))
                    .fontSize(14)
                    .visibility(this.useTime >= 0 ? Visibility.Visible:Visibility.Hidden)
            }.alignContent(Alignment.Center)


            Row().layoutWeight(1)
            Button("推送")
                .width('80%')
                .height(50)
                .margin({ bottom: 50 })
                .onClick(() => {
                    if (this.filePath) {
                        if (this.model) {
                            this.model.canBack = false;
                        }
                        this.useTime = 0;
                        this.progress = 0;
                        clearInterval(this.usrTimeIntervalId)
                        this.usrTimeIntervalId = setInterval(() => {
                            this.useTime++;
                        }, 1000)
                        readFileToUnit8Array(this.filePath).then((buffer: Uint8Array) => {
                            console.log("获取文件字节大小： " + buffer.length)
                            FissionSdkManager.getInstance().startDial(buffer, FissionConstant.WRITE_REMOTE_DIAL_DATA);
                        }).catch((err: BusinessError) => {
                            if (this.model) {
                                this.model.canBack = true;
                            }
                            this.useTime = 0;
                            this.progress = 0;
                            clearInterval(this.usrTimeIntervalId)
                            console.error(err.message)
                            ToastUtil.showToast("文件读取失败")
                        })
                    } else {
                        ToastUtil.showToast("请选择文件")
                    }
                })
        }
        .height('100%')
        .alignItems(HorizontalAlign.Center)
    }

    selectDialFile() {
        try {
            let context = getContext(this) as common.Context; // 请确保getContext(this)返回结果为UIAbilityContext
            let documentSelectOptions = new picker.DocumentSelectOptions();
            documentSelectOptions.maxSelectNumber = 1; //最大选择文件数量
            documentSelectOptions.selectMode = picker.DocumentSelectMode.FILE; //文件选择模式
            documentSelectOptions.fileSuffixFilters = ['bin']; //文件后缀过滤
            documentSelectOptions.authMode = true;
            // documentSelectOptions.defaultFilePathUri = "";//默认选择文件路径
            let documentPicker = new picker.DocumentViewPicker(context);
            documentPicker.select(documentSelectOptions).then((documentSelectResult: Array<string>) => {
                console.info('DocumentViewPicker.select successfully, documentSelectResult uri: ' + JSON.stringify(documentSelectResult));
                if (documentSelectResult.length > 0) {
                    this.filePath = documentSelectResult[0];
                }
            }).catch((err: BusinessError) => {
                console.error('DocumentViewPicker.select failed with err: ' + JSON.stringify(err));
            });
        } catch (error) {
            let err: BusinessError = error as BusinessError;
            console.error('DocumentViewPicker failed with err: ' + JSON.stringify(err));
        }
    }
}

