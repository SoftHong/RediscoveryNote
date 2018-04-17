//
//  Voca.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 10. 16..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import RealmSwift

class WordModel: Object {
    @objc dynamic var word: String?
    @objc dynamic var meaning: String?
    @objc dynamic var fileName: String?
    
    func delete() {
        if let fileName = fileName {
            do {
                let imagePath = URL.getDocumentsDirectory().appendingPathComponent(fileName)
                try FileManager.default.removeItem(atPath: imagePath.path)
            } catch let error as NSError {
                print("Error: \(error.domain)")
            }
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
}
