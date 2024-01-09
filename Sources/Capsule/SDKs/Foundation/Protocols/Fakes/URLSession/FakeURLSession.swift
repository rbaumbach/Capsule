//MIT License
//
//Copyright (c) 2020-2024 Ryan Baumbach <github@ryan.codes>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
public class FakeURLSession: URLSessionProtocol {
    // MARK: - Captured properties
    
    public var capturedInitConfiguration: URLSessionConfiguration?
    
    public var capturedDelegateInitConfiguration: URLSessionConfiguration?
    public var capturedDelegateInitDelegate: URLSessionDelegate?
    public var capturedDelegateInitDelegateQueue: OperationQueue?
    
    public var capturedSessionDescription: String?
    
    public var capturedURLSessionConfiguration: URLSessionConfiguration?
    
    public var didCallFinishTasksAndInvalidate = false
    public var didCallInvalidateAndCancel = false
    
    public var capturedFlushCompletionHandler: (() -> Void)?
    public var capturedResetCompletionHandler: (() -> Void)?
    
    public var capturedGetTasksWithCompletionHandler: (([URLSessionDataTask], [URLSessionUploadTask], [URLSessionDownloadTask]) -> Void)?
    
    // MARK: - URLSession
    
    public var capturedDataTaskURL: URL?
    public var capturedDataTaskURLCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    public var capturedDataTaskURLRequest: URLRequest?
    public var capturedDataTaskURLRequestCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    public var capturedDownloadTaskURL: URL?
    public var capturedDownloadTaskURLCompletionHandler: ((URL?, URLResponse?, Error?) -> Void)?
    
    public var capturedDownloadTaskURLRequest: URLRequest?
    public var capturedDownloadTaskURLRequestCompletionHandler: ((URL?, URLResponse?, Error?) -> Void)?
    
    public var capturedUploadTaskURLRequest: URLRequest?
    public var capturedUploadTaskURLRequestBodyData: Data?
    public var capturedUploadTaskURLRequestCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    public var capturedUploadTaskFileURLRequest: URLRequest?
    public var capturedUploadTaskFileURL: URL?
    public var capturedUploadTaskFileURLRequestCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    // MARK: - Extended protocol return types
    
    public var capturedExtendedDataTaskURL: URL?
    public var capturedExtendedDataTaskURLCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    public var capturedExtendedDataTaskURLRequest: URLRequest?
    public var capturedExtendedDataTaskURLRequestCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    public var capturedExtendedDownloadTaskURL: URL?
    public var capturedExtendedDownloadTaskURLCompletionHandler: ((URL?, URLResponse?, Error?) -> Void)?
    
    public var capturedExtendedDownloadTaskURLRequest: URLRequest?
    public var capturedExtendedDownloadTaskURLRequestCompletionHandler: ((URL?, URLResponse?, Error?) -> Void)?
    
    public var capturedExtendedUploadTaskURLRequest: URLRequest?
    public var capturedExtendedUploadTaskURLRequestBodyData: Data?
    public var capturedExtendedUploadTaskURLRequestCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    public var capturedExtendedUploadTaskFileURLRequest: URLRequest?
    public var capturedExtendedUploadTaskFileURL: URL?
    public var capturedExtendedUploadTaskFileURLRequestCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    // MARK: - Stubbed properties
    
    public var stubbedSessionDescription: String? = "A Sesh"
    
    public var stubbedURLSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration()
    
    public var stubbedDelegateQueue = OperationQueue()
    
    public var stubbedDelegate: URLSessionDelegate? = FakeURLSessionDelegate()
    
    public var stubbedGetDataTasks: [URLSessionDataTask] = []
    public var stubbedGetUploadTasks: [URLSessionUploadTask] = []
    public var stubbedGetDowloadTasks: [URLSessionDownloadTask] = []
    
    // MARK: - URLSession
    
    // Note: Unfortunately there isn't away to "init()" an instance of a URLSessionData/Download/Upload-Task or it's parent
    // URLSessionTask without creating a deprecation warning. Unfortunately using
    // URLSession.shared.data/download/upload-Task() does some real networking even if the URL is fake as shown below.
    
    public var stubbedDataTaskForURL = URLSession.shared.dataTask(with: URL(string: "https://simon-nope-not-working-jj009.codes")!)
    public var stubbedDataTaskURLData: Data? = "simon".data(using: .utf8)
    public var stubbedDataTaskURLResponse: URLResponse? = URLResponse()
    public var stubbedDataTaskURLError: Error? = FakeGenericError.whoCares
    
