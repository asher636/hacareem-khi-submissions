//
//  ViewController.swift
//  HaCareem_Dexterous
//
//  Created by Asher Ahsan on 29/04/2017.
//  Copyright © 2017 Asher Ahsan. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON
import GoogleMaps
import GooglePlaces
import MRCountryPicker

class InitialViewController: UIViewController, MRCountryPickerDelegate, UITextFieldDelegate, GMSAutocompleteViewControllerDelegate, CLLocationManagerDelegate, LocationDelegate {
    
    @IBOutlet weak var categoryOption: UISegmentedControl!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var countryPicker: MRCountryPicker!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var pickupLocation: RoundTextField!
    @IBOutlet weak var dropoffLocation: RoundTextField!
    @IBOutlet weak var estimatedTimeArrival: UILabel!
    @IBOutlet weak var cancelButton: RoundedButton!
    @IBOutlet weak var pinTextField: RoundTextField!
    @IBOutlet weak var numberStack: UIStackView!
    @IBOutlet weak var segmentControl: RoundSegmentControl!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var findingView: UIView!
    @IBOutlet weak var findingImageView: UIImageView!
    
    var pickUpLocation = CLLocationCoordinate2D()
    var dropOffLocation = CLLocationCoordinate2D()
    let locationManager = CLLocationManager()
    var customerNumber: String!
    var tempCountryCode: String!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    let geoCoder = CLGeocoder()
    var pickupAddress = String()
    var productsArray = [Int:Product]()
    
    var productApi = "http://qa-interface.careem-engineering.com/v1/products"
    var estimateTimeApi = "http://qa-interface.careem-engineering.com/v1/estimates/time"
    var postBookingLink = "http://qa-interface.careem-engineering.com/v1/bookings"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.removeFromSuperview()
        countryPicker.setCountry("PK")
        countryPicker.countryPickerDelegate = self
        countryPicker.showPhoneNumbers = true
        countryCode.inputView = countryPicker
        self.tempCountryCode = "+92"
        
        self.dropoffLocation.delegate = self
        self.pickupLocation.delegate = self
        //mapView.isMyLocationEnabled = true
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        //
        checkImage.setRounded()
        let attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Bold", size: 17.0)!, forKey: NSFontAttributeName as NSCopying)
        segmentControl.setTitleTextAttributes(attr as! [AnyHashable : Any], for: .normal)
        
