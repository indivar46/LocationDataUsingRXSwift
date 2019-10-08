//
//  AllCarsMapsController.swift
//  CarsLocation
//
//  Created by Indivar Raina on 05/10/19.
//  Copyright © 2019 Indivar Raina. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import GoogleMaps
class AllCarsMapsViewController: UIViewController,GMSMapViewDelegate {
    
    var carsData = [Placemarks]()
    var carLat = Float()
    var carLongt = Float()
    var markers = [GMSMarker]()

    @IBOutlet weak var mapVw: GMSMapView!
    
    override func viewDidLoad()
    {
        
        //setting mapview delegate here
        mapVw.delegate = self
        
        // function below to plot data on map
        self.setCarOnMapView()
    }
    
 
    func setCarOnMapView()
    {
//        var coordinates = self.carsData.map{$0.coordinates}
//        print(coordinates)
        
 //Accessing all model objects here
        for model in self.carsData {
            let latitude = model.coordinates?[0]
            let longitude = model.coordinates?[1]
           
           // print(latitude, longitude)
            
            let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(CLLocationDegrees(longitude!), CLLocationDegrees(latitude!));
            
            // setting a geofence radius if need to be displayed
            var geoFenceRadius = Double()
            geoFenceRadius = 20
            
            // condition to check whether the coordinates are vail or not
            if CLLocationCoordinate2DIsValid(circleCenter)
            {
//                print("Coordinate valid")
                
            
                let circ = GMSCircle(position: circleCenter, radius: geoFenceRadius)
                circ.fillColor = UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 0.1)
                circ.strokeColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 0.5)
                circ.strokeWidth = 2.5;
                circ.map = self.mapVw;
                
                //Plotting markers on the map
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(longitude!), longitude: CLLocationDegrees(latitude!))
                marker.icon = UIImage(named: "BookCab.png")
                marker.map = mapVw
                
                //adding marker in an array to access the index when tapped on a marker
                markers.append(marker)

            }
                
            else
                
            {
                print("Coordinate invalid")
            }
            
            //GMSCamera to zoom on the marker
            let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(longitude!), longitude: CLLocationDegrees(latitude!), zoom: 16.0)
            mapVw.animate(to: camera)

            
        }

        
    }
    
    
    // mapview delegate method to get tapp on the marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.delegate = self
        
        print("You tapped : \(marker.position.latitude),\(marker.position.longitude)")
        if let index = markers.index(of: marker)
        {
            //Fetching the data from tapped index of marker
            let tappedMarker = self.carsData[index]

            //navigating to the vehicle detail controller and passing the required data parameters
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "CarDetailVC") as! CarDetailVC
            //controller.carsData = self.viewModel.carsData.value
            controller.latCord = Float(marker.position.latitude)
            controller.longtCord = Float(marker.position.longitude)
            controller.nameVehicle = tappedMarker.name ?? ""
            controller.addressVehicle = tappedMarker.address ?? ""


                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(controller, animated: true)
            }
            
        }
        
        return true
    }
    
    
}
