//
//  DriversLocation.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import Foundation
import SwiftyJSON
class DriversLocation{
    
    private var latitude : Float!
    private var longitutde :Float!
    
    var lat: Float{
        return latitude
    }
    
    var long: Float{
        return longitutde
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
    }
    

}
