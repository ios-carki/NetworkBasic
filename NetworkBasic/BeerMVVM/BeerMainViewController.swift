//
//  BeerMainViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/11/01.
//

import UIKit

import Alamofire
import SwiftyJSON

class BeerMainViewController: UIViewController {
    
    let mainView = BeerMainView()
    let viewModel = BeerViewModel()
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .brown
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerLoadButton()
        
    }
    
    func beerLoadButton() {
        mainView.loadBeerButton.addTarget(self, action: #selector(beerLoadButtonClicked), for: .touchUpInside)
    }
    
    @objc func beerLoadButtonClicked() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        //validate - 유효성 검사
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //이름
                let beerName = json[0]["name"].stringValue
                mainView.beerNameLabel.text = "이름: \(beerName)"
                mainView.beerNameLabel.textAlignment = .center
                mainView.beerNameLabel.textColor = .orange
                mainView.beerNameLabel.font = .systemFont(ofSize: 20)
                
                //이미지
                let beerImageURL = URL(string: json[0]["image_url"].stringValue)
                if beerImageURL == nil {
                    mainView.beerImageView.image = UIImage(systemName:  "x.circle")
                    mainView.beerImageView.tintColor = .white
                }else {
                    mainView.beerImageView.kf.setImage(with: beerImageURL)
                }
                print("맥주 유알엘")
                print(beerImageURL)
                //설명
                let beerDescription = json[0]["description"].stringValue
                mainView.beerExplainTextView.text = "맥주 설명:  \(beerDescription)"
                mainView.beerExplainTextView.font = .systemFont(ofSize: 16)
                
                
                
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

        
}
