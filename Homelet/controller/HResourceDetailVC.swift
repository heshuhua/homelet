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
    
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resourceImage.image = UIImage(named:imageName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
