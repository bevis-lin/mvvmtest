import Foundation
 
import UIKit
 
// MARK: - UITableView Delegate
 
extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "DetailSegue", sender: indexPath.row)
    }
    
}
