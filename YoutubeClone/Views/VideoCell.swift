//
//  VideoCell.swift
//  FacebookClone
//
//  Created by Vlad Ovcharov on 04.02.2021.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        if self.traitCollection.userInterfaceStyle == .dark {
            self.backgroundColor = .black
        } else {
            self.backgroundColor = .white
        }
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 years ago"
                subtitleTextView.text = subtitleText
            }

            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.load(urlString: thumbnailImageUrl)
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.load(urlString: profileImageUrl)
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.5)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        thumbnailImageView.top(equalTo: self, constant: 16)
        thumbnailImageView.leading(equalTo: self, constant: 16)
        thumbnailImageView.trailing(equalTo: self, constant: 16)
        thumbnailImageView.height(equalTo: self.frame.height - 104 )
        
        userProfileImageView.leading(equalTo: self, constant: 16)
        userProfileImageView.top(equalTo: thumbnailImageView.bottomAnchor, constant: 8)
        userProfileImageView.height(equalTo: 44)
        userProfileImageView.width(equalTo: 44)
        
        separatorView.height(equalTo: 1)
        separatorView.leading(equalTo: self)
        separatorView.trailing(equalTo: self)
        separatorView.bottom(equalTo: self)
        
        titleLabel.top(equalTo: thumbnailImageView.bottomAnchor, constant: 8)
        titleLabel.leading(equalTo: userProfileImageView.trailingAnchor, constant: 8)
        titleLabel.trailing(equalTo: thumbnailImageView)
         
        titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 44)
        titleLabelHeightConstraint?.isActive = true

        subtitleTextView.top(equalTo: titleLabel.bottomAnchor, constant: 4)
        subtitleTextView.leading(equalTo: userProfileImageView.trailingAnchor, constant: 8)
        subtitleTextView.trailing(equalTo: self)
        subtitleTextView.height(equalTo: 30)
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageUrlString: String?

    func load(urlString: String) {
        
        imageUrlString = urlString
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
        } else if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let imageToCache = UIImage(data: data) {
                        if self?.imageUrlString == urlString {
                            imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        }
                        DispatchQueue.main.async {
                            self?.image = imageToCache
                        }
                    }
                }
            }
        }
    }
}
