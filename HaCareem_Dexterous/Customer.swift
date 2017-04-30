//
//  CustomerDetails.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Customer{
    
    private var latitude : Int!
    private var longitutde :Int!
    private var name : String!
    
    var lat: Int{
        return latitude
    }
    
    var long: Int{
        return longitutde
    }
    
    var _name : String{
        return name
    }
    
    init(data: JSON) {
        
        if data["longitude"] != nil {
            longitutde = data["longitude"].int
        }else{
            longitutde = 0
        }
        if data["latitude"] != nil {
            latitude = data["latitude"].int
        }else{
            latitude = 0
        }
        
        if data["name"] != nil {
            name = data["name"].string
        }else{
            name = ""
        }
        
    }
    
    
    
    
}
