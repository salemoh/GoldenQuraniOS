//
//  RecitationsViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/10/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class RecitationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var recitations = [Recitation]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        recitations = orderedRecetations()
        self.tableView.reloadData()
        self.tableView.estimatedRowHeight = 50
        
        self.title = NSLocalizedString("SELECT_READER_TITLE", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func orderedRecetations() -> [Recitation] {
        let recitations = RecitationManager.getRecitations()
        var favRecitations = [Recitation]()
        var orderedRecitations = [Recitation]()
        
        for recitation in recitations {
            if RecitationManager.isFavouriteRecitation(recitation: recitation) {
                favRecitations.append(recitation)
            } else {
                orderedRecitations.append(recitation)
            }
        }
        
        orderedRecitations = favRecitations + orderedRecitations
        return orderedRecitations
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

extension RecitationsViewController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recitation = recitations[indexPath.row]
        RecitationManager.setActiveRecitation(recitation: recitation)
        tableView.reloadData()
    }
}

//RecitationsTableViewCell
extension RecitationsViewController:UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return recitations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecitationsTableViewCell") as! RecitationsTableViewCell
        
        let recitation = recitations[indexPath.row]
        cell.lblRecitationTitle.text = NSLocalizedString(recitation.name!, comment: "")
        cell.imgRecitation.image = recitation.image
        
        if RecitationManager.isActiveRecitation(recitation: recitation) {
            UIView.animate(withDuration: 0.5, animations: { 
                cell.contentView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            })
            
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        
        if RecitationManager.isFavouriteRecitation(recitation: recitation) {
            cell.btnFavourite.tintColor =  UIColor.orange
        } else {
            cell.btnFavourite.tintColor =  UIColor.groupTableViewBackground
        }
        
        cell.actionsHandler = { (currentCell:RecitationsTableViewCell) -> Void in
            
            if RecitationManager.isFavouriteRecitation(recitation: recitation) {
                RecitationManager.removeRecitationFromFavourite(recitation: recitation)
                currentCell.btnFavourite.tintColor = UIColor.groupTableViewBackground
            } else {
                RecitationManager.addRecitationToFavourite(recitation: recitation)
                currentCell.btnFavourite.tintColor =   UIColor.orange
            }
        }
            
        
        cell.setNeedsLayout()
        return cell
    }

    
}
