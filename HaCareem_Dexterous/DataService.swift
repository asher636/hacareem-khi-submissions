//
//  DataService.swift
//  Videorist
//
//  Created by Asher Ahsan on 29/04/2017.
//  Copyright © 2016 Asher Ahsan. All rights reserved.
//

import Foundation
import Firebase

//typealias Completion = (_ errMsg: String?, _ data: FIRUser?) -> Void

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    let ref = FIRDatabase.database().reference()
    let userRef = FIRDatabase.database().reference().child("users")
}
