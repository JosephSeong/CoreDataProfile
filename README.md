# CoreDataProfile
![js](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)



|차이점|UserDefaults|**CoreData**|
|------|---|---|
|목적|주로 앱 설정, 사용자 환경 설정 또는 작은 양의 텍스트 데이터를 저장하는 데 사용. <br/>간단한 설정이나 사용자의 환경 설정과 같은 소량의 데이터를 저장하는 용도로 적합.|대량의 구조화된 데이터를 저장하고 관리하는 데 사용. <br/>복잡한 데이터 모델을 지원하며, 데이터 간의 관계를 효과적으로 다룰 수 있다.|
|데이터 모델|기본적으로 key-value 쌍을 사용하여 데이터를 저장. <br/>주로 기본 데이터 유형 및 몇 가지 커스텀 타입을 저장하는 데 적합.|관계형 데이터베이스를 기반으로 하며, 복잡한 데이터 모델을 정의하고 관리할 수 있다.v Entity, Attribute, Relationship 등을 사용하여 데이터 모델을 설계한다.|
|성능 및 용도|간단하며 작은 양의 데이터를 저장하는 데 최적화되어 있다.<br/> 복잡한 쿼리나 대량의 데이터를 처리하는 데는 적합하지 않다.|대규모 데이터 집합을 효율적으로 처리할 수 있다. <br/>복잡한 데이터 모델 및 관계를 다룰 때 성능이 뛰어나며, 데이터 검색 및 필터링에 용이.|
|지속성|데이터가 파일 시스템에 plist 파일 형태로 저장.<br/> 간단한 텍스트 데이터를 저장하는 데 사용되며, 앱이 종료되어도 데이터가 지속된다.|SQLite, XML, 이진 파일 등과 같은 백엔드 스토어를 사용하여 데이터를 지속화한다.<br/> 앱이 종료되어도 데이터를 유지하고 나중에 로드할 수 있다.|

## 요약
- **UserDefaults**는 간단한 설정이나 작은 양의 데이터를 저장하는 데 사용되는 반면
- **CoreData**는 대규모 및 복잡한 데이터 모델을 다루는 데 적합한 데이터 관리 프레임워크이다.
---

<img width="250" alt="스크린샷 2024-02-01 오전 11 36 34" src="https://github.com/JosephSeong/CoreDataProfile/assets/48307813/009ef953-35cb-4944-b6a3-c18ba4584c0e">

<img width="250" alt="스크린샷 2024-02-02 오후 4 28 53" src="https://github.com/JosephSeong/CoreDataProfile/assets/48307813/df84de8d-735b-4491-aafe-29b99bad27bf">




TodoList(UserDefaults에서 CoreData로)
