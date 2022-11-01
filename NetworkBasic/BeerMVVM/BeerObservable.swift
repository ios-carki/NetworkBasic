//
//  BeerObservable.swift
//  NetworkBasic
//
//  Created by Carki on 2022/11/01.
//

import Foundation

class BeerObservable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
