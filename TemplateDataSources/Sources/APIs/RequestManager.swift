//
//  RequestManager.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//

import Combine
import Moya
import SwiftyBeaver

public protocol RequestManagerType {
    func requestPublisher<Request: RequestTargetType>(_ request: Request) -> AnyPublisher<Request.Response, Error>
    func requestPublisher<Response: Decodable, Request: RequestTargetType>(_ request: Request) -> AnyPublisher<ResponseWithHeader<Response>, Error>
}

public final class RequestManager: RequestManagerType {

    public static let shared = RequestManager()

    private init() {}

    private let provider: MoyaProvider<MultiTarget> = {

        let entry = { (key: String, value: String, _: TargetType) -> String in
            return "\(key): \(value)"
        }

        let formmter = NetworkLoggerPlugin.Configuration.Formatter(entry: entry)

        let output = { (_: TargetType, outputs: [String]) -> Void in
            outputs
                // Responseのheaderがdefaultでlog表示されるので、それは表示しない
                .filter { !$0.hasPrefix("Response:") }
                .forEach {
                    if $0.hasPrefix("Error:") {
                        SwiftyBeaver.error($0)
                    } else {
                        SwiftyBeaver.debug($0)
                    }
                }
        }

        let config = NetworkLoggerPlugin.Configuration(formatter: formmter, output: output, logOptions: [.requestHeaders, .requestBody, .requestMethod, .errorResponseBody])

        let loggerPlugin = NetworkLoggerPlugin(configuration: config)

        let urlSessionConfiguration = URLSessionConfiguration.af.default
        urlSessionConfiguration.timeoutIntervalForRequest = 30
        urlSessionConfiguration.timeoutIntervalForResource = 30
        let session = Session(configuration: urlSessionConfiguration)

        return MoyaProvider(session: session, plugins: [loggerPlugin])
    }()

    public func requestPublisher<Request: RequestTargetType>(_ request: Request) -> AnyPublisher<Request.Response, Error> {
        let target = MultiTarget(request)
        return provider.requestPublisher(target)
            .mapError { $0 as Error }
            .flatMap { [weak self] result -> AnyPublisher<Request.Response, Error> in
                guard let self = self else { return Empty<Request.Response, Error>().eraseToAnyPublisher() }
                do {
                    let response: Request.Response = try self.handleResponse(result: result)
                    return Just(response)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } catch let e {
                    return Fail(outputType: Request.Response.self, failure: e)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    public func requestPublisher<Response: Decodable, Request: RequestTargetType>(_ request: Request) -> AnyPublisher<ResponseWithHeader<Response>, Error> {
        let target = MultiTarget(request)

        return provider.requestPublisher(target)
            .mapError { $0 as Error }
            .flatMap { [weak self] result -> AnyPublisher<ResponseWithHeader<Response>, Error> in
                guard let self = self else { return Empty<ResponseWithHeader<Response>, Error>().eraseToAnyPublisher() }
                do {
                    let response: Response = try self.handleResponse(result: result)
                    let reponseWithHeader = ResponseWithHeader(header: result.response?.allHeaderFields ?? [:], body: response)
                    return Just(reponseWithHeader)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } catch let e {
                    return Fail(outputType: ResponseWithHeader<Response>.self, failure: e)
                        .eraseToAnyPublisher()
                }
            }
            .mapError(handleError)
            .eraseToAnyPublisher()
    }

    private func handleError(_ error: Error) -> Error {
        guard let moyaError = error as? MoyaError else { return error }
        switch moyaError {
        case .underlying(let error, _):
            if error.asAFError?.isSessionTaskError ?? false {
                return DataSourceError.requestTimeout
            }
        default:
            break
        }
        return error
    }

    private func handleResponse<Response: Decodable>(result: Moya.Response) throws -> Response {
        do {
            // ErrorのMapping
            guard (200..<300).contains(result.statusCode) else {
                guard let dictionary = try? JSONSerialization.jsonObject(with: result.data),
                    let errorBody: [String: Any] = dictionary as? [String: Any],
                    let error: [String: Any] = errorBody["error"] as? [String: Any],
                    let message: String = error["message"] as? String,
                    let typeStr: String = error["type"] as? String else { throw DataSourceError.invalidErrorMessage }
                SwiftyBeaver.error(message)
                throw ErrorResponse(message: message, type: ErrorType(rawValue: typeStr), statusCode: result.statusCode)
            }

            // status codeが204の時はNoContentsResponseを返す
            if result.statusCode == 204, let noContent = NoContentsResponse() as? Response {
                return noContent
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try result.map(Response.self, using: decoder)
            return response
        } catch let e {
            throw e
        }
    }
}
