
// Created by Gayan Dias on 27/11/2022.

import Foundation

final class APIConstants {
    static var basedURL: String = "https://api.apilayer.com"
    static var apiKey: String = "NjmP9KvKoLcdMPObGPXEuyxCnPMXIIQV"
}

enum HTTPHeaderField: String {
    case authentication = "Authentication"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
    case acceptLanguage = "Accept-Language"
    case userAgent = "User-Agent"
}

enum ContentType: String {
    case json = "application/json"
    case xwwwformurlencoded = "application/x-www-form-urlencoded"
}
