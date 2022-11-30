
// Created by Gayan Dias on 27/11/2022.

import Foundation

struct CurrencyRate: Codable {
    let success: Bool?
    let query: QueryItem?
    let info: InfoData?
    let result: Double?
}

struct QueryItem: Codable {
    let form: String?
    let to: String?
    let amount: Double?
}

struct InfoData: Codable {
    let timestamp: Int?
    let quote: Double?
}
