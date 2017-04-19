//
//  HadithViewerViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/17/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class HadithViewerViewController: UIViewController {

    var startViewerIndex = 0
    var hadiths:[Hadith] = [Hadith]()
    
    @IBOutlet weak var nextBarItem: UIBarButtonItem!
    @IBOutlet weak var previousBarItem: UIBarButtonItem!
    @IBOutlet weak var lblTitle: GQLabel!
    @IBOutlet weak var textViewContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let closeBtnItem = UIBarButtonItem(title:NSLocalizedString("CLOSE", comment: ""),style:.plain , target:self , action:#selector(self.closePressed))
        self.navigationItem.setLeftBarButtonItems([closeBtnItem], animated: true)
        
        showHadith()
        
        self.nextBarItem.title = NSLocalizedString("HADITH_NEXT_BUTTON", comment: "")
        self.previousBarItem.title = NSLocalizedString("HADITH_PREVIOUS_BUTTON", comment: "")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closePressed(){
    
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextPressed(_ sender: UIBarButtonItem) {
        startViewerIndex += 1
        showHadith()
    }

    @IBAction func previousPressed(_ sender: UIBarButtonItem) {
        startViewerIndex -= 1
        showHadith()
    }
    
    func showHadith(){
        self.lblTitle.text = hadiths[startViewerIndex].title
        self.textViewContent.text = hadiths[startViewerIndex].content
        
        updateActions()
    }
    
    func updateActions(){
        self.previousBarItem.isEnabled = true
        self.nextBarItem.isEnabled = true
        
        if startViewerIndex == hadiths.count - 1 {
            self.nextBarItem.isEnabled = false
        }
        
        if startViewerIndex == 0 {
            self.previousBarItem.isEnabled = false
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
