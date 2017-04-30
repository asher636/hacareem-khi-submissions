//
//  VehicleDetail.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON

class VehicleDetail{
    
    private var model: String!
    private var make: String!
    private var license_plate: String!
    
    
    var modelNumber: String{
        return model
    }
    var makeVehicle: String{
        return make
    }
    var license: String{
        return license_plate
    }
    
    init(data: JSON) {
        
        if data["model"] != nil {
            model = data["model"].string
        }else{
            model = ""
        }
        
        if data["license_plate"] != nil {
            license_plate = data["license_plate"].string
        }else{
            license_plate = ""
        }
        
        if data["make"] != nil {
            make = data["make"].string
        }else{
            make = ""
        }
    }
    
}
