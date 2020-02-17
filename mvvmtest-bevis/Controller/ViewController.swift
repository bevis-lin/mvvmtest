//
//  ViewController.swift
//  mvvmtest-bevis
//
//  Created by 林昆儀 on 2020/2/14.
//  Copyright © 2020 Digi96. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 65
        
        HubUserViewModel.fetchHubUsers(completion: { result in
            
            switch result{
            
            case .failure(let error):
                print ("failure", error)
            
            case .success(_):
                print ("data loaded")
               // self.tableView.reloadData()
                DispatchQueue.main.async{
                    self.tableView.reloadData() }
            }
            
        })
            
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            
            if let destinationViewController = segue.destination as? DetailViewController
            {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let index = indexPath.row
                // #2 - The ViewModel is the app's de facto data source.
                // The ViewModel data for the currently-selected table
                // view cell representing a Messier object is passed to
                // a detail view controller via a segue.
                destinationViewController.hubUserViewModel = hubUserViewModels[index]
                
            }
        }
        
    } // end func prepare

}

