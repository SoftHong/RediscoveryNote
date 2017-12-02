//
//  Voca.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 10. 16..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import RealmSwift

class WordModel: Object{
    @objc dynamic var word: String?
    @objc dynamic var meaning: String?
    @objc dynamic var fileName: String?
}
