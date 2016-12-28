//
//  ViewController.swift
//  ShinoURLPromise
//
//  Created by shino on 2016/12/28.
//  Copyright © 2016年 shino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://shino.space")!
        URLSession.shared.dataTask(with: url).flatMap { (_: Data?) -> Async<Data?> in
            print("first callback")
            let url = URL(string: "https://www.baidu.com")!
            return URLSession.shared.dataTask(with: url)
        }.execute { data in
            let str = String(data: data!, encoding: .utf8)!
            print(str)
        }
    }
}

