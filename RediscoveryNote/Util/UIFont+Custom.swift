//
//  UIFont+Custom.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 7..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

enum CustomFont: String {
    case Myeongjo = "NanumMyeongjo"
    case MyeongjoBold = "NanumMyeongjoBold"
    case MyeongjoExtraBold = "NanumMyeongjoExtraBold"
    case SDMiSaeng = "SDMiSaeng"
}

extension UIFont {
    /**
     Initializes an UIFont using a predefined enumeration and a given size.
     */
    convenience init?(customFont: CustomFont, withSize size: CGFloat) {
        self.init(name: customFont.rawValue, size: size)
    }
}

