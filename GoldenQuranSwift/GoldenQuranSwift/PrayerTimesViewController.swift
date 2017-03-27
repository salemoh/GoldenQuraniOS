//
//  PrayerTimesViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/26/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import CoreLocation
import Adhan

enum PrayerTimeScreen:Int {
    case prayerTimes
    case settings
    case adjustment
}

class PrayerTimesViewController: UIViewController, LocationManagerDelegate {
    
    @IBOutlet weak var imgCompass: UIImageView!
    @IBOutlet weak var imgNeedle: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    
    var currentScreen:PrayerTimeScreen = .prayerTimes
    var prayerTimes:PrayerTimes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        LocationManager.shared.delegate = self
        
        LocationManager.shared.startHeadingUpdating()
        
        tabBar.selectedItem = tabBar.items?[0]
        tabBar.items?[0].title = NSLocalizedString("PRAYER_TIMES", comment: "")
        tabBar.items?[1].title = NSLocalizedString("PRAYER_SETTINGS", comment: "")
        tabBar.items?[2].title = NSLocalizedString("PRAYER_ADJUSTMENT", comment: "")
        
        reloadData()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: FontManager.fontWithSize(size: 11.0, isBold: true)], for: .normal)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocationManager.shared.stopUpdating()
    }
    
    func reloadData(){
        self.prayerTimes = PrayerTimesManager().getPrayerTimes()
        self.tableView.reloadData()
        
    }
    
    func getFormattedPrayerTime(time:Date?) -> String{
        if let prayerTime = time {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            formatter.timeZone = TimeZone.current
            return formatter.string(from: prayerTime)
        }
        return "--:--"
        
    }
    
    //MARK:- Actions
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    ///MARK:- Location Manager Delegate
    func locationManagerDidUpdateHeading(compassTransform: CGAffineTransform,needleTransform: CGAffineTransform){
        
        self.reloadData()
        
        UIView.animate(withDuration: 0.4) {
            self.imgNeedle.transform = needleTransform
        }
        
        UIView.animate(withDuration: 0.7) {
            self.imgCompass.transform = compassTransform
        }
        
    }
    
}

extension PrayerTimesViewController:UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.currentScreen {
        case .prayerTimes:
            return 7
        case .settings:
            return 20
        case .adjustment:
            return 6
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.currentScreen == .settings {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsFullTimesTableViewCell") as! PrayerSettingsFullTimesTableViewCell
            cell.constraintWidth.constant = (self.tableView.frame.size.width - 16.0) / 5.0
            cell.fillWithPrayer(prayerTimes: self.prayerTimes)
            return cell
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //PrayerSwitchEnableTableViewCell
        //PrayerTimeTableViewCell
        //PrayerSettingsFullTimesTableViewCell
        //PrayerSettingsLabelTableViewCell
        //PrayerSettingsTitleTableViewCell
        //PrayerSettingsSoundTableViewCell
        //PrayerAdjustmentTableViewCell
        
        switch self.currentScreen {
        case .prayerTimes:
            return self.getPrayerTimesCell(forIndexPath: indexPath)
        case .settings:
            return self.getPrayerSettingsCell(forIndexPath: indexPath)
        case .adjustment:
            return self.getPrayerAdjustmentCell(forIndexPath: indexPath)
        }
        
    }
    
    
    func getPrayerAdjustmentCell(forIndexPath:IndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerAdjustmentTableViewCell") as! PrayerAdjustmentTableViewCell
        
        switch forIndexPath.row {
        case 0:///Fajr
            
            cell.lblTitle.text = NSLocalizedString("FAJR_PRAY_TIME", comment: "")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.fajr)
            cell.modificationKey = Constants.userDefaultsKeys.prayerTimesAdjustmentFajr
            
        case 1: ///Sunrise
            
            cell.lblTitle.text = NSLocalizedString("SUNRISE_PRAY_TIME", comment: "")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.sunrise)
            cell.modificationKey = Constants.userDefaultsKeys.prayerTimesAdjustmentSunrise
        
            
        case 2:///Duhour
            
