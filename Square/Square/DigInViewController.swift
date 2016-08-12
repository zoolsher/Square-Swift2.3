//
//  DigInViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/8.
//  Copyright © 2016年 SquareCom. All rights reserved.
//

import UIKit

import Alamofire

import EZLoadingActivity

import NVActivityIndicatorView

class DigInViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CHTCollectionViewDelegateWaterfallLayout,UISearchBarDelegate,NVActivityIndicatorViewable {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var reuseID = "_diginCollectionViewCell"
    
    var arr = []
    
    var beforeLoadArr = [
        ["image":"http://file.ynet.com/2/1608/08/11571400.jpg"],
        ["image":"http://file.ynet.com/2/1608/08/11571402.jpg"],
        ["image":"http://file.ynet.com/2/1608/08/11571401.jpg"],
        ["image":"http://file.ynet.com/2/1608/08/11571403.jpg"]
    ]
    
    var imageArr:[String:UIImage] = [String:UIImage]()
    
    var collectionViewLayout = DigInCollectionViewLayout()
    var cellWidth : CGFloat? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cellWidth = collectionView.frame.width/2;
        initCollectionView()
        initLoadingImages()
        searchBar.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    func initCollectionView(){
        collectionViewLayout.minimumColumnSpacing = 1.0
        collectionViewLayout.minimumInteritemSpacing = 1.0
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight]
        
        self.collectionView.collectionViewLayout = self.collectionViewLayout
        self.collectionView.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let viewNib = UINib(nibName: "DigInCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(viewNib, forCellWithReuseIdentifier: reuseID)
//        self.collectionView.registerClass(DigInCollectionViewCell.self, forCellWithReuseIdentifier: reuseID)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let workBoardViewCon = self.storyboard?.instantiateViewControllerWithIdentifier("WorkBoard") as? WorkBoardViewController
        self.showViewController(workBoardViewCon!, sender: nil)
    }
    
    // MARK: DATASOURCE
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as? DigInCollectionViewCell
        cell!.backgroundColor = UIColor.purpleColor()
        cell?.loadImage(self.imageArr[self.arr[indexPath.row]["image"]! as! String]!)
        return cell!;
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // create a cell size from the image size, and return the size
        let imageURL = self.arr[indexPath.row]["image"]!
        
        let imageSize = self.imageArr[imageURL as! String]!.size
        
        return imageSize
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchImage(url:NSURL,res:(UIImage)->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            Alamofire.request(.GET, url)
                .responseImage { (response) in
                    debugPrint(response)
                    dispatch_async(dispatch_get_main_queue()){
                        if let img = response.result.value {
                            res(img)
                        }
                    }
            }
        }
    }

    func initLoadingImages(){
        self.activityStart()
        for index in 0..<beforeLoadArr.count {
            let url = NSURL(string:beforeLoadArr[index]["image"]! as String)
            fetchImage(url!, res: { (img) in
                self.imageArr[self.beforeLoadArr[index]["image"]! as String] = img
                if(self.imageArr.count >= self.beforeLoadArr.count){
                    self.loadFinish()
                    self.activityEnd()
                }
            })
        }
    }
    func loadFinish(){
        self.arr = self.beforeLoadArr
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let text = searchBar.text
        if(text == nil){
            return
        }else{
            searchBar.resignFirstResponder()
            self.arr = []
            
            self.collectionView.reloadData()
            //get json from network and put into the beforeArr
            
            self.initLoadingImages()
        }
    }
    
    func activityStart(){
        
        self.startActivityAnimating(self.view.bounds.size, message: "logining...", type: NVActivityIndicatorType.BallTrianglePath, color: UIColor.whiteColor(), padding: 125)
    }
    
    func activityEnd(){
        self.stopActivityAnimating()
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

