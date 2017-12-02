//
//  NewWordViewController3.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 8..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit
import RealmSwift

class NewWordViewController3: UIViewController {
    
    var wordModel: WordModel?
    var imageBtn: UIButton?
    var imageView: UIImageView?
    var imagePickerVC: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "완료", style: .plain, target: self, action: #selector(nextBtnDidTap))
        self.contentSizeInPopup = CGSize.init(width: 300, height: 300)
        self.landscapeContentSizeInPopup = CGSize.init(width: 400, height: 200)
        
        let imageBtn = UIButton()
        self.imageBtn = imageBtn
        
        let imageView = UIImageView()
        self.imageView = imageView
        
        imageView.contentMode = .scaleAspectFill
        
        self.view.addSubview(imageView)
        self.view.addSubview(imageBtn)
        
        imageBtn.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageBtn.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        if let wordModel = self.wordModel,
            let fileName = wordModel.fileName{
            
            print("\(fileName)")
            
            let imagePath = URL.getDocumentsDirectory().appendingPathComponent(fileName)
            if let image = UIImage.init(contentsOfFile: imagePath.path){
                imageView.image = image
                
            }else{
                print("not found")
            }
        }
        
        imageBtn.titleLabel?.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        imageBtn.tintColor = UIColor.black
        
        imageBtn.setTitle("사진 고르기", for: .normal)
        imageBtn.setTitleColor(UIColor.black, for: .normal)
        imageBtn.addTarget(self, action: #selector(openAlbum), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func saveImageInLocal(image:UIImage, url:URL){
        if let data = UIImageJPEGRepresentation(image, 1){
            try? data.write(to: url)
        }
    }
    
    func getCurrentTime() -> String{
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let timeString = formatter.string(from: date)
        
        return timeString
    }
    
    
    @objc func nextBtnDidTap(){
        
        guard let wordModel = self.wordModel else { return }
        guard let imageView = self.imageView else { return }
        
        if let image = imageView.image{
            let fileName = getCurrentTime() + ".jpg"
            
            var fileURL: URL?
            
            if let oldFileName = wordModel.fileName{
                fileURL = URL.getDocumentsDirectory().appendingPathComponent(oldFileName)
            }else{
                fileURL = URL.getDocumentsDirectory().appendingPathComponent(fileName)
                let realm = try! Realm()
                try! realm.write {
                    wordModel.fileName = fileName
                    realm.add(wordModel)
                    
                    print("save: \(fileName)")
                }
            }
            
            if let fileURL = fileURL{
                self.saveImageInLocal(image: image, url: fileURL)
            }
        }else{
            let realm = try! Realm()
            try! realm.write {
                realm.add(wordModel)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func openAlbum(){
        let imagePickerVC = UIImagePickerController.init()
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        self.present(imagePickerVC, animated: true)
        self.imagePickerVC = imagePickerVC
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

extension NewWordViewController3: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage, let imageView = self.imageView {
            
            imageView.image = pickedImage
        }
        
        self.imagePickerVC?.dismiss(animated: true, completion: nil)
        //        self.dismiss(animated: true, completion: nil)
    }
}
