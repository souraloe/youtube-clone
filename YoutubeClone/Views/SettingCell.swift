//
//  SettingCell.swift
//  YoutubeClone
//
//  Created by Vlad Ovcharov on 06.02.2021.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            
            nameLabel.textColor = isHighlighted ? .white : .black
            
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = .darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        add(subview: nameLabel)
        add(subview: iconImageView)
        
        iconImageView.centerY(equalTo: self)
        iconImageView.leading(equalTo: self, constant: 16)
        iconImageView.width(equalTo: 30)
        iconImageView.height(equalTo: 30)
        
        nameLabel.top(equalTo: self)
        nameLabel.bottom(equalTo: self)
        nameLabel.leading(equalTo: iconImageView.trailingAnchor, constant: 8)
        nameLabel.trailing(equalTo: self)
    }
}
