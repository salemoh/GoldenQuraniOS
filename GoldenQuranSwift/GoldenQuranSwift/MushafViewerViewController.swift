//
//  MushafViewerViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/1/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class MushafViewerViewController: SideMenuViewController  {

    @IBOutlet weak var scrollViewMain: UIScrollView!
    var pageController:UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options:nil)
        pageController!.delegate = self
        pageController!.dataSource = self
        pageController?.didMove(toParentViewController: self)
        pageController?.view.semanticContentAttribute = .forceRightToLeft
        pageController?.setViewControllers([self.mushafViewControllerForPage(page: 1)!], direction: .forward, animated: true, completion: nil)
        self.addChildViewController(pageController!)
        scrollViewMain.frame = self.view.frame
        scrollViewMain.addSubview(pageController!.view)
        pageController?.view.autoresizingMask = [.flexibleBottomMargin, .flexibleWidth,.flexibleHeight , .flexibleLeftMargin , .flexibleRightMargin , .flexibleTopMargin]
        pageController?.view.translatesAutoresizingMaskIntoConstraints = true
        pageController?.view.frame = scrollViewMain.frame
        
        //self.pageController?.view.backgroundColor = UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func mushafViewControllerForPage(page pageNumber:Int) -> MushafPageViewController? {
        if pageNumber <= Mus7afManager.shared.currentMus7af.numberOfPages! {
            let mushafVC = self.storyboard?.instantiateViewController(withIdentifier: "MushafPageViewController") as! MushafPageViewController
            mushafVC.pageNumber = pageNumber
            mushafVC.mushafViewerVC = self
            return mushafVC
        }
        
        return nil
    }

}

//MARK: Rotation Handling
extension MushafViewerViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            
//            coordinator.animate(alongsideTransition: { (ctx) in
//                
//            }, completion: { (ctx) in
//                let fullWidthPageSize = CGSize(width:UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.width * 1.8))
//                self.pageController?.view.frame = CGRect(origin:CGPoint.zero , size:fullWidthPageSize)
//                self.scrollViewMain.contentSize = fullWidthPageSize
//            })
            
            DispatchQueue.main.async {
                let fullWidthPageSize = CGSize(width:UIScreen.main.bounds.size.width, height: (UIScreen.main.bounds.size.width * 1.8))
                self.pageController?.view.frame = CGRect(origin:CGPoint.zero , size:fullWidthPageSize)
                self.scrollViewMain.contentSize = fullWidthPageSize
            }
            
        } else {
            print("Portrait")
            self.pageController?.view.frame = UIScreen.main.bounds
            
            self.scrollViewMain.contentSize = UIScreen.main.bounds.size
        }
        self.pageController?.view.setNeedsLayout()
    }


}

extension MushafViewerViewController:UIPageViewControllerDataSource {

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        let mushafPage = pageController?.viewControllers?[0] as! MushafPageViewController
        return self.mushafViewControllerForPage(page: mushafPage.pageNumber - 1)
    }
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        let mushafPage = pageController?.viewControllers?[0] as! MushafPageViewController
        return self.mushafViewControllerForPage(page: mushafPage.pageNumber + 1)
    }
    
}

extension MushafViewerViewController:UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation{
        return .max
    }

}


extension MushafViewerViewController:UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.pageController?.view
    }
}


