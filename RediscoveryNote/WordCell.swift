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
    var wordLabel: UILabel?
    var meaningLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        let wordLabel = UILabel()
        let meaningLabel = UILabel()

        self.addSubview(wordLabel)
        self.addSubview(meaningLabel)

        wordLabel.text = "단어"
        wordLabel.font = UIFont.boldSystemFont(ofSize: 30)
        wordLabel.numberOfLines = 0
        
        meaningLabel.text = "뜻"
        meaningLabel.numberOfLines = 0

        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guides = self.layoutMarginsGuide
        wordLabel.topAnchor.constraint(equalTo: guides.topAnchor).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
        
        meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 16).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        meaningLabel.trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
        meaningLabel.bottomAnchor.constraint(equalTo: guides.bottomAnchor).isActive = true
        
        self.wordLabel = wordLabel
        self.meaningLabel = meaningLabel
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
            self.meaningLabel?.text = wordModel.meaning
        }
    }
}
