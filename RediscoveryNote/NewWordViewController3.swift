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
    var albumBtn: UIButton?
    var captureBtn: UIButton?
    var imageView: UIImageView?
    var imagePickerVC: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "완료", style: .plain, target: self, action: #selector(nextBtnDidTap))
        self.contentSizeInPopup = CGSize.init(width: 300, height: 300)
        self.landscapeContentSizeInPopup = CGSize.init(width: 400, height: 200)
        
        let albumBtn = UIButton()
        self.albumBtn = albumBtn
        albumBtn.titleLabel?.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        albumBtn.tintColor = UIColor.black
        
        albumBtn.setTitle("가져오기", for: .normal)
        albumBtn.setTitleColor(UIColor.black, for: .normal)
        albumBtn.addTarget(self, action: #selector(openAlbum), for: .touchUpInside)
        
        let captureBtn = UIButton()
        self.captureBtn = captureBtn
        captureBtn.titleLabel?.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        captureBtn.tintColor = UIColor.black
        
        captureBtn.setTitle("촬영하기", for: .normal)
        captureBtn.setTitleColor(UIColor.black, for: .normal)
        captureBtn.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        
        let imageView = UIImageView()
        self.imageView = imageView
        
        
        imageView.contentMode = .scaleAspectFill
        
        
        self.view.addSubview(imageView)
        self.view.addSubview(captureBtn)
        self.view.addSubview(albumBtn)
        
        captureBtn.translatesAutoresizingMaskIntoConstraints = false
        albumBtn.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        captureBtn.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        captureBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        captureBtn.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        captureBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        captureBtn.backgroundColor = UIColor.Custom.background
        captureBtn.alpha = 0.5

        albumBtn.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        albumBtn.leadingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        albumBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        albumBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        albumBtn.backgroundColor = UIColor.Custom.backgroundLight
        albumBtn.alpha = 0.5

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
    
    @objc func openCamera(){
        let imagePickerVC = UIImagePickerController.init()
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        imagePickerVC.sourceType = .camera
        imagePickerVC.cameraCaptureMode = .photo
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
