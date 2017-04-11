//
//  TafseerViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/11/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class TafseerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tafseers = [Tafseer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tafseers = orderedTafseers()
        
        self.tableView.reloadData()
        self.tableView.estimatedRowHeight = 50
        
        self.title = NSLocalizedString("SELECT_TAFSEER_TITLE", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func orderedTafseers() -> [Tafseer] {
        let tafseersArray = TafseerManager.getTafseers()
        var favTafseers = [Tafseer]()
        var orderedTafseers = [Tafseer]()
        
        for tafseer in tafseersArray {
            if TafseerManager.isFavouriteTafseer(tafseer: tafseer) {
                favTafseers.append(tafseer)
            } else {
                orderedTafseers.append(tafseer)
            }
        }
        
        orderedTafseers = favTafseers + orderedTafseers
        return orderedTafseers
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


extension TafseerViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tafseer = tafseers[indexPath.row]
        TafseerManager.setActiveTafseer(tafseer: tafseer)
        tableView.reloadData()
    }
}

//TafseerTableViewCell
extension TafseerViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tafseers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TafseerTableViewCell") as! TafseerTableViewCell
        
        let tafseer = tafseers[indexPath.row]
        cell.lblTafeerTitle.text = tafseer.name
        cell.lblTafeerAuther.text = tafseer.autherName! + " " + tafseer.dateOfDeath!
        
        if TafseerManager.isActiveTafseer(tafseer: tafseer) {
            UIView.animate(withDuration: 0.5, animations: {
                cell.contentView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            })
            
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        
        if TafseerManager.isFavouriteTafseer(tafseer: tafseer) {
            cell.btnFavourite.tintColor =  UIColor.orange
        } else {
            cell.btnFavourite.tintColor =  UIColor.groupTableViewBackground
        }
        
        cell.actionsHandler = { (currentCell:TafseerTableViewCell) -> Void in
            
            if TafseerManager.isFavouriteTafseer(tafseer: tafseer) {
                TafseerManager.removeTafseerFromFavourite(tafseer: tafseer)
                currentCell.btnFavourite.tintColor = UIColor.groupTableViewBackground
            } else {
                TafseerManager.addTafseerToFavourite(tafseer: tafseer)
                currentCell.btnFavourite.tintColor =   UIColor.orange
            }
        }
        
        
        cell.setNeedsLayout()
        return cell
    }
    
    
}

