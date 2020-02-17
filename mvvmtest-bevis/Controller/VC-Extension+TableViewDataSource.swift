import Foundation
 
import UIKit
 
// MARK: - UITableView Data Source
 
extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hubUserViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        // #1 - The ViewModel is the app's de facto data source.
        //tableViewCell?.imageView?.image = UIImage(named: hubUserViewModels[indexPath.row].thumbnail)
        //tableViewCell?.textLabel?.text = messierViewModel[indexPath.row].formalName
        //tableViewCell?.detailTextLabel?.text = messierViewModel[indexPath.row].commonName
        
        tableViewCell?.imageView?.layer.cornerRadius = (tableViewCell?.imageView?.frame.size.width)! / 2
        tableViewCell?.imageView?.clipsToBounds = true
        
        
        
        
        
        tableViewCell?.textLabel?.text = hubUserViewModels[indexPath.row].userName
        tableViewCell?.imageView?.image = hubUserViewModels[indexPath.row].avatarImage
        
        return tableViewCell!
    }
    
}
