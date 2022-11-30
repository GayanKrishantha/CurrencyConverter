
// Created by Gayan Dias on 27/11/2022.

import Foundation

enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError( _ description: String)
    case urlSessionFailed(_ error: URLError)
    case timeOut
    case unknownError
    
    var errorTitle: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request)"
        case .badRequest:
            return "badRequest"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "NotFound"
        case .error4xx:
            return "Exceeded API rate limit."
        case .serverError:
            return "Server Error"
        case .error5xx:
            return "Error5xx"
        case .decodingError:
            return "Decoding Error"
        case .urlSessionFailed:
            return "Connection Error."
        case .timeOut:
            return "TimeOut"
        case .unknownError:
            return "Unknown Error"
        }
    }
    
    var errorDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request)"
        case .badRequest:
            return "badRequest"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "NotFound"
        case .error4xx:
            return "You have exceeded your daily/monthly API rate limit."
        case .serverError:
            return "Server Error"
        case .error5xx:
            return "Error5xx"
        case .decodingError:
            return "Decoding Error"
        case .urlSessionFailed:
            return "No Internet connection availabe."
        case .timeOut:
            return "TimeOut"
        case .unknownError:
            return "Unknown Error"
        }
    }
}
