//
//  TranslateViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

//UIButton, UITextField > Action
//UITextView, UISearchBar, UIPickerView > 액션연결 안됨 -> 컨트롤 기반이 아님
//UIControl
//        userInputTextView.resignFirstResponder()
//        userInputTextView.becomeFirstResponder()
//UIResponderChain > resignFirstResponder() / becomeFirstResponder() > 내일7월 29일 보충설명

class TranslateViewController: UIViewController {

    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        //name: 페밀리 네임이 아니라 파일명으로 갖고오기
        //***********************************
        //폰트 적용 폰트 적용 폰트 적용 폰트 적용 폰트 적용 폰트 적용 폰트 적용
        userInputTextView.font = UIFont(name: "Galmuri11-Regular", size: 17)
        
//        requestTranslatedData()
        
    }
    
    func requestTranslatedData(text: String) {
        let url = EndPoint.translateURL
        
        let parameter = ["source": "ko", "target": "en", "text": text]
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        //validate - 유효성 검사
        AF.request(url, method: .post, parameters: parameter, headers: header).validate(statusCode: 200..<500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                let translatedResult = json["message"]["result"]["translatedText"].stringValue
                self.translatedText.text = translatedResult
                
                
                
                if statusCode == 200 {
                    
                } else {
                    self.userInputTextView.text = json["errorMessage"].stringValue
                }
               // translatedText.text = json["message"]["result"]["translatedText"]
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        let text: String = userInputTextView.text
        requestTranslatedData(text: text)
    }
}


extension TranslateViewController: UITextViewDelegate {
    //텍스트의 글자가 변할때마다 호출(400/500 글자 수)
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    //텍스트필드에 커서가 올라가서 깜빨일 때(편집이 시작될 때)
    //텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray { //플레이스홀더처럼 텍스트가 회색이면 텍스트를 비워버리고 검은색 글자로 바꿈
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝날을 때, 커서가 없어지는 순간
    //텍스트뷰 글자: 사용자가 아무 글자도 안 썻으면 플레이스 홀더 글자 보이게 해!
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
}
