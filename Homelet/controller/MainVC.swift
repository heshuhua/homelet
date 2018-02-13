//
//  ViewController.swift
//  Homelet
//
//  Created by heshuhua on 2018/2/7.
//  Copyright © 2018年 heshuhua. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController ,UITableViewDataSource,UITableViewDelegate ,NSFetchedResultsControllerDelegate{
   
    @IBOutlet weak var tableView: UITableView!
    
    var fetchResultController : NSFetchedResultsController<HMResourceMO>!
    
    var resources : [HMResourceMO] = [
//        HMResourceMO(name: "friend", type: "beijing", location: "aa", phone: "aa", description: "aa", image: "abc"),
//        HMResourceMO(name: "friend", type: "beijing", location: "aa", phone: "aa", description: "aa", image: "abc")
//        
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest : NSFetchRequest<HMResourceMO> = HMResourceMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key : "name" , ascending : true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        {
            let context = appDelegate.persistentContainer.viewContext
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchObjects = fetchResultController.fetchedObjects {
                    resources = fetchObjects
                }
            } catch {
                print(error)
            }
        }
        
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
        cell.resourceType.text = resources[indexPath.row].type
        cell.resourceLocation.text = resources[indexPath.row].location
        cell.resourcePhone.text = resources[indexPath.row].phone
        cell.resourceRemark.text = resources[indexPath.row].summary
        
        
        if let resourceImage = resources[indexPath.row].image {
            cell.resourceImage.image = UIImage(data : resourceImage as Data)
            
        }
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResourceDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! HResourceDetailVC
                destVC.resource = resources[indexPath.row]
            }
        }
    }
    
    
    @IBAction func unwindToHome(segue :UIStoryboardSegue)
    {
        dismiss(animated: true, completion: nil)
    }

    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            resources = fetchedObjects as! [HMResourceMO]
        }
        
       
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { (action, sourceView, completionHandler) in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
            {
                let context = appDelegate.persistentContainer.viewContext
                let resourceToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(resourceToDelete)
                appDelegate.saveContext()
            }
            
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(named: "delete")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfiguration
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.hidesBarsOnSwipe = true
    }
    
}

