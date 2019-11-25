import Foundation

protocol UUIDProtocol {
    var uuidString: String { get }
}

extension UUID: UUIDProtocol { }
