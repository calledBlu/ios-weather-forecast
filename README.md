# ios-weather-forecast

[1. Team Introduce](#-team-lunna-)

[2. Ground Rules](#-ground-rules)

[3. STEP별 구현내용](#-step별-구현-내용)

[4. 학습내용 및 문제 해결](#-학습내용-및-문제-해결)

<br>

## 🌙 Team LuNna 🌙
🏃🏻🏃🏻‍♂️💨 **프로젝트 기간:** `23.03.13` ~ `23.04.14`

|<img src="https://avatars.githubusercontent.com/u/71758542?v=4" width=200>|<img src="https://avatars.githubusercontent.com/u/67406889?v=4" width=200>|
|:---:|:---:|
|[Blu](https://github.com/bomyuniverse)|[Jenna](https://github.com/ueunli)|

<br>

## ⛳ Ground Rules
- **커밋 규칙**
    - ✨ **Git Commit Convention**
        - Prefix 전체 소문자, **`[prefix]`**
        - `feat` = 주로 사용자에게 새로운 기능이 추가되는 경우
        - `fix` = 사용자가 사용하는 부분에서 bug가 수정되는 경우
        - `docs` = 문서에 변경 사항이 있는 경우
        - `config` = 프로젝트 초기 설정 시
        - `style` = 세미콜론을 까먹어서 추가하는 것 같이 형식적인 부분을 다루는 경우 (코드의 변화가 생산적인 것이 아닌 경우)
        - `refactor` = production code를 수정하는 경우 (변수의 네이밍을 수정하는 경우)
        - `test` = 테스트 코드를 수정하거나, 추가하는 경우 (코드의 변화가 생산적인 것이 아닌 경우)
        - `chore` = 별로 중요하지 않은 일을 수정하는 경우 (코드의 변화가 생산적인 것이 아닌 경우)
        - +) `design` = UI 디자인을 변경했을 때
- 브랜치 → step 별로 구분, PR 시 main으로 전송
- **천천히 차근차근, 하나씩 하기**

<br>

## 🔨 STEP별 구현 내용

### STEP 1
- **모델/네트워킹 타입 구현**
    - Open Weather Map의 날씨 API의 데이터 형식을 고려한 모델 타입 구현
    - **위도, 경도**를 사용하여 날씨를 호출 할 수 있도록 `WeatherURL` 타입 구현
- 🗝️ keyword: `API Key`, `URLSession`, `Codable`, `JSONDecoder`, `CodingKey`
- [STEP 1 PR 🔗](https://github.com/tasty-code/ios-weather-forecast/pull/4)

### STEP 2
- **위치정보 확인 및 날씨 API 호출**
    - 시뮬레이터의 위도와 경도를 Custom으로 설정
    - CoreLocation과 API를 통해 현재 좌표의 날씨 Data 호출
    - `CLLocationManagerDelegate`의 `locationManager(_:didUpdateLocations:)`의 매개변수 locations로 현재 위도, 경도를 포함한 `CLLocation` 타입 가져오기
- 🗝️ keyword: `CoreLocation`, `URLComponent`, `HTTP Method`, `CLGeocoder`
- [STEP 2-1 PR 🔗](https://github.com/tasty-code/ios-weather-forecast/pull/6)
- [STEP 2-2 PR 🔗](https://github.com/tasty-code/ios-weather-forecast/pull/8)

### STEP 3
- **UI구현**
    - `Collection View`를 활용하여 앱의 UI 구현
        - header view에 현재 날씨 적용
        - cell에 5일 예보 적용
    - 코드베이스 AutoLayout 구현
- 🗝️ keyword: `CollectionView`, `DateFormatter`, `UICollectionViewCompositionalLayout`, `URLComponents`, `UIRefreshControl`
- [STEP 3-1 PR 🔗](https://github.com/tasty-code/ios-weather-forecast/pull/13)
- [STEP 3-2 PR 🔗](https://github.com/tasty-code/ios-weather-forecast/pull/18)

<br>

## 📚 학습내용 및 문제 해결

### 1. API Key

> 🖇️　참고한 문서: [API Key](https://en.wikipedia.org/wiki/API_key), [Keeping API Keys Safe](https://betterprogramming.pub/fetch-api-keys-from-property-list-files-in-swift-4a9e092e71fa)
> 
- **학습 내용**
    - 개인별로 발급, API를 호출하기 위한 key
    - 공개하면 안 됨
- **적용 과정**
    - url쿼리에 들어가는 내용이라... → 현재는 문자열 배열을 .joined(separator: "&")처리하는 방식으로 구현했으나, 다음 스텝에서 `URLQueryItem`(추가학습키워드+)에 대한 학습 진행 후 리펙토링 예정!
- **문제와 해결**
    - 숨겨야 했음 → 재발급, 숨기기 (아래 질문사항에!)

### 2. URLSession

> 🖇️　참고한 공식문서: [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
> 
- **학습 내용**
    - URLSession은 싱글턴 인스턴스(shared)를 제공
    - 인스턴스메서드 '.data(for:`URLRequest`)'의 반환형은 `(Data, URLResponse)`
- **적용 과정**
    - api별 url로 `URLRequest`를 미리 만들어 인수로 사용
    ('.data(from: `URL`)' 사용하지 않음)
    - 지금 단계에선 response 없이 data만 할당하여 활용 → 다음 스텝에서 사용할 예정
- **문제와 해결**
    - 데이터 불러오기는 비동기로 이루어지되, 불러온 데이터를 활용하는 건 메인스레드에서 처리되어야 함
       - 동작 확인 방법: ViewController의 viewDidLoad()에서 `Task { ... }` 안에 묶어서 실행
       - `async`-`await` 활용에 도전 (기회가 된다면 GCD 등 다른 방식으로도 해보고 싶어요!)

### 3. Codable, JSONDecoder

> 🖇️　참고한 공식문서:
> - [Codable](https://developer.apple.com/documentation/swift/codable)
> - [JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder/)
> - [decode(_:from:)](https://developer.apple.com/documentation/foundation/jsondecoder/2895189-decode)

- **학습 내용**
    - `Encodable`과 `Decodable`의 합성 프로토콜
    - `JSONDecoder`는 `Codable`을 채택한 class로, 아래의 제네릭 메서드를 통해 (JSON형식의)Data를 원하는 모델타입으로 변환할 수 있음
        
        ```swift
        func decode<T>(_ type: T.Type, from: Data) -> T {   }
        ```
        
- **적용 과정**
    - 아래 이유로, 모델들이 `Codable`이 아닌 `Decodable`만 채택하도록 함
        - `decode(_:from:)` 문서에 따르면 type매개변수에 들어갈 제네릭 인자는 Codable이 아닌 ‘Decodable’만 준수하면 된다는 조건임
        - 우리가 사용하고자 하는 API는 날씨 데이터로, encoding하는 상황을 고려하지 않아도 됨    
(애초에 대부분의 api는 get 전용으로 한정되어 있음)
- **문제와 해결**
    - `.decode(type: 모델타입명, from: api데이터)`의 ‘모델 타입명’
        1. 타입 명을 달리 하기 위해 메서드나 타입을 둘(확장성을 고려하면 둘 이상) 만들거나 매개변수로 `weatherRange`를 넣어줘야 했음
        2. `Decodable`을 채택하며 weatherRange타입속성을 요구하는 `whetherComposable` 프로토콜을 새로 정의하여, JSON데이터를 받아올 주요 모델 2개가 준수하도록 함
        3. `WeatherParser`타입에 제네릭(`<T: WheterComposable>`)을 적용하여 `T.self`로 ‘타입명’을 받아올 수 있도록 함

### 4. CodingKey

> 🖇️　참고한 공식문서: [CodingKey](https://developer.apple.com/documentation/swift/codingkey/)
> 
- **학습 내용**
    - JSON data의 key와 모델의 프로퍼티 네이밍을 다르게 쓰고 싶을 경우, 인코딩&디코딩 과정에서 둘을 매칭해주는 ‘프로토콜’
    - 보통 해당 모델 내부에 중첩열거형으로 선언해서 쓰며, 모델 내 모든 프로퍼티에 대한 case를 작성해줘야 함
- **적용 과정**
    - 받아온 데이터를 그대로 쓰기에는 네이밍 가이드라인에 위배되는 부분이 많았음 → 고쳐줘야 해서 쓸 수밖에 없었음
- **문제와 해결**
    - 모델의 프로퍼티 중 JSON Data의 key와 일치하는 항목이 없는 경우 decoding 과정에서 error가 발생하였음
    - ViewController의 `ViewDidLoad()` 메서드를 활용하지 않고 LLDB를 통해 디버깅을 시도하였고 그 과정에서 `p data`를 실행하는 경우 아래와 같은 에러 발생
        ```swift
        error: expression failed to parse:
        warning: <EXPR>:11:7: warning: initialization of variable '$__lldb_error_result' was never used; consider replacing with assignment to '_' or removing it
          var $__lldb_error_result = __lldb_tmp_error
          ~~~~^~~~~~~~~~~~~~~~~~~~
          _

        error: <EXPR>:19:5: error: cannot find '$__lldb_injected_self' in scope
            $__lldb_injected_self.$__lldb_wrapped_expr_15(
            ^~~~~~~~~~~~~~~~~~~~~
        ```
    -  고민 및 검색해 본 결과 lldb 디버거가 제네릭을 활용하는 부분인 `T.self`를 추론하지 못해서 생기는 문제라고 판단!
    -  LLDB를 통해 디버깅하는 과정을 추가 학습하도록 하고, 우선적으로 정상 작동되었을 때의 components들과 오류가 발생했을 시점의 components들과 비교하여 오류가 발생하는 부분을 찾아 수정할 수 있었음


### 5. CoreLocation
> 🖇️　참고한 공식문서: 
> - [CoreLocation](https://developer.apple.com/documentation/corelocation)
> - [CLLocationManager](https://developer.apple.com/documentation/corelocation/cllocationmanager)
> - [CLLocationManagerDelegate](https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate)

- **학습 내용**
    - Core Location을 사용하기 위해서는 `CoreLocation` 프레임워크를 import해야 함
    - Core Location은 장치의 지리적 위치와 방향을 얻는 것으로 `CLLocationManager` 클래스의 인스턴스로 Core Location 서비스를 구성하고 사용하고 중지시킬 수 있음
    - Core Location으로 알 수 있는 정보
        - 위치 업데이트
        - 지역 모니터링
        - iBeacon 감지 및 찾기
        - 나침반의 방향
    - Core Location을 사용하기 위해서는 승인을 요청해야 함
        - 승인 변경을 비롯한 이벤트는 `CLLocationManagerDelegate` 프로토콜을 준수하는 개체에서 수신
    - `CLLocationManager` 인스턴스가 할당되면 시스템이 delegate의 `locationManagerDidChangeAuthorization(_:)`메서드에 앱의 승인 상태를 보고함
        - 그렇기 때문에 manager가 구성되는 시점에 delegate를 즉시 할당해야 함
    - 위치 서비스 권한
        - When In Use와 Always가 있음
        - 공식문서에서는 가능하면 When In Use만 사용하는 것을 권장
        - 위치 정보는 민감한 개인정보이기 때문에 사용자에게 위치 사용에 대한 설명이 필요함
- **적용 과정**
    - 시뮬레이터에 커스텀으로 설정해 둔 현재 위치 받아오기
- **문제와 해결**
    |문제와 해결|내용|
    |:---:|:---|
    |문제|ViewController의 `viewDidLoad()` 메서드 내부에 `locationManager.requestLocation()`를 호출하는 경우 `locationManager(didFailWithError:)`가 호출되던 문제|
    |해결|학습 내용처럼 CLLocationManager 할당 시 권한을 확인하는 메서드가 호출되므로, 사용자에게 권한 요청을 하기 전에 위치 정보를 요청하게 됨! 이로 인해 location을 받아올 수 없어서 error handling 관련 메서드가 호출됨!<br>**⭐️권한을 확인하는 메서드 내부에서만 location을 호출하도록 리팩토링**|
    
- **아쉬운 점**
    전력 사용을 최적화 할 수 있는 설정에 대한 학습을 추가로 진행하지 못해서 아쉬웠지만, STEP 2-2에서 함께 학습 후 반영하기로 함!


### 6. URLComponent

> 🖇️　참고한 공식문서: 
> - [URLComponent](https://developer.apple.com/documentation/foundation/urlcomponents)
> - [URLQueryItem](https://developer.apple.com/documentation/foundation/urlqueryitem)
    
- **학습 내용**
    - `URLComponents` 인스턴스는 `URL?`타입 프로퍼티를 가짐
    - `URLQueryItem`은 key, value 형태로 생성
    - `path`속성에 String을 append, `queryItems`에 [`URLQueryItem`]을 할당 혹은 append해주면 자동으로 url에 알맞은 양식으로 추가됨
- **적용 과정**
    - 아래 이유로 URLComponents를 사용하도록 리펙토링에 도전
        1. 기존에 비해 문자열 관련 연산을 줄이고 기본제공 타입을 활용하고자 함, 
        2. URL의 구성요소에 보다 구조적으로 접근하고 활용할 수 있겠다는 장점을 고려
    - 적용 방법
        1. `baseURL`을 기반으로 URLComponents 인스턴스를 만들어 필요한 `path`, `query` 매개변수들을 추가·할당
        2. 완성된 인스턴스의 url을 옵셔널바인딩하여 에러를 던지거나 url(`URL`타입)을 반환
- **문제와 해결**
    |문제와 해결|내용|
    |:---:|:---|
    |기존|URLComponents인스턴스를 static 프로퍼티로 선언, path는 `해당 인스턴스.path.append("String")`해주는 식으로 구현|
    |문제|static 프로퍼티다 보니, `WeatherParser.make(at:weatherRange:)` 메서드가 호출될 때마다 path가 바뀌지 않고 덧붙여지는(append) 문제|
    |해결|    static 프로퍼티로는 URLComponents 생성자에 필요한 `baseURL`(String) 형태만 저장, 메서드 body 내에서 URLComponents 인스턴스를 생성하여 쓰도록 수정|


### 7. HTTP Method
> 🖇️　참고한 공식문서: 
> - [URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)
> - [NSURLRequest](https://developer.apple.com/documentation/foundation/nsurlrequest#1776617)
> - [httpMethod](https://developer.apple.com/documentation/foundation/urlrequest/2011415-httpmethod)

- **학습 내용**
    - httpMethod
    - URLRequest & NSURLRequest
        - 로드 요청에 대한 두 가지 필수 속성을 캡술화함
            - 로드할 URL
            - 사용되는 정책
        - HTTP/HTTPS 요청의 경우 HTTP method(GET, POST...)와 헤더를 포함
        - HTTP method를 지정하기 위한 `httpMethod` 프로퍼티는 `NSURLRequest` 클래스의 프로퍼티임
        - Foundation 프레임워크는 `URLRequest`클래스와 해당 가변 클래스인 `NSMutableURLRequest`에 연결된 `URLRequest` 구조체를 제공함,    
**즉, `NSURLRequest`에 있는 component들을 `URLRequest`에서 사용할 수 있음!**
        - httpMethod의 기본 HTTP method는 GET
- **적용 과정**
    - 문서에 따르면 `"GET"`이 default값
        ```Swift
        The default HTTP method is “GET”.
        ```
    - 'HTTP GET 메서드 명시적 호출'이 요구사항이라 아래와 같이 set해주는 코드를 추가해주긴 했지만, 아래 아쉬운 점과 더불어 '명시적 호출'을 제대로 구현한 게 맞는가에 대한 의문이 듦
       ```Swift
       request.httpMethod = "GET"
       ```
    
- **아쉬운 점**
    - 문서에서 알 수 있다시피 String? 타입이라 String("GET") 리터럴값을 직접 넣어줘야 했음
    - 휴먼에러가 발생하기 쉬운 부분이라고 생각되는데 원래 이렇게 사용하는 게 맞는 건지, 놓친 부분이 있는지 궁금함

<br>

### 8. CLGeocoder

> 🖇️　참고한 공식문서: 
> - [CLGeocoder](https://developer.apple.com/documentation/corelocation/clgeocoder)
> - [CLPlacemark](https://developer.apple.com/documentation/corelocation/clplacemark)
    
- **학습 내용**
    - CLGeocoder
        - Core Location 프레임워크 내부의 클래스
        - 위도와 경도로 이루어진 좌표와 사용자 친화적인 주소 표현 사이의 변환 서비스를 제공하는 클래스
        - 일반적으로 거리, 도시, 주, 국가 및 지역정보를 포함함
        - forward geocoding method  (**순방향**)
            - 사용자가 읽을 수 있는 주소로 위도와 경도를 찾음
            - 관심 지점이나 해당 위치의 건물과 같은 지정 위치에 대한 추가정보를 반환할 수 있음
            - 제공된 정보가 여러 위치를 산출할 경우 여러 개의 placemark가 반환될 수 있음
        - reverse geocoding method (**역방향**) ✅
            - 위도와 경도를 가지고 사용자가 읽을 수 있는 주소를 찾음
            - `reverseGeocodeLocation` 사용
        - forward / reverse 모두 `CLPlacemark` 형태로 반환
    - CLPlacemark
        - 장소의 이름, 주소 및 기타 관련 정보를 포함하는 좌표에 대한 **사용자 친화적인 설명**
        - 지정된 위/경도에 대한 placemark 데이터를 저장
        - 좌표, 국가, 지역, 주, 도시 및 거리 주소와 같은 정보 포함
        - 관심지점 및 지리적인 데이터가 포함될 수 있음
        - reverse geocoding을 하는 경우 CLPlacemark 개체를 반환받음
        - Detail properties
            |프로퍼티명|설명|
            |:---|:---|
            |`throughfare`|The street address associated with the placemark.<br>**거리 주소(도로명주소의 ~로)**|
            |`subThroughfare`|Additional street-level information for the placemark.<br>**추가 거리수준 정보(상세주소)**|
            |`locality`|The city associated with the placemark.<br>**도시('시'로 끝나는 행정구역)**|
            |`subLocality`|Additional city-level information for the placemark.<br>**추가 도시수준 정보(동/면/~로)**|
            |`adminstrativeArea`|The state or province associated with the placemark.<br>**주 혹은 지방 정보(행정구역 중 가장 넓은 범위, 도/특별시/광역시)**|
            |`subAdminstrativeArea`|Additional administrative area information for the placemark.<br>**추가 행정구역 정보(행정구역 중 군)**|
            |`postalCode`|The postal code associated with the placemark.<br>**우편번호**|
            |`country`|The name of the country or region associated with the placemark.<br>**국가명**|
            |`name`|The name of the placemark.<br>**placemark의 이름(보통 throughfare + subThroughfare)**|
- **적용 과정**
    - CLLocationManager으로 가져온 CLLocation 타입의 location으로 reverse geocoding 을 진행
- **문제와 해결**
    |문제와 해결|내용|
    |:---:|:---|
    |문제|기존에 Coustom Location으로 지정한 좌표(37.53, 126.96)를 기준으로 주소를 가져오는 경우 '구'에 해당하는 '용산구'를 불러오는 프로퍼티가 없음|
    |해결|***해결중!!*** 외부 라이브러리가 제약된 상황이라 출력된 정보를 가지고 가공해야 하는지 방법을 찾아보는 중|
    
### 9. UICollectionViewCompositionalLayout
> 🖇️　참고한 공식문서: 
> - [UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout)
> - [UICollectionLayoutListConfiguration](https://developer.apple.com/documentation/uikit/uicollectionlayoutlistconfiguration)
> - [UICollectionViewListCell](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)
> - [UIBackgroundConfiguration](https://developer.apple.com/documentation/uikit/uibackgroundconfiguration)
- **학습 내용**
   - `UICollectionViewCompositionalLayout`
       - Collection View 레이아웃의 한 종류
       - 적응성이 높고 유연한 배열로 아이템을 결합할 수 있는 레이아웃 개체
       - `list(using:)` 메서드 사용 시 지정된 구성의 list 섹션만 포함하는 레이아웃을 구성
       - 위 메서드를 사용하기 위해서는 `UICollectionLayoutListConfiguration`으로 layout을 구성해 주어야 함
    - `UICollectionLayoutListConfiguration`
        - list의 header와 footer를 설정하기 위해 필요한 구조체
        - `headerMode`, `footerMode` 프로퍼티를 .supplementary로 설정하여 보조 view를 사용하여 header, footer 표시 가능
        - 위 프로퍼티들은 .none이 기본값, `headerMode`의 경우 .firstItemInSection으로 Section 내의 첫 번째 아이템을 헤더로 사용할 수 있음
        - `backgroundColor`는 배경색을 완전히 없애기 위한 프로퍼티
            - 기본 값은 nil이지만, 이는 system background color를 사용한 것 → 우리 프로젝트에서는 white로 지정됨
        - appearance로 list의 모양을 지정해줄 수 있음
    - `UICollectionViewListCell`
        - list 기능과 기본 스타일을 사용하기 위해 사용되는 Collection View cell 클래스
        - list의 셀 액세서리나 상호작용 동작 등을 지원하는 타입
    - `UIBackgroundConfiguration`
        - View에 대해 배경을 구성하는 타입
        - UIButton에 직접 적용하거나 UICollectionView/UITableView의 cell, header, footer에 적용할 수 있음
- **적용 과정**
   - FlowLayout에서 CompositionalLayout으로 리팩토링하는 과정에서 `UICollectionViewCell` 대신 `UICollectionViewListCell`으로 대체하려고 하였으나 현재 프로젝트 내에서는 list의 기능을 사용할 일이 없으므로 학습만 진행
- **문제와 해결**
   - View의 backgroundColor를 .clear로 설정하였으나 배경색이 사라지지 않는 문제 발생
   - View를 구성하는 configuration의 backgroundColor를 .clear로 해주어야 배경색이 사라짐
- **아쉬운 점**
   - `defaultContentConfiguration()`을 활용하여 셀을 구성해보지 못한 것이 조금 아쉬움

<br>

### 10. URLComponents
> 🖇️　참고한 공식문서: 
> - [URLComponents](https://developer.apple.com/documentation/foundation/urlcomponents)
- **적용 과정**
   - **기존)**
   날씨 데이터/아이콘 중 무엇을 불러오기 위한 url이냐에 따라 URL 구성요소가 달라져 매개변수가 다른 메서드를 여럿 구현하는 과정에서 중복표현이 다수 발생
   - **수정)**
      - 기존에는 path, queryItems 프로퍼티만 활용했지만, 이번에는 scheme, host 등 다른 url요소도 적극적으로 다뤄보기로 함
      - 데이터/아이콘을 불러오기 위한 메서드 각각에서 path, queryItems를 직접 할당해줬던 기존 코드가 OCP에 좋지 않다고 판단, 불러올 타입에 따라 여러 가지 url요소들(scheme, host, path, query 등)을 계산속성으로 알려주는 WeatherRouter 열거형을 구현
      - URL 및 URLRequest를 만드는 기능은 연관성이 깊은 WeatherRouter에 맡기고, 실제로 데이터를 받아오는 기능만 WeatherParser에 구현
- **문제와 해결**
   |트러블슈팅 A|제네릭타입 명시 문제|
   |:-:|:-|
   |😰|- 불러올 타입에 따른 중복로직을 최대한 통합하려고 했으나, 어디까지나 url생성 및 변환을 위한 정보를 매개변수를 통해 전달해줘야 하므로 제네릭타입 관련 문제점이 발생<br>- WeatherParser에서 날씨데이터가 아닌 날씨아이콘을 parse하는 메서드는 WeatherParser의 제네릭타입 T의 정보를 필요로 하지 않음에도 호출부에서 제네릭 타입을 넣어줘야 했으므로 불필요&적절치 않은 비용을 발생시킴|
   |🚀|- WeatherParser타입이 아닌, 날씨데이터를 불러오는 메서드에만 단독으로 제네릭타입을 붙이기로 함|
   
   |트러블슈팅 B|제네릭타입 추론 문제|
   |:-:|:-|
   |😰|- 제네릭 메서드의 호출부에서 제네릭타입을 추론하기 위한 단서를 요구<br>- 메서드의 반환형을 담을 상수에 타입을 명시하려 했으나, 협업인원이 늘어나고 이러한 유의사항의 공유가 활발하지 않다면 이를 놓쳐 휴먼에러가 발생할 여지가 크다는 우려 발생
   |🚀|- 제네릭타입 T의 추론을 위한 단서(`T.Type`)를 해당 메서드의 매개변수로 받도록 강제함으로써 위의 우려를 해결|
- **아쉬운 점**
   - host 프로퍼티의 경우 맨앞의 "api." 외에는 모두 동일함
   - 아래 3가지를 고민하다가 3번을 택했지만, 여전히 중복표현이 많아 좋은 방법인지 확신이 서지 않음
       1. 'api.'를 제외한 부분(openweathermap.org)을 공통상수로 선언 후, 한쪽에만 'api.'를 붙여 host에 할당하는 방법, 
       2. `subhost: String` 계산속성을 만들어 한쪽은 "api.", 한쪽은 ""를 넣은 후 host = subhost + host 해주는 방법, 
       3. 한쪽은 "api.open~org", 한쪽은 "open~org"을 host에 할당하는 방법
     

<br>

### 11. UIRefreshControl
> 🖇️　참고한 공식문서: 
> - [UIRefreshControl](https://developer.apple.com/documentation/uikit/uirefreshcontrol)
- **학습 내용**
   - `UIRefreshControl` 인스턴스에 `addTarget(_:action:for:)`로 action method를 더해주면 target은 refreshControl의 beginRefreshing을 감지하고 controlEvents를 위해 selector안에 넣어 둔 objc메서드를 실행함
   - `UICollectionView` 인스턴스는 `UIRefreshControl?`타입의 `refreshControl`프로퍼티를 가짐
   (따라서 기본값이 nil이므로 새로운 UIRefreshControl 인스턴스를 만들어 addTarget한 후 할당해줘야 함)
- **적용 과정**
   - `configureRefreshControl()` 메서드 및 objc메서드 `refreshCollectionView()`를 ViewController에 구현

<br>
