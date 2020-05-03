//
//  RateData.swift
//  ByteCoin
//
//  Created by Vitor Capretz on 2020-04-22.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct RateData: Codable {
    let rate: Double
    let asset_id_quote: String
}
