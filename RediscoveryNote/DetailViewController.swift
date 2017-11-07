//
//  DetailViewController.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 7..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var wordModel: WordModel?{
        didSet{
            setContent()
        }
    }
    
    var scrollView: UIScrollView?
    var contentView: UIView?

    var thumbnailView: UIImageView?
    var wordLabel: UILabel?
    var meaningLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        
        let scrollView = UIScrollView()
        let thumbnailView = UIImageView()
        let wordLabel = UILabel()
        let meaningLabel = UILabel()
        
        self.scrollView = scrollView
        self.thumbnailView = thumbnailView
        self.wordLabel = wordLabel
        self.meaningLabel = meaningLabel
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(thumbnailView)
        scrollView.addSubview(wordLabel)
        scrollView.addSubview(meaningLabel)
        
        scrollView.isUserInteractionEnabled = true
        
        thumbnailView.contentMode = .scaleAspectFill
        thumbnailView.image = UIImage.init(named: "jesun")
        thumbnailView.clipsToBounds = true

        //        wordLabel.font = UIFont.boldSystemFont(ofSize: 30)
        wordLabel.font = UIFont.init(customFont: .MyeongjoBold, withSize: 26)
        meaningLabel.font = UIFont.init(customFont: .Myeongjo, withSize: 14)

        wordLabel.numberOfLines = 0
        meaningLabel.numberOfLines = 0
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guides = self.view.layoutMarginsGuide
        
        
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        thumbnailView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        thumbnailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        thumbnailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        thumbnailView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        wordLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: CGFloat(Constants.Margin.top)).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(Constants.Margin.leading)).isActive = true


        meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 8).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(Constants.Margin.leading)).isActive = true
        meaningLabel.trailingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: -CGFloat(Constants.Margin.trailing)).isActive = true
        meaningLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -CGFloat(Constants.Margin.bottom)).isActive = true
        
        self.setContent()
        self.updateContentView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateContentView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateContentView() {
        
        if let scrollView = self.scrollView,
            let contentView = self.contentView{
            scrollView.contentSize.height = view.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? scrollView.contentSize.height
            
            contentView.frame = CGRect.init(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: contentView.frame.width, height: scrollView.contentSize.height)
        }

    }
    
    
    fileprivate func setContent(){
        
        if let wordModel = wordModel{
            
            self.wordLabel?.text = wordModel.word
            
            if let meaning = wordModel.meaning{
                self.meaningLabel?.text = meaning
            }else{
                self.meaningLabel?.text = nil
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
