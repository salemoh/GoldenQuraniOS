//
//  SearchViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/13/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

enum SearchType:Int {
    case verse = 1
    case topic
    case mojam
}

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmntedControl: GQSegmentedControl!
    
    var currentSearchType:SearchType = .verse
    var searchResults = [SearchResult]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let closeBtnItem = UIBarButtonItem(title:NSLocalizedString("CLOSE", comment: ""),style:.plain , target:self , action:#selector(self.closePressed))
        self.navigationItem.setLeftBarButtonItems([closeBtnItem], animated: true)
        // Do any additional setup after loading the view.

        
        self.title = NSLocalizedString("SEARCH_TITLE", comment: "")
        
        tableView.keyboardDismissMode = .onDrag
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionHeaderHeight = 40
        
        self.searchBar.becomeFirstResponder()
        
        segmntedControl.setTitle(NSLocalizedString("SEARCH_MUSHAF_VERSES_SEGMENT", comment: "") , forSegmentAt: 0)
        segmntedControl.setTitle(NSLocalizedString("SEARCH_MUSHAF_TOPICS_SEGMENT", comment: ""), forSegmentAt: 1)
        segmntedControl.setTitle(NSLocalizedString("SEARCH_MUSHAF_MO3JAM_SEGMENT", comment: ""), forSegmentAt: 2)
        
        updateToNewSearchMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func closePressed(){
        self.searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchSegmentChanged(_ sender: GQSegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentSearchType = .verse
        case 1:
            currentSearchType = .topic
        case 2:
            currentSearchType = .mojam
        default:
            currentSearchType = .verse
        }
        updateToNewSearchMethod()
    }

    func updateToNewSearchMethod(){
        switch currentSearchType {
        case .verse:
            currentSearchType = .verse
            self.searchBar.placeholder = NSLocalizedString("SEARCH_MUSHAF_VERSES_PLACEHOLDER", comment: "")
        case .topic:
            currentSearchType = .topic
            self.searchBar.placeholder = NSLocalizedString("SEARCH_MUSHAF_TOPICS_PLACEHOLDER", comment: "")
        case .mojam:
            currentSearchType = .mojam
            self.searchBar.placeholder = NSLocalizedString("SEARCH_MUSHAF_MO3JAM_PLACEHOLDER", comment: "")
        }
        
        doSearch()
        
    }
    
    func doSearch(){
        guard let query = self.searchBar.text, query.characters.count > 0 else {
            return
        }
        switch currentSearchType {
        case .verse:
           searchResults =  DBManager.shared.searchMushafVerse(keyword: query);
        case .topic:
            searchResults =  DBManager.shared.searchMushafByTopic(keyword: query);
        case .mojam:
             searchResults =  DBManager.shared.searchMushafMo3jam(keyword: query);
        }
        self.tableView.reloadData()
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

extension SearchViewController:UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count >= 3 {
            doSearch()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let _ = searchBar.text {
            doSearch()
        }
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// Navigate to search data
        
    }
}


extension SearchViewController:UITableViewDataSource {
    //SearchVerseTableViewCell
    //SearchTopicTableViewCell
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHeaderTableViewCell") as! SearchHeaderTableViewCell
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let str = String(formatter.string(from: NSNumber(value: searchResults.count))!)
        
        cell.lblResultsCount.text = String(format: NSLocalizedString("SEARCH_RESULTS_%@", comment: ""), str!).correctLanguageNumbers()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        switch currentSearchType {
        case .topic:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTopicTableViewCell") as! SearchTopicTableViewCell
            
            let searchResult = searchResults[indexPath.row]
            let sora = String(format:"Sora%d" , searchResult.soraNo!)
            cell.lblTo.text = NSLocalizedString("SEARCH_TO", comment: "")
            cell.lblSora.text = NSLocalizedString( sora , comment: "")
            cell.lblFromVerse.text = String(format:"%d", searchResult.fromVerse!).correctLanguageNumbers()
            cell.lblToVerse.text =  String(format:"%d", searchResult.toVerse!).correctLanguageNumbers()
            cell.lblSearchContent.text = searchResult.content
            
//            cell.setNeedsLayout()
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchVerseTableViewCell") as! SearchVerseTableViewCell
            
            let searchResult = searchResults[indexPath.row]
            let sora = String(format:"Sora%d" , searchResult.soraNo!)
            
            cell.lblSearchSora.text = NSLocalizedString( sora , comment: "")
            cell.lblSearchVerse.text = String(format:"%d", searchResult.fromVerse!).correctLanguageNumbers()
            cell.lblSearchContent.text = searchResult.content
            
            
//            cell.setNeedsLayout()
            return cell
            
        }
        
    }
    
    
}
