//
//  MushafListViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 3/6/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit


class MushafListViewController: UIViewController   {

    @IBOutlet weak var mushafListTableView:UITableView!
    let userMushafs = Mus7afManager.shared.userMushafs()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mushafListTableView.reloadData()
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
extension MushafListViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userMushafs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mushafObject = userMushafs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MushafListTableViewCell") as! MushafListTableViewCell
        
        cell.fillFromMushaf(mushaf: mushafObject)
        
        return cell
    }

}

extension MushafListViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mushafObject = userMushafs[indexPath.row]
        Mus7afManager.shared.currentMus7af = mushafObject
        Mus7afManager.shared.saveCurrentMushaf()
        //FIXME:- temp
        UIApplication.shared.windows[0].rootViewController = Constants.storyboard.mushaf.instantiateInitialViewController()
    }
    
}
