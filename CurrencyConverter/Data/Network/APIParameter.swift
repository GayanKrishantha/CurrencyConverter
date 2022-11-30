
// Created by Gayan Dias on 27/11/2022.

import Foundation

protocol DictionaryConvertor: Codable {}

//MARK: APIParameters for using in URLrequests
/// Structs that containg all parameters that needed for passing data as body or queary strings to urlrequest
/// it is conforimig to DictionaryConvertor
struct APIParameters{
    
    struct CurrencyParams: Encodable  {
        var apikey: String?
    }
    
    struct CurrencyRateParams: Encodable {
        var to: String?
        var from: String?
        var amount: Double?
        var apikey: String?
    }
}
