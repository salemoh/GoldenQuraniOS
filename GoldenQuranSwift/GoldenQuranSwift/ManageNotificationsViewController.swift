//
//  ManageNotificationsViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/9/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

enum ManageNotificationsViewControllerCell:String {
    case fridayNotification = "fridayNotification"
    case dailyNotification = "dailyNotification"
    case longTimeNotReading = "longTimeNotReading"
    case athanNotifications = "athanNotifications"
}

class ManageNotificationsViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!

    var cells = [ManageNotificationsViewControllerCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cells.append(.fridayNotification)
        cells.append(.dailyNotification)
        cells.append(.longTimeNotReading)
        cells.append(.athanNotifications)
        
        self.tableView.reloadData()
        self.tableView.estimatedRowHeight = 85
        
        self.title = NSLocalizedString("MANAGE_NOTIFICATIONS_TITLE", comment: "")
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

extension ManageNotificationsViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
}

extension ManageNotificationsViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageNotificationsTableViewCell") as! ManageNotificationsTableViewCell
        switch cells[indexPath.row] {
        case .fridayNotification:
            cell.lblTitle.text = NSLocalizedString("MANAGE_NOTIFICATION_FRIDAY_READING_TITLE", comment: "")
            cell.lblSubTitle.text = NSLocalizedString("MANAGE_NOTIFICATION_FRIDAY_READING_SUBTITLE", comment: "")
            cell.switchControl.isOn = !UserDefaults.standard.bool(forKey:Constants.userDefaultsKeys.notificationsFridayDisabled)
            cell.actionsHandler = {(isOn: Bool) -> Void in
                UserDefaults.standard.set(!isOn, forKey: Constants.userDefaultsKeys.notificationsFridayDisabled)
                UserDefaults.standard.synchronize()
            }
        
        case .dailyNotification:
            cell.lblTitle.text = NSLocalizedString("MANAGE_NOTIFICATION_DAILY_TITLE", comment: "")
            cell.lblSubTitle.text = NSLocalizedString("MANAGE_NOTIFICATION_DAILY_SUBTITLE", comment: "")
            cell.switchControl.isOn = !UserDefaults.standard.bool(forKey:Constants.userDefaultsKeys.notificationsDailyDisabled)
            cell.actionsHandler = {(isOn: Bool) -> Void in
                UserDefaults.standard.set(!isOn, forKey: Constants.userDefaultsKeys.notificationsDailyDisabled)
                UserDefaults.standard.synchronize()
            }
            
        case .longTimeNotReading:
            cell.lblTitle.text = NSLocalizedString("MANAGE_NOTIFICATION_LONG_TIME_TITLE", comment: "")
            cell.lblSubTitle.text = NSLocalizedString("MANAGE_NOTIFICATION_LONG_TIME_SUBTITLE", comment: "")
            cell.switchControl.isOn = !UserDefaults.standard.bool(forKey:Constants.userDefaultsKeys.notificationsLongTimeReadingDisabled)
            cell.actionsHandler = {(isOn: Bool) -> Void in
                UserDefaults.standard.set(!isOn, forKey: Constants.userDefaultsKeys.notificationsLongTimeReadingDisabled)
                UserDefaults.standard.synchronize()
            }
        case .athanNotifications:
            cell.lblTitle.text = NSLocalizedString("MANAGE_NOTIFICATION_ATHAN_TITLE", comment: "")
            cell.lblSubTitle.text = NSLocalizedString("MANAGE_NOTIFICATION_ATHAN_SUBTITLE", comment: "")
            cell.switchControl.isOn = !UserDefaults.standard.bool(forKey:Constants.userDefaultsKeys.notificationsAthanDisabled)
            cell.actionsHandler = {(isOn: Bool) -> Void in
                UserDefaults.standard.set(!isOn, forKey: Constants.userDefaultsKeys.notificationsAthanDisabled)
                UserDefaults.standard.synchronize()
            }
        
        }
        
        
        cell.setNeedsLayout()
        return cell
    }
    
    


}
