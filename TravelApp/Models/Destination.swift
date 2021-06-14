//
//  Destination.swift
//  TravelApp
//
//  Created by Shreyak Godala on 15/05/21.
//

import Foundation

struct Destination: Hashable {
    var name, countryName, image: String
    var latitude, longitude: Double
}

struct DestinationDetail: Decodable {
    var description: String
    var photos: [String]
}
