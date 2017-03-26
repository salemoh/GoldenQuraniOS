//
//  LocationManager.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/26/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate {
    func locationManagerDidUpdateHeading(compassTransform: CGAffineTransform,needleTransform: CGAffineTransform)
}

class LocationManager: NSObject , CLLocationManagerDelegate {

    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    var kabahLocation:CLLocation?
    var distanceFromKabah : Double?
    var lastLocation:CLLocation?
    
    var delegate:LocationManagerDelegate?
    
    func stopUpdating() {
        self.locationManager.stopUpdatingHeading()
        self.locationManager.stopUpdatingLocation()
    }
    
    func startHeadingUpdating(){
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.fixHeadingForCurrentOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        kabahLocation = CLLocation(latitude: 21.422487 , longitude: 39.826206)
        if !CLLocationManager.headingAvailable() {
            return
        }
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingHeading()
        
    }
    
    func fixHeadingForCurrentOrientation(){
        
        switch UIDevice.current.orientation{
        case .portrait:
        
            self.locationManager.headingOrientation = CLDeviceOrientation.portrait
        case .portraitUpsideDown:
        
            self.locationManager.headingOrientation = CLDeviceOrientation.portrait
        case .landscapeLeft:
        
            self.locationManager.headingOrientation = CLDeviceOrientation.landscapeLeft
        case .landscapeRight:
        
            self.locationManager.headingOrientation = CLDeviceOrientation.landscapeRight
        default: break
        
        }
        
    }
    
    func startLocationUpdating(){
    
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func DegreesToRadians (value:Double) -> Double {
        return value * M_PI / 180.0
    }
    
    func RadiansToDegrees (value:Double) -> Double {
        return value * 180.0 / M_PI
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        
        guard let userLocation = self.lastLocation else {
            return
        }
        
        let needleAngle = self.setLatLonForDistanceAndAngle(userlocation: userLocation)
        let needleDirection   = -newHeading.trueHeading;
        let compassDirection  = -newHeading.magneticHeading;
        
        //you Need to Multiply With M_PI
        
        let needleTransform = CGAffineTransform(rotationAngle: CGFloat(((Double(needleDirection) * M_PI) / 180.0) + needleAngle))
        
        print("Needle \(CGAffineTransform(rotationAngle: CGFloat(((Double(needleDirection) * M_PI) / 180.0) + needleAngle)))")
        let compossTransform = CGAffineTransform(rotationAngle: CGFloat((Double(compassDirection) * M_PI) / 180.0))
        print("composs \(CGAffineTransform(rotationAngle: CGFloat((Double(compassDirection) * M_PI) / 180.0)))")
        
        
        
        self.delegate?.locationManagerDidUpdateHeading(compassTransform: compossTransform , needleTransform: needleTransform)
        
    }
    
    
    
    func setLatLonForDistanceAndAngle(userlocation: CLLocation) -> Double
    {
        let lat1 = DegreesToRadians(value: userlocation.coordinate.latitude)
        let lon1 = DegreesToRadians(value: userlocation.coordinate.longitude)
        let lat2 = DegreesToRadians(value: kabahLocation!.coordinate.latitude)
        let lon2 = DegreesToRadians(value: kabahLocation!.coordinate.longitude)
        
        //distanceFromKabah = userlocation.distance(from: kabahLocation!)
        let dLon = lon2 - lon1;
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        var radiansBearing = atan2(y, x)
        if(radiansBearing < 0.0)
        {
            radiansBearing += 2*M_PI;
        }
        
        return radiansBearing
        
    }
    
    //MARK:- Location Manager Delegate
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
    
        guard let lastLocation = locations.last else {
            return
        }
        
        
        print("new location %@" , locations.last ?? "")
        //locationManager.stopUpdatingLocation()
        self.lastLocation = lastLocation
        PrayerTimesManager().getPrayerTimes(forLocation: lastLocation)
        
    }
    
    
    
    /*
     *  locationManagerShouldDisplayHeadingCalibration:
     *
     *  Discussion:
     *    Invoked when a new heading is available. Return YES to display heading calibration info. The display
     *    will remain until heading is calibrated, unless dismissed early via dismissHeadingCalibrationDisplay.
     */
    
    public func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    
    
    /*
     *  locationManager:didFailWithError:
     *
     *  Discussion:
     *    Invoked when an error has occurred. Error types are defined in "CLError.h".
     */
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
        print("Location manager failed")
    }
    
    
    
}
