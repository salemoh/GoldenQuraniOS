//
//  SettingsViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/3/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import SideMenu

enum SettingsViewControllerCells:String {
    case pageColor = "pageColor"
    case fontSize = "fontSize"
    case manageNotifications = "manageNotifications"
    case changeReader = "changeReader"
    case changeTafseer = "changeTafseer"
    case manageDownloads = "manageDownloads"
    case versesDownload = "versesDownload"
    case contactUs = "contactUs"
    case changeLanguage = "changeLanguage"
}
class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cells = [SettingsViewControllerCells]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cells.append(.pageColor)
        
        cells.append(.manageNotifications)
        cells.append(.changeReader)
        cells.append(.changeTafseer)
        cells.append(.manageDownloads)
        cells.append(.versesDownload)
        cells.append(.contactUs)
        cells.append(.changeLanguage)
        cells.append(.fontSize)
        
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
        
        switch cells[indexPath.row] {
        case .pageColor:
            return 92
        case .fontSize:
            return 55
        case .changeLanguage:
            return 80
        default:
            return 44
        }
 
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
        case .fontSize:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsFontSizeTableViewCell") as! SettingsFontSizeTableViewCell
            cell.lblPreview.text = NSLocalizedString("SETTINGS_FONT_SIZE_PRIEVIEW", comment: "")
            return cell
        case .manageNotifications:
            //SettingsLabelWithIconTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsLabelWithIconTableViewCell") as! SettingsLabelWithIconTableViewCell
            cell.lblTitle.text = NSLocalizedString("SETTINGS_MANAGE_NOTIFICATION", comment: "")
            cell.imgIcon.image = UIImage(named:"notificationManagementIcon")
            
            return cell
        case .changeReader:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsLabelWithIconTableViewCell") as! SettingsLabelWithIconTableViewCell
            cell.lblTitle.text = NSLocalizedString("SETTINGS_MANAGE_READER", comment: "")
            cell.imgIcon.image = UIImage(named:"speakerIcon")
            
            return cell
        
        case .changeTafseer:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsLabelWithIconTableViewCell") as! SettingsLabelWithIconTableViewCell
            cell.lblTitle.text = NSLocalizedString("SETTINGS_MANAGE_TAFSEER", comment: "")
            cell.imgIcon.image = UIImage(named:"tafseerManagmentIcon")
            
            return cell
            
        case .manageDownloads:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsLabelWithIconTableViewCell") as! SettingsLabelWithIconTableViewCell
            cell.lblTitle.text = NSLocalizedString("SETTINGS_MANAGE_DOWNLOADS", comment: "")
            cell.imgIcon.image = UIImage(named:"downloadManagmentIcon")
            
            return cell
        
        case .versesDownload:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsLabelWithIconTableViewCell") as! SettingsLabelWithIconTableViewCell
            cell.lblTitle.text = NSLocalizedString("SETTINGS_DOWNLOADS_VERSES", comment: "")
            cell.imgIcon.image = UIImage(named:"downloadVersesIcon")
            
            return cell
        
        case .contactUs:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsLabelWithIconTableViewCell") as! SettingsLabelWithIconTableViewCell
            cell.lblTitle.text = NSLocalizedString("SETTINGS_CONTACT_US", comment: "")
            cell.imgIcon.image = UIImage(named:"contactUsIcon")
            //cell.imgSepratore.isHidden = true
            //cell.accessoryType = .none
            return cell
            
            
        case .changeLanguage:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsLanguageTableViewCell") as! SettingsLanguageTableViewCell
            cell.lblTitle.text = NSLocalizedString("SETTINGS_APPLICATION_LANGUAGE", comment: "")
            cell.accessoryType = .none
            cell.actionsHandler = { (index) -> Void  in
                self.dismiss(animated: true, completion: { 
                    if index == 0 {
                        // English
                        LanguageManager.changeLanguageTo(lang: .en)
                    } else {
                        // Arabic
                        LanguageManager.changeLanguageTo(lang: .ar)
                    }
                    
                    let mainWindow: UIWindow = (UIApplication.shared.delegate?.window!)!
                    mainWindow.rootViewController = self.storyboard?.instantiateInitialViewController()
                    
                    UIView.transition(with: mainWindow, duration: 0.5, options: .transitionFlipFromLeft, animations: { () -> Void in }) { _ -> Void in }
                })
                
            }
            return cell
            
            //SettingsLanguageTableViewCell
            
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
