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

open class FakeFileManager: FileManagerProtocol {
    // MARK: - Captured properties
    
    public var capturedSearchPathDirectory: FileManager.SearchPathDirectory?
    public var capturedSearchPathDomainMask: FileManager.SearchPathDomainMask?
    
    public var capturedFileExistsPath: String?
    
    public var capturedCreateFilePath: String?
    public var capturedCreateFileData: Data?
    public var capturedCreateFileAttributes: [FileAttributeKey: Any]?
    
    public var capturedCreateDirectoryURL: URL?
    public var capturedCreateDirectoryCreateIntermediates: Bool?
    public var capturedCreateDirectoryAttributes: [FileAttributeKey: Any]?
    
    public var capturedCopyItemSRCURL: URL?
    public var capturedCopyItemDSTURL: URL?
    
    public var capturedCopyItemSRCPath: String?
    public var capturedCopyItemDSTPath: String?
    
    public var capturedMoveItemSRCURL: URL?
    public var capturedMoveItemDSTURL: URL?
    
    public var capturedMoveItemSRCPath: String?
    public var capturedMoveItemDSTPath: String?
    
    public var capturedRemoveItemURL: URL?
    public var capturedRemoveItemPath: String?
    
    public var capturedContentsPath: String?
    
    public var capturedContentsOfDirectoryURL: URL?
    public var capturedContentsOfDirectoryKeys: [URLResourceKey]?
    public var capturedContentsOfDirectoryOptions: FileManager.DirectoryEnumerationOptions?
    
    // MARK: - Stubbed properties
        
    public var stubbedTemporaryDirectory: URL = {
        var components = URLComponents()
        components.scheme = "file"
        components.host = ""
        components.path = "/fake-temp-directory/"
        
        return components.url!
    }()
    
    public var stubbedFileExistsPath = false
    
    public var stubbedCreateFile = false
    
    public var stubbedContentsData: Data? = "fred-fks".data(using: .utf8)
    
    public var stubbedContentsOfDirectoryURLs: [URL] = []
    
    // MARK: - Public properties
    
    public var shouldThrowCreateDirectoryError = false
    public var shouldThrowCopyError = false
    public var shouldThrowMoveError = false
    public var shouldThrowRemoveError = false
    public var shouldThrowContentsOfDirectoryError = false
    
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
    
    public func createFile(atPath path: String,
                           contents data: Data?,
                           attributes attr: [FileAttributeKey: Any]?) -> Bool {
        capturedCreateFilePath = path
        capturedCreateFileData = data
        capturedCreateFileAttributes = attr
        
        return stubbedCreateFile
    }
    
    public func createDirectory(at url: URL,
                                withIntermediateDirectories createIntermediates: Bool,
                                attributes: [FileAttributeKey: Any]?) throws {
        capturedCreateDirectoryURL = url
        capturedCreateDirectoryCreateIntermediates = createIntermediates
        capturedCreateDirectoryAttributes = attributes
        
        if shouldThrowCreateDirectoryError {
            throw FakeGenericError.whoCares
        }
    }
    
    public func copyItem(at srcURL: URL, to dstURL: URL) throws {
        capturedCopyItemSRCURL = srcURL
        capturedCopyItemDSTURL = dstURL
        
        if shouldThrowCopyError {
            throw FakeGenericError.whoCares
        }
    }
    
    public func copyItem(atPath srcPath: String, toPath dstPath: String) throws {
        capturedCopyItemSRCPath = srcPath
        capturedCopyItemDSTPath = dstPath
        
        if shouldThrowCopyError {
            throw FakeGenericError.whoCares
        }
    }
    
    public func moveItem(at srcURL: URL, to dstURL: URL) throws {
        capturedMoveItemSRCURL = srcURL
        capturedMoveItemDSTURL = dstURL
        
        if shouldThrowMoveError {
            throw FakeGenericError.whoCares
        }
    }
    
    public func moveItem(atPath srcPath: String, toPath dstPath: String) throws {
        capturedMoveItemSRCPath = srcPath
        capturedMoveItemDSTPath = dstPath
        
        if shouldThrowMoveError {
            throw FakeGenericError.whoCares
        }
    }
    
    public func removeItem(at URL: URL) throws {
        capturedRemoveItemURL = URL
        
        if shouldThrowRemoveError {
            throw FakeGenericError.whoCares
        }
    }
    
    public func removeItem(atPath path: String) throws {
        capturedRemoveItemPath = path
        
        if shouldThrowRemoveError {
            throw FakeGenericError.whoCares
        }
    }
    
    public func contents(atPath path: String) -> Data? {
        capturedContentsPath = path
        
        return stubbedContentsData
    }
    
    public func contentsOfDirectory(at url: URL,
                                    includingPropertiesForKeys keys: [URLResourceKey]?,
                                    options mask: FileManager.DirectoryEnumerationOptions) throws -> [URL] {
        capturedContentsOfDirectoryURL = url
        capturedContentsOfDirectoryKeys = keys
        capturedContentsOfDirectoryOptions = mask
        
        if shouldThrowContentsOfDirectoryError {
            throw FakeGenericError.whoCares
        }
        
        return stubbedContentsOfDirectoryURLs
    }
    
    // MARK: - Private stub methods
    
    private func stubSystemDirectory(for searchPathDirectory: FileManager.SearchPathDirectory) -> URL {
        var components = URLComponents()
        components.scheme = "file"
        components.host = ""
        
        if searchPathDirectory == .documentDirectory {
            components.path = "/fake-documents-directory/"
        } else if searchPathDirectory == .libraryDirectory {
            components.path = "/fake-library-directory/"
        } else if searchPathDirectory == .cachesDirectory {
            components.path = "/fake-caches-directory/"
        } else if searchPathDirectory == .applicationSupportDirectory {
            components.path = "/fake-application-support-directory/"
        } else {
            preconditionFailure("Attempted to create invalid iOS searchPathDirectory: \(searchPathDirectory)")
        }

        return components.url!
    }
}
