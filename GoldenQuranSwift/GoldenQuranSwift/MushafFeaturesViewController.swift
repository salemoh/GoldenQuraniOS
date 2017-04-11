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
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
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
