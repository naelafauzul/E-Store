//
//  CategoryViewCell.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/10/23.
//

import UIKit

class CategoryViewCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(){
        thumbImageView.layer.borderWidth = 8
        thumbImageView.layer.masksToBounds = true
    }

}
