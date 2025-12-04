import { HMPopInfo, HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';
import {
    DialModel,
    FissionBigDataCmdResultListener,
    FissionDialUtil,
    FissionDialUtilsV1,
    FissionSdkManager,
    HardWareInfo,
    QuickLZUtils,
    SpKeys,
    SpUtil
} from 'fission_sdk';
import { TitleBar } from '../components/TitleBar';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { ResourceUtil } from 'module_common';
import { image } from '@kit.ImageKit';
import { FissionConstant } from 'fission_sdk';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { dataSharePredicates } from '@kit.ArkData';
import { ImageUtil } from 'fission_sdk';
import { ToastUtil } from '@pura/harmony-utils';

export interface CropImageParam {
    imageWidth: number;
    imageHeight: number;
    isCircle: boolean;
    imagePixelMap: image.ImageSource;
}

@HMRouter({ pageUrl: PageConstant.PAGE_CUSTOM_DIAL })
@Component
export struct PageCustomDial {
    @State enable: boolean = false;
    @State startTime: number = 0;
    @State endTime: number = 0;
    @State imagePath: string = ''
    @State dialStyleColor: number = ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_3'));
    @State dialBackgroundColor: number = ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_white_big'));
    context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    @State preImagePixelMap: PixelMap | null = null;
    @State sourcePixelMap: PixelMap | null = null;
    hardWareInfo: HardWareInfo | null = null
    uris: Array<string> = [];
    private scroller: Scroller = new Scroller();
    private dialStyleColorRange: number[] = [ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_1')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_2')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_3')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_4')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_5')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_6')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_7')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_8')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_9'))]
    private dialBackColorRange: number[] = [
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_white_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_red_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_yellow_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_gray_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_orange_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_green_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_light_blue_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_dark_blue_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_sky_blue_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_purple_big')),
        ResourceUtil.Color.getColorSync($r('app.color.public_custom_dial_72f4ef'))
    ]

    aboutToAppear(): void {
        this.hardWareInfo = FissionSdkManager.getInstance().hardWareInfo;

        class BigDataListener extends FissionBigDataCmdResultListener {
            sendSuccess(cmdId: string): void {

            }

            sendFail(cmdId: string): void {

            }

            onResultTimeout(cmdId: string): void {

            }

            onResultError(errorMsg: string): void {

            }
        }

        FissionSdkManager.getInstance().addListener(new BigDataListener());
    }

    selectImage() {
        if (!this.hardWareInfo) {
            ToastUtil.showShort("请先获取硬件信息!");
            return;
        }

        try {
            let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
            PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
            PhotoSelectOptions.maxSelectNumber = 1;
            let photoPicker = new photoAccessHelper.PhotoViewPicker();
            photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
                console.info('PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult));
                this.imagePath = PhotoSelectResult.photoUris[0];
                this.getPixelMapFromPath()
            }).catch((err: BusinessError) => {
                console.error('PhotoViewPicker.select failed with err: ' + JSON.stringify(err));
            });


        } catch (error) {
            let err: BusinessError = error as BusinessError;
            console.error('PhotoViewPicker failed with err: ' + JSON.stringify(err));
        }
    }

    selectImageAndCrop(data: image.ImageSource) {
        let that = this;
        if (!this.hardWareInfo) {
            ToastUtil.showShort("请先获取硬件信息!");
            return;
        }
        if (!this.sourcePixelMap) {
            ToastUtil.showShort("请先选择图片!");
            return;
        }
        const imageWidth = this.hardWareInfo.getDeviceWidth();
        const imageHeight = this.hardWareInfo.getDeviceHigh();
        const cropParam: CropImageParam = {
            imageWidth: imageWidth,
            imageHeight: imageHeight,
            isCircle: this.hardWareInfo.getDialShape()==1,
            imagePixelMap: data
        }
        HMRouterMgr.push({
            pageUrl: PageConstant.PAGE_CROP_IMAGE, param: cropParam
        }, {
            onResult(popInfo: HMPopInfo) {
                const pageName = popInfo.srcPageInfo.name;
                let params = popInfo.result as PixelMap;
                that.sourcePixelMap = ImageUtil.compressPixelMapToTargetSize(params, imageWidth, imageHeight);
                //压缩图片
                console.log(`收到回参: from： ${pageName}, params is image${JSON.stringify(params.getImageInfoSync())}   压缩后 ${JSON.stringify(that.sourcePixelMap.getImageInfoSync())}`);
            }
        })
    }

    async getPixelMapFromPath() {
        try {
            let that = this;

            class MediaHandler implements photoAccessHelper.MediaAssetDataHandler<image.ImageSource> {
                onDataPrepared(data: image.ImageSource) {
                    if (data===undefined) {
                        console.error('Error occurred when preparing data');
                        return;
                    }
                    console.info('on image data prepared');


                    let imageInfo = data.getImageInfoSync()
                    console.log("图片信息 " + JSON.stringify(imageInfo));
                    // let opt: image.DecodingOptions = {
                    //     editable: true,
                    //     desiredSize: imageInfo.size,
                    //     desiredPixelFormat: image.PixelMapFormat.RGBA_8888
                    // }
                    //
                    // data.createPixelMap(opt, (err: BusinessError, pixelMap: image.PixelMap) => {
                    //     if (err) {
                    //         console.error(`Failed to create pixelMap.code is ${err.code},message is ${err.message}`);
                    //     } else {
                    //         that.sourcePixelMap = pixelMap;
                    //         that.selectImageAndCrop()
                    //     }
                    // })


                    that.selectImageAndCrop(data)
                }
            }


            let predicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
            let uri = this.imagePath // 需保证此uri已存在。
            predicates.equalTo(photoAccessHelper.PhotoKeys.URI, uri.toString());
            let fetchOptions: photoAccessHelper.FetchOptions = {
                fetchColumns: [photoAccessHelper.PhotoKeys.TITLE],
                predicates: predicates
            };
            let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(this.context);
            try {
                let fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset> = await phAccessHelper.getAssets(fetchOptions);
                let photoAsset: photoAccessHelper.PhotoAsset = await fetchResult.getFirstObject();
                console.info('getAssets photoAsset.uri : ' + photoAsset.uri);
                // 获取属性值，以标题为例；对于非默认查询的属性，get前需要在fetchColumns中添加对应列名
                console.info('title : ' + photoAsset.get(photoAccessHelper.PhotoKeys.TITLE));
                // 请求图片资源数据
                let requestOptions: photoAccessHelper.RequestOptions = {
                    deliveryMode: photoAccessHelper.DeliveryMode.HIGH_QUALITY_MODE,
                }
                await photoAccessHelper.MediaAssetManager.requestImage(this.context, photoAsset, requestOptions, new MediaHandler());
                console.info('requestImageData successfully');
                fetchResult.close();
            } catch (err) {
                console.error('getAssets failed with err: ' + err);
            }

            // this.preImagePixelMap =     this.getPixelMapFromFilePath(this.imagePath)
        } catch (error) {
            console.error('uriGetAssets failed with err: ' + error);
        }
    }

    getRawFilePixelMap(context: Context, fileName: string): PixelMap {
        try {
            let rawDataContent: Uint8Array = context.resourceManager.getRawFileContentSync("custom_dial_week/" + fileName);
            let rawImageSource: image.ImageSource = image.createImageSource(rawDataContent.buffer.slice(0));
            let rawDecodingOptions: image.DecodingOptions = {
                editable: true,
                desiredPixelFormat: image.PixelMapFormat.RGBA_8888
            }
            return rawImageSource.createPixelMapSync(rawDecodingOptions);
        } catch (error) {
            let code = (error as BusinessError).code;
            let message = (error as BusinessError).message;
            console.error(`getRawFileContentSync failed, error code: ${code}, message: ${message}.`);
            throw new Error(error)
        }
    }

    build() {
        Scroll(this.scroller) {
            Column() {
                TitleBar({
                    title: '自定义表盘推送',
                    onBackClick: () => {
                        HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
                    }
                })
                Stack() {
                    Row() {
                        Text("选择图片")
                    }.width('100%').height(200).justifyContent(FlexAlign.Center).onClick(() => {
                        this.selectImage();
                    })

                    Row() {
                        Image(this.sourcePixelMap).width(200).height(200).onClick(() => {
                            this.selectImage();
                        }).objectFit(ImageFit.ScaleDown)
                    }.width('100%').height(200).justifyContent(FlexAlign.Center)

                }.width('100%').height(200).margin({ top: 20 })

                // Button('选择图片').width('80%').margin({ top: 20 }).onClick(() => {
                // });

                Button('生成图片并推送').width('80%').margin({ top: 20 }).onClick(() => {
                    let hardWareInfo = FissionSdkManager.getInstance().hardWareInfo;
                    if (!hardWareInfo) {
                        ToastUtil.showToast("请先获取硬件信息!")
                        return
                    }
                    if (!this.sourcePixelMap) {
                        ToastUtil.showToast("请选择图片")
                        return
                    }
                    let dialModel = new DialModel();
                    // let pixelMap = this.getRawFilePixelMap(this.context, 'lbxx.jpg');
                    let pixelMap = this.sourcePixelMap;
                    if (hardWareInfo && pixelMap) {
                        dialModel.dialShape = hardWareInfo.getDialShape();
                        dialModel.previewImage = ImageUtil.clonePixelMap(pixelMap);
                        dialModel.backgroundImage = ImageUtil.clonePixelMap(pixelMap);
                        dialModel.dialPosition = 1;
                        dialModel.dialWidth = hardWareInfo.getDeviceWidth();
                        dialModel.dialHeight = hardWareInfo.getDeviceHigh();
                        dialModel.preImageWidth = hardWareInfo.getThumbnailWidth();
                        dialModel.preImageHeight = hardWareInfo.getThumbnailHigh();
                        dialModel.dialStyleColor = this.dialStyleColor;
                        dialModel.isSupportAntiAliasing = SpUtil.getData(SpKeys.SUPPORT_ANTI_ALIASING) as boolean;
                        dialModel.isSupportCrcChecksum = SpUtil.getData(SpKeys.SUPPORT_DAIL_CRC_CHECKSUM) as boolean;
                    }
                    let resultData = FissionDialUtilsV1.getDiaInfoBinData(this.context, dialModel);
                    FissionSdkManager.getInstance().startDial(resultData, FissionConstant.WRITE_DIAL_DATA)
                });


                Button('生成图片并推送(压缩数据)').width('80%').margin({ top: 20 }).onClick(() => {
                    let hardWareInfo = FissionSdkManager.getInstance().hardWareInfo;
                    if (!hardWareInfo) {
                        ToastUtil.showToast("请先获取硬件信息!")
                        return
                    }
                    if (!this.sourcePixelMap) {
                        ToastUtil.showToast("请选择图片")
                        return
                    }
                    let dialModel = new DialModel();
                    // let pixelMap = this.getRawFilePixelMap(this.context, 'lbxx.jpg')
                    let pixelMap = this.sourcePixelMap;
                    if (hardWareInfo) {
                        dialModel.dialShape = hardWareInfo.getDialShape();
                        dialModel.previewImage = ImageUtil.clonePixelMap(pixelMap);
                        dialModel.backgroundImage = ImageUtil.clonePixelMap(pixelMap);
                        dialModel.dialPosition = 1;
                        dialModel.dialWidth = hardWareInfo.getDeviceWidth();
                        dialModel.dialHeight = hardWareInfo.getDeviceHigh();
                        dialModel.preImageWidth = hardWareInfo.getThumbnailWidth();
                        dialModel.preImageHeight = hardWareInfo.getThumbnailHigh();
                        dialModel.dialStyleColor = this.dialStyleColor;
                        dialModel.isSupportAntiAliasing = SpUtil.getData(SpKeys.SUPPORT_ANTI_ALIASING) as boolean;
                        dialModel.isSupportCrcChecksum = SpUtil.getData(SpKeys.SUPPORT_DAIL_CRC_CHECKSUM) as boolean;
                    }
                    this.sourcePixelMap = ImageUtil.clonePixelMap(pixelMap);

                    let resultData = FissionDialUtil.getBigDiaInfoBinData(this.context, dialModel);
                    let outData = QuickLZUtils.compressFission(resultData);
                    FissionSdkManager.getInstance().startDial(outData, FissionConstant.WRITE_DIAL_DATA)

                });


                Row() {
                    Text('小字体颜色:')
                    Slider({
                        value: 2,
                        min: 0,
                        max: this.dialStyleColorRange.length - 1,
                        style: SliderStyle.OutSet
                    })
                        .showTips(true)
                        .onChange((value: number, mode: SliderChangeMode) => {
                            this.dialStyleColor = this.dialStyleColorRange[value]
                            console.info('value:' + value + 'mode:' + mode.toString())
                        })
                        .layoutWeight(1)
                    Text().backgroundColor(this.dialStyleColor).width(50).height(50).border({
                        color: Color.Gray,
                        style: BorderStyle.Dotted,
                        width: 1,
                        radius: 5
                    })
                }
                .margin({ top: 30 })
                .width('80%')

                Row() {
                    Text('大字体颜色:')
                    Slider({
                        value: 0,
                        min: 0,
                        max: this.dialBackColorRange.length - 1,
                        style: SliderStyle.OutSet
                    })
                        .showTips(true)
                        .onChange((value: number, mode: SliderChangeMode) => {
                            this.dialBackgroundColor = this.dialBackColorRange[value];
                            console.info('value:' + value + 'mode:' + mode.toString())
                        })
                        .layoutWeight(1)
                    Text().backgroundColor(this.dialBackgroundColor).width(50).height(50).border({
                        color: Color.Gray,
                        style: BorderStyle.Dotted,
                        width: 1,
                        radius: 5
                    })
                }
                .margin({ top: 30 })
                .width('80%')

                Column() {
                    Text('预览图:')
                    Image(this.preImagePixelMap)
                        .objectFit(ImageFit.Cover)
                }.width('100%')

            }
        }
    }
}