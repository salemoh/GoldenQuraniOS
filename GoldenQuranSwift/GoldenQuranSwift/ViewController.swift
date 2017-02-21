//
//  ViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/12/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DBManager.shared.getDefaultMus7afs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

