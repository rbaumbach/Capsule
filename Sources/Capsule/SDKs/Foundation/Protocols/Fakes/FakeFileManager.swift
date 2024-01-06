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

public class FakeFileManager: FileManagerProtocol {
    // MARK: - Captured properties
    
    public var capturedSearchPathDirectory: FileManager.SearchPathDirectory?
    public var capturedSearchPathDomainMask: FileManager.SearchPathDomainMask?
    
    public var capturedFileExistsPath: String?
    
    public var capturedCreateDirectoryURL: URL?
    public var capturedCreateDirectoryCreateIntermediates: Bool?
    public var capturedCreateDirectoryAttributes: [FileAttributeKey: Any]?
    
    // MARK: - Stubbed properties
        
    public var stubbedTemporaryDirectory: URL = {
        var components = URLComponents()
        components.scheme = "file"
        components.host = ""
        components.path = "/fake-temp-directory"
        
        return components.url!
    }()
    
    public var stubbedFileExistsPath = false
    
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - <FileManagerProtocol>
    
    public var temporaryDirectory: URL {
        return stubbedTemporaryDirectory
    }
    
    public func urls(for directory: FileManager.SearchPathDirectory,
                     in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
        capturedSearchPathDirectory = directory
        capturedSearchPathDomainMask = domainMask
                        
        return [stubSystemDirectory(for: directory)]
    }
    
    public func fileExists(atPath path: String) -> Bool {
        capturedFileExistsPath = path
        
        return stubbedFileExistsPath
    }
    
    public func createDirectory(at url: URL,
                                withIntermediateDirectories createIntermediates: Bool,
                                attributes: [FileAttributeKey: Any]?) throws {
        capturedCreateDirectoryURL = url
        capturedCreateDirectoryCreateIntermediates = createIntermediates
        capturedCreateDirectoryAttributes = attributes
    }
    
    // MARK: - Private stub methods
    
    private func stubSystemDirectory(for searchPathDirectory: FileManager.SearchPathDirectory) -> URL {
        var components = URLComponents()
        components.scheme = "file"
        components.host = ""
        
        if searchPathDirectory == .documentDirectory {
            components.path = "/fake-documents-directory"
        } else if searchPathDirectory == .libraryDirectory {
            components.path = "/fake-library-directory"
        } else if searchPathDirectory == .cachesDirectory {
            components.path = "/fake-caches-directory"
        } else if searchPathDirectory == .applicationSupportDirectory {
            components.path = "/fake-application-support-directory"
        } else {
            preconditionFailure("Attempted to create invalid iOS searchPathDirectory: \(searchPathDirectory)")
        }

        return components.url!
    }
}
