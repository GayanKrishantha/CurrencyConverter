
// Created by Gayan Dias on 27/11/2022.

import Foundation

// MARK: - Currency
struct Currency: Codable {
    let success: Bool
    let currencies: [String: String]
}

// MARK: - Currency Value
struct CurrencyValue: Codable, Hashable, Equatable {
    let code: String
    let description: String
}
