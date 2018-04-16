//
//  ViewController.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 10. 10..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit
import RealmSwift
import STPopup
import SnapKit
import Then

class ViewController: UITableViewController {
    
    let reuseIdentifier = "reuseIdentifier"
    var wordList: Results<WordModel>?
    var filterList: Results<WordModel>?
    
    lazy var emptyLabel = UILabel().then {
        $0.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        $0.text = "당신의 단어를 추가해보세요"
        $0.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeNavigationBar()
        
        view.backgroundColor = UIColor.Custom.background
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(WordCell.self, forCellReuseIdentifier: "reuseIdentifier")

        view.addSubview(emptyLabel)

        emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.tableView.alpha = 1.0
        self.getWordList()
        self.tableView.reloadData()
        self.animateTable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UIView.animate(withDuration: 1.0) {
            self.tableView.alpha = 0.0
        }
    }

    func animateTable() {
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform.init(translationX: 0, y: tableHeight)
            UIView.animate(withDuration: 1.6, delay: 0.05 * Double(index), usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform.init(translationX: 0, y: 0);
            }, completion: nil)
        }
    }
    
    private func makeNavigationBar() {
        
        tabBarController?.tabBar.barTintColor = UIColor.Custom.background
        navigationController?.view.backgroundColor = UIColor.Custom.background
        navigationController?.navigationBar.barTintColor = UIColor.Custom.background

        let addWordButton = UIBarButtonItem.init(title: "추가", style: .plain, target: self, action: #selector(presentAddWordPopup))
        
        let serachController = UISearchController.init(searchResultsController: nil).then {
            $0.obscuresBackgroundDuringPresentation = false
            $0.searchResultsUpdater = self
            $0.searchBar.placeholder = "어떤 단어를 찾아볼까요"
        }

        navigationItem.setRightBarButton(addWordButton, animated: true)
        navigationItem.searchController = serachController
        definesPresentationContext = true
    }
    
    @objc private func presentAddWordPopup(){
        let popupController = STPopupController.init(rootViewController: NewWordViewController())
        popupController.present(in: self)
        popupController.containerView.layer.cornerRadius = 10.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSeraching {
            if let filterList = self.filterList{
                return filterList.count
            }
        }else{
            if let wordList = self.wordList{
                if wordList.count == 0{
                    emptyLabel.isHidden = false
                } else {
                    emptyLabel.isHidden = true
                }
                
                return wordList.count
            }
        }
        
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if let wordCell = cell as? WordCell{
            
            if isSeraching {
                
                if let filterList = self.filterList,
                    filterList.count > indexPath.row{
                    
                    wordCell.wordModel = filterList[indexPath.row]
                }
                
            }else{
                if let wordList = self.wordList,
                    wordList.count > indexPath.row{
                    
                    wordCell.wordModel = wordList[indexPath.row]
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var wordModel: WordModel?
        if isSeraching {
            if let filterList = self.filterList,
                filterList.count > indexPath.row{
                wordModel = filterList[indexPath.row]
            }
        } else {
            if let wordList = self.wordList,
                wordList.count > indexPath.row{
                
                wordModel = wordList[indexPath.row]
            }
        }
        
        if let wordModel = wordModel{
            self.tableView.deselectRow(at: indexPath, animated: true)
            let detailVC = DetailViewController()
            detailVC.wordModel = wordModel
            self.show(detailVC, sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            if let wordList = self.wordList,
                wordList.count > indexPath.row{
                
                let targetModel = wordList[indexPath.row]
                
                if let fileName = targetModel.fileName{
                    do {
                        let imagePath = URL.getDocumentsDirectory().appendingPathComponent(fileName)
                        try FileManager.default.removeItem(atPath: imagePath.path)
                    } catch let error as NSError {
                        print("Error: \(error.domain)")
                    }
                }
                
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(targetModel)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK:- Realm
    
    func getWordList() {
        let realm = try! Realm()
        let wordList = realm.objects(WordModel.self)
        self.wordList = wordList
    }
    
    // MARK:- Serach BAr
    
    var serachBarIsEmpty: Bool{
        if let serachController = navigationItem.searchController{
            return serachController.searchBar.text?.isEmpty ?? true
        }
        
        return true
    }
    
    func filterContent(text: String){
        if let wordList = self.wordList{
            self.filterList = wordList.filter("word contains '\(text)'")
            self.tableView.reloadData()
        }
    }
    
    var isSeraching: Bool{
        guard let serachController = self.navigationItem.searchController else { return false }
        return serachController.isActive && !self.serachBarIsEmpty
    }
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        if let text = searchController.searchBar.text{
            self.filterContent(text: text)
        }
    }
}
