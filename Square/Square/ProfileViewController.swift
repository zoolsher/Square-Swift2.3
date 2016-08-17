//
//  ProfileViewController.swift
//  Square
//
//  Created by zoolsher on 2016/8/10.
//  Copyright © 2016年 SquareCom. All rights reserved.
//



import UIKit
import RainbowNavigation
import Alamofire
import BSImagePicker
import Photos

private extension BSImagePickerViewController {
    func costumColor(){
        
    }
}

class ProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    let userinfoReuse = "_userInfoProfileCollectionViewCell"
    let headerReuse = "_headerProfileCollectionReuseView"
    let workReuse = "_workProfileCollectionViewCell"
    let stackReuse = "_stackProfileCollectionView"
    
    var isUserSelf:Bool = true
    var workData = [[String:String]]()
    var userInfo = [String:String]()
    var stackData = [[String:String]]()
    var subscribeData = [[String:String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        initCollectionView()
        initLeftButton()
        initRightButton()
        self.navigationController?.navigationBar.df_setBackgroundColor(UIColor.clearColor())
        self.userInfo = [
            "username":"J.Wong",
            "title":"CEO",
            "info":"I came from Amercian",
            "subscribe":"100",
            "follower":"10",
            "following":"100",
            "background":"http://d.haotu5.com/ga/images4/94/11/94115b4c6d8b53d1d888c44aa8bbf7d84da04fe4.jpg",
            "avator":"http://p3.wmpic.me/article/2015/03/18/1426649933_mafqzZLi.jpeg"
        ]
        let testImage = "http://img.sootuu.com/Exchange/2013-6/20136149264922032024.jpg"
        self.workData = [
            [
                "image":testImage,
                "heart":"100",
                "comment":"1000"
            ],
            [
                "image":testImage,
                "heart":"100",
                "comment":"1000"
            ],
            [
                "image":testImage,
                "heart":"100",
                "comment":"1000"
            ],
            [
                "image":testImage,
                "heart":"100",
                "comment":"1000"
            ],
        ]
        self.stackData = [
            [
                "image":testImage,
                "title":"likes by me",
            ],
            [
                "image":testImage,
                "title":"likes by me",
            ],
            [
                "image":testImage,
                "title":"likes by me",
            ],
            [
                "image":testImage,
                "title":"likes by me",
            ],
            [
                "image":testImage,
                "title":"likes by me",
            ],[
                "image":testImage,
                "title":"likes by me",
            ],
        ]
        self.subscribeData = [
            [
                "image":testImage,
                "title":"what is this",
            ],[
                "image":testImage,
                "title":"this is nothing",
            ],
        ]
        // Do any additional setup after loading the view.
    }
    
    func initRightButton(){
        if isUserSelf{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: #selector(ProfileViewController.rightButtonHandler(_:)));
        }else{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "following", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ProfileViewController.followAction(_:)))
        }
    }
    
    func followAction(sender:AnyObject?){
        let control = UIAlertController(title: "您要怎么处理这个人", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        control.addAction(UIAlertAction(title: "怒取关", style: UIAlertActionStyle.Default, handler: { (action) in
            print("取关")
        }));
        control.addAction(UIAlertAction(title:"再关注一会儿",style: UIAlertActionStyle.Cancel, handler: { (action) in
            print("goon")
        }))
        self.presentViewController(control, animated: true, completion: nil)
    }
    
    func initLeftButton(){
        if isUserSelf{
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(createWork(_:)))
        }else{
        
        }
    }
    
    func createWork(sender:AnyObject?){
        let vc = BSImagePickerViewController()
        UINavigationBar.appearance().tintColor = UIColor.redColor();
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            // User selected an asset.
                                            // Do something with it, start upload perhaps?
            }, deselect: { (asset: PHAsset) -> Void in
                // User deselected an assets.
                // Do something, cancel upload?
            }, cancel: { (assets: [PHAsset]) -> Void in
                // User cancelled. And this where the assets currently selected.
            }, finish: { (assets: [PHAsset]) -> Void in
                // User finished with these assets
            }, completion: {
                UINavigationBar.appearance().tintColor = UIColor.whiteColor();
        })
    }
    
    func rightButtonHandler(sender:AnyObject?){
        self.performSegueWithIdentifier("GoToProfileEdit", sender: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.df_reset()
    }
    
    func initCollectionView(){
        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.minimumInteritemSpacing = 5
        self.collectionView.collectionViewLayout = collectionViewLayout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.alwaysBounceVertical = true
        let userInfoNib = UINib(nibName: "UserInfoProfileCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(userInfoNib, forCellWithReuseIdentifier: userinfoReuse)
        let headerNib = UINib(nibName: "HeaderProfileCollectionReusableView",bundle: nil)
        self.collectionView.registerNib(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse)
        let workNib = UINib(nibName: "WorkProfileCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(workNib, forCellWithReuseIdentifier: workReuse)
        let stackNib = UINib(nibName: "StackProfileCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(stackNib, forCellWithReuseIdentifier: stackReuse)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return workData.count
        case 2:
            return stackData.count
        case 3:
            return subscribeData.count
        default :
            return 1;
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return renderUserInfoCell(indexPath)
        case 1:
            return renderWorkCell(indexPath)
        case 2:
            return renderStackCell(indexPath)
        case 3:
            return renderSubscribeCell(indexPath)
        default:
            return renderUserInfoCell(indexPath)
        }
        
    }
    
    func renderSubscribeCell(indexPath:NSIndexPath)->UICollectionViewCell{
        let stackCell = collectionView.dequeueReusableCellWithReuseIdentifier(stackReuse, forIndexPath: indexPath) as! StackProfileCollectionViewCell
        let data = subscribeData[indexPath.row]
        stackCell.loadData(data["title"]!)
        stackCell.stackImageView.af_setImageWithURL(NSURL(string:data["image"]!)!)
        return stackCell
    }
    
    func renderStackCell(indexPath:NSIndexPath) -> UICollectionViewCell{
        let stackCell = collectionView.dequeueReusableCellWithReuseIdentifier(stackReuse, forIndexPath: indexPath) as! StackProfileCollectionViewCell
        let data = stackData[indexPath.row]
        stackCell.loadData(data["title"]!)
        stackCell.stackImageView.af_setImageWithURL(NSURL(string:data["image"]!)!)
        return stackCell
    }
    
    func renderWorkCell(indexPath:NSIndexPath)->UICollectionViewCell{
        let workCell = collectionView.dequeueReusableCellWithReuseIdentifier(workReuse, forIndexPath: indexPath) as! WorkProfileCollectionViewCell
        let data = workData[indexPath.row]
        workCell.loadData(data["heart"]!, comment: data["comment"]!)
        workCell.workImageView.af_setImageWithURL(NSURL(string:data["image"]!)!)
        return workCell
    }
    
    func renderUserInfoCell(indexPath:NSIndexPath)->UICollectionViewCell{
        let userinfoCell = collectionView.dequeueReusableCellWithReuseIdentifier(userinfoReuse, forIndexPath: indexPath) as? UserInfoProfileCollectionViewCell
        userinfoCell?.loadData(userInfo["username"] ?? "", title: userInfo["title"] ?? "", info: userInfo["info"] ?? "", subscribe: userInfo["subscribe"] ?? "", follower: userInfo["follower"] ?? "", following: userInfo["following"] ?? "")

        userinfoCell?.userBackgroundImageView.af_setImageWithURL(NSURL(string:userInfo["background"]!)!)
        userinfoCell?.avator.af_setImageWithURL(NSURL(string:userInfo["avator"]!)!)
        userinfoCell?.clickAction = {
            self.performSegueWithIdentifier("GoToFollower", sender: nil)
        }
        return userinfoCell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var retSize = CGSize.zero
        switch section {
        case 0:
            break;
        default:
            retSize = CGSize(width: self.view.frame.width, height: 30)
        }
        
        return retSize
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            switch indexPath.section {
            case 0:
                fallthrough
            case 1:
                let retView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse, forIndexPath: indexPath) as? HeaderProfileCollectionReusableView
                retView?.loadData(" Work(\(workData.count))")
                return retView!
            case 2:
                let retView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse, forIndexPath: indexPath) as? HeaderProfileCollectionReusableView
                retView?.loadData(" Stack(\(stackData.count))")
                return retView!
            case 3:
                let retView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse, forIndexPath: indexPath) as? HeaderProfileCollectionReusableView
                retView?.loadData(" Subscribe(\(subscribeData.count))")
                return retView!
            default:
                let retView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuse, forIndexPath: indexPath) as? HeaderProfileCollectionReusableView
                retView?.loadData(" Work(\(workData.count))")
                return retView!
            }
    }
        
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // create a cell size from the image size, and return the size
        switch indexPath.section {
        case 0:
            return CGSize(width: self.view.frame.width ,height: 164);
        case 1:
            return CGSize(width: (self.view.frame.width/2)-4,height:100)
        case 2:
            fallthrough
        case 3:
            return CGSize(width: (self.view.frame.width/3)-6,height:100)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1:
            let VC = self.storyboard?.instantiateViewControllerWithIdentifier("WorkBoard")
            VC?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(VC!, animated: true)
//            self.showViewController(VC!, sender: nil)
            return
        default:
            return
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let themeColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
        
        let offsetY = scrollView.contentOffset.y
        if offsetY >= 0 {
            let height = 164
            let maxOffset = height-64
            
            var progress = (collectionView.contentOffset.y) / CGFloat(maxOffset)
            progress = min(progress, 1)
            
            self.navigationController?.navigationBar.df_setBackgroundColor(themeColor.colorWithAlphaComponent(progress))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.scrollViewDidScroll(UIScrollView())
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
}
