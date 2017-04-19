//
//  AudioPlayerToolsViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 4/18/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

enum AudioPlayerToolsCells:String{
    case pickSora = "PickSora"
}

class AudioPlayerToolsViewController: UIViewController {

    var cells:[AudioPlayerToolsCells] = [AudioPlayerToolsCells]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cells.append(.pickSora)
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


//AudioPlayerToolsPickSoraTableViewCell
extension AudioPlayerToolsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch cells[indexPath.row] {
        case .pickSora:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AudioPlayerToolsPickSoraTableViewCell") as! AudioPlayerToolsPickSoraTableViewCell
            
            cell.pickerView.delegate = self
            cell.pickerView.dataSource = self
            
            cell.pickerView.font = FontManager.fontWithSize(size: 16.0)
            cell.pickerView.highlightedFont = FontManager.fontWithSize(size: 16.0 , isBold: true)
            cell.pickerView.pickerViewStyle = .wheel
            cell.pickerView.maskDisabled = false
            cell.pickerView.textColor = Constants.color.GQBrown
            cell.pickerView.reloadData()
            
//            DispatchQueue.main.async {
//                cell.pickerView.scrollToItem(5)
//            }
            return cell
        default:
            break
        }
    }

    
}

extension AudioPlayerToolsViewController: AKPickerViewDelegate  {
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int){
    
    }
    
    func pickerView(_ pickerView: AKPickerView, marginForItem item: Int) -> CGSize{
        return CGSize(width:20 , height:40)
    }
    
    func pickerView(_ pickerView: AKPickerView, configureLabel label: UILabel, forItem item: Int){
    
    }
}

extension AudioPlayerToolsViewController: AKPickerViewDataSource {
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return ""
    }
    
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage()
    }
    
}
