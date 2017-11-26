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
            updateContentView()
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
        let lineView = UIView()
        
        self.scrollView = scrollView
        self.thumbnailView = thumbnailView
        self.wordLabel = wordLabel
        self.meaningLabel = meaningLabel
        
        self.view.addSubview(lineView)
        lineView.addSubview(scrollView)
        scrollView.addSubview(thumbnailView)
        scrollView.addSubview(wordLabel)
        scrollView.addSubview(meaningLabel)
        
        scrollView.isUserInteractionEnabled = true
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.cornerRadius = 10.0

        lineView.layer.backgroundColor = CGColor.init(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        lineView.layer.masksToBounds = false
        lineView.layer.cornerRadius = 10.0
        lineView.layer.shadowOffset = CGSize.init(width: -1, height: 2)
        lineView.layer.shadowOpacity = 0.2
        
        thumbnailView.contentMode = .scaleAspectFill
//        thumbnailView.image = UIImage.init(named: "jesun")
        
//            ?.resizeImage(targetSize: CGSize.init(width: view.frame.width-32, height: view.frame.width-32))
        thumbnailView.clipsToBounds = true

        //        wordLabel.font = UIFont.boldSystemFont(ofSize: 30)
        wordLabel.font = UIFont.init(customFont: .MyeongjoBold, withSize: 26)
        meaningLabel.font = UIFont.init(customFont: .Myeongjo, withSize: 14)

        wordLabel.textAlignment = .left
        wordLabel.numberOfLines = 0
        meaningLabel.numberOfLines = 0
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guides = self.view.layoutMarginsGuide

        lineView.topAnchor.constraint(equalTo: guides.topAnchor, constant: Constants.Margin.large).isActive = true
        lineView.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: guides.bottomAnchor, constant: -Constants.Margin.large).isActive = true

        scrollView.topAnchor.constraint(equalTo: guides.topAnchor, constant: Constants.Margin.large).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
        
        scrollView.bottomAnchor.constraint(equalTo: guides.bottomAnchor, constant: -Constants.Margin.large).isActive = true
        
        thumbnailView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        thumbnailView.leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
        thumbnailView.trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
        thumbnailView.heightAnchor.constraint(equalTo: thumbnailView.widthAnchor).isActive = true
        
        wordLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: CGFloat(Constants.Margin.large)).isActive = true
        wordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(Constants.Margin.large)).isActive = true
        wordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(Constants.Margin.large)).isActive = true

        meaningLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: Constants.Margin.small).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(Constants.Margin.large)).isActive = true
        meaningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(Constants.Margin.large)).isActive = true
        meaningLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -CGFloat(Constants.Margin.large)).isActive = true
        
        thumbnailView.alpha = 0.0
        UIView.animate(withDuration: 2.0, animations: {
            thumbnailView.alpha = 1.0
        })
        
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
            
            if let imagePath = wordModel.imagePath{
                let image = UIImage.init(contentsOfFile: imagePath)
                thumbnailView?.image = image
            }

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
