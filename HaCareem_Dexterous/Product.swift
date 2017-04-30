//
//  User.swift
//  Sleek Learning
//
//  Created by Asher Ahsan on 15/04/2017.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    private var availibility_later: Int!
    private var availibility_now: Int!
    private var capacity: Int!
    private var display_name: String!
    private var display_order: Int!
    private var image: String!
    private var maximum_time_to_cancel_later: Int!
    private var maximum_time_to_cancel_now: Int!
    private var minimum_time_to_book: Int!
    
    
    private var priceDetails : [String:JSON]?
    
    //Product Detials
    
    
    private var product_id: Int
    
    var productId: Int{
        return product_id
    }
    
        
    var availibilityNow: Int {
        return availibility_now
    }
    
    var _capacity: Int {
        return capacity
    }
    
    var displayName: String {
        return display_name
    }
    
    var diplayOrder: Int {
        return display_order
    }
    
    var carImage: String {
        return image
    }
    
    var maxTimeToCancelLater: Int {
        return maximum_time_to_cancel_later
    }
    
    var maxTimeToCancelNow: Int {
        return maximum_time_to_cancel_now
    }
    
    var minTimeToBook: Int {
        return minimum_time_to_book
    }
    
    var priceDetail: [String:Any]{
        return priceDetails!
    }
    
    
    init(data: JSON) {
        
        if data["product_id"] != nil {
            product_id = data["product_id"].int!
        } else{
            product_id = 0
        }
        
        if data["availibility_later"] != nil {
            availibility_later = data["availibility_later"].int
        }else{
            availibility_later = 0
        }
        
        if data["availibility_now"] != nil {
            availibility_now = data["availibility_now"].int
        }else{
            availibility_now = 0
        }
        
        if data["capacity"] != nil {
            capacity = data["capacity"].int
        }else{
            capacity = 0
        }
        
        if data["display_name"] != nil {
            display_name = data["display_name"].string
        }else{
            display_name = ""
        }
        
        if data["display_order"] != nil {
            display_order = data["display_order"].int
        }else{
            display_order = 0
        }

        if data["image"] != nil {
            image = data["image"].string
        }else{
            image = ""
        }

        if data["maximum_time_to_cancel_later"] != nil {
            maximum_time_to_cancel_later = data["maximum_time_to_cancel_later"].int
        }else{
            maximum_time_to_cancel_later = 0
        }

        if data["maximum_time_to_cancel_now"] != nil {
            maximum_time_to_cancel_now = data["maximum_time_to_cancel_now"].int
        }else{
            maximum_time_to_cancel_now = 0
        }

        if data["minimum_time_to_book"] != nil {
            minimum_time_to_book = data["minimum_time_to_book"].int
        }else{
            minimum_time_to_book = 0
        }

        if let pricedetail = data["price_details"].dictionary{
            priceDetails = pricedetail
        }

        
    }
    
}
