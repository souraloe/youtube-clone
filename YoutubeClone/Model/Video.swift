//
//  Video.swift
//  YoutubeClone
//
//  Created by Vlad Ovcharov on 05.02.2021.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadData: Data?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
