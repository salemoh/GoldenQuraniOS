//
//  BookmarksViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/13/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var bookmarks:[Bookmark] = [Bookmark]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BookmarkManager.addBookmark(forPage: 1)
        bookmarks = BookmarkManager.getMushafBookmarks(mushaf: Mus7afManager.shared.currentMus7af)
        // Do any additional setup after loading the view.
        
        self.title = NSLocalizedString("BOOKMARKS_TITLE", comment: "")
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.reloadData()
        
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


extension BookmarksViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// Navigate to bookmark data
        
    }
}

//BookmarksTableViewCell
extension BookmarksViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarksTableViewCell") as! BookmarksTableViewCell
        
        let bookmark = bookmarks[indexPath.row]
        cell.lblTitle.text = "-"
        cell.lblSubtitle.text = "-"
        
        let date = Date(timeIntervalSince1970: bookmark.updatedAt!)
        cell.lblLastUse.text = date.toStringWithRelativeTime().correctLanguageNumbers()
        
        
        cell.setNeedsLayout()
        return cell
    }
    
    
}
