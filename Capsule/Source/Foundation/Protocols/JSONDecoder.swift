import Foundation

protocol JSONDecoderProtocol {
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get set }
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: JSONDecoderProtocol { }
