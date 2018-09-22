//
//  ParkingsMapVC.swift
//  SmartPay
//
//  Created by Mostafa on 6/3/18.
//  Copyright © 2018 Ismail. All rights reserved.
//

import UIKit
import GoogleMaps
import SDWebImage
class ParkingsMapVC: UIViewController {
    
    
    @IBOutlet weak var map_view: GMSMapView!
    @IBOutlet weak var view_bottom: UIView!
    @IBOutlet weak var img_view: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_model: UILabel!
    @IBOutlet weak var cons_bottom: NSLayoutConstraint!
    @IBOutlet weak var menuSideMenuBt: UIButton!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    @IBOutlet weak var titleVc: UILabel!
    
    var lat = 0.0//53.56849
    var long = 0.0 //9.92438
    let zoom: Float = 13
   
    var locations: [CarObject] = []

    var pressedOnCar: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        img_view.setRounded()
        createMapView()
        self.implementLocationCore()
        getCars()
        map_view.delegate = self
        view_bottom.setRounded(6)
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createMapView() {
        let camera = GMSCameraPosition.camera(withLatitude:lat, longitude: long, zoom: zoom)
        map_view.camera = camera
        map_view.isMyLocationEnabled = true
//        map_view.mapStyle(withFilename: "dark", andType: "json")
        
    }
    
    
    func setupMapMarker(){
        
        DispatchQueue.main.async(execute: {
            print(self.locations)
            for address in self.locations {
                if let lat = address.lng, let lan = address.lat {
                    let position = CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(lan))
                    let marker = GMSMarker.init(position: position)
                    marker.iconView?.isHidden = false
                    marker.iconView = UIImageView(image: "map-marker".toImage)
                    marker.title = address.name
                    marker.map = self.map_view
                }
            }
        })
    }
    func hideAllMarkers() {
        
    }
    func getCars()  {
        if let path = Bundle.main.path(forResource: "locations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let placemarks = jsonResult["placemarks"] as? [Dictionary<String, AnyObject>] {
                    self.locations.removeAll()
                    for car in placemarks {
                        let object = CarObject.init(dictionary: car)
                        self.locations.append(object)
                    }
                    self.setupMapMarker()

                }
            } catch {
                // handle error
            }
        }
    }


    
    func didCloseButtonViewPressed() {
        
        
        cons_bottom.constant = -130
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
}


extension ParkingsMapVC: GMSMapViewDelegate ,CLLocationManagerDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.title ?? "aaa")
        if pressedOnCar == false {
        for address in locations{
            if address.name == marker.title {
                 self.locations.removeAll()
                self.map_view.clear()
                pressedOnCar = true
                self.locations.append(address)
                self.cons_bottom.constant = 16
                if let name = address.name {
                    self.lbl_name.text = "Car Name: " + name
                }
                if let model = address.engineType {
                    self.lbl_model.text = "Engine type: " + model
                }
                self.img_view.image = "carImg".toImage
                self.setupMapMarker()
                break
            }
            }
        }else{
            self.didCloseButtonViewPressed()
            pressedOnCar = false
            self.locations.removeAll()
            self.map_view.clear()
            getCars()
        }
        return true
    }
    
        
        
        func implementLocationCore(){
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
            
        }
        
        // Handle incoming location events.
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if let location: CLLocation = locations.last {
                    print("Location: \(location)")
                    self.lat = location.coordinate.latitude
                    self.long = location.coordinate.longitude
                    self.map_view.animate(toLocation: CLLocationCoordinate2D(latitude: self.lat, longitude: self.long))
                    self.map_view.setMinZoom(4.6, maxZoom: 20)
//                    locationManager.stopUpdatingLocation()
                }
            
        }
   
}
