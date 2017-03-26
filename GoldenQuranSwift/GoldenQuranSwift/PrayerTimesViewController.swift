//
//  PrayerTimesViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/26/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import CoreLocation

class PrayerTimesViewController: UIViewController, LocationManagerDelegate {

    @IBOutlet weak var imgCompass: UIImageView!
    @IBOutlet weak var imgNeedle: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LocationManager.shared.delegate = self
        
        LocationManager.shared.startHeadingUpdating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocationManager.shared.stopUpdating()
    }
    
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
    
        UIView.animate(withDuration: 0.4) {
            self.imgNeedle.transform = needleTransform
        }
        
        UIView.animate(withDuration: 0.7) {
            self.imgCompass.transform = compassTransform
        }
        
    }
    
}
