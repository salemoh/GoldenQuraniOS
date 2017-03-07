//
//  MushafPageViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/2/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class MushafPageViewController: UIViewController {
    
    
    @IBOutlet weak var imgPageBackground: UIImageView!
    var pageNumber:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if pageNumber%2 == 0 {
            imgPageBackground.image = UIImage(named:"pageLeftBlue")
        } else {
            imgPageBackground.image = UIImage(named:"pageRightBlue")
        }
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
