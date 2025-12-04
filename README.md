# HOS_Fission_Demo

# 1.SDK 快速接入

## 1.1 添加权限
```json
{
  "module": {
    "requestPermissions": [
      {
        "name": "ohos.permission.APPROXIMATELY_LOCATION"
      },
      {
        "name": "ohos.permission.APPROXIMATELY_LOCATION"
      },
      {
        "name": "ohos.permission.APPROXIMATELY_LOCATION"
      }
    ]
  }
}
```

## 1.2 添加核心库（必须）
```json
{ "dependencies": { "rxjs": "^7.8.1" } }
```

# 2.SDK 连接设备
## 2.1 初始化SDK
```ts
FissionSdkManager.getInstance().init(true);
```

## 2.2 连接
```ts
  /**
   * 连接
   * @param deviceInfo（deviceInfo.macAddress 非空）
   * @param reConnect
   */
  public connectBleDevice(deviceInfo: DeviceInfo) {
    let that = this;
    let bleComConfig: BleComConfig = new BleComConfig();
    let bindKey: string = getBindKey(deviceInfo.macAddress);
    bleComConfig.bindKeys = bindKey; //需保存，重连时传入，key不一致会重走绑定流程。
    bleComConfig.isBind = true;
    this.onDeviceDataListener();//订阅数据

    FissionSdkManager.getInstance().connectBleDevice(deviceInfo, bleComConfig, {
        /**
         * BLE 连接状态变化
         * @param newState
         */
        onConnectionStateChange(newState: BLE_STATE): void {
          switch (newState) {
            case BLE_STATE.DISCONNECTED:
              console.log(`${that.TAG} connectState: 断开连接`);
              break;
            case BLE_STATE.CONNECTING:
              console.log(`${that.TAG} connectState: 连接中...`);
              break;
            case BLE_STATE.CONNECTED:
              console.log(`${that.TAG} connectState: 已连接`);
              break;
            case BLE_STATE.DISCONNECTING:
              console.log(`${that.TAG} connectState: 正在断开连接中。。。。`);
              break;
          }
        },

        /**
         * BLE 连接失败
         * @param throwable
         */
        onConnectionFailure(throwable: Error): void {
        
        },

        /**
         * Ble 连接成功后， 绑定中/发现服务（取决于是否需要绑定）
         */
        onBinding(): void {
       
        },

        /**
         * 绑定成功/发现服务成功 （真正意义上的连接成功，可以正常通讯）
         */
        onBindSucceeded(address: string, name: string): void {
          FissionSdkManager.getInstance().getHardwareInfo();
        },

        /**
         * 绑定失败
         * @param code
         */
        onBindFailed(code: number): void {
         
        },

        /**
         *  当前ble连接的设备是新设备
         */
        isBindNewDevice(): void {
          
        },

        /**
         *  ble通讯服务异常解绑
         */
        onServiceDisconnected(): void {
         
        }
      })
  }
```

# 3.获取数据（心率，电量）
```ts
   //设置数据监听接收数据
  //AT指令类
  FissionSdkManager.getInstance().addListener(new AtDataListener())
   class AtDataListener extends FissionAtCmdResultListener {
            sendSuccess(cmdId: string): void {
            }

            sendFail(cmdId: string): void {
            }

            onResultTimeout(cmdId: string): void {
            }

            onResultError(cmdId: string): void {
            }

            fssSuccess(fssStatus: FssStatus): void {
                
            }
            getDeviceBattery(deviceBattery: DeviceBattery): void {
                //接收电量数据
            }
        }

 //大数据指令
FissionSdkManager.getInstance().addListener(new BigDataListener())
  class BigDataListener extends FissionBigDataCmdResultListener {
            sendSuccess(cmdId: string): void {

            }

            sendFail(cmdId: string): void {

            }

            onResultTimeout(cmdId: string): void {

            }

            onResultError(errorMsg: string): void {

            }

            getHeartRateRecord(heartRateRecords: HeartRateRecord[]):void {
              //接收心率记录数据
            }
        }

FissionSdkManager.getInstance().getDeviceBattery();
FissionSdkManager.getInstance().getHeartRateRecord(startTime, endTime);
```

