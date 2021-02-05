//
//  ViewController.swift
//  FacebookClone
//
//  Created by Vlad Ovcharov on 03.02.2021.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var videos: [Video] = {
        var kanyeChannel = Channel()
        kanyeChannel.name = "KanyeIsTheBestChannel"
        kanyeChannel.profileImageName = "kanye_profile"
        
        var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space"
        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
        blankSpaceVideo.channel = kanyeChannel
        blankSpaceVideo.numberOfViews = 3239434394
        
        var badBloodVideo = Video()
        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
        badBloodVideo.channel = kanyeChannel
        badBloodVideo.numberOfViews = 2334343483
        
        return [blankSpaceVideo, badBloodVideo]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.traitCollection.userInterfaceStyle == .dark {
            collectionView.backgroundColor = .black
        } else {
            collectionView.backgroundColor = .white
        }
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavigationBarButtons()
    }
    
    func setupNavigationBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreBarButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
    }
    
    @objc func handleSearch() {
        print(123)
    }

    @objc func handleMore() {
        print(123)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        menuBar.top(equalTo: view)
        menuBar.leading(equalTo: view)
        menuBar.trailing(equalTo: view)
        menuBar.height(equalTo: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9 / 16
        return .init(width: view.frame.width, height: height + 16 + 88)
    }
}

