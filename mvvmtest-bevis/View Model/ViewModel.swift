//
//  ViewModel.swift
//  mvvmtest-bevis
//
//  Created by 林昆儀 on 2020/2/14.
//  Copyright © 2020 Digi96. All rights reserved.
//

import Foundation

import UIKit

public typealias ImageDownloadCompletionClosure = (_ imageData: NSData ) -> Void

var hubUserViewModels: [HubUserViewModel] = []


class HubUserViewModel
{
    private let hubUserModel: HubUserDataModel
    
    private var hubUserDetailModel: HubUserDeatilDataModel!
    
    private var imageURL: URL
    
    var avatarImage: UIImage!
    
    init(hubUserModel: HubUserDataModel) {
        self.hubUserModel = hubUserModel
        self.imageURL = URL(string: hubUserModel.avatar_url)!
        
    }
    
    public var userName: String {
        return hubUserModel.login
    }
    
    public var isAdmin: Bool {
        return hubUserModel.site_admin
    }
    
    public var avatarURL: URL {
        return imageURL
    }
    
    public var fullName: String {
        return hubUserDetailModel.name
    }
    
    public var userLocation: String {
        return hubUserDetailModel.location
    }
    
    public var userBlogURL: String {
        return hubUserDetailModel.blog
    }
    
    public var userBio: String {
        return hubUserDetailModel.bio
    }
    
    
//    public var avatar: UIImage {
//        return avatarImage
//    }
//
    func download(completionHanlder: @escaping ImageDownloadCompletionClosure)
    {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:imageURL)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    let rawImageData = NSData(contentsOf: tempLocalUrl)
                    completionHanlder(rawImageData!)
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(String(describing: error?.localizedDescription))")
            }
        } // end let task
        
        task.resume()
        
    } // end func download
    
    func getDetailData(completion: @escaping (Result<HubUserDeatilDataModel,Error>) -> Void) {
        
        let loginName = hubUserModel.login
        let apiURL = "https://api.github.com/users/\(loginName)"
        
        var userDeailDataModelResult: HubUserDeatilDataModel!
        
        HTTPManager.shared.get(urlString: apiURL) { result in
            
            switch result {
                
            case .failure(let error):
                print("failure", error)
            
            case .success(let dta):
                let decoder = JSONDecoder()
                do
                {
                    
                    userDeailDataModelResult = try decoder.decode(HubUserDeatilDataModel.self, from: dta)
                    
                    if userDeailDataModelResult.location==nil{
                        userDeailDataModelResult.location = "N/A"
                    }
                    
                    self.hubUserDetailModel = userDeailDataModelResult
                    
                    completion(.success(userDeailDataModelResult))
                    
                }catch {
                    // deal with error from JSON decoding if used in production
                    print("Unexpected error: \(error).")
                }
                
                
            }
            
            
            
        }
        
    }
    
    static func fetchHubUsers(completion: @escaping (Result<[HubUserViewModel],Error>) -> Void) {
        
        let apiURL = "https://api.github.com/users?since=1&per_page=100"
        
        var hubUserDataModels: [HubUserDataModel]!
        
        
        HTTPManager.shared.get(urlString: apiURL, completionBlock: { result in
           // guard let self = self else {return}
            switch result {
                
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do
                {
                    hubUserDataModels = try decoder.decode([HubUserDataModel].self, from: dta)
                    
                    //var hubUserVMs:[HubUserViewModel]!
                    
                    for dataModel in hubUserDataModels
                    {
                        
                        let newHubUserVM = HubUserViewModel(hubUserModel:dataModel)
                        
                        let imageCompletionClosure = { (imageData:NSData) -> Void in

                            newHubUserVM.avatarImage =  UIImage(data: imageData as Data)

                        
                        }
                         
                        newHubUserVM.download(completionHanlder: imageCompletionClosure)
                        
                       // let data = try? Data(contentsOf: newHubUserVM.avatarURL)
                       // newHubUserVM.avatarImage = UIImage(data: data!)
                        
                        hubUserViewModels.append(newHubUserVM)
                    }
                    
                   // hubUserViewModels = hubUserVMs
                    
                    completion(.success(hubUserViewModels))
                } catch {
                    // deal with error from JSON decoding if used in production
                    print("Unexpected error: \(error).")
                }
            }
        })
    }
    
}
