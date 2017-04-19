//
//  TableOfContentsViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/19/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class TableOfContentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentViewType: GQSegmentedControl!
    
    var filteredContent:Dictionary< String , [TableOfContentItem]> = [:]
    var keys:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let closeBtnItem = UIBarButtonItem(title:NSLocalizedString("CLOSE", comment: ""),style:.plain , target:self , action:#selector(self.closePressed))
        self.navigationItem.setLeftBarButtonItems([closeBtnItem], animated: true)
        
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionHeaderHeight = 50
        
        tableView.keyboardDismissMode = .onDrag
        
        self.segmentViewType.setTitle(NSLocalizedString("TableOfContentsFilterBySora", comment: ""), forSegmentAt: 0)
        self.segmentViewType.setTitle(NSLocalizedString("TableOfContentsFilterBySection", comment: ""), forSegmentAt: 1)
        self.searchBar.placeholder = NSLocalizedString("TableOfContentsSearchInSoras", comment: "")
        self.title = NSLocalizedString("TableOfContentsTitle", comment: "")
        
        let tocData = Mus7afManager.shared.currentMus7af.tableOfContents
        filteredContent = formatData(tableOfContentsData: tocData!)
        
        self.tableView.reloadData()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBar.resignFirstResponder()
    }

    func closePressed(){
        self.searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    func formatData(tableOfContentsData:[TableOfContentItem]) -> Dictionary< String , [TableOfContentItem]>{
        var newDataDic:Dictionary< String , [TableOfContentItem]> = [:]
        keys.removeAll()
        
        for tocItem in tableOfContentsData {
            
            if tocItem.sora == -1 { /// Juz item
                let juzContent = newDataDic[String(format:"%d",tocItem.juz!)]
                if juzContent  == nil {
                    newDataDic[String(format:"%d",tocItem.juz!)] = [TableOfContentItem]()
                }
                newDataDic[String(format:"%d",tocItem.juz!)]?.append(tocItem)
                keys.append(String(format:"%d",tocItem.juz!))
            }
            
            if tocItem.sora != -1 {
                let juzContent = newDataDic[String(format:"%d",tocItem.juz!)]
                if juzContent  == nil {
                    newDataDic[String(format:"%d",tocItem.juz!)] = [tocItem]
                } else {
                    newDataDic[String(format:"%d",tocItem.juz!)]?.append(tocItem)
                }
            }
        }
        
        return newDataDic
        
    }
    
    @IBAction func segmentFilterChanged(_ sender: GQSegmentedControl) {
        
        let tableOfContentsData = Mus7afManager.shared.currentMus7af.tableOfContents
        var newContents = [TableOfContentItem]()
        
        if sender.selectedSegmentIndex == 0 {
            // Sora
            newContents = tableOfContentsData!
        }
        
        if sender.selectedSegmentIndex == 1 {
            //Juz
            for tocItem in tableOfContentsData! {
                
                if tocItem.sora == -1 { /// Juz item
                    newContents.append(tocItem)
                }
               
            }
        }
        filteredContent = formatData(tableOfContentsData: newContents)
        tableView.reloadData()
    }
    
    func searchContents(keyword:String){
        
        let tableOfContentsData = Mus7afManager.shared.currentMus7af.tableOfContents
        if keyword.characters.count == 0 {
            filteredContent = formatData(tableOfContentsData: tableOfContentsData!)
            tableView.reloadData()
            return
        }
        
        
        var newContents = [TableOfContentItem]()
        
        for tocItem in tableOfContentsData! {
            
            if tocItem.sora != -1 {
                let soraTitle = String(format:"Sora%d",tocItem.sora!)
                let soraName = NSLocalizedString(soraTitle, comment: "")
                
                if soraName.contains(keyword) {
                    newContents.append(tocItem)
                }
                
            }
        }
        
        var contentsWithSections = [TableOfContentItem]()
        var keysAdded:Dictionary<String,Any> = [:]
        
        for newTocItem in newContents {
            let key = String(format:"%d",newTocItem.juz!)
            if (keysAdded[key] == nil) {
                for tocItem in tableOfContentsData! {
                    
                    if tocItem.sora == -1 && tocItem.juz! == newTocItem.juz! {
                        
                        contentsWithSections.append(tocItem)
                        keysAdded[key] = ""
                        break
                    }
                }
            }
            contentsWithSections.append(newTocItem)
        }
        
        filteredContent = formatData(tableOfContentsData: contentsWithSections)
        tableView.reloadData()
        
//        let juzContent = newDataDic[String(format:"%d",tocItem.juz!)]
//        if juzContent  == nil {
//            newDataDic[String(format:"%d",tocItem.juz!)] = [tocItem]
//        } else {
//            newDataDic[String(format:"%d",tocItem.juz!)]?.append(tocItem)
//        }
    
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


extension TableOfContentsViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchContents(keyword: searchText)
//        if searchText.characters.count >= 3 {
            //doSearch()
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let _ = searchBar.text {
            //doSearch()
        }
        searchBar.resignFirstResponder()
    }
}

extension TableOfContentsViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// Navigate to toc data
        
    }
}


extension TableOfContentsViewController:UITableViewDataSource {
    //TableOfContentsSectionHeaderTableViewCell
    //TableOfContentsSoraTableViewCell
    func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableOfContentsSectionHeaderTableViewCell") as! TableOfContentsSectionHeaderTableViewCell
        
        let sectionKey = keys[section]
        
        guard let juzContent = filteredContent[sectionKey] else  {
            return nil
        }
        
        let tocItem = juzContent[0]
        
        let juzTitle = String(format:"Juz%d",tocItem.juz!)
        cell.lblTitle.text = NSLocalizedString(juzTitle, comment: "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let juzContent = filteredContent[keys[section]] {
            return juzContent.count - 1
        }
        
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableOfContentsSoraTableViewCell") as! TableOfContentsSoraTableViewCell
        
        guard let juzContent = filteredContent[keys[indexPath.section]] else  {
            return UITableViewCell()
        }
        
        let tocItem = juzContent[indexPath.row + 1]
        
        let soraTitle = String(format:"Sora%d",tocItem.sora!)
        let soraLocation = String(format:"SoraLocation%d",tocItem.place!)
        
        cell.lblSoraName.text = NSLocalizedString(soraTitle, comment: "")
        cell.lblSoraNo.text = String(format: NSLocalizedString("SoraNumberTOC", comment: "") , tocItem.sora!).correctLanguageNumbers()
        cell.lblVersesCount.text = String(format: NSLocalizedString("SoraVersesCountTOC", comment: "") , tocItem.versesCount!).correctLanguageNumbers()
        cell.lblSoraLocation.text = NSLocalizedString(soraLocation, comment: "")
        
        return cell
        
    }
    
    
}
