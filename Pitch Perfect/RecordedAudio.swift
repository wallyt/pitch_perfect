//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Wally Thornton on 6/12/15.
//  Copyright (c) 2015 Wally Thornton. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var title: String
    var filePathUrl: NSURL
    
    init(title: String, filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
    
}

