//
//  CarsListingCell.swift
//  CarsLocation
//
//  Created by Indivar Raina on 05/10/19.
//  Copyright © 2019 Indivar Raina. All rights reserved.
//

import Foundation
import UIKit

class CarsListingCell: UITableViewCell {

    @IBOutlet weak var imgInterior: UIImageView!
    @IBOutlet weak var vwInteriorType: UIView!
    @IBOutlet weak var engineLabel: UILabel!
    @IBOutlet weak var engineTypeLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var interiorLabel: UILabel!
    @IBOutlet weak var vinLabel: UILabel!
    
    func setData(model: Placemarks) {
        //plotting data on table view cell
        self.engineLabel.text = model.name
        self.engineTypeLabel.text = model.engineType
        vwInteriorType.layer.cornerRadius = 12.0
        vwInteriorType.layer.masksToBounds = true
        if model.interior == "GOOD"
        {
            imgInterior.image = UIImage.init(named: "smileh.png")
            
        }
        else
        {
            imgInterior.image = UIImage.init(named: "cry.png")

            
        }
        self.fuelLabel.text = "\(model.fuel!)"
        self.interiorLabel.text = model.interior
        self.vinLabel.text = model.vin
        

    }
    
}
