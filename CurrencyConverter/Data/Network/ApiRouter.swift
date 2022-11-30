
// Created by Gayan Dias on 27/11/2022.

import Foundation

class APIRouter {
    
    // GET Request
    struct GetCurrencies: Request {
        typealias ReturnType = Currency
        var path: String = "/currency_data/list"
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?
        init(queryParams: APIParameters.CurrencyParams?) {
            self.queryParams = queryParams.asDictionary
        }
    }
    
    // GET Request
    struct GetCurrencyRate: Request {
        typealias ReturnType = CurrencyRate
        var path: String = "/currency_data/convert"
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?
        init(queryParams: APIParameters.CurrencyRateParams?) {
            self.queryParams = queryParams.asDictionary
        }
    }
}
