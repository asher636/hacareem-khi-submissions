//
//  PickupDetails.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON

class PickupDetails{
    
    private var latitude : Float!
    private var longitutde :Float!
    private var name : String!
    
    var lat: Float{
        return latitude
    }
    
    var long: Float{
        return longitutde
    }
    
    var _name : String{
        return name
    }
    
    init(data: JSON) {
        
        if data["longitude"] != nil {
            longitutde = data["longitude"].float
        }else{
            longitutde = 0
        }
        
        if data["latitude"] != nil {
            latitude = data["latitude"].float
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
