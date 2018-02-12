//
//  HResourceDetailVC.swift
//  Homelet
//
//  Created by heshuhua on 2018/2/8.
//  Copyright © 2018年 heshuhua. All rights reserved.
//

import UIKit

class HResourceDetailVC: UIViewController {

    @IBOutlet weak var resourceImage: UIImageView!
    
    var resource : HMResourceMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let resourceImagedata = resource.image {
            resourceImage.image = UIImage(data :resourceImagedata as Data)
        }
        
//        resourceImage.image = UIImage(named:imageName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
