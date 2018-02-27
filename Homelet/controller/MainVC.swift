//
//  ViewController.swift
//  Homelet
//
//  Created by heshuhua on 2018/2/7.
//  Copyright © 2018年 heshuhua. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController ,UITableViewDataSource,UITableViewDelegate ,NSFetchedResultsControllerDelegate ,UISearchResultsUpdating{
   
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController?
    
    var searchResult: [HMResourceMO] = []
    
    
    var fetchResultController : NSFetchedResultsController<HMResourceMO>!
    
    var resources : [HMResourceMO] = [
//        HMResourceMO(name: "friend", type: "beijing", location: "aa", phone: "aa", description: "aa", image: "abc"),
//        HMResourceMO(name: "friend", type: "beijing", location: "aa", phone: "aa", description: "aa", image: "abc")
//        
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController?.searchBar
        
        
        searchController?.searchResultsUpdater = self
        searchController?.dimsBackgroundDuringPresentation = false
        
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
        
        if (searchController?.isActive)! {
            return searchResult.count
        }
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInd = "ResourceCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellInd, for: indexPath) as! HResourceTableViewCell
        
        let resource = (searchController?.isActive)! ? searchResult[indexPath.row] : resources[indexPath.row]
        
        cell.resourceName.text = resource.name
        cell.resourceType.text = resource.type
        cell.resourceLocation.text = resource.location
        cell.resourcePhone.text = resource.phone
        cell.resourceRemark.text = resource.summary
        
        
        if let resourceImage = resource.image {
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
    
    
    func filterContent(for searchText: String)
    {
        searchResult = resources.filter({ (resource) -> Bool in
            if let name = resource.name {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            if let remark = resource.summary {
                let isMatch = remark.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            if let type = resource.type {
                let isMatch = type.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            if let location = resource.location {
                let isMatch = location.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
}

