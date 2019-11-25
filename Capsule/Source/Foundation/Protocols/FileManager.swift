import Foundation

// MARK: - FileManager

protocol FileManagerProtocol {
    var temporaryDirectory: URL { get }

    func urls(for directory: FileManager.SearchPathDirectory,
              in domainMask: FileManager.SearchPathDomainMask) -> [URL]
    
    func fileExists(atPath path: String) -> Bool
    
    func createDirectory(at url: URL,
                         withIntermediateDirectories createIntermediates: Bool,
                         attributes: [FileAttributeKey: Any]?) throws
}

extension FileManager: FileManagerProtocol { }
