//
//  BeerViewModel.swift
//  NetworkBasic
//
//  Created by Carki on 2022/11/01.
//

import Foundation

import RxAlamofire
import RxSwift

class BeerViewModel {
    let disposeBag = DisposeBag()
    
    func loadButtonClicked() -> (String, URL?, String) {
        let url = "https://api.punkapi.com/v2/beers/random"
        var beerName: String = ""
        var beerImage: URL?
        var beerDesc: String = ""
        request(.get, url)
            .data()
            .decode(type: SearchBeer.self, decoder: JSONDecoder())
            .subscribe(onNext: { value in
                print("이름: \(value.name), 설명: \(value.description)")
                beerName = value.name
                beerImage = value.imageURLs
                beerDesc = value.description
            })
            .disposed(by: disposeBag)
        
         return (beerName, beerImage, beerDesc)
    }
}
