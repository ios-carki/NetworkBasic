//
//  ListTableViewCell.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/27.
//

import UIKit
//xib 파일

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }
    
}
