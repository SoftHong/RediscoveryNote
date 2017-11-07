//
//  Voca.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 10. 16..
//  Copyright © 2017년 홍성호. All rights reserved.
//

class WordModel {
    
    var word: String
    var meaning: String?
    
    init(word: String, meaning: String? = nil, part: String? = nil) {
        
        self.word = word
        self.meaning = meaning
    }
}