    public var stubbedDataTaskForURLRequest = URLSession.shared.dataTask(with: URL(string: "https://trevor-nope-not-working-jj009.codes")!)
    public var stubbedDataTaskURLRequestData: Data? = "trevor".data(using: .utf8)
    public var stubbedDataTaskURLRequestResponse: URLResponse? = URLResponse()
    public var stubbedDataTaskURLRequestError: Error? = FakeGenericError.whoCares
    
    public var stubbedDownloadTaskForURL: URLSessionDownloadTask = {
        let url = URL(string: "https://richter-nope-not-working-jj009.codes")!
        
        return URLSession.shared.downloadTask(with: url)
    }()
    public var stubbedDownloadTaskURL: URL? = URL(string: "https://richter-nope-not-working-jj009.codes")!
    public var stubbedDownloadTaskURLResponse: URLResponse? = URLResponse()
    public var stubbedDownloadTaskURLError: Error? = FakeGenericError.whoCares
    
    public var stubbedDownloadTaskForURLRequest: URLSessionDownloadTask = {
        let url = URL(string: "https://christopher-nope-not-working-jj009.codes")!
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.downloadTask(with: urlRequest)
    }()
    public var stubbedDownloadTaskURLRequestURL: URL? = URL(string: "https://christopher-nope-not-working-jj009.codes")!
    public var stubbedDownloadTaskURLRequestResponse: URLResponse? = URLResponse()
    public var stubbedDownloadTaskURLRequestError: Error? = FakeGenericError.whoCares
    
    public var stubbedUploadTaskForURLRequest: URLSessionUploadTask = {
        let url = URL(string: "https://juste-nope-not-working-jj009.codes")!
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.uploadTask(with: urlRequest,
                                            from: "juste".data(using: .utf8)!)
    }()
    public var stubbedUploadTaskURLRequestData: Data? = "juste".data(using: .utf8)
    public var stubbedUploadTaskURLRequestResponse: URLResponse? = URLResponse()
    public var stubbedUploadTaskURLRequestError: Error? = FakeGenericError.whoCares
    
    public var stubbedUploadTaskFileURLForURL: URLSessionUploadTask = {
        let url = URL(string: "https://leon-nope-not-working-jj009.codes")!
        let urlRequest = URLRequest(url: url)
        
        return URLSession.shared.uploadTask(with: urlRequest,
                                            from: "leon".data(using: .utf8)!)
    }()
    public var stubbedUploadTaskFileURLData: Data? = "leon".data(using: .utf8)
    public var stubbedUploadTaskFileURLResponse: URLResponse? = URLResponse()
    public var stubbedUploadTaskFileURLError: Error? = FakeGenericError.whoCares

    // MARK: - Extended protocol return types
    
    public var stubbedExtendedDataTaskForURL = FakeURLSessionTask()
    public var stubbedExtendedDataTaskWithURLData: Data? = "sypha".data(using: .utf8)
    public var stubbedExtendedDataTaskWithURLResponse: URLResponse? = URLResponse()
    public var stubbedExtendedDataTaskWithURLError: Error? = FakeGenericError.whoCares
    
    public var stubbedExtendedDataTaskForURLRequest = FakeURLSessionTask()
    public var stubbedExtendedDataTaskWithURLRequestData: Data? = "royd".data(using: .utf8)
    public var stubbedExtendedDataTaskWithURLRequestURLResponse: URLResponse? = URLResponse()
    public var stubbedExtendedDataTaskWithURLRequestURLError: Error? = FakeGenericError.whoCares
    
    public var stubbedExtendedDownloadTaskForURL = FakeURLSessionTask()
    public var stubbedExtendedDownloadTaskURL: URL? = URL(string: "https://cynthia-nope-not-working-jj009.codes")!
    public var stubbedExtendedDownloadTaskURLResponse: URLResponse? = URLResponse()
    public var stubbedExtendedDownloadTaskURLError: Error? = FakeGenericError.whoCares
    
    public var stubbedExtendedDownloadTaskForURLRequest = FakeURLSessionTask()
    public var stubbedExtendedDownloadTaskURLRequestURL: URL? = URL(string: "https://annette-nope-not-working-jj009.codes")!
    public var stubbedExtendedDownloadTaskURLRequestResponse: URLResponse? = URLResponse()
    public var stubbedExtendedDownloadTaskURLRequestError: Error? = FakeGenericError.whoCares
    
