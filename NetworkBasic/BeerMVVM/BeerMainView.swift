//
//  BeerMainView.swift
//  NetworkBasic
//
//  Created by Carki on 2022/11/01.
//

import UIKit

import SnapKit

class BeerMainView: UIView {
    
    let beerNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "맥주이름"
        return view
    }()
    
    let beerImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let beerExplainTextView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let loadBeerButton: UIButton = {
        let view = UIButton()
        view.setTitle("맥주 불러오기", for: .normal)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [beerNameLabel, beerImageView, beerExplainTextView, loadBeerButton].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        
        beerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        beerImageView.snp.makeConstraints { make in
            make.top.equalTo(beerNameLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(300)
        }
        
        beerExplainTextView.snp.makeConstraints { make in
            make.top.equalTo(beerImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(200)
        }
        
        loadBeerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(200)
        }
    }
}
