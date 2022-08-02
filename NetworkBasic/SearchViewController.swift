//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/27.
//

import UIKit

import Alamofire
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
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
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
