//
//  TrackBooking.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON
class TrackBooking{
    
    private var eta: Double!
    private var status: String!
    private var product_id: Int!
    private var vehicle_details: [String:JSON]?
    private var driver_details: [String:JSON]?
    private var driver_location_details:[String:JSON]?
    
    var estimatedTime: Double{
        return eta
    }
    
    var statuses: String{
        return status
    }
    
    var productID: Int{
        return product_id
    }
    
    var vehicleDetails: [String: JSON]?{
        return vehicle_details
    }
    
    var driverDetails: [String:JSON]?{
        return driver_details
    }
    
    var driverLocation: [String:JSON]?{
        return driver_location_details
    }
    
    
    init(data: JSON) {
        
        
        if data["eta"] != nil {
            eta = data["eta"].double
        }else{
            eta = 0
        }
        
        if data["status"] != nil {
            status = data["status"].string
        }else{
            status = ""
        }
        
        if data["product_id"] != nil {
            product_id = data["product_id"].int
        }else{
            product_id = 0
        }
        
        if data["vehicle_details"] != nil {
            vehicle_details = data["vehicle_details"].dictionary
        }
        
        
        if data["driver_details"] != nil {
            driver_details = data["driver_details"].dictionary
        }
        
        
        if data["driver_location_details"] != nil {
            driver_location_details = data["driver_location_details"].dictionary
        }
        
    }
    

}
