//
//  SettingsViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/3/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
enum SettingsViewControllerCells:String {
    case pageColor = "pageColor"
}
class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cells = [SettingsViewControllerCells]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cells.append(.pageColor)
        tableView.reloadData()
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

    //SettingsSelectPageColor
}


//MARK:- TableView Datasource and Delegate

extension SettingsViewController:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*
        switch cells[indexPath.row] {
        case .prayerTimes:
            self.performSegue(withIdentifier: "toPrayerTimes", sender: nil)
        case .settings:
            //            self.performSegue(withIdentifier: "toSettings", sender: nil)
            let settingsVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController")
            self.navigationController?.pushViewController(settingsVC!, animated: true)
        default:
            break
        }
        */
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /*
        switch cells[indexPath.row] {
        case .topSummary:
            return 70
        default:
            return 50
        }
 */
        return 92.0
    }
}

extension  SettingsViewController:UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cells.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        
//        if cells[indexPath.row] == .topSummary {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MushafFeaturesTopSummeryTableViewCell") as! MushafFeaturesTopSummeryTableViewCell
//            cell.btnNextPrayTime.setTitle(PrayerTimesManager().getNextPrayerRemining(), for: .normal)
//            cell.lblDate.text = self.getCurrentTime()
//            cell.lblHijriDate.text = self.getHijriDate()
//            
//            cell.actionsHandler = { () -> Void  in
//                self.performSegue(withIdentifier: "toPrayerTimes", sender: nil)
//            }
//            return cell
//        }
//        
        
//        cell.switchControl.isHidden = true
//        
        switch cells[indexPath.row] {
            
        case .pageColor:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsPageColorTableViewCell") as! SettingsPageColorTableViewCell
            cell.lblTitle.text = NSLocalizedString("SETTINGS_SELECT_PAGE_COLOR", comment: "")
            return cell
//        case .settings:
//            cell.imgIcon.image = UIImage(named:"settings")
//            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_SETTINGS", comment: "")
//            
//        case .highlightMushafTopics:
//            cell.switchControl.isHidden = false
//            cell.imgIcon.image = UIImage(named:"mushafByTopicIcon")
//            cell.lblTitle.text = NSLocalizedString("MUSHAF_FEATURES_ENABLE_HIGHLIGHT_BY_TOPIC", comment: "")
//            cell.actionsHandler = { (isOn: Bool) -> Void in
//                UserDefaults.standard.set(isOn, forKey: Constants.userDefaultsKeys.highlightMushafByTopicsEnabled)
//                UserDefaults.standard.synchronize()
//            }
//            cell.switchControl.isOn = UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.highlightMushafByTopicsEnabled)
//            
            
        default:
            return UITableViewCell()
            
        }
        
    }
}