            cell.lblTitle.text = NSLocalizedString("DOHOR_PRAY_TIME", comment: "")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.dhuhr)
            cell.modificationKey = Constants.userDefaultsKeys.prayerTimesAdjustmentDhuhr
            
            
        case 3:///Asr
            cell.lblTitle.text = NSLocalizedString("ASR_PRAY_TIME", comment: "")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.asr)
            cell.modificationKey = Constants.userDefaultsKeys.prayerTimesAdjustmentAsr
            
            
        case 4:///Maghrib
            cell.lblTitle.text = NSLocalizedString("MAGHRIB_PRAY_TIME", comment: "")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.maghrib)
            cell.modificationKey = Constants.userDefaultsKeys.prayerTimesAdjustmentMagrib
            
            
        case 5://Isha
            cell.lblTitle.text = NSLocalizedString("ISHA_PRAY_TIME", comment: "")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.isha)
            cell.modificationKey = Constants.userDefaultsKeys.prayerTimesAdjustmentIsha
            
            
        default:
            break
        }
        cell.lblAdjustment.text = String(UserDefaults.standard.integer(forKey: cell.modificationKey!))
        cell.actionsHandler = {() -> Void in
            self.reloadData()
        }
        return cell
    }
    
    
    func getPrayerSettingsCell(forIndexPath:IndexPath) -> UITableViewCell{
        
        
        switch forIndexPath.row {
            /*
             case 0:
             let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsFullTimesTableViewCell") as! PrayerSettingsFullTimesTableViewCell
             cell.constraintWidth.constant = (self.tableView.frame.size.width - 16.0) / 5.0
             cell.fillWithPrayer(prayerTimes: self.prayerTimes)
             return cell
             */
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsLabelTableViewCell") as! PrayerSettingsLabelTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD", comment: "")
            return cell
            
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_muslimWorldLeague", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) <= 1 {
                cell.accessoryType = .checkmark
            }
            return cell
            
        case 2:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_egyptian", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) == 2 {
                cell.accessoryType = .checkmark
            }
            return cell
            
        case 3:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_karachi", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) == 3 {
                cell.accessoryType = .checkmark
            }
            return cell
            
            
        case 4:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_ummAlQura", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) == 4 {
                cell.accessoryType = .checkmark
            }
            return cell
            
            
        case 5:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_gulf", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) == 5 {
                cell.accessoryType = .checkmark
            }
            return cell
            
            
        case 6:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_moonsightingCommittee", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) == 6 {
                cell.accessoryType = .checkmark
            }
            return cell
            
        case 7:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_northAmerica", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) == 7 {
                cell.accessoryType = .checkmark
            }
            return cell
            
        case 8:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_kuwait", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) == 8 {
                cell.accessoryType = .checkmark
            }
            return cell
            
        case 9:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_METHOD_qatar", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod) == 9 {
                cell.accessoryType = .checkmark
            }
            return cell
            
            
        case 10:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsLabelTableViewCell") as! PrayerSettingsLabelTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_MADHAB", comment: "")
            return cell
            
        case 11:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_MADHAB_HANFI", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMadhab) == 1 {
                cell.accessoryType = .checkmark
            }
            return cell
        case 12:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsTitleTableViewCell") as! PrayerSettingsTitleTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_CALCULATION_MADHAB_SHAFI", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMadhab) != 1 {
                cell.accessoryType = .checkmark
            }
            return cell
            
        case 13:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsLabelTableViewCell") as! PrayerSettingsLabelTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_SETTINGS_ATHAN_SOUND", comment: "")
            return cell
            
        case 14:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsSoundTableViewCell") as! PrayerSettingsSoundTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_SETTINGS_ATHAN_SOUND1", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound) <= 1 {
                cell.accessoryType = .checkmark
            }
            return cell
        case 15:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsSoundTableViewCell") as! PrayerSettingsSoundTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_SETTINGS_ATHAN_SOUND2", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound) == 2 {
                cell.accessoryType = .checkmark
            }
            return cell
            
        case 16:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsSoundTableViewCell") as! PrayerSettingsSoundTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_SETTINGS_ATHAN_SOUND3", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound) == 3 {
                cell.accessoryType = .checkmark
            }
            return cell
        case 17:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsSoundTableViewCell") as! PrayerSettingsSoundTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_SETTINGS_ATHAN_SOUND4", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound) == 4 {
                cell.accessoryType = .checkmark
            }
            return cell
        case 18:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsSoundTableViewCell") as! PrayerSettingsSoundTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_SETTINGS_ATHAN_SOUND5", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound) == 5 {
                cell.accessoryType = .checkmark
            }
            return cell
        case 19:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSettingsSoundTableViewCell") as! PrayerSettingsSoundTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_SETTINGS_ATHAN_SOUND6", comment: "")
            cell.accessoryType = .none
            if UserDefaults.standard.integer(forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound) == 6 {
                cell.accessoryType = .checkmark
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func getPrayerTimesCell(forIndexPath:IndexPath) -> UITableViewCell{
        
        switch forIndexPath.row {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerSwitchEnableTableViewCell") as! PrayerSwitchEnableTableViewCell
            cell.lblTitle.text = NSLocalizedString("PRAYER_TIMES_ENABLE_ATHAN_NOTIFICATION", comment: "")
            cell.switchEnable.isOn = !UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.notificationsAthanDisabled)
            cell.actionsHandler = {
                (isOn: Bool) -> Void in
                UserDefaults.standard.set(!isOn, forKey: Constants.userDefaultsKeys.notificationsAthanDisabled)
            }
            return cell
            
        case 1:///Fajr
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerTimeTableViewCell") as! PrayerTimeTableViewCell
            cell.lblTitle.text = NSLocalizedString("FAJR_PRAY_TIME", comment: "")
            cell.imgIcon.image = UIImage(named:"fajrIcon")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.fajr)
            
            cell.btnToggleEnable.isHidden = false
            cell.btnToggleEnable.isSelected = UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.notificationsAthanFajrDisabled)
            cell.actionsHandler = {
                (isMuted:Bool) -> Void in
                UserDefaults.standard.set(isMuted, forKey: Constants.userDefaultsKeys.notificationsAthanFajrDisabled)
            }
            return cell
            
        case 2:///Sunrise
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerTimeTableViewCell") as! PrayerTimeTableViewCell
            cell.lblTitle.text = NSLocalizedString("SUNRISE_PRAY_TIME", comment: "")
            cell.imgIcon.image = UIImage(named:"sunriseIcon")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.sunrise)
            cell.btnToggleEnable.isHidden = true
            return cell
            
        case 3:///Duhour
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerTimeTableViewCell") as! PrayerTimeTableViewCell
            cell.lblTitle.text = NSLocalizedString("DOHOR_PRAY_TIME", comment: "")
            cell.imgIcon.image = UIImage(named:"duhorIcon")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.dhuhr)
            cell.btnToggleEnable.isHidden = false
            
            cell.btnToggleEnable.isSelected = UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.notificationsAthanDouhrDisabled)
            cell.actionsHandler = {
                (isMuted:Bool) -> Void in
                UserDefaults.standard.set(isMuted, forKey: Constants.userDefaultsKeys.notificationsAthanDouhrDisabled)
            }
            return cell
            
        case 4:///Asr
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerTimeTableViewCell") as! PrayerTimeTableViewCell
            cell.lblTitle.text = NSLocalizedString("ASR_PRAY_TIME", comment: "")
            cell.imgIcon.image = UIImage(named:"asrIcon")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.asr)
            cell.btnToggleEnable.isHidden = false
            
            cell.btnToggleEnable.isSelected = UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.notificationsAthanAsrDisabled)
            cell.actionsHandler = {
                (isMuted:Bool) -> Void in
                UserDefaults.standard.set(isMuted, forKey: Constants.userDefaultsKeys.notificationsAthanAsrDisabled)
            }
            
            return cell
            
        case 5:///Maghrib
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerTimeTableViewCell") as! PrayerTimeTableViewCell
            cell.lblTitle.text = NSLocalizedString("MAGHRIB_PRAY_TIME", comment: "")
            cell.imgIcon.image = UIImage(named:"magribIcon")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.maghrib)
            cell.btnToggleEnable.isHidden = false
            
            cell.btnToggleEnable.isSelected = UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.notificationsAthanMaghribDisabled)
            cell.actionsHandler = {
                (isMuted:Bool) -> Void in
                UserDefaults.standard.set(isMuted, forKey: Constants.userDefaultsKeys.notificationsAthanMaghribDisabled)
            }
            
            return cell
            
        case 6://Isha
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PrayerTimeTableViewCell") as! PrayerTimeTableViewCell
            cell.lblTitle.text = NSLocalizedString("ISHA_PRAY_TIME", comment: "")
            cell.imgIcon.image = UIImage(named:"ishaIcon")
            cell.lblTime.text = self.getFormattedPrayerTime(time: self.prayerTimes?.isha)
            cell.btnToggleEnable.isHidden = false
            
            cell.btnToggleEnable.isSelected = UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.notificationsAthanIshaDisabled)
            cell.actionsHandler = {
                (isMuted:Bool) -> Void in
                UserDefaults.standard.set(isMuted, forKey: Constants.userDefaultsKeys.notificationsAthanIshaDisabled)
            }
            return cell
            
            
        default:
            return UITableViewCell()
        }
    }
    
}

