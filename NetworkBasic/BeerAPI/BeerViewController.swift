//
//  BeerViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/08/01.
//
//api 주소 https://api.punkapi.com/v2/beers/random

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController {
    
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerDescriptionTextView: UITextView!
    @IBOutlet weak var randButton: UIButton!
    
    var fontFamily = UIFont(name: "Galmuri11-Regular", size: 17)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        buttonDesign(btnName: randButton)

        requestBeer()
    }
    
    func buttonDesign(btnName: UIButton) {
        btnName.setTitle("맥주정보 받기", for: .normal)
        btnName.setTitle("어떤 맥주가 나올까나~?", for: .highlighted)
        btnName.setTitleColor(.white, for: .normal)
        btnName.setTitleColor(.red, for: .highlighted)
        btnName.layer.cornerRadius = 5
        btnName.layer.borderWidth = 2
        btnName.backgroundColor = .lightGray
    }
    
    //알라모 파이어 설정
    func requestBeer() {
        let url = "https://api.punkapi.com/v2/beers/random"
        
        //validate - 유효성 검사
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //이름
                let beerName = json[0]["name"].stringValue
                beerNameLabel.text = "이름: \(beerName)"
                beerNameLabel.textAlignment = .center
                beerNameLabel.textColor = .orange
                beerNameLabel.font = fontFamily
                
                //이미지
                let beerImageURL = URL(string: json[0]["image_url"].stringValue)
                if beerImageURL == nil {
                    beerImageView.image = UIImage(systemName:  "x.circle")
                    beerImageView.tintColor = .white
                }else {
                    beerImageView.kf.setImage(with: beerImageURL)
                }
                print("맥주 유알엘")
                print(beerImageURL)
                //설명
                let beerDescription = json[0]["description"].stringValue
                beerDescriptionTextView.text = "맥주 설명:  \(beerDescription)"
                beerDescriptionTextView.font = fontFamily
                
                
                
                
            case .failure(let error):
                print(error)
            }
            

        }
        
    }
    

    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        requestBeer()
    }
    
}
