//
//  CreateWorkFormViewController.swift
//  Squarance
//
//  Created by zoolsher on 2016/8/31.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import Eureka
class CreateWorkFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.title = "Create Work"
        initRightButton()
        initLeftButton()
        
        ImageRow.defaultCellUpdate = { cell, row in
            cell.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.tintColor = .grayColor()
            cell.textLabel!.font = UIFont(name: "DINCOND-Regular", size: 16)!
        }
        
        TextRow.defaultCellUpdate = { cell, row in
            cell.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.tintColor = .grayColor()
            cell.textLabel!.font = UIFont(name: "DINCOND-Regular", size: 16)!
            cell.textField.textColor = .grayColor()
            cell.textField.font = UIFont(name: "DINCOND-Regular", size: 16)!
        }
        TextAreaRow.defaultCellUpdate = {cell,row in
            cell.textView.font = UIFont(name: "DINCOND-Regular", size: 16)!
            cell.textView.textColor = .grayColor()
            cell.textView.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
            cell.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
        }
        
        
        
        form
            +++ Section("")
            <<< ImageRow(){
                row in
                row.title = "Work Cover"
                
            }
            +++ Section("")
            <<< TextRow(){
                row in
                row.title = "Title"
            }.cellSetup({ (cell, row) in
                cell.backgroundColor = UIColor.blackColor()
                cell.detailTextLabel?.textColor = UIColor.grayColor()
                
            })
            <<< TextRow(){
                row in
                row.title = "Category"
            }
            <<< TextRow(){
                row in
                row.title = "Industry"
            }
            +++ Section("Introduction")
            <<< TextAreaRow(){
                row in
                row.title = "Introduction"
            }
        
        self.tableView?.backgroundColor = .blackColor()
        
        // Do any additional setup after loading the view.
    }
    
    func initRightButton(){

        
        let barButton = UIBarButtonItem(title: "\u{e642}", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(rightButtonClicked(_:)))
        barButton.setTitleTextAttributes([NSFontAttributeName:UIFont(name:"iconfont",size:18)!], forState: .Normal)
        
        self.navigationItem.rightBarButtonItem = barButton
        
        
        
    }
    
    func initLeftButton(){
        let barButton = UIBarButtonItem(title: "\u{e637}", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(leftButtonClicked(_:)))
        barButton.setTitleTextAttributes([NSFontAttributeName:UIFont(name:"iconfont",size:18)!], forState: .Normal)
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func leftButtonClicked(sender:AnyObject?){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func rightButtonClicked(sender:AnyObject){
        print("rightbuttonclicked")
        let dvc = self.storyboard?.instantiateViewControllerWithIdentifier("createWorkSelectPhotoViewController") as! CreateWorkSelectPhotoViewController
        self.showViewController(dvc, sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier!{
        case "goToSelectPhotos":
            let dvc = segue.destinationViewController as! CreateWorkSelectPhotoViewController
        default:
            let dvc = segue.destinationViewController as! CreateWorkSelectPhotoViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