    public var stubbedExtendedUploadTaskForURLRequest = FakeURLSessionTask()
    public var stubbedExtendedUploadTaskURLRequestData: Data? = "rayph".data(using: .utf8)
    public var stubbedExtendedUploadTaskURLRequestResponse: URLResponse? = URLResponse()
    public var stubbedExtendedUploadTaskURLRequestError: Error? = FakeGenericError.whoCares
    
    public var stubbedExtendedUploadTaskFileURLForURL = FakeURLSessionTask()
    public var stubbedExtendedUploadTaskFileURLData: Data? = "janis".data(using: .utf8)
    public var stubbedExtendedUploadTaskFileURLResponse: URLResponse? = URLResponse()
    public var stubbedExtendedUploadTaskFileURLError: Error? = FakeGenericError.whoCares
    
    // MARK: - Public properties
    
    public var shouldExecuteCompletionHandlersImmediately = false
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <URLSessionProtocol>
    
    public required init(configuration: URLSessionConfiguration) {
        capturedInitConfiguration = configuration
    }
    
    public required init(configuration: URLSessionConfiguration, 
                         delegate: URLSessionDelegate?,
                         delegateQueue queue: OperationQueue?) {
        capturedDelegateInitConfiguration = configuration
        capturedDelegateInitDelegate = delegate
        capturedDelegateInitDelegateQueue = delegateQueue
    }
    
    public var sessionDescription: String? {
        get {
            return stubbedSessionDescription
        }
        
        set {
            capturedSessionDescription = newValue
        }
    }
    
    public var configuration: URLSessionConfiguration {
        get {
            return stubbedURLSessionConfiguration
        }
        
        set {
            capturedURLSessionConfiguration = newValue
        }
    }
    
    public var delegateQueue: OperationQueue {
        return stubbedDelegateQueue
    }
    
    public var delegate: URLSessionDelegate? {
        return stubbedDelegate
    }
    
    public func finishTasksAndInvalidate() {
        didCallFinishTasksAndInvalidate = true
    }
    
    public func invalidateAndCancel() {
        didCallInvalidateAndCancel = true
    }
    
#if swift(>=5.5)
    public func flush(completionHandler: @escaping @Sendable () -> Void) {
        capturedFlushCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler()
        }
    }
    
    public func reset(completionHandler: @escaping @Sendable () -> Void) {
        capturedResetCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler()
        }
    }
    
    public func getTasksWithCompletionHandler(_ completionHandler: 
                                              @escaping @Sendable ([URLSessionDataTask], [URLSessionUploadTask], [URLSessionDownloadTask]) -> Void) {
        capturedGetTasksWithCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedGetDataTasks,
                              stubbedGetUploadTasks,
                              stubbedGetDowloadTasks)
        }
    }
#else
    public func flush(completionHandler: @escaping () -> Void) {
        capturedFlushCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler()
        }
    }
    
    public func reset(completionHandler: @escaping () -> Void) {
        capturedResetCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler()
        }
    }
    
    public func getTasksWithCompletionHandler(_ completionHandler: 
                                              @escaping ([URLSessionDataTask], [URLSessionUploadTask], [URLSessionDownloadTask]) -> Void) {
        capturedGetTasksWithCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedGetDataTasks,
                              stubbedGetUploadTasks,
                              stubbedGetDowloadTasks)
        }
    }
#endif
    
