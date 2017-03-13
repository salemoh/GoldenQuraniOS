//
//  SideMenuViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/11/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupSideMenu()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showFeaturesSideMenu(){
        if UIApplication.isAr() {
            self.performSegue(withIdentifier: "toFeaturesRight", sender: nil)
        } else {
            self.performSegue(withIdentifier: "toFeaturesLeft", sender: nil)
        }
//        self.performSegue(withIdentifier: "toFeatures", sender: nil)
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        
        let featuresLeftVC = storyboard!.instantiateViewController(withIdentifier: "MushafFeaturesLeftNavigationViewController") as? UISideMenuNavigationController
        
        
        let featuresRightVC = storyboard!.instantiateViewController(withIdentifier: "MushafFeaturesRightNavigationViewController") as? UISideMenuNavigationController
        
        
        SideMenuManager.menuRightNavigationController = featuresRightVC
        SideMenuManager.menuLeftNavigationController = featuresLeftVC
        
        
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
//        setMenuDefaults()
        
        // Set up a cool background image for demo purposes
//        SideMenuManager.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "GoldenIcon")!)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setMenuDefaults(){
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAnimationFadeStrength = 0.4
        SideMenuManager.menuWidth = UIScreen.main.bounds.width * 0.7
        SideMenuManager.menuAnimationTransformScaleFactor = 0.95
    }
    
//    fileprivate func setDefaults() {
//        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .menuDissolveIn]
//        presentModeSegmentedControl.selectedSegmentIndex = modes.index(of: SideMenuManager.menuPresentMode)!
//        
//        let styles:[UIBlurEffectStyle] = [.dark, .light, .extraLight]
//        if let menuBlurEffectStyle = SideMenuManager.menuBlurEffectStyle {
//            blurSegmentControl.selectedSegmentIndex = styles.index(of: menuBlurEffectStyle) ?? 0
//        } else {
//            blurSegmentControl.selectedSegmentIndex = 0
//        }
//        
//        darknessSlider.value = Float(SideMenuManager.menuAnimationFadeStrength)
//        shadowOpacitySlider.value = Float(SideMenuManager.menuShadowOpacity)
//        shrinkFactorSlider.value = Float(SideMenuManager.menuAnimationTransformScaleFactor)
//        screenWidthSlider.value = Float(SideMenuManager.menuWidth / view.frame.width)
//        blackOutStatusBar.isOn = SideMenuManager.menuFadeStatusBar
//    }
//    
//    @IBAction fileprivate func changeSegment(_ segmentControl: UISegmentedControl) {
//        switch segmentControl {
//        case presentModeSegmentedControl:
//            let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .viewSlideInOut, .menuDissolveIn]
//            SideMenuManager.menuPresentMode = modes[segmentControl.selectedSegmentIndex]
//        case blurSegmentControl:
//            if segmentControl.selectedSegmentIndex == 0 {
//                SideMenuManager.menuBlurEffectStyle = nil
//            } else {
//                let styles:[UIBlurEffectStyle] = [.dark, .light, .extraLight]
//                SideMenuManager.menuBlurEffectStyle = styles[segmentControl.selectedSegmentIndex - 1]
//            }
//        default: break;
//        }
//    }
//    
//    @IBAction fileprivate func changeSlider(_ slider: UISlider) {
//        switch slider {
//        case darknessSlider:
//            SideMenuManager.menuAnimationFadeStrength = CGFloat(slider.value)
//        case shadowOpacitySlider:
//            SideMenuManager.menuShadowOpacity = slider.value
//        case shrinkFactorSlider:
//            SideMenuManager.menuAnimationTransformScaleFactor = CGFloat(slider.value)
//        case screenWidthSlider:
//            SideMenuManager.menuWidth = view.frame.width * CGFloat(slider.value)
//        default: break;
//        }
//    }
//    
//    @IBAction fileprivate func changeSwitch(_ switchControl: UISwitch) {
//        SideMenuManager.menuFadeStatusBar = switchControl.isOn
//    }

}
