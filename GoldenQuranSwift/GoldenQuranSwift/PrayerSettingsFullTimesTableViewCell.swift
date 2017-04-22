//
//  PrayerSettingsFullTimesTableViewCell.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/27/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import Adhan

class PrayerSettingsFullTimesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFajrSeprator: UIImageView!
    @IBOutlet weak var lblFajr: GQLabel!
    @IBOutlet weak var lblFajrTime: GQLabel!
    
    @IBOutlet weak var imgDuhorSeprator: UIImageView!
    @IBOutlet weak var lblDuhor: GQLabel!
    @IBOutlet weak var lblDuhorTime: GQLabel!
    
    @IBOutlet weak var imgAsrSeprator: UIImageView!
    @IBOutlet weak var lblAsr: GQLabel!
    @IBOutlet weak var lblAsrTime: GQLabel!
    
    @IBOutlet weak var imgMagribSeprator: UIImageView!
    @IBOutlet weak var lblMagrib: GQLabel!
    @IBOutlet weak var lblMagribTime: GQLabel!
    
    @IBOutlet weak var imgIshaSeprator: UIImageView!
    @IBOutlet weak var lblIsha: GQLabel!
    @IBOutlet weak var lblIshaTime: GQLabel!
    
    
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected( _ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func fillWithPrayer(prayerTimes:PrayerTimes? ) {
        
        lblFajr.text = NSLocalizedString("FAJR_PRAY_TIME", comment: "")
        lblFajrTime.text = self.getFormattedPrayerTime(time: prayerTimes?.fajr)
        
        lblDuhor.text = NSLocalizedString("DOHOR_PRAY_TIME", comment: "")
        lblDuhorTime.text = self.getFormattedPrayerTime(time: prayerTimes?.dhuhr)
        
        lblAsr.text = NSLocalizedString("ASR_PRAY_TIME", comment: "")
        lblAsrTime.text = self.getFormattedPrayerTime(time: prayerTimes?.asr)
        
        
        lblMagrib.text = NSLocalizedString("MAGHRIB_PRAY_TIME", comment: "")
        lblMagribTime.text = self.getFormattedPrayerTime(time: prayerTimes?.maghrib)
        
        
        lblIsha.text = NSLocalizedString("ISHA_PRAY_TIME", comment: "")
        lblIshaTime.text = self.getFormattedPrayerTime(time: prayerTimes?.isha)
        
    }
    
    func getFormattedPrayerTime( time:Date?) -> String{
        if let prayerTime = time {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            formatter.timeZone = TimeZone.current
            return formatter.string(from: prayerTime)
        }
        return "--:--"
        
    }
}