#if swift(>=5.5)
    // MARK: - URLSession
    
    public func dataTask(with url: URL,
                         completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedDataTaskURL = url
        capturedDataTaskURLCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDataTaskURLData, 
                              stubbedDataTaskURLResponse,
                              stubbedDataTaskURLError)
        }
        
        return stubbedDataTaskForURL
    }
    
    public func dataTask(with urlRequest: URLRequest,
                         completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedDataTaskURLRequest = urlRequest
        capturedDataTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDataTaskURLRequestData, 
                              stubbedDataTaskURLRequestResponse,
                              stubbedDataTaskURLRequestError)
        }
        
        return stubbedDataTaskForURLRequest
    }
    
    public func downloadTask(with url: URL,
                             completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        capturedDownloadTaskURL = url
        capturedDownloadTaskURLCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDownloadTaskURL, 
                              stubbedDownloadTaskURLResponse,
                              stubbedDownloadTaskURLError)
        }
        
        return stubbedDownloadTaskForURL
    }
    
    public func downloadTask(with request: URLRequest,
                             completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        capturedDownloadTaskURLRequest = request
        capturedDownloadTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDownloadTaskURLRequestURL, 
                              stubbedDownloadTaskURLRequestResponse,
                              stubbedDownloadTaskURLRequestError)
        }
        
        return stubbedDownloadTaskForURLRequest
    }
    
    public func uploadTask(with request: URLRequest,
                           from bodyData: Data?,
                           completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        capturedUploadTaskURLRequest = request
        capturedUploadTaskURLRequestBodyData = bodyData
        capturedUploadTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedUploadTaskURLRequestData, 
                              stubbedUploadTaskURLRequestResponse,
                              stubbedUploadTaskURLRequestError)
        }
        
        return stubbedUploadTaskForURLRequest
    }
    
    public func uploadTask(with request: URLRequest,
                           fromFile fileURL: URL,
                           completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        capturedUploadTaskFileURLRequest = request
        capturedUploadTaskFileURL = fileURL
        capturedUploadTaskFileURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedUploadTaskFileURLData,
                              stubbedUploadTaskFileURLResponse,
                              stubbedUploadTaskFileURLError)
        }
        
        return stubbedUploadTaskFileURLForURL
    }
    
    // MARK: - Extended protocol return types
    
    public func dataTask(url: URL,
                         completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedDataTaskURL = url
        capturedExtendedDataTaskURLCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedDataTaskWithURLData,
                              stubbedExtendedDataTaskWithURLResponse,
                              stubbedExtendedDataTaskWithURLError)
        }
        
        return stubbedExtendedDataTaskForURL
    }
    
    public func dataTask(request: URLRequest,
                         completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedDataTaskURLRequest = request
        capturedExtendedDataTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedDataTaskWithURLRequestData, 
                              stubbedExtendedDataTaskWithURLRequestURLResponse,
                              stubbedExtendedDataTaskWithURLRequestURLError)
        }
        
        return stubbedExtendedDataTaskForURLRequest
    }
    
    public func downloadTask(url: URL,
                             completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedDownloadTaskURL = url
        capturedExtendedDownloadTaskURLCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedDownloadTaskURL,
                              stubbedExtendedDownloadTaskURLResponse,
                              stubbedExtendedDownloadTaskURLError)
        }
        
        return stubbedExtendedDownloadTaskForURL
    }
    
    public func downloadTask(request: URLRequest,
                             completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedDownloadTaskURLRequest = request
        capturedExtendedDownloadTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedDownloadTaskURLRequestURL,
                              stubbedExtendedDownloadTaskURLRequestResponse,
                              stubbedExtendedDownloadTaskURLRequestError)
        }
        
        return stubbedExtendedDownloadTaskForURLRequest
    }
    
    public func uploadTask(request: URLRequest,
                           from bodyData: Data?,
                           completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedUploadTaskURLRequest = request
        capturedExtendedUploadTaskURLRequestBodyData = bodyData
        capturedExtendedUploadTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedUploadTaskURLRequestData,
                              stubbedExtendedUploadTaskURLRequestResponse,
                              stubbedExtendedUploadTaskURLRequestError)
        }
        
        return stubbedExtendedUploadTaskForURLRequest
    }
    
    public func uploadTask(request: URLRequest,
                           fromFile fileURL: URL,
                           completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedUploadTaskFileURLRequest = request
        capturedExtendedUploadTaskFileURL = fileURL
        capturedExtendedUploadTaskFileURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedUploadTaskFileURLData,
                              stubbedExtendedUploadTaskFileURLResponse,
                              stubbedExtendedUploadTaskFileURLError)
        }
        
        return stubbedExtendedUploadTaskFileURLForURL
    }
