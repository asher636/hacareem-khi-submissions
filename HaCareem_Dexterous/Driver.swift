//
//  DriverDetail.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Driver{
    
    private var promo_code: String!
    private var pickup_time: Int?
    private var booking_id: String!
    private var status: String!
    private var product_id: Int!
    private var product_name: String!
    private var vehicle_details: [String: JSON]? // model make licecne
    private var driver_details: [String: JSON]?
    
    var promoCode: String{
        return promo_code
    }
    var pickUpTime: Int{
        return pickup_time!
    }
    var bookingId: String{
        return booking_id
    }
    var statuses: String{
        return status
    }
    var productId: Int{
        return product_id
    }
    var productName: String{
        return product_name
    }
    var vehicleDetails: [String:JSON]?{
        return vehicle_details
    }
    var driverDetails: [String:JSON]?{
        return driver_details
    }
    
    init(data: JSON) {
        
        if data["promo_code"] != nil {
            promo_code = data["promo_code"].string
        }else{
            promo_code = ""
        }
        
        if data["pickup_time"] != nil {
            pickup_time = data["pickup_time"].int
        }else{
            pickup_time = 0
        }
        
        if data["booking_id"] != nil {
            booking_id = data["booking_id"].string
        }else{
            booking_id = ""
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
        if data["product_name"] != nil {
            product_name = data["product_name"].string
        }else{
            product_name = ""
        }
        if data["driver_details"] != nil {
            driver_details = data["driver_details"].dictionary
        }else{
            driver_details = [:]
        }
        
        if data["vehicle_details"] != nil {
            vehicle_details = data["vehicle_details"].dictionary
        }else{
            driver_details = [:]
        }


    }
    
    
    
}
