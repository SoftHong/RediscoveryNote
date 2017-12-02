//
//  NewWordViewController2.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 8..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit
import RealmSwift

class NewWordViewController2: UIViewController {

    var wordModel: WordModel?
    var textView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "다음", style: .plain, target: self, action: #selector(nextBtnDidTap))
        self.contentSizeInPopup = CGSize.init(width: 300, height: 300)
        self.landscapeContentSizeInPopup = CGSize.init(width: 400, height: 200)
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        textView.textAlignment = .center
        self.view.addSubview(textView)
        self.textView = textView
        
        if let navi = self.navigationController{
            textView.topAnchor.constraint(equalTo: navi.view.topAnchor).isActive = true
        }else{
            textView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        }
        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.Margin.medium).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.Margin.medium).isActive = true
        textView.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        
        if let wordModel = wordModel,
            let meanaing = wordModel.meaning{
            
            textView.text = meanaing
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func nextBtnDidTap(){
        
        guard let textView = self.textView else { return }
        guard let wordModel = self.wordModel else {
            return
        }
        
        let realm = try! Realm()
        try! realm.write {
            wordModel.meaning = textView.text
        }
        
        let newWordVC = NewWordViewController3()
        newWordVC.wordModel = wordModel
        self.popupController?.push(newWordVC, animated: true)
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
