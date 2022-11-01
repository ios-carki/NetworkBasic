//
//  BeerMainViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/11/01.
//

import UIKit



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
        var results = viewModel.loadButtonClicked()
        
        mainView.beerNameLabel.text = "맥주 이름: \(results.0)"
        mainView.beerImageView.kf.setImage(with: results.1)
        mainView.beerExplainTextView.text = results.2
        
        print("이름: \(results.0), \n이미지URL: \(results.1), \n설명: \(results.2)")
    }

        
}
