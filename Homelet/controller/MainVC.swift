//
//  ViewController.swift
//  Homelet
//
//  Created by heshuhua on 2018/2/7.
//  Copyright © 2018年 heshuhua. All rights reserved.
//

import UIKit

class MainVC: UIViewController ,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    var resources : [HResource] = [
        HResource(name: "friend", type: "beijing", location: "aa", phone: "aa", description: "aa", image: "abc"),
        HResource(name: "friend", type: "beijing", location: "aa", phone: "aa", description: "aa", image: "abc")
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInd = "ResourceCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellInd, for: indexPath) as! HResourceTableViewCell
        cell.resourceName.text = resources[indexPath.row].name
        cell.resourceImage.image = UIImage(named :resources[indexPath.row].image)
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResourceDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! HResourceDetailVC
                destVC.imageName = resources[indexPath.row].image
            }
        }
    }

}

