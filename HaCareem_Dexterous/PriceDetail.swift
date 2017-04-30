//
//  PriceDetail.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/29/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON

class PriceDetails{
    
    private var base_later: Int!
    private var base_now: Int!
    private var cancellation_fee_later: Int!
    private var cancellation_fee_now: Int!
    private var cost_per_distance: Int!
    private var cost_per_hour: Int!
    private var currency_code: String!
    
    private var distance_unit: String!
    private var minimum_now: Int!
    private var minimum_later: Int!
    
    var cancellationFeeLater: Int {
        return cancellation_fee_later
    }
    
    var cancellationFeeNow: Int {
        return cancellation_fee_now
    }

    var distacneUnit: String {
        return distance_unit
    }
    
    var minimumLater: Int {
        return minimum_later
    }
    
    var minimumNow: Int {
        return minimum_now
    }
    
    var costPerDistance: Int {
        return cost_per_distance
    }
    
    var costPerHour: Int {
        return cost_per_hour
    }
    
    var currencyCode: String {
        return currency_code
    }
    
    var baseLater: Int {
        return base_later
    }
    
    var baseNow: Int {
        return base_now
    }
    
    init(id:Int!, data: JSON) {
        
        if data["minimum_now"] != nil {
            minimum_now = data["minimum_now"].int
        }else{
            minimum_now = 0
        }
        
        if data["minimum_later"] != nil {
            minimum_later = data["minimum_later"].int
        }else{
            minimum_later = 0
        }
        
        if data["distance_unit"] != nil {
            distance_unit = data["distance_unit"].string
        }else{
            distance_unit = ""
        }
        
        if data["currency_code"] != nil {
            currency_code = data["currency_code"].string
        }else{
            currency_code = ""
        }

        
        if data["cost_per_hour"] != nil {
            cost_per_hour = data["cost_per_hour"].int
        }else{
            cost_per_hour = 0
        }
        
        if data["currency_code"] != nil {
            currency_code = data["currency_code"].string
        }else{
            currency_code = ""
        }

        
        if data["cost_per_distance"] != nil {
            cost_per_distance = data["cost_per_distance"].int
        }else{
            cost_per_distance = 0
        }
        
        if data["cancellation_fee_now"] != nil {
            cancellation_fee_now = data["cancellation_fee_now"].int
        }else{
            cancellation_fee_now = 0
        }
        
        if data["cancellation_fee_later"] != nil {
            cancellation_fee_later = data["cancellation_fee_later"].int
        }else{
            cancellation_fee_later = 0
        }

        if data["base_later"] != nil {
            base_later = data["base_later"].int
        }else{
            base_later = 0
        }

        
        if data["base_now"] != nil {
            base_now = data["base_now"].int
        }else{
            base_now = 0
        }
    }
    
    
}
