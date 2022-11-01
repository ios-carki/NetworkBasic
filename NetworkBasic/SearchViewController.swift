//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/27.
//

import UIKit

import Alamofire
import JGProgressHUD
import SwiftyJSON

/*
 Swift Protocol (왼팔 오른팔)
 -delegate
 -DataSouce

 1.왼팔 / 오른팔
 2.상속받는 클래tm
 3.오버라이드 제거
 */

/*
 각 json value -> list
 */

//한번의 뷰 컨트롤러 배경색 전환 익스텐션
extension UIViewController {
    func setBackGroundColor() {
        view.backgroundColor = .red
    }
}

class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    //ProgressView
    let hud = JGProgressHUD()
    
    //타입 어노테이션 VS 타입 추론 => 누가 더 속도가 빠를까
    //What's new in Swift
//    var nickname: String = ""
//    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.backgroundColor = .clear

        //연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
//        searchTableView.delegate = self //self 클래스의 인스턴스 자체
//        searchTableView.dataSource = self
        //테이블뷰가 사용할 테이블 뷰 셀(XIB) 등록
        //XIB: xml interface builder <= Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        searchBar.delegate = self
        
        //==========================================================================================
        //날짜 계산하기 방법
        //1. 어제기준 timeinterval 이용
//        let format = DateFormatter()
//        format.dateFormat = "yyyyMMdd" // TMI -> ""yyyyMMdd" "YYYYMMdd" -> 20221231 (찾아보기)
//        let dateResult = Date(timeIntervalSinceNow: -86400)
        
        //2. Date DateFormatter Calendar 이용
//        let format = DateFormatter()
//        format.dateFormat = "yyyyMMdd"
//        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
//        let dateResult = format.string(from: yesterday!)
        
        // 네트워크 통신: 서버 점검 등에 대한 예외 처리
        // 네트워크가 느린 환경 테스트:
        // 실기기 테스트 시 Condition 조절 가능!
        // 시뮬레이터에서도 가능! (추가 설치) -> Window -> Devices and Simulators -> 디바이스 연결 후 오른쪽 밑에
        //==========================================================================================
        
        requestBoxOffice()
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
//    func configureLabel() {
//        <#code#>
//    }
    
    func requestBoxOffice() {
        
        hud.show(in: view)
        list.removeAll()
        
        let calendar = Calendar.current
        let nowDate = Date() //오늘날짜

        //데이트포멧
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        let strNowDate = dateFormatter.string(from: nowDate) //nowDate를 문자열로 변환
        let date = dateFormatter.date(from: strNowDate) //문자열 타입의 오늘날짜
        let yesterday = calendar.date(byAdding: .day, value: -1, to: date!) //어제날짜
        let strYesterday = dateFormatter.string(from: yesterday!) //문자열 타입의 어제날짜
        
        //targetDt에 "yyyyDDmm"데이트포멧 형식의 문자열 strYesterday 대입
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(strYesterday)"

        //validate - 유효성 검사
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
//                self.list.removeAll()
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNM = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNM, releaseDate: openDt, totalCount: audiAcc)
                    
                    self.list.append(data)
                }
                
                print(self.list)
                print(strYesterday)
                self.searchTableView.reloadData()
                self.hud.dismiss()
                
                
            case .failure(let error):
                print(error)
            }
            

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {return UITableViewCell() }
        cell.backgroundColor = .clear //셀 + 백그라운드 컬러 (보통 클리어로 사용함)
        cell.titleLabel.font = .boldSystemFont(ofSize: 18)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseDate)"
        cell.titleLabel.textAlignment = .center
        
        return cell
        
    }


}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice() //옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인지 등
        
    }
}
