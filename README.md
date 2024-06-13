# CarbonCerts -- View carbon certificates and bookmark them (Online and Offiline)



![2](https://github.com/schetty/CarbonCerts/assets/16530138/e10db43e-a403-436f-af46-a358c69eed05)

### Languages and Libraries Used
- Moya & MoyaCombine
- SwiftUI
- SwiftData
- XCTesting
- XCUITesting

### Architecture Used
MVVM (Model-View-ViewModel)

### API
I pulled carbon certificate data from https://api-dev-v2.fieldmargin.com/tech-test, to persist information about the carbon certificates in a ListView. Each certificate can be bookmarked then found on the favorites tab.
All certificate data is cached locally so you can continue to view your favourite certificates even while youre offline. 
