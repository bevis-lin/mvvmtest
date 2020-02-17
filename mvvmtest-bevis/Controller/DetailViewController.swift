//
//  DetailViewController.swift
//  mvvmtest-bevis
//
//  Created by 林昆儀 on 2020/2/14.
//  Copyright © 2020 Digi96. All rights reserved.
//

import UIKit

class DetailViewController:UIViewController {
    
    var hubUserViewModel: HubUserViewModel?
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLoginName: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbBlogURL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        hubUserViewModel?.getDetailData(completion: { result in
             switch result{
                       
                case .failure(let error):
                    print ("failure", error)
                       
                case .success(_):
                    print ("detaul data loaded")
                    DispatchQueue.main.async{
                    
                        self.avatarImage.image = self.hubUserViewModel?.avatarImage
                        self.lbName.text = self.hubUserViewModel?.fullName
                        self.lbLoginName.text = self.hubUserViewModel?.userName
                        self.lbLocation.text = self.hubUserViewModel?.userLocation
                        self.lbBlogURL.text = self.hubUserViewModel?.userBlogURL
                        
                    }
            }
        })
        
        
    }

}
