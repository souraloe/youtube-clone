//
//  VideoCell.swift
//  FacebookClone
//
//  Created by Vlad Ovcharov on 04.02.2021.
//

import UIKit

class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        if self.traitCollection.userInterfaceStyle == .dark {
            self.backgroundColor = .black
        } else {
            self.backgroundColor = .white
        }
        setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "struct-image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile-image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)

        thumbnailImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        thumbnailImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: self.frame.height - 84).isActive = true
        
        userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        separatorView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleTextView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        subtitleTextView.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 0).isActive = true
        subtitleTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
