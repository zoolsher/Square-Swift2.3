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

class ProfileViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let collectionViewLayout = UICollectionViewFlowLayout()
    let userinfoReuse = "_userInfoProfileCollectionViewCell"
    let headerReuse = "_headerProfileCollectionReuseView"
    let workReuse = "_workProfileCollectionViewCell"
    
    var workData = [[String:String]]()
    var userInfo = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
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
        let testImage = "https://raw.githubusercontent.com/vsouza/awesome-ios/master/awesome_logo.png"
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
        // Do any additional setup after loading the view.
    }
    
    func initRightButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: #selector(ProfileViewController.rightButtonHandler(_:)));
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
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return workData.count
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
        default:
            return renderUserInfoCell(indexPath)
        }
        
    }
    
    func renderWorkCell(indexPath:NSIndexPath)->UICollectionViewCell{
        let workCell = collectionView.dequeueReusableCellWithReuseIdentifier(workReuse, forIndexPath: indexPath) as! WorkProfileCollectionViewCell
        let data = workData[indexPath.row]
        workCell.loadData(data["heart"]!, comment: data["comment"]!)
        fetchImage(NSURL(string:data["image"]!)!) { (image) in
            workCell.loadImage(image)
        }
        return workCell
    }
    
    func renderUserInfoCell(indexPath:NSIndexPath)->UICollectionViewCell{
        let userinfoCell = collectionView.dequeueReusableCellWithReuseIdentifier(userinfoReuse, forIndexPath: indexPath) as? UserInfoProfileCollectionViewCell
        userinfoCell?.loadData(userInfo["username"] ?? "", title: userInfo["title"] ?? "", info: userInfo["info"] ?? "", subscribe: userInfo["subscribe"] ?? "", follower: userInfo["follower"] ?? "", following: userInfo["following"] ?? "")
        fetchImage(NSURL(string:userInfo["avator"]!)!, res: { (image) in
            userinfoCell?.loadImage(image)
        })
        fetchImage(NSURL(string:userInfo["background"]!)!) { (image) in
            userinfoCell?.loadBackgroundImage(image)
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
            if indexPath.row == 1{
                return CGSize(width: (self.view.frame.width/2)-4,height:150)
            }
            return CGSize(width: (self.view.frame.width/2)-4,height:100)
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
            self.showViewController(VC!, sender: nil)
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
