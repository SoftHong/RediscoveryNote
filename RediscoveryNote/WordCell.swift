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
            parseWord()
        }
    }
    
    var thumbnailView: UIImageView?
    var wordLabel: UILabel?
    var meaningLabel: UILabel?
    var pronLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        let thumbnailView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 66, height: 66))
        let wordLabel = UILabel()
        let meaningLabel = UILabel()
        let pronLabel = UILabel()
        
        self.thumbnailView = thumbnailView
        self.wordLabel = wordLabel
        self.meaningLabel = meaningLabel
        self.pronLabel = pronLabel
        
        self.addSubview(thumbnailView)
        self.addSubview(wordLabel)
        self.addSubview(meaningLabel)
        self.addSubview(pronLabel)
        
        thumbnailView.image = UIImage.init(named: "jesun")?.resizeImage(targetSize: thumbnailView.frame.size).circleMasked
        thumbnailView.contentMode = .scaleAspectFill
        
        pronLabel.textAlignment = .right
        wordLabel.font = UIFont.boldSystemFont(ofSize: 30)

        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        pronLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guides = self.layoutMarginsGuide
        thumbnailView.topAnchor.constraint(equalTo: guides.topAnchor).isActive = true
        thumbnailView.trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
        thumbnailView.heightAnchor.constraint(equalToConstant: 44)
        thumbnailView.widthAnchor.constraint(equalTo: heightAnchor)
        
        wordLabel.topAnchor.constraint(equalTo: guides.topAnchor, constant: 0).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        
        pronLabel.centerYAnchor.constraint(equalTo: wordLabel.centerYAnchor).isActive = true
        pronLabel.leadingAnchor.constraint(equalTo: wordLabel.trailingAnchor, constant: 8).isActive = true
        
        meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 8).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        meaningLabel.trailingAnchor.constraint(equalTo: guides.trailingAnchor, constant: -44).isActive = true
        meaningLabel.bottomAnchor.constraint(equalTo: guides.bottomAnchor).isActive = true
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
    
    fileprivate func parseWord(){
        
        if let wordModel = wordModel{
            self.wordLabel?.text = wordModel.word
            
            if let meaning = wordModel.meaning{
                self.meaningLabel?.text = meaning
            }
            
            if let pron = wordModel.pron{
                self.pronLabel?.text = "[" + pron + "]"
            }
        }
    }
}
