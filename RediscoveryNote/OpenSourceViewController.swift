//
//  OpenSourceViewController.swift
//  RediscoveryNote
//
//  Created by 홍성호 on 2017. 11. 30..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class OpenSourceViewController: UIViewController {

    let openSource = "오픈소스의 도움을 받았습니다.\n\n\nRelam Swift\nCopyright [2017] [Realm]\nLicensed under the Apache License, Version 2.0 (the \"License\");\nyou may not use this file except in compliance with the License.\nYou may obtain a copy of the License at\n    http://www.apache.org/licenses/LICENSE-2.0\nUnless required by applicable law or agreed to in writing, software\ndistributed under the License is distributed on an \"AS IS\" BASIS,\nWITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\nSee the License for the specific language governing permissions and\nlimitations under the License.\n\n\nSTPopup\nThe MIT License (MIT)\nCopyright (c) 2015 Kevin\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentSizeInPopup = CGSize.init(width: 300, height: 300)
        
        let textView = UITextView.init()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.text = openSource
        textView.font = UIFont.init(customFont: .Myeongjo, withSize: Constants.Font.small)
        self.view.addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.Margin.small).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.Margin.small).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
