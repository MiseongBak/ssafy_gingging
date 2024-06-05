// 카메라 설정
#include "esp_camera.h"
#define CAMERA_MODEL_AI_THINKER // Has PSRAM
#include "camera_pins.h"

// 블루투스 설정
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include "esp_bt.h"
#include "base64.h"     // Base64 인코딩용

#define SERVICE_UUID           "6E400001-B5A3-F393-E0A9-E50E24DCCA9E" // UART service UUID
#define CHARACTERISTIC_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID_TX "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
const String device_name = "GingStick";

BLEServer *pServer = NULL;
BLECharacteristic * pTxCharacteristic;

bool deviceConnected = false;
bool oldDeviceConnected = false;


// 센서 설정
#define DEBOUNCE_DELAY 100 // 디바운스 딜레이 100ms 설정
unsigned long lastDebounceTime = 0;  // 마지막 디바운스 시간을 저장
const int buttonPin = 12;
bool previousButtonState = LOW; // 버튼의 이전 상태를 저장 (풀다운 저항 사용)
bool readyToCapture = true; // 캡처 준비 상태
const int ledPin = 33;
bool ledState = false;
int loopCnt = 0;
const int cameraCapturePin = 13;
unsigned int cameraCaptureTime = 5000;


class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      deviceConnected = true;
    };

    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
    }
};

class MyCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharacteristic) {
      std::string rxValue = pCharacteristic->getValue();

      if (rxValue.length() > 0) {
        Serial.println("*********");
        Serial.print("Received Value: ");
        for (int i = 0; i < rxValue.length(); i++)
          Serial.print(rxValue[i]);

        Serial.println();
        Serial.println("*********");
      }
    }
};

// 카메라 데이터 전송
void sendData(uint8_t *data, size_t length) {
    String encodedData = base64::encode(data, length); // 데이터를 Base64로 인코딩
    size_t encodedLength = encodedData.length();
    int packetID = 0;           // 패킷 ID를 위한 변수
    const int packetSize = 500; // BLE 패킷 최대 크기 설정
    int index = 0;
    while (index < encodedLength) {
        packetID++;  // 각 패킷마다 패킷 ID를 증가
        String header = String(packetID) + "|"; // 패킷 ID를 문자열로 추가
        int currentPacketSize = (index + packetSize <= encodedLength) ? packetSize : encodedLength - index;
        String packet = header + encodedData.substring(index, index + currentPacketSize); // 패킷 데이터 생성
        pTxCharacteristic->setValue(packet.c_str());
        pTxCharacteristic->notify();  // BLE를 통해 패킷 전송

        // Serial.print("Sending packet ID ");
        // Serial.print(packetID);
        // Serial.print(", from index ");
        // Serial.print(index);
        // Serial.print(" with size ");
        // Serial.println(currentPacketSize);
        
        digitalWrite(cameraCapturePin, packetID % 2);

        delay(500);  // 수신기가 처리하고 응답할 시간
        index += currentPacketSize;
    }
}

// MAC주소 출력
void printMacAddress(uint8_t* mac) {
  for (int i = 0; i < 6; i++) {
    if (mac[i] < 16) {
      Serial.print("0");
    }
    Serial.print(mac[i], HEX);
    if (i < 5) {
      Serial.print(":");
    }
  }
  Serial.println();
}

// 카메라 캡처 시 
void handleButtonPress() {
  int currentButtonState = digitalRead(buttonPin);
  camera_fb_t *fb = NULL;
  Serial.println(currentButtonState);

  if (currentButtonState == LOW && cameraCaptureTime >= 5000) {
    cameraCaptureTime = 0;
    fb = esp_camera_fb_get();
    Serial.println("Get Image!");
    delay(50);
    if (!fb) {
      Serial.println("Failed to capture image");
      return;
    }
    Serial.println("Captured image, now sending...");
    sendData(fb->buf, fb->len);
    esp_camera_fb_return(fb);
    
  } else {
    Serial.println("No Data");
    const char* zeroSignal = "0";
    pTxCharacteristic->setValue(zeroSignal);
    pTxCharacteristic->notify();
    return;
  }
}



