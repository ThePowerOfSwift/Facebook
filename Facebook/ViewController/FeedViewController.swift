//
//  ViewController.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/13/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    let zoomImageView = UIImageView()
    var statusImageView: UIImageView?
    let blackBackgroundView = UIView()
    let navigationBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    var posts = [Post]()
    
    
    
    // MARK: - LyfeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupViews()
        self.setupCache()
        
        if let path = NSBundle.mainBundle().pathForResource("all_posts", ofType: "json") {
            
            do {
                
                let data = try(NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe))
                
                let jsonDictionary = try(NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers))
                
                if let postsArray = jsonDictionary["posts"] as? [[String: AnyObject]] {
                    
                    self.posts = [Post]()
                    
                    for postDictionary in postsArray {
                        let post = Post()
                        post.setValuesForKeysWithDictionary(postDictionary)
                        self.posts.append(post)
                    }
                }
                
            } catch let err {
                print(err)
            }
        }
    }
    
    func setupViews() {
        navigationItem.title = "News Feed"
        
        self.collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.collectionView?.alwaysBounceVertical = true
        
        self.collectionView?.registerClass(FeedCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Storyboard.FacebookCellID)
    }
    
    func setupCache() {
        let memoryCapacity = 500 * 1024 * 1024 // 500mb
        let diskCapacity = 500 * 1024 * 1024 // 500mb
        let urlCache = NSURLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        NSURLCache.setSharedURLCache(urlCache)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.Storyboard.FacebookCellID, forIndexPath: indexPath) as! FeedCollectionViewCell
        
        feedCell.post = posts[indexPath.item]
        feedCell.feedViewController = self
        
        return feedCell
    }

    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText {
            
            let rect = NSString(string: statusText).boundingRectWithSize(CGSizeMake(view.frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
            
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSizeMake(view.frame.width, rect.height + knownHeight + 24)
        }
        
        return CGSizeMake(view.frame.width, 500)
    }
    
    
    // MARK: - animateImageView
    
    func animateImageView(statusImageView: UIImageView) {
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convertRect(statusImageView.frame, toView: nil) {
            
            statusImageView.alpha = 0.0
            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = UIColor.blackColor()
            blackBackgroundView.alpha = 0.0
            view.addSubview(blackBackgroundView)
            
            navigationBarCoverView.frame = CGRectMake(0, 0, 1000, 20 + 44)
            navigationBarCoverView.backgroundColor = UIColor.blackColor()
            navigationBarCoverView.alpha = 0.0
            
            
            if let keyWindow = UIApplication.sharedApplication().keyWindow {
                keyWindow.addSubview(navigationBarCoverView)
                
                tabBarCoverView.frame = CGRectMake(0, keyWindow.frame.height - 49, 1000, 49)
                tabBarCoverView.backgroundColor = UIColor.blackColor()
                tabBarCoverView.alpha = 0.0
                keyWindow.addSubview(tabBarCoverView)

            }
            
            
            zoomImageView.frame = startingFrame
            zoomImageView.userInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .ScaleAspectFit
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            
            UIView.animateWithDuration(0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .CurveEaseOut, animations: {
                //let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                //let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.center =  self.view.center //CGRectMake(0, y, self.view.frame.width, height)
                self.blackBackgroundView.alpha = 1
                self.navigationBarCoverView.alpha = 1.0
                self.tabBarCoverView.alpha = 1.0
                }, completion: nil)
            
            UIView.animateWithDuration(0.75, animations: { 
                
            })
        }
    }
    
    
    func zoomOut() {
        if let startingFrame = statusImageView!.superview?.convertRect(statusImageView!.frame, toView: nil) {
            
            UIView.animateWithDuration(0.75, animations: {
                
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0.0
                self.navigationBarCoverView.alpha = 0.0
                self.tabBarCoverView.alpha = 0.0
                
                }, completion: { (finished) in
                    
                    self.zoomImageView.removeFromSuperview()
                    self.blackBackgroundView.removeFromSuperview()
                    self.navigationBarCoverView.removeFromSuperview()
                    self.tabBarCoverView.removeFromSuperview()
                    
                    self.statusImageView?.alpha = 1.0

            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

