//
//  SettingsPageColorTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/4/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class SettingsPageColorTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: GQLabel!
    
    @IBOutlet weak var btnColorYellow: UIButton!
    @IBOutlet weak var btnColorGreen: UIButton!
    @IBOutlet weak var btnColorBlue: UIButton!
    @IBOutlet weak var btnColorWhite: UIButton!
    @IBOutlet weak var btnColorRed: UIButton!
    @IBOutlet weak var btnColorNight: UIButton!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        refreshSelectedColor()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func sendChangeColorNotifier(){
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.notifiers.pageColorChanged), object: nil)
    }
    
    @IBAction func nighPressed(_ sender: UIButton) {
        UserDefaults.standard.set(MushafPageColor.night.rawValue, forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor)
        UserDefaults.standard.synchronize()
        refreshSelectedColor()
        sendChangeColorNotifier()
    }
    @IBAction func redPressed(_ sender: UIButton) {
        UserDefaults.standard.set(MushafPageColor.red.rawValue, forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor)
        UserDefaults.standard.synchronize()
        refreshSelectedColor()
        sendChangeColorNotifier()
    }
    @IBAction func whitePressed(_ sender: UIButton) {
        UserDefaults.standard.set(MushafPageColor.white.rawValue, forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor)
        UserDefaults.standard.synchronize()
        refreshSelectedColor()
        sendChangeColorNotifier()
    }
    @IBAction func bluePressed(_ sender: UIButton) {
        UserDefaults.standard.set(MushafPageColor.blue.rawValue, forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor)
        UserDefaults.standard.synchronize()
        refreshSelectedColor()
        sendChangeColorNotifier()
    }
    @IBAction func greenPressed(_ sender: UIButton) {
        UserDefaults.standard.set(MushafPageColor.green.rawValue, forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor)
        UserDefaults.standard.synchronize()
        refreshSelectedColor()
        sendChangeColorNotifier()
    }
    @IBAction func yellowPressed(_ sender: UIButton) {
        UserDefaults.standard.set(MushafPageColor.yellow.rawValue, forKey: Constants.userDefaultsKeys.preferedPageBackgroundColor)
        UserDefaults.standard.synchronize()
        refreshSelectedColor()
        sendChangeColorNotifier()
    }
    
    func refreshSelectedColor()  {
        for btn in [btnColorRed , btnColorBlue , btnColorGreen , btnColorNight , btnColorWhite , btnColorYellow] {
            btn?.shadowColor = UIColor.darkGray
        }
        switch MushafPageColorManager.currentColor {
        case .blue:
            btnColorBlue.shadowColor = UIColor.orange
        case .red:
            btnColorRed.shadowColor = UIColor.orange
        case .green:
            btnColorGreen.shadowColor = UIColor.orange
        case .white:
            btnColorWhite.shadowColor = UIColor.orange
        case .night:
            btnColorNight.shadowColor = UIColor.orange
        default:
            btnColorYellow.shadowColor = UIColor.orange
        }
    }
    
}