extension PrayerTimesViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.currentScreen {
        case .prayerTimes:
            return 50
        case .settings:
            switch indexPath.row {
            case 0:
                return 44.0
            case 1:
                return 44.0
                
            default:
                return 44.0
            }
            
        case .adjustment:
            return 65.0
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.currentScreen == .settings {
            return 60.0
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentScreen != .settings {
            return
        }
        
        
        switch indexPath.row {
        ///Calculation Method
        case 1:
            UserDefaults.standard.set(1, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
        case 2:
            UserDefaults.standard.set(2, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
        case 3:
            UserDefaults.standard.set(3, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
        case 4:
            UserDefaults.standard.set(4, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
        case 5:
            UserDefaults.standard.set(5, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
        case 6:
            UserDefaults.standard.set(6, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
        case 7:
            UserDefaults.standard.set(7, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
        case 8:
            UserDefaults.standard.set(8, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
        case 9:
            UserDefaults.standard.set(9, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMethod)
            
            
            
        ///Madhab
        case 11:
            UserDefaults.standard.set(1, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMadhab)
            
        case 12:
            UserDefaults.standard.set(2, forKey: Constants.userDefaultsKeys.prayerTimesSettingsCalculationMadhab)
            
        ///Sound
        case 14:
            UserDefaults.standard.set(1, forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound)
            
        case 15:
            UserDefaults.standard.set(2, forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound)
            
        case 16:
            UserDefaults.standard.set(3, forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound)
        case 17:
            UserDefaults.standard.set(4, forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound)
        case 18:
            UserDefaults.standard.set(5, forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound)
        case 19:
            UserDefaults.standard.set(6, forKey: Constants.userDefaultsKeys.prayerTimesSettingsNotificationSound)
        default:
            break
            
        }
        UserDefaults.standard.synchronize()
        self.reloadData()
    }
}

extension PrayerTimesViewController:UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 0:
            self.currentScreen = .prayerTimes
        case 1:
            self.currentScreen = .settings
        case 2:
            self.currentScreen = .adjustment
        default:
            break
        }
        self.tableView.reloadData()
        
    }
    
}
