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

    
    
    @IBOutlet weak var btnSave:UIButton!
    @IBOutlet weak var btnCancel:UIButton!
    
    @IBOutlet weak var imgMushafIcon: UIImageView!
    @IBOutlet weak var lblMushafName: UILabel!
    @IBOutlet weak var lblMushafInfo: UILabel!
    
    @IBOutlet weak var lblSaveMushafHint: UILabel!
    @IBOutlet weak var txtMushafName: GQTextField!
    
    
    var defaultMushaf:Mus7af?
    var delegate:AddMushafNameViewControllerDelegate?
    
    //MARK:- ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.fillUIData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.txtMushafName.canBecomeFirstResponder{
            self.txtMushafName.becomeFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Functions
    func fillUIData(){
    
        
        self.btnSave.setTitle(NSLocalizedString("ADD_MUSHAF_SAVE_BTN", comment: ""), for: .normal)
        self.btnCancel.setTitle(NSLocalizedString("ADD_MUSHAF_CANCEL_BTN", comment: ""), for: .normal)
        self.lblSaveMushafHint.text = NSLocalizedString("SAVE_MUSHAF_WITH_NAME", comment: "")
        self.txtMushafName.placeholder = NSLocalizedString("MUSHAF_NAME_EXAMPLE", comment: "")
        self.txtMushafName.updateToNewFont()
        self.imgMushafIcon.image = defaultMushaf?.logo
        self.lblMushafName.text = defaultMushaf?.name
        
        let hint = NSLocalizedString("\((defaultMushaf?.type)!)_NOVEL", comment: "") + "\n" + NSLocalizedString("NUMBER_OF_PAGES", comment: "") + " : " + String(format:"%d",(defaultMushaf?.numberOfPages)!)
        
        let attributedString = NSMutableAttributedString().getAttributedString(originalString: hint.correctLanguageNumbers(), stringToAttribute: NSLocalizedString("\((defaultMushaf?.type)!)_NOVEL", comment: ""), font: self.lblMushafInfo.font, isUnderlined: false, color: UIColor.black, fontSizeDelta: 2)
        
        self.lblMushafInfo.attributedText =  attributedString//hint.toArabicNumbers()
        
    }
    
    
    //MARK:- Actions
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
    
    @IBAction func cancelPressed(sender:UIButton) {
        
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.alpha = 0.0
        }) { (finished:Bool) in
            if finished == true {
                self.dismiss(animated: false, completion: nil)
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

    
}
