//
//  ASAddPlaceViewController.swift
//  AugmentedSzczecin
//
//  Created by Grzegorz Pawlowicz on 31.05.2015.
//  Copyright (c) 2015 BLStream. All rights reserved.
//

import UIKit

class ASAddPlaceViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = "Name".localized
        streetTextField.placeholder = "Street".localized
        zipCodeTextField.placeholder = "Zip Code".localized
        cityTextField.placeholder = "City".localized
        categoryTextField.placeholder = "Category".localized
        tagsTextField.placeholder = "Tags".localized
        
        
    }

    @IBAction func openCategoryPicker(sender: AnyObject) {
        self.performSegueWithIdentifier("showCategoryPickerSegue", sender: nil)
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
