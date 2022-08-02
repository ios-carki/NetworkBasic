//
//  RottoViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/28.
//

import UIKit

//1.임포트(오픈소스라이브러리 사용은 알파벳 순서대로)
import Alamofire
import SwiftyJSON

class RottoViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    @IBOutlet var lottoNumberCollectionLabel: [UILabel]!
    
    var lottoPickerView = UIPickerView() // 클래스의 인스턴스 선언
    //코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있다!
    
    let numberList: [Int] = Array(1...1025).reversed()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //인증번호 텍스트필드에 자동으로 띄우기
        numberTextField.textContentType = .oneTimeCode

        numberTextField.tintColor = .clear //커서
        numberTextField.inputView = lottoPickerView
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        requestLotto(number: 986)
        labelDesign(labelNum: lottoNumberCollectionLabel)
        
    }
    
    func labelDesign(labelNum: [UILabel]) {
        
        for i in 0..<labelNum.count {
            labelNum[i].textAlignment = .center
            labelNum[i].layer.cornerRadius = 12.5
            labelNum[i].clipsToBounds = true
            labelNum[i].layer.borderWidth = 1
            
            for j in 0..<labelNum.count {
                let r : CGFloat = CGFloat.random(in: 0.7...1)
                let g : CGFloat = CGFloat.random(in: 0.7...1)
                let b : CGFloat = CGFloat.random(in: 0.7...1)
                
                labelNum[j].backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
            }
        }
    }
    
    //알라모 파이어 설정
    func requestLotto(number: Int) {
        //AF: 200 ~ 299 status code -> 알라모파이어에서 디폴트 성공 상태코드 / statuscode를 301까지를 성공코드로 해달라라는 요청이 들어올때는 validate를 통해서 바꾼다 .statuscode
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        
        //validate - 유효성 검사
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let date = json["drwNoDate"].stringValue
                
                let firstNum = json["drwtNo1"].stringValue
                let secondNum = json["drwtNo2"].stringValue
                let thirdNum = json["drwtNo3"].stringValue
                let fourthNum = json["drwtNo4"].stringValue
                let fifthNum = json["drwtNo5"].stringValue
                let sixthNum = json["drwtNo6"].stringValue
                let bonusNum = json["bnusNo"].stringValue
                
                let lottoDate = json["drwNo"].stringValue
                
                self.lottoNumberCollectionLabel[0].text = firstNum
                self.lottoNumberCollectionLabel[1].text = secondNum
                self.lottoNumberCollectionLabel[2].text = thirdNum
                self.lottoNumberCollectionLabel[3].text = fourthNum
                self.lottoNumberCollectionLabel[4].text = fifthNum
                self.lottoNumberCollectionLabel[5].text = sixthNum
                self.lottoNumberCollectionLabel[6].text = bonusNum
                
                self.numberTextField.text = "\(date) (\(lottoDate)회차)"
                
                
            case .failure(let error):
                print(error)
            }
            

        }
        
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    

}

extension RottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
//        numberTextField.text = "\(numberList[row])회차" -> 덮혀짐
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
}
