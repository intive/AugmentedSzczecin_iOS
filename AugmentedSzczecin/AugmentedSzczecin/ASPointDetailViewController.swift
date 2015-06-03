//
//  ASPointDetailViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 10.05.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import Social

class ASPointDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var detailInfoHolder: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images = [UIImage]()
    
    var POI: ASPOI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var shareButton = UIBarButtonItem(image: UIImage(named: "Share"), style: .Plain, target: self, action: Selector("share"))
        shareButton.tintColor = UIColor.blackAugmentedColor()
        var backButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: Selector("popViewController"))

        self.navigationItem.rightBarButtonItem = shareButton
        self.navigationItem.leftBarButtonItem = backButton
        
        //Mocking images
        if (images.count == 0) {
            images.append(UIImage(named: "SzczecinNight")!)
            images.append(UIImage(named: "SzczecinNight2")!)
            images.append(UIImage(named: "SzczecinNight")!)
            images.append(UIImage(named: "SzczecinNight2")!)
        }
        
        if (POI != nil) {
            descriptionTextView.text = POI?.description
            nameLabel.text = POI?.name
            categoryLabel.text = POI?.tag
        }
        
        
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.scrollView.frame.height)

        let scrollViewWidth: CGFloat = self.scrollView.frame.width
        let scrollViewHeight: CGFloat = self.scrollView.frame.height
        
        for index in 0...images.count-1 {
           var img = UIImageView(frame: CGRectMake(scrollViewWidth * CGFloat(index), 0, scrollViewWidth, scrollViewHeight))
            img.image = images[index ]
            img.contentMode = UIViewContentMode.ScaleToFill
            self.scrollView.addSubview(img)
        }
        
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * CGFloat(images.count), self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
        detailInfoHolder.backgroundColor = UIColor.dodgerBlueAugmentedColor()
        nameLabel.textColor = UIColor.whiteAugmentedColor()
        categoryLabel.textColor = UIColor.whiteAugmentedColor()
        
        
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView){

        var pageWidth: CGFloat = CGRectGetWidth(scrollView.frame)
        var currentPage: CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1

        self.pageControl.currentPage = Int(currentPage);

    }
    
    func share() {
        var image: UIImage = images.first!
        let activity = UIActivityViewController(activityItems: ["My POI in AugmentedSzczecin", image], applicationActivities: nil)
        activity.excludedActivityTypes = [
            UIActivityTypePostToFlickr,
            UIActivityTypePostToWeibo,
            UIActivityTypeMessage,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo,
            UIActivityTypeAirDrop,
            UIActivityTypePrint,
            UIActivityTypeMail,
            UIActivityTypeCopyToPasteboard
        ]
        self.presentViewController(activity, animated: true, completion: nil)
    }
    
    func popViewController() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}