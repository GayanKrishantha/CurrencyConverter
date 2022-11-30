
// Created by Gayan Dias on 27/11/2022.

import Foundation
import Combine

struct NetworkDispatcher {
    
    let urlSession: URLSession!
    
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        
        //Log Request
        debugPrint("[\(request.httpMethod?.uppercased() ?? "")] '\(request.url!)'")
        
        return urlSession.dataTaskPublisher(for: request)
        // Retry when its required
            .retry(3)
        // Request on background
            .subscribe(on: DispatchQueue.global(qos: .default))
        // Map on Request response
            .tryMap({try handelUrlResponse(output: $0, url: request.url!) })
        // Update on main thred
            .receive(on: DispatchQueue.main)
        // Decode data using our ReturnType
            .decode(type: ReturnType.self, decoder: JSONDecoder())
        // Handle any decoding errors
            .mapError { error in
                Log.error("\(error)")
                return handleError(error)
            }
        // And finally, expose our publisher
            .eraseToAnyPublisher()
    }
    
    private func handelUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        // If the response is invalid, throw an error
        guard let response = output.response as? HTTPURLResponse else {
            throw httpError(0)
        }
        
        //Log Request result
        debugPrint("[\(response.statusCode)] '\(url)'")
        
        if !(200...299).contains(response.statusCode) {
            throw httpError(response.statusCode)
        }
        // Return Response data
        return output.data
    }
    
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}

struct APIClient {
    
    static var networkDispatcher: NetworkDispatcher = NetworkDispatcher()
    
    /// Dispatches a Request and returns a publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded data or an error
    static func dispatch<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: APIConstants.basedURL) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        typealias RequestPublisher = AnyPublisher<R.ReturnType, NetworkRequestError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}
