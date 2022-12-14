//
//  ViewPresentableProtocol.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/28.
//

import Foundation
import UIKit

//프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다!
//실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다!
//클래스, 구조체, 익스텐션, 열거형...
//클래스는 단일 상속만 가능하지만, 프로토콜은 채택 갯수에 제한이 없다.
//함수명 앞에 optional -> 쓸 수도 있고 안쓸수도 있는 메서드
//@objc optional -> 선택적 요청(Optional Requirement)
//프로토콜 프로퍼티, 프로토콜 메서드 , 프로퍼티??

//프로토콜 프로퍼티: 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관하지 않는다!
//명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고 연산 프로퍼티로 사용할 수도 있다.
//무조건 var로 선언해야한다
//만약 get만 명시했다면, get 기능만 최소한 구현되어 있으면 된다! 그래서 필요하다면 set도 구현해도 괜찮다.

@objc
protocol ViewPresentableProtocol {
    
    //get:읽기 / set:쓰기
    //get + set -> let을 쓰면 set 조건에 위배됨
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()//뷰 관련
    @objc optional func configureLabel()//레이블 관련
    @objc optional func configureTextField()
    
}
/*
 ex. 테이블 뷰
 */

@objc protocol CarkiTableViewProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
