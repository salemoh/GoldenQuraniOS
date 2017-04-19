//
//  MushafFeaturesViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/11/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

enum MushafFeaturesViewControllerCells:String {
    case topSummary = "TopCell"
    case prayerTimes = "PrayerTimes"
    case highlightMushafTopics = "highlightMushafTopics"
    case settings = "SettingsCell"
    case bookmarks = "BookmarksCell"
    case search = "SearchCell"
    case fortyHadith = "FortyHadithCell"
    case finishDoaa = "FinishDoaaCell"
    case audioPlayer = "AudioPlayerCell"
    case tableOfContents = "TableOfContents"
}

class MushafFeaturesViewController: UIViewController  {

    @IBOutlet weak var tableView:UITableView!
    
    var cells = [MushafFeaturesViewControllerCells]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("MUSHAF_FEATURES_TITLE", comment: "")
        
        // Do any additional setup after loading the view.
        cells.append(.topSummary)
        cells.append(.prayerTimes)
        cells.append(.settings)
        cells.append(.highlightMushafTopics)
        cells.append(.bookmarks)
        cells.append(.search)
        cells.append(.fortyHadith)
        cells.append(.finishDoaa)
        cells.append(.audioPlayer)
        cells.append(.tableOfContents)
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toFinishQuranDoaa" {
            let navigationController = segue.destination as! UINavigationController
            let rootViewController = navigationController.viewControllers[0] as! HadithViewerViewController
            
            rootViewController.hadiths = DBManager.shared.getHadithContent(withGroupId: 1)
            rootViewController.startViewerIndex = 0
        }
    }
 

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    func getHijriDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:LanguageManager.deviceLanguage())
        let islamic = Calendar(identifier:.islamic) // Changed the variable name
        let components = islamic.dateComponents([.day , .month ,.year], from: Date())
        // *** Note also NSCalendar(identifier:) now returns now returns an optional ***
        let date = islamic.date(from: components)
        dateFormatter.calendar = islamic
        dateFormatter.dateFormat = "yyyy MMMM dd "
        if UIApplication.isAr() {
            dateFormatter.dateFormat = "d MMMM yyyy"
        }
        
        return dateFormatter.string(from: date!)
        
    }
    
    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:LanguageManager.deviceLanguage())
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: Date())
    }
    
}

//MARK:- TableView Datasource and Delegate

extension MushafFeaturesViewController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch cells[indexPath.row] {
            
        case .prayerTimes:
            self.performSegue(withIdentifier: "toPrayerTimes", sender: nil)
            
        case .settings:
            self.performSegue(withIdentifier: "toSettings", sender: nil)
            
        case .bookmarks:
            self.performSegue(withIdentifier: "toBookmarks", sender: nil)
            
        case .search:
            self.performSegue(withIdentifier: "toSearch", sender: nil)
            
        case .fortyHadith:
            self.performSegue(withIdentifier: "toFortyHadith", sender: nil)
            
        case .finishDoaa:
            self.performSegue(withIdentifier: "toFinishQuranDoaa", sender: nil)
            
        case .audioPlayer:
            self.performSegue(withIdentifier: "toAudioPlayer", sender: nil)
            
        case .tableOfContents:
            self.performSegue(withIdentifier: "toTableOfContents", sender: nil)
            
        default:
            break
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row] {
        case .topSummary:
            return 70
        default:
            return 50
        }
    }
}

extension MushafFeaturesViewController:UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cells.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if cells[indexPath.row] == .topSummary {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MushafFeaturesTopSummeryTableViewCell") as! MushafFeaturesTopSummeryTableViewCell
            cell.btnNextPrayTime.setTitle(PrayerTimesManager().getNextPrayerRemining(), for: .normal)
            cell.lblDate.text = self.getCurrentTime()
            cell.lblHijriDate.text = self.getHijriDate()
            
            cell.actionsHandler = { () -> Void  in
                self.performSegue(withIdentifier: "toPrayerTimes", sender: nil)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MushafFeaturesIconLabelTableViewCell") as! MushafFeaturesIconLabelTableViewCell
        cell.switchControl.isHidden = true
        
        switch cells[indexPath.row] {
            
        case .prayerTimes:
            cell.imgIcon.image = UIImage(named:"prayerIcon")
            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_PRAYER_TIMES", comment: "")
        
        case .settings:
            cell.imgIcon.image = UIImage(named:"settings")
            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_SETTINGS", comment: "")
            
        case .bookmarks:
            cell.imgIcon.image = UIImage(named:"bookmarkListIcon")
            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_BOOKMARKS", comment: "")
            
        case .search:
            cell.imgIcon.image = UIImage(named:"searchIcon")
            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_SEARCH", comment: "")
            
            
        case .fortyHadith:
            cell.imgIcon.image = UIImage(named:"fortyHadithIcon")
            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_FORTY_HADITH", comment: "")
            
            
        case .finishDoaa:
            cell.imgIcon.image = UIImage(named:"finishDoaaIcon")
            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_FINISH_DOAA", comment: "")
            
        case .tableOfContents:
            cell.imgIcon.image = UIImage(named:"tableOfContentsIcon")
            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_TABLE_OF_CONTENTS", comment: "")
            
        case .highlightMushafTopics:
            cell.switchControl.isHidden = false
            cell.imgIcon.image = UIImage(named:"mushafByTopicIcon")
            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_ENABLE_HIGHLIGHT_BY_TOPIC", comment: "")
            cell.actionsHandler = { (isOn: Bool) -> Void in
                UserDefaults.standard.set(isOn, forKey: Constants.userDefaultsKeys.highlightMushafByTopicsEnabled)
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: Notification.Name(rawValue:Constants.notifiers.pageHighlightTopicsChanged), object: nil)
            }
            cell.switchControl.isOn = UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.highlightMushafByTopicsEnabled)
            
            
        default:
            break
        }
        return cell
    }
}
