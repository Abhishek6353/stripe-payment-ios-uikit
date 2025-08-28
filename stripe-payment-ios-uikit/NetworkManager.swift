import Alamofire
import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    private let session: Session

    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        self.session = Session(configuration: config)
    }

    // Generic request method
    private func performRequest<T: Codable>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: ["Accept": "application/json"]
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Public methods
    func get<T: Codable>(
        url: String,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        performRequest(url: url, method: .get, parameters: parameters, completion: completion)
    }

    func post<T: Codable>(
        url: String,
        parameters: Parameters,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        performRequest(url: url, method: .post, parameters: parameters, encoding: JSONEncoding.default, completion: completion)
    }
}
