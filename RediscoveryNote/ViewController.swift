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

class ViewController: UITableViewController {
    
    let reuseIdentifier = "reuseIdentifier"
    var wordList: Results<WordModel>?
    var filterList: Results<WordModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.navigationController?.view.backgroundColor = UIColor.white
        
//        self.wordList.append(WordModel(word: "지선", meaning: "모든 아름다움의 근원\n당신과의 순간을 생각하면 저절로 행복해진다."))
//        self.wordList.append(WordModel(word: "아일", meaning: "순수하고 자유로우며 언제나 사랑이 넘치는 아이", part: "명사"))
//        self.wordList.append(WordModel(word: "팽팽", meaning: "언제나 팽팽한 긴장감을 유지하며 사랑이 넘치는 아이", part: "?!"))
//        self.wordList.append(WordModel(word: "소설", meaning: "출근한 오늘도 나는 계속 해서 할머니의 돈에 대해서 생각을 하고 있다. 할머니는 그 돈을 주면서 할머니와 나의 관계는 이 매장에 오는 고객들과 나의 관계와 다를 바가 없어졌다. 하지만 그 돈으로 그녀는 머리를 감고 손톱을 깎을 수 있었다. 그녀가 더 나이가 들어간다면 그녀는 더 할 수 있는 일이 줄어들 것이고 그럴 때마다 돈은 그런 그녀를 지켜줄 것이다. 이런 생각 정도 까지 흘렀을 때 누군가 조심스럽게 문을 여는 소리가 들린다. 예전에 세차게 문을 닫고 나갔던 그 고객이었다. 그녀는 어색한 표정으로 나를 보더니 내 앞에 앉는다. 그렇게 당차게 나가더니 그녀는 결국 왜 이곳에 왔을까 싶어 아무 말 않고 있었다. 그녀는 “자기 밖에 없더라고, 역시.” 라며 손을 내밀었다. 그 손이 뻔뻔스럽다고 여겨졌다. “이런 얘기를 들어 줄만 한 사람이 없어.” 하며 그녀는 또 자신 혼자 그 이야기를 하기 시작했다. 벽에 대듯 이야기하는 그녀를 보면서 문득 할머니 집에서의 적막이 떠올랐다. 그녀의 집도 그런 적막 속에 있는 것은 아닐까. 적막 속에 지금처럼 혼자 소음을 내고 있을 그녀가 그려졌다. 그러자 그녀의 손이 차갑게 느껴졌다. 그 차가운 손을 나는 잡았다. 돈을 받으며 온기를 준다는 것. 그게 그렇게 잘 못된 것도 이상한 것도 아니라는 생각이 들었다. 누군가 에게는 온기를 나눌 수 있는 유일한 방식일지도 모르고 그 누군가가 얼마든지 내가 될 수도 있으니깐.", part: "동명사"))
        
        self.makeNaviItems()
        
        self.tableView.separatorColor = UIColor.clear
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(WordCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
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
    
    fileprivate func makeNaviItems(){
        
        let addWordButton = UIBarButtonItem.init(title: "추가", style: .plain, target: self, action: #selector(addWord))

        self.navigationItem.setRightBarButton(addWordButton, animated: true)
        
        let serachController = UISearchController.init(searchResultsController: nil)
        // UISearchController.init() 만 써도 되지 않을까?
        
        serachController.searchBar.backgroundImage = UIImage()
    
        serachController.searchResultsUpdater = self
        serachController.searchBar.placeholder = "어떤 단어를 찾아볼까요"
        navigationItem.searchController = serachController
        definesPresentationContext = true
    }
    
    @objc fileprivate func addWord(){
        
        let popupController = STPopupController.init(rootViewController: NewWordViewController())
        popupController.present(in: self)
        popupController.present(in: self) {
            self.getWordList()
            self.tableView.reloadData()
        }
        
        popupController.containerView.layer.cornerRadius = 10.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSeraching(){
            
            if let filterList = self.filterList{
                return filterList.count
            }
            
        }else{
        
            if let wordList = self.wordList{
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
            
            if isSeraching(){
                
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
        if isSeraching(){
            if let filterList = self.filterList,
                filterList.count > indexPath.row{
                wordModel = filterList[indexPath.row]
            
            }
        }else{
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
                
                if let imagePath = targetModel.imagePath{
                    do {
                        try FileManager.default.removeItem(atPath: imagePath)
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
    
    func getWordList(){
        let realm = try! Realm()
        let wordList = realm.objects(WordModel.self)
        self.wordList = wordList
    }
    
    // MARK:- Serach BAr
    
    func serachBarIsEmpty() -> Bool{
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
    
    func isSeraching() -> Bool{
        
        guard let serachController = self.navigationItem.searchController else { return false }
        return serachController.isActive && !self.serachBarIsEmpty()
    }
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        if let text = searchController.searchBar.text{
            
            self.filterContent(text: text)
        }
    }
}

