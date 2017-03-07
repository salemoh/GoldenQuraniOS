//
//  AddMushafNameViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/5/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
protocol AddMushafNameViewControllerDelegate {
    func mushafAddedSuccessfully()
}

class AddMushafNameViewController: UIViewController {

    @IBOutlet weak var txtMushafName: UITextField!
    
    var defaultMushaf:Mus7af?
    var delegate:AddMushafNameViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender:UIButton) {
        
        
        UIView.animate(withDuration: 0.4, animations: { 
            self.view.alpha = 0.0
        }) { (finished:Bool) in
            if finished == true {
                self.dismiss(animated: false, completion: nil)
            }
        }
        
    
    }
    
    @IBAction func savePressed(sender:UIButton) {
        
        if let name = txtMushafName.text {
            defaultMushaf?.name = name
        }
        
        Mus7afManager.shared.createNewMushaf(mushaf: defaultMushaf!)
        UIView.animate(withDuration: 0.4, animations: {
            self.view.alpha = 0.0
        }) { (finished:Bool) in
            if finished == true {
                self.dismiss(animated: false, completion:{
                    self.delegate?.mushafAddedSuccessfully()
                })
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }, completion: nil)
        
    }
}
