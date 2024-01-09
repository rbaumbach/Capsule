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

public protocol URLSessionProtocol {
    init(configuration: URLSessionConfiguration)
    init(configuration: URLSessionConfiguration,
         delegate: URLSessionDelegate?,
         delegateQueue queue: OperationQueue?)
    
    var sessionDescription: String? { get set }
    var configuration: URLSessionConfiguration { get }
    
    var delegateQueue: OperationQueue { get }
    var delegate: URLSessionDelegate? { get }
    
    func finishTasksAndInvalidate()
    func invalidateAndCancel()
    
#if swift(>=5.5)
    func flush(completionHandler: @escaping @Sendable () -> Void)
    func reset(completionHandler: @escaping @Sendable () -> Void)
    
    func getTasksWithCompletionHandler(_ completionHandler: 
                                       @escaping @Sendable ([URLSessionDataTask], [URLSessionUploadTask], [URLSessionDownloadTask]) -> Void)
#else
    func flush(completionHandler: @escaping () -> Void)
    func reset(completionHandler: @escaping () -> Void)
    
    func getTasksWithCompletionHandler(_ completionHandler: 
                                       @escaping ([URLSessionDataTask], [URLSessionUploadTask], [URLSessionDownloadTask]) -> Void)
#endif
    
    // MARK: - URLSessionTask
    
#if swift(>=5.5)
    
    // MARK: - URLSession
    
    func dataTask(with url: URL,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    func dataTask(with urlRequest: URLRequest,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    func downloadTask(with url: URL,
                      completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
    
    func downloadTask(with request: URLRequest,
                      completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
    
    func uploadTask(with request: URLRequest,
                    from bodyData: Data?,
                    completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
    
    func uploadTask(with request: URLRequest,
                    fromFile fileURL: URL,
                    completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
    
    // MARK: - Extended protocol return types
    
    // Note: In order to bypass the 'Ambiguous use of 'data/download/uploadTask(with:completionHandler:)''
    // compile time error, the method signaure of these methods differ only by a slight parameter name change
    // from the Foundation method signatures.
    // Ex: Foundation Method -> func dataTask(with:completionHandler:)
    //     Extension Method  -> func dataTask(url:completionHandler:)
    // 'with' is replaced by 'url'
    
    func dataTask(url: URL,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func dataTask(request: URLRequest,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func downloadTask(url: URL,
                      completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func downloadTask(request: URLRequest,
                      completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func uploadTask(request: URLRequest,
                    from bodyData: Data?,
                    completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func uploadTask(request: URLRequest,
                    fromFile fileURL: URL,
                    completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
#else
    // MARK: - URLSession
    
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    func dataTask(with urlRequest: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    func downloadTask(with url: URL,
                      completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
    
    func downloadTask(with request: URLRequest,
                      completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
    
    func uploadTask(with request: URLRequest,
                    from bodyData: Data?,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
    
    func uploadTask(with request: URLRequest,
                    fromFile fileURL: URL,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
    
    // MARK: - Extended protocol return types
    
    func dataTask(url: URL,
                  completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func dataTask(request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func downloadTask(url: URL,
                      completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func downloadTask(request: URLRequest,
                      completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func uploadTask(request: URLRequest,
                    from bodyData: Data?,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
    
    func uploadTask(request: URLRequest,
                    fromFile fileURL: URL,
                    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol
#endif
}

extension URLSession: URLSessionProtocol {
#if swift(>=5.5)
    public func dataTask(url: URL,
                         completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let dataTask: URLSessionDataTask = dataTask(with: url,
                                                    completionHandler: completionHandler)
        return dataTask
    }
    
    public func dataTask(request: URLRequest,
                         completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let dataTask: URLSessionDataTask = dataTask(with: request,
                                                    completionHandler: completionHandler)
        return dataTask
    }
    
    public func downloadTask(url: URL,
                             completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let downloadTask: URLSessionDownloadTask = downloadTask(with: url,
                                                                completionHandler: completionHandler)
        
        return downloadTask
    }
    
    public func downloadTask(request: URLRequest,
                             completionHandler: @escaping @Sendable (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let downloadTask: URLSessionDownloadTask = downloadTask(with: request,
                                                                completionHandler: completionHandler)
        
        return downloadTask
    }
    
    public func uploadTask(request: URLRequest,
                           from bodyData: Data?,
                           completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let uploadTask: URLSessionUploadTask = uploadTask(with: request,
                                                          from: bodyData,
                                                          completionHandler: completionHandler)
        
        return uploadTask
    }
    
    public func uploadTask(request: URLRequest,
                           fromFile fileURL: URL,
                           completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let uploadTask: URLSessionUploadTask = uploadTask(with: request,
                                                          fromFile: fileURL,
                                                          completionHandler: completionHandler)
        
        return uploadTask
    }
#else
    public func dataTask(url: URL,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let dataTask: URLSessionDataTask = dataTask(with: url,
                                                    completionHandler: completionHandler)
        return dataTask
    }
    
    public func dataTask(request: URLRequest,
                         completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let dataTask: URLSessionDataTask = dataTask(with: request,
                                                    completionHandler: completionHandler)
        return dataTask
    }
    
    public func downloadTask(url: URL,
                             completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let downloadTask: URLSessionDownloadTask = downloadTask(with: url,
                                                                completionHandler: completionHandler)
        
        return downloadTask
    }
    
    public func downloadTask(request: URLRequest,
                             completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let downloadTask: URLSessionDownloadTask = downloadTask(with: request,
                                                                completionHandler: completionHandler)
        
        return downloadTask
    }
    
    public func uploadTask(request: URLRequest,
                           from bodyData: Data?,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let uploadTask: URLSessionUploadTask = uploadTask(with: request,
                                                          from: bodyData,
                                                          completionHandler: completionHandler)
        
        return uploadTask
    }
    
    public func uploadTask(request: URLRequest,
                           fromFile fileURL: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTaskProtocol {
        let uploadTask: URLSessionUploadTask = uploadTask(with: request,
                                                          fromFile: fileURL,
                                                          completionHandler: completionHandler)
        
        return uploadTask
    }
#endif
}
