//
//  FirstTableViewCell.swift
//  Travels Memories
//
//  Created by Emircan saglam on 7.07.2022.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewCell.layer.borderWidth = 1
        imageViewCell.layer.masksToBounds = false
        if self.traitCollection.userInterfaceStyle == .dark {
            imageViewCell.layer.borderColor = UIColor.white.cgColor
        } else {
            imageViewCell.layer.borderColor = UIColor.black.cgColor
        }
        
        
        
        imageViewCell.layer.cornerRadius = imageViewCell.frame.height/2
        imageViewCell.clipsToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

