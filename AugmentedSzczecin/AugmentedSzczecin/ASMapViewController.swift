//
//  ASMainViewController.swift
//  AugmentedSzczecin
//
//  Created by Patronage on 16.03.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit
import CoreData

class ASMapViewController: BLSAugmentedViewController, BLSAugmentedViewControllerDelegate, MKMapViewDelegate, NSFetchedResultsControllerDelegate {
    
    var isConnectedToNetwork: Bool?
    var timer: NSTimer?
    var userLocation: MKUserLocation?
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var scaleLabel: UILabel!
    @IBOutlet weak var mapChoiceSegmentedControl: UISegmentedControl!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "ASPOI")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: ASData.sharedInstance.mainContext!,
            sectionNameKeyPath: "ASPOI.id",
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
        }()
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch (type) {
            
        case .Insert:
            //the implementation of inserting an object
            break;
        case .Delete:
            //the implementation of deleting an object
            break;
        case .Update:
            //the implementation of updating an object
            break;
        default:
            break;
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        isConnectedToNetwork = Reachability.isConnectedToNetwork()
        
        scaleLabel.backgroundColor = UIColor(hex: 0xb6b6b6, alpha: 1)
        scaleLabel.text = "500 m"
        scaleLabel.textColor = UIColor(hex: 0x212121, alpha: 1)
        
        resetTimer()
    }

    func augmentedViewController(augmentedViewController: BLSAugmentedViewController!, viewForAnnotation annotation: BLSAugmentedAnnotation!, forUserLocation location: CLLocation!, distance: CLLocationDistance) -> BLSAugmentedAnnotationView! {
        let annotationView = ASAnnotationView()
        
        if let annotation = annotation as? ASAnnotation {
            annotationView.addressLabel.text = annotation.title
            annotationView.distanceLabel.text = annotation.subtitle
        }
        
        return annotationView
    }
    
    @IBAction func homeButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func mapTypeChange(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            self.style = BLSAugmentedViewControllerStyle.Map
        } else if (sender.selectedSegmentIndex == 1) {
            self.style = BLSAugmentedViewControllerStyle.AR
        }
    }
    
    override func shouldAutorotate() -> Bool {
        if (self.style == BLSAugmentedViewControllerStyle.Map) {
            return (UIApplication.sharedApplication().statusBarOrientation != UIInterfaceOrientation.Portrait) ;
        } else {
            return true
        }
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        mapView.showsUserLocation = true
        mapView.scrollEnabled = true
        mapView.zoomEnabled = true
        self.userLocation = userLocation
    }
    
    func resetTimer() {
        self.timer?.invalidate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "setLocation", userInfo: nil, repeats: true)
    }
    
    func setLocation() {
        if let location = self.userLocation {
            self.setMapRegionWithTopLeftCoordinate(location.coordinate, andBottomRightCoordinate: location.coordinate, animated: false)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        resetTimer()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        resetTimer()
    }

    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        resetTimer()
    }
}