//
//  BookingDetailViewController.swift
//  HaCareem_Dexterous
//
//  Created by SSaad Ullah on 4/30/17.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMaps
import Alamofire
import Kingfisher

class BookingDetailViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var eta: UILabel!
    @IBOutlet weak var carDetail: UILabel!
    
    
    var bookingId:String!
    var driverLink = "http://qa-interface.careem-engineering.com/v1/bookings/"

    var trackLocationLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackLocationLink = (driverLink+bookingId+"/track")
        
        driversDetail()
        driverLocationAPI()

    }
    
    func driversDetail(){
        Alamofire.request(
            driverLink,
            parameters: ["booking_id": bookingId],
            headers: ["Authorization": "crl54u6cj8f3a7hkc304359lhg"]
            
            )
            .responseJSON { response in
                
                //print("Hello11 : \(response)")
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print("hello2123: ", response)
                        
                        let value = JSON(response.result.value!)
                        print("Hello1: ",value["code"])
                        
                        let driver = Driver(data: value)
                        print("CarType: \(driver)")
                        
                        let driverDetails = DriverDetails(data: JSON(driver.driverDetails))
                        print("Driver: \(driverDetails.driverName)")
                        self.name.text = "Name: Captain Deadshot" //+ driverDetails.driverName
                        self.phoneNumber.text = "Phone Number: +923333359101" + driverDetails.driverNumber
                        
                        let vehicleDetail = VehicleDetail(data: JSON(driver.vehicleDetails))
                        print("Vehicle: \(vehicleDetail.modelNumber)")
                        self.carDetail.text = "Honda Accord : APM-858"//vehicleDetail.makeVehicle + " " + vehicleDetail.modelNumber + " " + vehicleDetail.license
                        let url = URL(string: driverDetails.driverPicture)
                        self.imageView.kf.setImage(with: url)
                         
                    }
                    break
                    
                case .failure(_):
                    print("Hello2", response.result.error)
                    break
                    
                }
        }
        
    }
    
    func driverLocationAPI(){
        
        Alamofire.request(
            trackLocationLink,
            parameters: ["booking_id": bookingId],
            headers: ["Authorization": "crl54u6cj8f3a7hkc304359lhg"]
            
            )
            .responseJSON { response in
                
                //print("Hello11 : \(response)")
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        
                        let value = JSON(response.result.value!)
                        print("Hello1: ",value)
                        
                        let track = TrackBooking(data: value)
                        let driverLoc = DriversLocation(data: JSON(track.driverLocation))
                        let lat = driverLoc.lat
                        let long = driverLoc.long

                    }
                    break
                    
                case .failure(_):
                    print("Hello2", response.result.error)
                    break
                    
                }
                
        }

        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func thankYouBtn(_ sender: UIButton) {
        dismiss(animated: true , completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
