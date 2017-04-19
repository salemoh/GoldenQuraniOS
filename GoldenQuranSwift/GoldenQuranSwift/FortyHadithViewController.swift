//
//  FortyHadithViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/17/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class FortyHadithViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var hadiths:[Hadith] = [Hadith]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        hadiths  = DBManager.shared.getHadithContent(withGroupId: 0)
        self.tableView.estimatedRowHeight = 50
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "viewHadith" {
            let indexPath = sender as! IndexPath
            let navigationController = segue.destination as! UINavigationController
            let rootViewController = navigationController.viewControllers[0] as! HadithViewerViewController
            
            rootViewController.hadiths = self.hadiths
            rootViewController.startViewerIndex = indexPath.row
        }
    }
 

}
//FortyHadithTableViewCell
extension FortyHadithViewController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "viewHadith", sender: indexPath)
        
    }
}

extension FortyHadithViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return hadiths.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FortyHadithTableViewCell") as! FortyHadithTableViewCell
        
        let hadith = hadiths[indexPath.row]
        cell.lblTitle.text = hadith.title
        
        
        cell.setNeedsLayout()
        return cell
    }
    
    
}