#else
    // MARK: - URLSession
    
    public func dataTask(with url: URL,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedURL = url
        capturedCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDataTaskData, stubbedDataTaskURLResponse, stubbedDataTaskURLError)
        }
        
        return stubbedDataTask
    }
    
    public func dataTask(with urlRequest: URLRequest,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedDataTaskURLRequest = urlRequest
        capturedDataTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDataTaskURLRequestData,
                              stubbedDataTaskURLRequestResponse,
                              stubbedDataTaskURLRequestError)
        }
        
        return stubbedDataTaskForURLRequest
    }
    
    public func downloadTask(with url: URL,
                             completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        capturedDownloadTaskURL = url
        capturedDownloadTaskURLCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDownloadTaskURL,
                              stubbedDownloadTaskURLResponse,
                              stubbedDownloadTaskURLError)
        }
        
        return stubbedDownloadTaskForURL
    }
    
    public func downloadTask(with request: URLRequest,
                             completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        capturedDownloadTaskURLRequest = request
        capturedDownloadTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedDownloadTaskURLRequestURL,
                              stubbedDownloadTaskURLRequestResponse,
                              stubbedDownloadTaskURLRequestError)
        }
        
        return stubbedDownloadTaskForURLRequest
    }
    
    public func uploadTask(with request: URLRequest,
                           from bodyData: Data?,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        capturedUploadTaskURLRequest = request
        capturedUploadTaskURLRequestBodyData = bodyData
        capturedUploadTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedUploadTaskURLRequestData,
                              stubbedUploadTaskURLRequestResponse,
                              stubbedUploadTaskURLRequestError)
        }
        
        return stubbedUploadTaskForURLRequest
    }
    
    public func uploadTask(with request: URLRequest,
                           fromFile fileURL: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask {
        capturedUploadTaskFileURLRequest = request
        capturedUploadTaskFileURL = fileURL
        capturedUploadTaskFileURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedUploadTaskFileURLData,
                              stubbedUploadTaskFileURLResponse,
                              stubbedUploadTaskFileURLError)
        }
        
        return stubbedUploadTaskFileURLForURL
    }
        
    // MARK: - Extended protocol return types
    
    public func dataTask(url: URL,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedDataTaskURL = url
        capturedExtendedDataTaskURLCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedDataTaskWithURLData,
                              stubbedExtendedDataTaskWithURLResponse,
                              stubbedExtendedDataTaskWithURLError)
        }
        
        return stubbedExtendedDataTaskForURL
    }
    
    public func dataTask(request: URLRequest,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedDataTaskURLRequest = request
        capturedExtendedDataTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedDataTaskWithURLRequestData,
                              stubbedExtendedDataTaskWithURLRequestURLResponse,
                              stubbedExtendedDataTaskWithURLRequestURLError)
        }
        
        return stubbedExtendedDataTaskForURLRequest
    }
    
    public func downloadTask(url: URL,
                             completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedDownloadTaskURL = url
        capturedExtendedDownloadTaskURLCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedDownloadTaskURL,
                              stubbedExtendedDownloadTaskURLResponse,
                              stubbedExtendedDownloadTaskURLError)
        }
        
        return stubbedExtendedDownloadTaskForURL
    }
    
    public func downloadTask(request: URLRequest,
                             completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedDownloadTaskURLRequest = request
        capturedExtendedDownloadTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedDownloadTaskURLRequestURL,
                              stubbedExtendedDownloadTaskURLRequestResponse,
                              stubbedExtendedDownloadTaskURLRequestError)
        }
        
        return stubbedExtendedDownloadTaskForURLRequest
    }
    
    public func uploadTask(request: URLRequest,
                           from bodyData: Data?,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedUploadTaskURLRequest = request
        capturedExtendedUploadTaskURLRequestBodyData = bodyData
        capturedExtendedUploadTaskURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedUploadTaskURLRequestData,
                              stubbedExtendedUploadTaskURLRequestResponse,
                              stubbedExtendedUploadTaskURLRequestError)
        }
        
        return stubbedExtendedUploadTaskForURLRequest
    }
    
    public func uploadTask(request: URLRequest,
                           fromFile fileURL: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        capturedExtendedUploadTaskFileURLRequest = request
        capturedExtendedUploadTaskFileURL = fileURL
        capturedExtendedUploadTaskFileURLRequestCompletionHandler = completionHandler
        
        if shouldExecuteCompletionHandlersImmediately {
            completionHandler(stubbedExtendedUploadTaskFileURLData,
                              stubbedExtendedUploadTaskFileURLResponse,
                              stubbedExtendedUploadTaskFileURLError)
        }
        
        return stubbedExtendedUploadTaskFileURLForURL
    }
#endif
}
// swiftlint:enable type_body_length
// swiftlint:enable file_length
