//
//  ViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocol {
    
    static let identifier: String = "ViewController"
    
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        set {
            title = newValue
        }
    }
    
    var backgroundColor: UIColor { // get만 사용한다면 var -> let으로도 사용 가능하다
        get {
            return .blue
        }
    }
    
    func configureView() {
        navigationTitleString = "고래밥님의 다마고치"
//        backgroundColor = .red
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    
}

