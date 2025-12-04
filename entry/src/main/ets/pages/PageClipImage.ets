import { HMRouter, HMRouterMgr } from '@hadss/hmrouter';
import { PageConstant } from '../constant/PageConstant';
import {
    DialModel,
    FissionBigDataCmdResultListener,
    FissionDialUtil,
    FissionDialUtilsV1,
    FissionSdkManager,
    QuickLZUtils,
    SpKeys,
    SpUtil
} from 'fission_sdk';
import { TitleBar } from '../components/TitleBar';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { image } from '@kit.ImageKit';
import { FissionConstant,splitUint8Array } from 'fission_sdk';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { dataSharePredicates } from '@kit.ArkData';
import { LengthMetricsUnit } from '@kit.ArkUI';

@HMRouter({ pageUrl: PageConstant.PAGE_CLIP_IMAGE })
@Component
export struct PageClipImage {
    @State imagePath: string = ''
    context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    @State sourcePixelMap: PixelMap | null = null;
    private scroller: Scroller = new Scroller();

    private settings: RenderingContextSettings = new RenderingContextSettings(true);
    private contextPX: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings, LengthMetricsUnit.PX);
    aboutToAppear(): void {

    }

    build() {
        Scroll(this.scroller) {
            Column() {
                TitleBar({
                    title: '裁剪',
                    onBackClick: () => {
                        HMRouterMgr.pop({ navigationId: 'mainNavigationId' })
                    }
                })
                Stack() {
                    Canvas(this.contextPX)
                        .width('100%')
                        .height('100%')
                        .backgroundColor('#ffff00')
                        .onReady(() => {

                        })

                    Image(this.sourcePixelMap).width('100%').height('100%').onClick(() => {
                        this.selectImage();
                    }).objectFit(ImageFit.ScaleDown)

                }.width('100%').height('100%')
            }
            .backgroundColor(Color.White)
        }.width('100%')

    }

    selectImage() {

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
                    let opt: image.DecodingOptions = {
                        editable: true,
                        desiredSize: imageInfo.size,
                        desiredPixelFormat: image.PixelMapFormat.RGBA_8888
                    }

                    data.createPixelMap(opt, (err: BusinessError, pixelMap: image.PixelMap) => {
                        if (err) {
                            console.error(`Failed to create pixelMap.code is ${err.code},message is ${err.message}`);
                        } else {
                            that.sourcePixelMap = pixelMap
                        }
                    })
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
}
