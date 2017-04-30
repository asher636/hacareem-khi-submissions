//
//  Booking.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON

class CustomerDetails {
    
    private var uuid: String!
    private var name: String!
    private var email: String!
    private var phone_number: String!
    
    var userId: String{
        return uuid
    }
    var _name: String{
        return name
    }
    var emailId: String{
        return email
    }
    var phoneNumber : String{
        return phone_number
    }
    
    init(id:Int!, data: JSON) {
        
        if data["uuid"] != nil {
            uuid = data["uuid"].string
        }else{
            uuid = ""
        }
        
        if data["name"] != nil {
            name = data["name"].string
        }else{
            name = ""
        }
        if data["email"] != nil {
            email = data["email"].string
        }else{
            email = ""
        }
        if data["phone_number"] != nil {
            phone_number = data["phone_number"].string
        }else{
            phone_number = ""
        }
    }
    
}
