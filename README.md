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
(추가 예정)

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


