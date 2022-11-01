//
//  Cosntant.swift
//  NetworkBasic
//
//  Created by Carki on 2022/08/01.
//

import Foundation

struct APIKey {
    static let BOXOFFICE = "2447b8fcd01f3c451e652506fd5950da"
    static let NAVER_ID: String = "YE7cni9bubM_t_SRGx_s"
    static let NAVER_SECRET: String = "gW_aaxnyaa"
    
}

struct EndPoint {
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber"
    static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let imageSearchURL = "https://openapi.naver.com/v1/search/image.json?"
}

//방법1. 열거형
//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//}

//방법2. 구조체
struct StoryboardName {
    
    //접근 제어를 통해 초기화 방지
    //private가 붙으면 다른 타입들에서는 사용할 수 없다.
    private init() {
        
    }
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

//StoryboardName.search -> 이런식으로 사용한다
/*
 1.struct type property vs enum type property => 구조체는 인스턴스 생성 방지 코드(init())이 필요하다
 구조체 -> 인스턴스 생성 될 수 있음
 */

//방법3
// case vs enum 차이? => 중복, case 제약
// ->
//enum StoryboardName { //열거형은 구조체나 클래스처럼 인스턴스를 만들 수 없다
//    var nickname = "고래밥" //인스턴스 저장 프로퍼티
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

enum FontName {
    //static let vs case -> 중복된 내용을 하드코딩 할 수 있냐 없냐의 차이
    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
}
