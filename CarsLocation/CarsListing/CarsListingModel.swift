//
//  CarsListingModel.swift
//  CarsLocation
//
//  Created by Indivar Raina on 05/10/19.
//  Copyright © 2019 Indivar Raina. All rights reserved.
//

struct CarsListing : Codable {
    let placemarks : [Placemarks]?
    
    enum CodingKeys: String, CodingKey {
        case placemarks = "placemarks"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        placemarks = try values.decodeIfPresent([Placemarks].self, forKey: .placemarks)
    }
    
}


struct Placemarks : Codable {
    let address : String?
    let coordinates : [Double]?
    let engineType : String?
    let exterior : String?
    let fuel : Int?
    let interior : String?
    let name : String?
    let vin : String?
    
    enum CodingKeys: String, CodingKey {
        
        case address = "address"
        case coordinates = "coordinates"
        case engineType = "engineType"
        case exterior = "exterior"
        case fuel = "fuel"
        case interior = "interior"
        case name = "name"
        case vin = "vin"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        coordinates = try values.decodeIfPresent([Double].self, forKey: .coordinates)
        engineType = try values.decodeIfPresent(String.self, forKey: .engineType)
        exterior = try values.decodeIfPresent(String.self, forKey: .exterior)
        fuel = try values.decodeIfPresent(Int.self, forKey: .fuel)
        interior = try values.decodeIfPresent(String.self, forKey: .interior)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        vin = try values.decodeIfPresent(String.self, forKey: .vin)
    }
    
}
