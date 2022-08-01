//
//  ReusableViewProtocol.swift
//  NetworkBasic
//
//  Created by Carki on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    //익스텐션은 저장 프로퍼티를 사용할 수 없다
    //연산 프로퍼티 형식
    static var reuseIdentifier: String { //연산 프로퍼티 get만 사용한다면 get 생략 가능
        return String(describing: self)
        
    }
    
    
}

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
