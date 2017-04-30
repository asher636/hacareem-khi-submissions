//
//  DriverDetails.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON

class DriverDetails{
    
    
    private var driver_name: String!
    private var driver_number: String!
    private var driver_picture: String!
    private var notes_to_driver: String!
    
    
    var driverName: String{
        return driver_name
    }
    
    var driverNumber: String{
        return driver_number
    }
    
    var driverPicture: String{
        return driver_picture
    }
    
    var notesToDriver: String{
        return notes_to_driver
    }
    
    
    init(data: JSON) {
        
        if data["driver_name"] != nil {
            driver_name = data["driver_name"].string
        }else{
            driver_name = ""
        }
        
        if data["driver_number"] != nil {
            driver_number = data["driver_number"].string
        }else{
            driver_number = ""
        }
        
        
        if data["driver_picture"] != nil {
            driver_picture = data["driver_picture"].string
        }else{
            driver_picture = ""
        }
        
        
        if data["notes_to_driver"] != nil {
            notes_to_driver = data["notes_to_driver"].string
        }else{
            notes_to_driver = ""
        }
        
    }

}
