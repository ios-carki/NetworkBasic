//
//  UserDefaultsHelper.swift
//  NetworkBasic
//
//  Created by Carki on 2022/08/01.
//

import Foundation
import UIKit

class UserDefaultsHelper {
    private init() { }
    
    static let standard = UserDefaultsHelper()
    // singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        //연산 프로퍼티 형태 get set
        get {
            
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"// 옵셔널 형태로 String? 으로 하거나 / 타입은 그대로 두고 닉네임이 닐이라면 다른 값들을 넣어준다 ( ?? )
        }
        set { //연산 프로퍼티 parameter -> newValue
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
