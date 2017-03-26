//
//  MushafFeaturesViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/11/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

enum MushafFeaturesViewControllerCells:String {
    case topSummary = "TopCell"
    case prayerTimes = "PrayerTimes"
}

class MushafFeaturesViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tableView:UITableView!
    
    var cells = [MushafFeaturesViewControllerCells]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cells.append(.topSummary)
        cells.append(.prayerTimes)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MAARK:- TableView Datasource and Delegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cells.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        if cells[indexPath.row] == .topSummary {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell")
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconAndTitleCell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toPrayerTimes", sender: nil)
    }
}
