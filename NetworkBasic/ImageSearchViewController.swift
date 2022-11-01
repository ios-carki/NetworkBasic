//
//  ImageSearchViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/08/03.
//


import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController {
    
    //네트워크 요청할 시작 페이지 넘버
    var startPage = 1
    var list: [String] = []//리스트 새로 만들어야됨
    var totalCount = 0
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        //컬렉션뷰 아울렛 연곃하면됨
        searchBar.delegate = self
//        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.prefetchDataSource = self //페이지네이션
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }
    
    //fetchImage, requestImage, callRequestImage, getImage... > 서버의 response에 따라 네이밍을 설정해주기도 함
    //내일 > 페이지네이션 많은 데이터를 리소르를 통해 가져오는 것
    func fetchImage(query: String) {
        //show
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { totalCount, list in
            self.totalCount = totalCount
            self.list.append(contentsOf: list)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            //dismiss
        }
    }
    
    
    
    
}


extension ImageSearchViewController: UISearchBarDelegate {
    
    //검색 버튼 클릭 시 실행. 검색 단어가 바뀔 수 있음
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            list.removeAll()
            startPage = 1
            fetchImage(query: text)
        }
    }
    
    //취소버튼 눌렸을 때
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    //서치바에 커서가 깜빡이기 시작할 때 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

//페이지네이션 방법3.
//용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적.
//셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을 수도 있고, 필요하지 않다면 데이터를 취소할 수도 있음
//iOS10 이상, 스크롤 성능 향상됨.


extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        //어떻게 네트워크 연결을 하면 될까
        for indexPath in indexPaths {
            if list.count - 1 == indexPath.item && list.count < totalCount {
                startPage += 30 //위 url 에 display 설정에 따라 다름
                fetchImage(query: searchBar.text!)
            }
        }
        
        print("=====\(indexPaths)")
    }
    
    //취소
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("=====취소\(indexPaths)")
    }
    
    
}



//extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//}
    
    
    
    
    
    //프리패칭 활용
    //방법1 메소드
    //호출 시점: 컬렉션뷰가 특정 셀을 그리려는 시점에 호출되는 메서드 willdisplay / foritemat에 쓰면 됨
    //마지막셀에 사용자가 위치해있는지 명확하게 확인하기가 어려움
    
    
    
    //방법2 메소드
    //테이블뷰./컬렉션뷰 스크롤뷰를 상속받고 있어서, 스크롤뷰 프로토콜을 사용할 수 있음
//    func scrollviewdidscroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//    }
    
    
    