void setup() {
  Serial.begin(115200);

  // BLE setup //
  BLEDevice::init(device_name.c_str());  // 장치명

  pServer = BLEDevice::createServer();            // 서버생성
  pServer->setCallbacks(new MyServerCallbacks()); // 연결 상태 확인 콜백 등록

  BLEService *pService = pServer->createService(SERVICE_UUID);  // 서비스 추가

  // Create a BLE Characteristic
  pTxCharacteristic = pService->createCharacteristic(           // 송신 서비스 정의
										CHARACTERISTIC_UUID_TX,
										BLECharacteristic::PROPERTY_NOTIFY
									);

  pTxCharacteristic->addDescriptor(new BLE2902());

  BLECharacteristic * pRxCharacteristic = pService->createCharacteristic(
											 CHARACTERISTIC_UUID_RX,
											BLECharacteristic::PROPERTY_WRITE         // 수신 서비스 정의
										);

    pRxCharacteristic->setCallbacks(new MyCallbacks());           // 읽기함수 콜백

  // Bluetooth MAC 주소 출력
  uint8_t mac[6];
  esp_read_mac(mac, ESP_MAC_BT);
  Serial.print("Bluetooth MAC: ");
  printMacAddress(mac);

  // Start the service
  pService->start();

  // Start advertising
  pServer->getAdvertising()->start();
  Serial.println("Waiting a client connection to notify...");


  // 카메라 setup //
  camera_config_t config;
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sccb_sda = SIOD_GPIO_NUM;
  config.pin_sccb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 20000000;
  config.pixel_format = PIXFORMAT_JPEG;
  config.frame_size = FRAMESIZE_QVGA;    // 이미지 해상도
  config.jpeg_quality = 12;
  config.fb_count = 1;
  
  config.fb_location = CAMERA_FB_IN_PSRAM;
  config.grab_mode = CAMERA_GRAB_LATEST;
  if(psramFound()){
    config.jpeg_quality = 10;
    config.fb_count = 2;
  } else {
    config.jpeg_quality = 12;
    config.fb_count = 1;
  }

  esp_err_t err = esp_camera_init(&config);
  if (err != ESP_OK) {
    Serial.printf("Camera init failed with error 0x%x", err);
    return;
  }

  Serial.println("Camera Ready! Send images via Bluetooth.");

  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);      // 풀업 저 항이 외부에 연결되어 있다고 가정
  pinMode(cameraCapturePin, OUTPUT);
}


void loop() {
  // disconnecting
  if (!deviceConnected && oldDeviceConnected) {
      delay(500);
      pServer->startAdvertising();
      Serial.println("start advertising");
      oldDeviceConnected = deviceConnected;
  }
  
  // connecting
  if (deviceConnected && !oldDeviceConnected) {
      oldDeviceConnected = deviceConnected;
  }

  // 블루투스 연결 여부 시각화
  if(loopCnt % 100 == 0) {
        if(ledState) digitalWrite(ledPin, HIGH);
        else digitalWrite(ledPin, LOW);

        if(!deviceConnected) {
            ledState = !ledState;
        }
    }

  if(deviceConnected) {
    // 디바이스가 연결되었고, 카메라를 찍을 준비가 되어있다면 LED ON
    if (cameraCaptureTime >= 5000) {
      digitalWrite(cameraCapturePin, HIGH);
      handleButtonPress();
    } else {
      digitalWrite(cameraCapturePin, LOW);
    }
  } else {
    digitalWrite(cameraCapturePin, LOW);
  }

  cameraCaptureTime += 100;   // 카메라 준비 시간 체크
  loopCnt += 100;
  if(loopCnt == 5000) loopCnt = 0;
  delay(100);
}
