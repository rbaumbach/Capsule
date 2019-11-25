import Foundation

class FakeUUID: UUIDProtocol {
    // MARK: - Stubbed properties
    
    var stubbedUUIDString = "uuid-amigos-012345"
    
    // MARK: - <UUIDProtocol>
    
    var uuidString: String {
        return stubbedUUIDString
    }
}
