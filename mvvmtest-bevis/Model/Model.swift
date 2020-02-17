//
//  Model.swift
//  mvvmtest-bevis
//
//  Created by 林昆儀 on 2020/2/14.
//  Copyright © 2020 Digi96. All rights reserved.
//

import Foundation

struct HubUserDataModel: Codable {
    
    let login: String //user id
    let avatar_url: String //url of avatar
    let site_admin: Bool //is site admin or not
}

struct HubUserDeatilDataModel: Codable {
    
    let name: String! //full name
    var location: String! //location of user
    let blog: String //url of user's blog
    let bio: String! //user's biography
    
}
