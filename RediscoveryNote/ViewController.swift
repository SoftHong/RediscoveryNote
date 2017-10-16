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
    var wordList: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.wordList.append(Word(definition: "지선", meaning: "모든 아름다움의 근원"))
        self.wordList.append(Word(definition: "아일", meaning: "순수하고 자유로우며 언제나 사랑이 넘치는 아이"))
        self.wordList.append(Word(definition: "팽팽", meaning: "언제나 팽팽한 긴장감을 유지하며 사랑이 넘치는 아이"))
        self.wordList.append(Word(definition: "팍팍", meaning: "팽팽이 보다 힘이 세며 나보다 강력함을 일깨워주는 아이"))
        self.tableView.reloadData()
        
        self.makeNaviItems()
        self.tableView.register(WordCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    fileprivate func makeNaviItems(){
        
        let addWordButton = UIBarButtonItem.init(title: "추가", style: .plain, target: self, action: #selector(addWord))
        navigationItem.setRightBarButton(addWordButton, animated: true)
    }
    
    @objc fileprivate func addWord(){
        
        let definition = "어떤말"
        let meaning = "어떤뜻"
        self.wordList.append(Word(definition: definition, meaning: meaning))
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
                
        if wordList.count > indexPath.row{
            let word = wordList[indexPath.row]
            cell.textLabel?.text = word.definition
            cell.detailTextLabel?.text = word.meaning
        }
        return cell
    }

}

