//
//  NewWordViewController.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 8..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit
import RealmSwift

class NewWordViewController: UIViewController {

    var textField: UITextField?
    var wordModel: WordModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "다음", style: .plain, target: self, action: #selector(nextBtnDidTap))
        self.contentSizeInPopup = CGSize.init(width: 300, height: 300)
        self.landscapeContentSizeInPopup = CGSize.init(width: 400, height: 200)
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        self.textField = textField
        
        if let navi = self.navigationController{
            textField.topAnchor.constraint(equalTo: navi.view.topAnchor).isActive = true
        }else{
            textField.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        }
        textField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.Margin.medium).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.Margin.medium).isActive = true
        textField.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        textField.placeholder = "지금 당신에게 떠오른 단어가 있나요?"
        
        if let wordModel = self.wordModel,
            let word = wordModel.word{
            textField.text = word
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func nextBtnDidTap(){
        
        if let textField = self.textField{
            
            var wordModel: WordModel?
            if let oldWordModel = self.wordModel{
                wordModel = oldWordModel
            }else{
                wordModel = WordModel()
            }
            
            if let wordModel = wordModel{
                let newWordVC = NewWordViewController2()
                
                let realm = try! Realm()
                try! realm.write {
                    wordModel.word = textField.text
                }
                newWordVC.wordModel = wordModel
                self.popupController?.push(newWordVC, animated: true)
            }
        }
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
