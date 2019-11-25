import Foundation

protocol JSONEncoderProtocol {
    var outputFormatting: JSONEncoder.OutputFormatting { get set }
    var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy { get set }
    
    func encode<T>(_ value: T) throws -> Data where T: Encodable
}

extension JSONEncoder: JSONEncoderProtocol { }
