//
//  FeedCollectionViewCell.swift
//  Facebook
//
//  Created by Mihail Șalari on 6/13/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

//var imageCache = [String: UIImage]()
//var imageCache = NSCache()
//
//
//
//if let statusImageUrl = post?.statusImageURL {
//    
//    if let image = imageCache.objectForKey(statusImageUrl) as? UIImage {
//        statusImageView.image = image
//        
//    } else {
//        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: statusImageUrl)!, completionHandler: { (data, response, error) in
//            if error != nil {
//                print(error)
//            }
//            
//            let image = UIImage(data: data!)
//            imageCache.setObject(image!, forKey: self.statusImageView)
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                self.statusImageView.image = image
//                self.loader.stopAnimating()
//            })
//            
//            
//        }).resume()
//    }
//}



//if let statusImageUrl = post?.statusImageURL {
//    
//    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: statusImageUrl)!, completionHandler: { (data, response, error) in
//        if error != nil {
//            print(error)
//        }
//        
//        let image = UIImage(data: data!)
//        
//        dispatch_async(dispatch_get_main_queue(), {
//            self.statusImageView.image = image
//            self.loader.stopAnimating()
//        })
//        
//        
//    }).resume()
//}



class FeedCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    
    var feedViewController: FeedViewController?
    
    var post: Post? {
        didSet {
            if let name = post?.name {
                
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)])
                
                if let city = post?.location?.city, state = post?.location?.state {
                    attributedText.appendAttributedString(NSAttributedString(string: "\n\(city), \(state)  •  ", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName:
                        UIColor.rgb(155, green: 161, blue: 161, alpha: 1)]))
                    
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 4
                    
                    attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                    
                    let attachment = NSTextAttachment()
                    attachment.image = UIImage(named: "globe_small")
                    attachment.bounds = CGRectMake(0, -2, 12, 12)
                    attributedText.appendAttributedString(NSAttributedString(attachment: attachment))
                }
                
                nameLabel.attributedText = attributedText
                
            }
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let profileImagename = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImagename)
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }
            
            if let numLikes = post?.numLikes, numComments = post?.numComments {
                likesCommentsLabel.text = "\(numLikes) Likes  \(numComments) Comments"
            }
        }
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    
    let profileImageView = UIImageView.createImageView("wwdc16-schedule-kickoff")
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Big. Bold. Beautiful."
        textView.font = UIFont.systemFontOfSize(12)
        textView.scrollEnabled = false
        
        return textView
    }()
    
    let statusImageView: UIImageView =  {
        let imageView = UIImageView.createImageView("iOS10")
        imageView.userInteractionEnabled = true
        imageView.contentMode = .ScaleAspectFit
        
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "578 Likes    21.5K Comments"
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.lightGrayFacebookFeatureColor()
        
        return label
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.dividerFacebookFeatureColor()
        
        return view
    }()
    
    
    let likeButton = UIButton.createButtonWithImage(withTitle: "Like",
                                                    imageName: "like",
                                                    titleColor: UIColor.lightGrayFacebookFeatureColor(),
                                                    tintColor: UIColor.lightGrayFacebookFeatureColor(),
                                                    withFont: UIFont.boldSystemFontOfSize(14))
    
    let commentButton = UIButton.createButtonWithImage(withTitle: "Comment",
                                                       imageName: "comment",
                                                       titleColor: UIColor.lightGrayFacebookFeatureColor(),
                                                       tintColor: UIColor.lightGrayFacebookFeatureColor(),
                                                       withFont: UIFont.boldSystemFontOfSize(14))
    
    let shareButton = UIButton.createButtonWithImage(withTitle: "Share",
                                                     imageName: "share",
                                                     titleColor: UIColor.lightGrayFacebookFeatureColor(),
                                                     tintColor: UIColor.lightGrayFacebookFeatureColor(),
                                                     withFont: UIFont.boldSystemFontOfSize(14))
    
    override func setupViews() {
        backgroundColor =  UIColor.whiteColor()
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLine)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: statusImageView)
        
        addConstraintsWithFormat("H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat("H:|-12-[v0]|", views: likesCommentsLabel)
        
        addConstraintsWithFormat("H:|-2-[v0]-12-|", views: dividerLine)
        
        
        //
        addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        
        
        
        addConstraintsWithFormat("V:|-12-[v0]", views: nameLabel)
        
        addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.7)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLine, likeButton)
        
        
        addConstraintsWithFormat("V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat("V:[v0(44)]|", views: shareButton)
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateStatusImageView)))

        
        
    }
    
    
    
    func animateStatusImageView() {
        feedViewController?.animateImageView(statusImageView)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
