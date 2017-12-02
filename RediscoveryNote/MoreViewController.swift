//
//  MoreViewController.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 30..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit
import STPopup

class MoreViewController: UIViewController {

    var tableView: UITableView?
    let reuseId = "MoreViewController.cell"
    
    var titleView: UIView?
    let menus = ["만들었습니다", "도움을 받았습니다", "의견이 있나요?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.Custom.background
        
        let titleView = self.makeTitleView()
        self.view.addSubview(titleView)
        
        let tableView = UITableView.init()
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView = tableView
        self.view.addSubview(tableView)
        
        let guide = self.view.layoutMarginsGuide
        
        tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeTitleView() -> UIView{
        
        let titleFrame = CGRect.init(x: 0, y: Constants.Margin.medium, width: self.view.frame.width, height: self.view.frame.height/2)
        let titleView = UIView.init(frame: titleFrame)
        
        titleView.backgroundColor = UIColor.clear
        
        let nameLabel = UILabel.init()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(nameLabel)
        
        let guide = titleView.layoutMarginsGuide
        nameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.text = "나의 언어로 기록되는\n\n행복한 사전"
        nameLabel.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        nameLabel.textAlignment = .center
        
        return titleView
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

extension MoreViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.menus.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.view.frame.height/2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: reuseId)
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = self.menus[indexPath.row]
        cell.textLabel?.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView?.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            
            self.popup(viewController: CreditViewController())
            
        }else if indexPath.row == 1{
            
            self.popup(viewController: OpenSourceViewController())
        
        }else if indexPath.row == 2{
            
            let mailUrl = URL.init(string: "mailto:hsh3592@gmail.com")
            
            if(UIApplication.shared.canOpenURL(mailUrl!)){
                
                UIApplication.shared.open(mailUrl!, options: [:], completionHandler: nil)
            }
        }
    }
    
    func popup(viewController: UIViewController){
        let popupController = STPopupController.init(rootViewController: viewController)
        popupController.present(in: self)
        popupController.containerView.layer.cornerRadius = 10.0
    }
}
