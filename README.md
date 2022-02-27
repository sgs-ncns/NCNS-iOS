#  NCNS-iOS

[![CocoaPods Version](https://img.shields.io/badge/Swift-v5.3.2-orange)](https://www.swift.org)
[![CocoaPods Version](https://img.shields.io/badge/cocoapods-v1.11.2-blue)](http://cocoadocs.org/docsets/BadgeSwift)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<div align="center">
<img width= 25% alt="NCNS" src="https://user-images.githubusercontent.com/64491659/153750857-5f94dd7a-a27f-47d2-b53e-c6cbaffcd01f.png">

## SGS DEV CAMP 2기 NCNS팀의 인스타그램 클론 프로젝트 🥳
## 깐부스타그램

</div>

## 📚 사용 기술 스택 및 라이브러리
### 언어
- Swift

### 라이브러리
- SwiftUI
- Combine

### 개발도구
- Xcode

---
## 📋 요구 사항
| 대상 | 버전 |
|:-------------:|:-------------:|
| 애플리케이션 사용환경 | iOS 15.0+ |
| IDE | Xcode 13.0+ |

---
## 설치 방법

Swift Package Management와 외부 라이브러리 관리자인 CocoaPods을 같이 사용하였습니다. CocoaPods을 통한 라이브러리 설치가 필요합니다.


```bash
sudo gem install cocoapods

cd {path}/NCNS-iOS/SGS_NCNS/

pod install
```

## 코딩 방향성 설명
저는 앱 구현에서 처음으로 MVC가 아닌 **MVVM 패턴**, Swift UIKit이 아닌 **SwiftUI**, 마지막으로 비동기처리인 **Combine**을 사용해서 앱을 만들게 되었습니다. 

### 🗂 MVVM 패턴 구조
이번 개발에서는 처음으로 MVVM 패턴을 사용해 데이터 구조를 담당할 **Model**, 사용자에게 보여질 **View**, 비즈니스 로직을 담당할 **ViewModel**으로 나뉘도록 하였습니다.

특히 MVVM을 사용하면서 View에서는 비즈니스 로직에 관여하지 않도록 특히나 고민을 해보았습니다. 

### 👨‍💻 SwiftUI
MVVM 패턴을 좀 더 유용하게 쓰기 위해 SwiftUI에 도전했습니다. 또한 2019년에 출시된 최신 프레임워크라서 도전해보고 싶었습니다.

### 💻 Combine
비동기 처리 방식도 애플이 만든 퍼스트파티를 이용하고 싶었습니다. 또한 SwiftUI는 iOS 13+ 버전에서만 지원하는데, Combine도 지원 버전이 맞아서 쓰게 되었습니다. 

### 🍎 애플의 퍼스트파티를 경험해보자!
결론적으로는 애플이 만든 Frist-Party를 완전하게 써보고 싶었습니다. Snap-Kit이 아닌 SwiftUI, RxSwift가 아닌 Combine을 사용해 애플이 추구하는 방향을 이해하고싶기 때문입니다.

## 구동 화면 
|                          로그인 화면                          |                          팔로우 없을 시 피드                          |                          팔로우 있을 시 피드      
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | 
| <img alt="1_loginView" src="https://user-images.githubusercontent.com/64491659/155893784-34a870ac-4bc9-42e0-9fd9-02a0d5293975.png" width="60%" /> | <img alt="2_NoFollowerFeedView" src="https://user-images.githubusercontent.com/64491659/155893821-9303f801-8f6f-4678-905b-eb49df09b8a7.png" width = "90%"/> | <img alt="3_FollowerFeedView" src="https://user-images.githubusercontent.com/64491659/155893823-61a81004-1f43-4b05-9110-f589189d4031.png" width = "90%" />
|

 |                          포스트가 없을 시 프로필 뷰                     |                          포스트가 있을 시 프로필 뷰        
| :----------------------------------------------------------: | :----------------------------------------------------------: | 
| <img alt="5_NoPostProfileView" src="https://user-images.githubusercontent.com/64491659/155893865-d4d7defc-fb14-4b15-92b5-ad72db2b4f57.png" width = "60%" /> | <img alt="6_PostProfileView" src="https://user-images.githubusercontent.com/64491659/155893868-34b2ca91-50f5-4714-b681-6c8a91593c6b.png"  width="60%" /> |

|                          깐부 맺기                     |                          깐부 추가 후 피드 보기         |                          깐부 추가 확인                   |          프로필 뷰 팔로워 체크
| :----------------------------------------------------------:| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![깐부맺기](https://user-images.githubusercontent.com/64491659/155894067-4cbfb5ab-7f95-46ef-9c95-2d59dac9897c.gif) | ![깐부추가 후피드만 보기](https://user-images.githubusercontent.com/64491659/155894091-febf94a1-c0bf-46a5-a5ee-a01ff684beb9.gif) | ![깐부추가확인](https://user-images.githubusercontent.com/64491659/155894112-10cd1f1e-b780-4704-9871-24a223753a41.gif) | ![프로필뷰팔로워 체크](https://user-images.githubusercontent.com/64491659/155894356-921b379b-d9b2-43b2-989d-2233d787ec20.gif) | 

 |                          푸시 알림                     |                          서치 후 댓글        
| :----------------------------------------------------------: | :----------------------------------------------------------: | 
| ![푸시알림](https://user-images.githubusercontent.com/64491659/155894641-6bf84cb4-68d9-4d68-93fd-1cdf2a7f9161.gif) | ![서치 후 댓글](https://user-images.githubusercontent.com/64491659/155894742-d2f3f8c5-9c2e-4856-a72c-92b94cbb568d.gif) |


## 디렉토리 구조
```zsh
├── Model       # ViewModel에서 바인딩할 구조 정의
├── View        # View로 보여주기 위한 파일 정리
│   ├── Authentication
│   ├── Comments
│   ├── Feed
│   └── ...
├── ViewModel   # View에 적용될 비즈니스 로직 정의 
│   │            # (통신, 데이터 바인딩)
│   ├── Authentication
│   ├── Comments
│   ├── Feed
│   └── ...
├── Network     # 서버와 통신할 API 주소 및 ResponseModel 정의
├── Preview Content
├── Resources   # 이미지, 색상코드 정리
└── Utils       # Extension, CustomView, 상수 정의
```

## License
`NCNS-iOS` is available under the MIT license. See the LICENSE file for more info.


