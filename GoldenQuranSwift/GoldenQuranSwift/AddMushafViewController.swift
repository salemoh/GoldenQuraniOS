//
//  AddMus7afViewController.swift
//  GoldenQuranSwift
//
//  Created by Omar Fraiwan on 2/21/17.
//  Copyright © 2017 Omar Fraiwan. All rights reserved.
//

import UIKit

class AddMushafViewController: UIViewController  {

    @IBOutlet weak var mushafListCollectionView: UICollectionView!
    
    let defaultMus7afArray = DBManager.shared.getDefaultMus7afs()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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

//MARK: Collection View Delegate
extension AddMushafViewController:UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let addMushafNameVC = self.storyboard?.instantiateViewController(withIdentifier: "AddMushafNameViewController") as! AddMushafNameViewController
        addMushafNameVC.modalPresentationStyle = .custom
        addMushafNameVC.defaultMushaf = defaultMus7afArray?[indexPath.row]
        addMushafNameVC.delegate = self
        self.present(addMushafNameVC, animated: true, completion: nil)
        
//      let storyboard = UIStoryboard(name:"Mushaf" , bundle: nil)
//        let mushafViewer = storyboard.instantiateViewController(withIdentifier: "MushafViewerViewController")
//        Mus7afManager.shared.currentMus7af = defaultMus7afArray![indexPath.row]
//        self.present(mushafViewer, animated: true, completion: nil)
        
    }
}

extension AddMushafViewController:AddMushafNameViewControllerDelegate{
    func mushafAddedSuccessfully() {
        let mushafList = self.storyboard?.instantiateViewController(withIdentifier: "MushafListViewController") as! MushafListViewController
        self.present(mushafList, animated: true, completion: nil)
    }
}
//MARK: Collection View DataSource
extension AddMushafViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let mus7afArray = defaultMus7afArray{
            return mus7afArray.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddMushafCollectionViewCell", for: indexPath) as! AddMus7afCollectionViewCell
        let mushaf = defaultMus7afArray?[indexPath.row]
        
        cell.lblMushafName.text = mushaf?.name
        
        
        let pagesAttributedText = NSMutableAttributedString().getAttributedString(originalString: "Number of pages \((mushaf?.numberOfPages)!)", stringToAttribute: "\((mushaf?.numberOfPages)!)", font: nil, isUnderlined: true, color: UIColor.green)
        cell.lblNumberOfPages.attributedText = pagesAttributedText
        
        
        return cell
    }
    
}

//MARK: Collection View FlowLayoutDelegate
extension AddMushafViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:collectionView.frame.size.width, height:140)
    
    }
    
}
