//
//  NewResourceControllerTableViewController.swift
//  Homelet
//
//  Created by heshuhua on 2018/2/12.
//  Copyright © 2018年 heshuhua. All rights reserved.
//

import UIKit
import CoreData

class NewResourceVC: UITableViewController,UITextFieldDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var resource : HMResourceMO!
    
    @IBOutlet weak var photoImageView:UIImageView!

    @IBOutlet weak var nameTextField: UITextField!
    {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var typeTextField: UITextField!
    {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    @IBOutlet weak var locationTextField: UITextField!
    {
        didSet {
            locationTextField.tag = 3
            locationTextField.delegate = self
        }
    }
    @IBOutlet weak var phoneTextField: UITextField!
    {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    @IBOutlet weak var remarkTextField: UITextField!
    {
        didSet {
            remarkTextField.tag = 5
            remarkTextField.delegate = self
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField = view.viewWithTag(textField.tag + 1){
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let photoSelectRequestController = UIAlertController(title: "", message: "请选择：", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "照相", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibAction = UIAlertAction(title: "相册", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            photoSelectRequestController.addAction(cameraAction)
            photoSelectRequestController.addAction(photoLibAction)
            
            present(photoSelectRequestController, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
            
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        {
            resource = HMResourceMO(context : appDelegate.persistentContainer.viewContext)
            
            resource.name = nameTextField.text
            resource.type = typeTextField.text
            resource.location = locationTextField.text
            resource.phone = phoneTextField.text
            resource.summary = remarkTextField.text
            
            if let resourceImage = photoImageView.image {
                resource.image = UIImagePNGRepresentation(resourceImage)
            }
            
            print("save data-----")
            appDelegate.saveContext()
            
            dismiss(animated: true, completion: nil)
        }
        
    }
}
