//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/27.
//

import UIKit

/*
 Swift Protocol (왼팔 오른팔)
 -delegate
 -DataSouce

 1.왼팔 / 오른팔
 2.상속받는 클래tm
 3.오버라이드 제거
 */

//한번의 뷰 컨트롤러 배경색 전환 익스텐션
extension UIViewController {
    func setBackGroundColor() {
        view.backgroundColor = .red
    }
}

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        searchTableView.backgroundColor = .clear

        //연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
//        searchTableView.delegate = self //self 클래스의 인스턴스 자체
//        searchTableView.dataSource = self
        //테이블뷰가 사용할 테이블 뷰 셀(XIB) 등록
        //XIB: xml interface builder <= Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
//    func configureLabel() {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {return UITableViewCell() }
        cell.backgroundColor = .clear //셀 + 백그라운드 컬러 (보통 클리어로 사용함)
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "HELLO"
        
        return cell
        
    }


}
