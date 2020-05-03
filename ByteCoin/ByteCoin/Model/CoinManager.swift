//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, rate: RateModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let finalURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: finalURL)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let rate = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRate(self, rate: rate)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ rateData: Data) -> RateModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RateData.self, from: rateData)
            
            let rate = decodedData.rate
            let quote = decodedData.asset_id_quote
            
            return RateModel(rate: rate, asset_id_quote: quote)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
