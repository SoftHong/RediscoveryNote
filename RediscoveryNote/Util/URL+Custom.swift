//
//  URL+Custom.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 30..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

extension URL {
    static func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
