//
//  ImageSearchAPIManager.swift
//  NetworkBasic
//
//  Created by Carki on 2022/08/05.
//

import Foundation

import Alamofire
import SwiftyJSON

//클래스 싱글턴 패턴 vs 구조체 싱글턴 패턴
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() { }
    
    typealias completionHandler = (Int, [String]) -> Void
    
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping (Int, [String]) -> Void) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)" //한글이 안되는 이유 -인코딩(UTF-8)
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        //validate - 유효성 검사
        AF.request(url, method: .get, headers: header).validate(statusCode: 200..<500).responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let totalCount = json["total"].intValue
                
//                for item in json["items"].arrayValue {
//                    self.list.append(item["link"].stringValue)
//                }
                
                let list = json["items"].arrayValue.map { $0["link"].stringValue }
                completionHandler(totalCount, list)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
