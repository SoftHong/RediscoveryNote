//
//  WordCellTableViewCell.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 10. 16..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class WordCell: UITableViewCell {
    
    var wordModel: WordModel?{
        didSet{
            updateUI()
        }
    }
    
    var thumbnailView: UIImageView?
    var wordLabel: UILabel?
    var meaningLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        let thumbnailView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        let wordLabel = UILabel()
        let meaningLabel = UILabel()
        
        self.thumbnailView = thumbnailView
        self.wordLabel = wordLabel
        self.meaningLabel = meaningLabel
        
        self.addSubview(wordLabel)
        self.addSubview(meaningLabel)
        self.addSubview(thumbnailView)
        
        wordLabel.font = UIFont.init(customFont: .MyeongjoBold, withSize: 26)
        meaningLabel.font = UIFont.init(customFont: .Myeongjo, withSize: 14)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guides = self.layoutMarginsGuide
        
        thumbnailView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        thumbnailView.trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        thumbnailView.widthAnchor.constraint(equalTo: thumbnailView.heightAnchor).isActive = true

        wordLabel.topAnchor.constraint(equalTo: guides.topAnchor, constant: 0).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        
        meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 8).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        meaningLabel.trailingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: -60).isActive = true
        meaningLabel.bottomAnchor.constraint(equalTo: guides.bottomAnchor).isActive = true
        
//        self.layer.backgroundColor = CGColor.init(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
//        self.layer.masksToBounds = false
//        self.layer.cornerRadius = 2.0
//        self.layer.shadowOffset = CGSize.init(width: -1, height: 1)
//        self.layer.shadowOpacity = 0.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func updateUI(){
        
        if let wordModel = wordModel{
            
            if let fileName = wordModel.fileName{
                
                print("cell: \(fileName)")
                
                let imageSize = CGSize.init(width: 100, height: 100)
                let imagePath = URL.getDocumentsDirectory().appendingPathComponent(fileName)

                if let image = UIImage.init(contentsOfFile: imagePath.path){
                    thumbnailView?.image = image.resizeImage(targetSize: imageSize).circleMasked

                }else{
                    print("not found")
                }
            }else{
                thumbnailView?.image = nil
            }
            
            self.wordLabel?.text = wordModel.word
            self.wordLabel?.sizeToFit()
            
            if let meaning = wordModel.meaning{
                self.meaningLabel?.text = meaning
            }else{
                self.meaningLabel?.text = nil
            }
            meaningLabel?.sizeToFit()
        }
    }
}
