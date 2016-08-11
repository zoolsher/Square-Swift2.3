//
//  ProfileEditViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/11.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit
import Eureka
import EZLoadingActivity

class ProfileEditViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initForm()
        self.title = "Edit"
        self.view.backgroundColor = UIColor(red:0.11, green:0.11, blue:0.11, alpha:1.00)
        initRightButton()
    }
    
    func initRightButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: #selector(ProfileEditViewController.save(_:)))
    }
    
    func save(sender:AnyObject?){
        print(self.form.values())
        EZLoadingActivity.show("saving...", disableUI: false)
        EZLoadingActivity.hide(success: false, animated: true)
    }

    func initForm(){
        form +++ Section("Photo")
            <<< ImageRow(){
                row in
                row.title = "avator"
                row.tag = "avator"
            }
            <<< ImageRow(){
                row in
                row.title = "background"
                row.tag = "background"
            }
            +++ Section("info")
            <<< TextRow(){
                row in
                row.title = "username"
            }
            <<< TextRow(){
                row in
                row.title = "come from"
            }
        +++ Section("Describe yourself")
            <<< TextAreaRow(){
                row in
                row.title = "describe"
            }
        +++ Section("Action")
            <<< ButtonRow(){
                row in
                row.title = "Submit"
            }.onCellSelection({ (cell, row) in
                self.save(nil)
            })
            <<< ButtonRow(){
                row in
                row.baseCell.textLabel?.textColor = UIColor.redColor()
                row.title = "Cancel"
            }.onCellSelection({ (cell, row) in
                self.dismissViewControllerAnimated(true, completion: nil)
            })

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
