//
//  CreditViewController.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 30..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class CreditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentSizeInPopup = CGSize.init(width: 300, height: 300)

        let nameLabel = UILabel.init()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.text = "Made by\n\n코찐 & 아일"
        nameLabel.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        self.view.addSubview(nameLabel)
        
        nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
