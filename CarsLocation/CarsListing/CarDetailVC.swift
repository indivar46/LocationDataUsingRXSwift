//
//  CarDetailVC.swift
//  CarsLocation
//
//  Created by sequelone solution on 06/10/19.
//  Copyright © 2019 Saurabh Yadav. All rights reserved.
//

import UIKit
import GoogleMaps
class CarDetailVC: UIViewController,GMSMapViewDelegate {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mapVw: GMSMapView!
    var latCord = Float()
    var longtCord = Float()
    var nameVehicle = String()
    var addressVehicle = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showSelectedCar()
        lblName.text = String(format:"Vehicle Name :%@",nameVehicle)
        lblAddress.text = String(format:"Vehicle Address :%@",addressVehicle)

        // Do any additional setup after loading the view.
    }
    
    // function below to plot selected marker on the map

    func showSelectedCar()
    {
        var geoFenceRadius = Double()
        geoFenceRadius = 30
        let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(CLLocationDegrees(latCord), CLLocationDegrees(longtCord));

        
        if CLLocationCoordinate2DIsValid(circleCenter)
        {
            print("Coordinate valid")
            //
            let circ = GMSCircle(position: circleCenter, radius: geoFenceRadius)
            circ.fillColor = UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 0.1)
            circ.strokeColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 0.5)
            circ.strokeWidth = 2.5;
            circ.map = self.mapVw;
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latCord), longitude: CLLocationDegrees(longtCord))
            marker.icon = UIImage(named: "BookCab.png")
            marker.map = mapVw
        }
            
        else
            
        {
            print("Coordinate invalid")
        }
        
        
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(latCord), longitude: CLLocationDegrees(longtCord), zoom: 19.0)
        mapVw.animate(to: camera)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
