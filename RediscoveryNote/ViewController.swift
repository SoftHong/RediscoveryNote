//
//  ViewController.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 10. 10..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let reuseIdentifier = "reuseIdentifier"
    var wordList: [WordModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.view.backgroundColor = UIColor.white
        
        self.wordList.append(WordModel(word: "지선", meaning: "모든 아름다움의 근원\n당신과의 순간을 생각하면 저절로 행복해진다."))
        self.wordList.append(WordModel(word: "아일", meaning: "순수하고 자유로우며 언제나 사랑이 넘치는 아이", part: "명사"))
        self.wordList.append(WordModel(word: "팽팽", meaning: "언제나 팽팽한 긴장감을 유지하며 사랑이 넘치는 아이", part: "?!"))
        self.wordList.append(WordModel(word: "팍팍", meaning: "팽팽이 보다 힘이 세며 나보다 강력함을 일깨워주는 아이", part: "동명사"))
        self.tableView.reloadData()

        self.makeNaviItems()
        
        self.tableView.separatorColor = UIColor.clear
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(WordCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        self.animateTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func animateTable() {
        
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            
            cell.transform = CGAffineTransform.init(translationX: 0, y: tableHeight)
            UIView.animate(withDuration: 2.0, delay: 0.05 * Double(index), usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform.init(translationX: 0, y: 0);
            }, completion: nil)
        }
    }
    
    fileprivate func makeNaviItems(){
        
        let addWordButton = UIBarButtonItem.init(title: "추가", style: .plain, target: self, action: #selector(addWord))
        navigationItem.setRightBarButton(addWordButton, animated: true)
    }
    
    @objc fileprivate func addWord(){
        
        let word = "어떤말"
        let meaning = "어떤뜻"
        self.wordList.append(WordModel(word: word, meaning: meaning))
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
                
        if let wordCell = cell as? WordCell, wordList.count > indexPath.row{
            let wordModel = wordList[indexPath.row]
            
            wordCell.wordModel = wordModel
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard self.wordList.count > indexPath.row else { return }
        let wordModel = self.wordList[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.wordModel = wordModel
        self.show(detailVC, sender: self)
    }
}

