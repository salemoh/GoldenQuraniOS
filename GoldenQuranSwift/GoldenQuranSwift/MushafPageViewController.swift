//
//  MushafPageViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/2/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class MushafPageViewController: UIViewController {
    
    
    var tapGesture:UITapGestureRecognizer?
    var pageManager:MushafPageManager = MushafPageManager()
    var pageScaleFactor:CGFloat = 0.0
    
    @IBOutlet weak var constraintImgIconLeft: NSLayoutConstraint!
    
    weak var mushafViewerVC:MushafViewerViewController?
    
    @IBOutlet weak var imgPageBackground: UIImageView!
    @IBOutlet weak var imgMushafPage: UIImageView!
    
    var pageNumber:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageManager.mushafPage = self
        pageManager.pageNumber = self.pageNumber
        
        // Do any additional setup after loading the view.
        
        if pageNumber%2 == 0 {
            imgPageBackground.image = MushafPageColorManager().getBackgroundImage(isLeft: true)
        } else {
            imgPageBackground.image = MushafPageColorManager().getBackgroundImage(isLeft: false)
        }
        
        self.imgMushafPage.isUserInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.pageTapped(_:)))
        self.imgMushafPage.addGestureRecognizer(tapGesture!)
    }

    func preparNotifiersObservers(){
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.refreshPageImageSize()
        self.refreshTopIcons()
        self.removeHighlights(forType: nil)
        if UserDefaults.standard.bool(forKey: Constants.userDefaultsKeys.highlightMushafByTopicsEnabled) {
            pageManager.drawMushafTopics()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @IBAction func showSideMenuPressed(){
        self.mushafViewerVC?.showFeaturesSideMenu()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- Repostion top icons 
    func refreshTopIcons(){
        let viewSize = self.view.frame.size
        self.constraintImgIconLeft.constant = 0.04 * viewSize.width
    }
    
    //MARK:- Resize page image
    func refreshPageImageSize()  {
        
        let pageImg = Mus7afManager.shared.currentMus7af.getImageForPage(pageNumber: pageNumber)
        
        let pageImgSize = pageImg.size
        let viewSize = self.view.frame.size
        let horizontalPadding = CGFloat(0.05 * viewSize.width)  /// Left + Right
        let topPadding = 50.0
        let bottomPadding = 25.0
        let verticalPadding = CGFloat(topPadding + bottomPadding )
        
        let allowedSize = CGSize(width: viewSize.width - horizontalPadding , height:viewSize.height - verticalPadding)
        
        let verticalReducePercentage =  allowedSize.width / pageImgSize.width
        let horizontalReducePercentage =  allowedSize.height / pageImgSize.height
        
        
        var scaleFactor:CGFloat = 0.0
        
        if verticalReducePercentage < horizontalReducePercentage {
            //// reduce for vertical
            scaleFactor = verticalReducePercentage
        } else {
            //// reduce for horizontal
            scaleFactor = horizontalReducePercentage
        }
        pageScaleFactor = scaleFactor
        
        let scaledFrame = CGRect(x:horizontalPadding / 2.0 , y:CGFloat(topPadding) , width: pageImgSize.width * scaleFactor , height: pageImgSize.height * scaleFactor)
        
        self.imgMushafPage.frame = scaledFrame
        
        self.imgMushafPage.image = pageImg
    }

    ///MARK:- TapGesture
    func pageTapped(_ sender: UITapGestureRecognizer)  {
        if sender.state == .ended {
            let touchLocation: CGPoint = sender.location(in: self.imgMushafPage)
            
            self.pageManager.handleUserTouchPoint(touchLocation: touchLocation)
        }
    }
}


/// Page manager function
extension MushafPageViewController{

    func drawHighlightRects(highlightRects: [HighlightRect] ,  highlightType:HighlightType , highlightColor:UIColor?) {
        
        for highlightRect in highlightRects {
            let x = CGFloat(highlightRect.x!) * pageScaleFactor
            let y = CGFloat(highlightRect.y!) * pageScaleFactor
            let width = CGFloat(highlightRect.width!) * pageScaleFactor
            let height = CGFloat(highlightRect.height!) * pageScaleFactor
            
            let highlightView = GQHighlightView(frame:CGRect(x:x, y: y, width: width, height:height ))
            highlightView.highlightType = highlightType
            
            if let _ = highlightColor {
                highlightView.backgroundColor = highlightColor!
            }
            self.imgMushafPage.addSubview(highlightView)
        }
        
    }
    
    func removeHighlights(forType:HighlightType?){
        for viw in self.imgMushafPage.subviews {
            if let highlightView = viw as? GQHighlightView {
                if let type = forType {
                    if highlightView.highlightType == type {
                        viw.removeFromSuperview()
                    }
                } else {
                    //remove all if type not presented
                    viw.removeFromSuperview()
                }
                
            }
        }
    }
    
}
