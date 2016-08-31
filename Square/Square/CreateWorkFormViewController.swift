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
        self.title = "CreateWork"
        initRightButton()
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
            }
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
        // Do any additional setup after loading the view.
    }
    
    func initRightButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(rightButtonClicked(_:)))
        
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