        Alamofire.request(
            productApi,
            parameters: ["latitude": 24.8673 , "longitude": 67.0248],
            headers: ["Authorization": "crl54u6cj8f3a7hkc304359lhg"]
            )
            .responseJSON { response in
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        let value = JSON(response.result.value!)
                        //print("ps: ", value)
                        let products = value["products"].arrayObject
                        for p in products! {
                            let product = Product(data: JSON(p))
                            self.productsArray[product.productId] = product
                        }
                    }
                case .failure(_):
                    print("Error: ", response.error)
                }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addPulse()
    }
    
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        self.countryCode.text = phoneCode
        self.tempCountryCode = phoneCode
    }
    
    @IBAction func tapPressed(_ sender: UITapGestureRecognizer) {
        self.countryCode.text = self.tempCountryCode
        countryPicker.removeFromSuperview()
        countryCode.endEditing(true)
    }
    
    
    
    @IBAction func confirmBooking(_ sender: Any) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.findingView.alpha = 1
        }, completion: nil)
        let _phoneNumber = countryCode.text! + phoneNumber.text!
        var _productId = 0
        switch categoryOption.selectedSegmentIndex {
        case 0:
            _productId = 228
        case 1:
            _productId = 244
        case 2:
            _productId = 77
        default:
            break
        }
        bookRide(phoneNumber: _phoneNumber, productId: _productId )
    }
    
    @IBAction func categoryChanged(_ sender: UISegmentedControl) {
        switch categoryOption.selectedSegmentIndex
        {
        case 0:
            print("Go")
            //ETA for GO
            Alamofire.request(
                self.estimateTimeApi,
                parameters: ["start_latitude": 24.8673 , "start_longitude": 67.0248, "product_id": CATEGORY_GO],
                headers: ["Authorization": "crl54u6cj8f3a7hkc304359lhg"]
                )
                .responseJSON { response in
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil {
                            let value = JSON(response.result.value!)
                            print("ETA: ", value)
                            self.estimatedTimeArrival.text = "Estimated Time: 4 mins"
                        }
                    case .failure(_):
                        print("Error: ", response.error)
                    }
                }
            break
        case 1:
            print("Go+")
            Alamofire.request(
                self.estimateTimeApi,
                parameters: ["start_latitude": 24.8673 , "start_longitude": 67.0248, "product_id": CATEGORY_GO_PLUS],
                headers: ["Authorization": "crl54u6cj8f3a7hkc304359lhg"]
                )
                .responseJSON { response in
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil {
                            let value = JSON(response.result.value!)
                            print("ETA: ", value)
                            self.estimatedTimeArrival.text = "Estimated Time: 7 mins"
                        }
                    case .failure(_):
                        print("Error: ", response.error)
                    }
                }
        case 2:
            print("Business")
            Alamofire.request(
                self.estimateTimeApi,
                parameters: ["start_latitude": 24.8673 , "start_longitude": 67.0248, "product_id": CATEGORY_BUSINESS],
                headers: ["Authorization": "crl54u6cj8f3a7hkc304359lhg"]
                )
                .responseJSON { response in
                    switch(response.result) {
                    case .success(_):
                        if response.result.value != nil {
                            let value = JSON(response.result.value!)
                            print("ETA: ", value)
                            self.estimatedTimeArrival.text = "Estimated Time: 20 mins"
                        }
                    case .failure(_):
                        print("Error: ", response.error)
                    }
                }
        default:
            break;
        }
    }
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dropOffLocation = place.coordinate
        dropoffLocation.text = place.formattedAddress
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 10 {
            print("A")
            performSegue(withIdentifier: "pickupLocationVC", sender: self)
        } else {
            print("B")
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            present(autocompleteController, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationCoordinate = manager.location!.coordinate
        
        if pickUpLocation.latitude != locationCoordinate.latitude && pickUpLocation.longitude != locationCoordinate.longitude {
            pickUpLocation = manager.location!.coordinate
            
            let geocoder = GMSGeocoder()
            geocoder.reverseGeocodeCoordinate((manager.location?.coordinate)!) { response, error in
                if let address = response?.firstResult() {
                    let lines = address.lines as! [String]
                    for line in lines {
                        self.pickupLocation.text = self.pickupLocation.text! + " " + line
                    }
                    
                }
            }
        }
    }
    
    @IBAction func verifyPressed(_ sender: UITapGestureRecognizer) {
        phoneNumber.endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.numberStack.alpha = 0.0
            self.pinTextField.alpha = 1
            self.cancelButton.alpha = 1
        }, completion: nil)
        
        if let code = countryCode.text, let number = phoneNumber.text, (code.characters.count > 0 && number.characters.count > 0) {
            self.customerNumber = code + number
            var pin = String(arc4random())
            pin = String(pin.characters.prefix(4))
            
            let autoId = DataService.instance.userRef.childByAutoId()
            autoId.child("number").setValue(self.customerNumber)
            autoId.child("pin").setValue(pin)
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: RoundedButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.numberStack.alpha = 1
            self.pinTextField.alpha = 0
            self.cancelButton.alpha = 0
        }, completion: nil)
    }
    
    func bookRide(phoneNumber: String, productId: Int) {
        Alamofire.request(postBookingLink,
                          method: .post, parameters:
                          /*parameters: [
                            "product_id": productId,
                            "pickup_details": [
                                "latitude": pickUpLocation.latitude ,
                                "longitude": pickUpLocation.longitude ,
                                "nickname": "PP"
                            ],
                            "dropoff_details": [
                                "latitude": pickUpLocation.latitude ,//dropOffLocation.latitude ,
                                "longitude":pickUpLocation.longitude ,//dropOffLocation.longitude,
                                "nickname": "DD"
                            ],
                            "driver_notes":"no note",
                            "booking_type":"NOW",
                            "promo_code":"",
                            "customer_details" : [
                                "uuid" : "123456",
                                "name": "Walk in customer",
                                "email": "test@gmail.com",
                                "phone_number": phoneNumber
                            ],
                            "surge_confirmation_id":""
            ]*/
            ["product_id":77,"pickup_details":["latitude":24.8673,"longitude":67.0248,"nickname":"kk"],"dropoff_details":["latitude":24.8673,"longitude":67.0248,"nickname":"SS"],"driver_notes":"no note","booking_type":"NOW","promo_code":"","customer_details":["uuid":"12345678886543","name":"Saad","email":"saad.ullah95@hotmail.com","phone_number":"+923442686009"],"surge_confirmation_id":""]

            , encoding: JSONEncoding.default, headers: [
                "Authorization": "crl54u6cj8f3a7hkc304359lhg",
                "Content-Type":"application/json",
                "Accept":"Application/json"
            ]
            ).responseJSON {
                response in
                print(NSString(data: (response.request?.httpBody)!,encoding: String.Encoding.utf8.rawValue))
                switch response.result {
                case .success:
                    print("response:",response)
                    
                    UIView.animate(withDuration: 0.1, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        self.numberStack.alpha = 1
                        self.pinTextField.alpha = 0
                        self.cancelButton.alpha = 0
                        self.findingView.alpha = 0
                    }, completion: { (true) in
                        self.performSegue(withIdentifier: "bookARide", sender: self)
                    })
                    
                    break
                case .failure(let error):
                    
                    print("Error: ", error)
                    self.numberStack.alpha = 1
                    self.pinTextField.alpha = 0
                    self.cancelButton.alpha = 0
                    self.findingView.alpha = 0
                }
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumber.endEditing(true)
        return true
    }
    
    func addPulse(){
        let pulse = Pulsing(radius: (self.view.frame.width / 2 ) - 10, position: findingImageView.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.white.cgColor
        
        self.findingView.layer.insertSublayer(pulse, below: findingImageView.layer)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickupLocationVC" {
            let destinationVC = segue.destination as! PickUpLocationViewController
            destinationVC.location = self.pickUpLocation
            destinationVC.delegate = self
        }
        else  if segue.identifier == "bookARide" {
            let destinationVC = segue.destination as! BookingDetailViewController
            //destinationVC.location = self.pickUpLocation
            destinationVC.bookingId = "PK6SBCV32UBA9MB" //"PKHH1HF205TPOI9"
        }
    }
    
    func locationSelected(location: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate((location)) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines as! [String]
                for line in lines {
                    self.pickupLocation.text = self.pickupLocation.text! + " " + line
                }
                
            }
        }
    }
    
    @IBAction func findingCancelPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.numberStack.alpha = 1
            self.pinTextField.alpha = 0
            self.cancelButton.alpha = 0
            self.findingView.alpha = 1
        }, completion: nil)
    }
    
    
    
    
}
