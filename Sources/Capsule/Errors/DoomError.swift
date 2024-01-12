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

// Note: The purpose of this DrDoo, eh I mean Doom error is to be used as a "catch-all" for unrecoverable situations

public enum DoomError: Error, CaseIterable, LocalizedError, Equatable {
    case doom(_ info: Any? = nil)
    
    // MARK: - <CaseIterable>
    
    public static var allCases: [DoomError] {
        return [.doom()]
    }
    
    // MARK: - <Error>
    
    public var localizedDescription: String {
        var localizedDescription = "Something seriously went wrong"
        
        switch self {
        case .doom(let info):
            if let info = info {
                localizedDescription.append(", info:\n\(info)")
            }
        }
        
        return localizedDescription
    }
    
    // MARK: - <LocalizedError>
    
    public var errorDescription: String? {
        return localizedDescription
    }
    
    public var failureReason: String? {
        return localizedDescription
    }
    
    public var recoverySuggestion: String? {
        let suggesstion = """
        There doesnt' seem to be any recovery for this error. Check
        your environemnt and/or software implementation
        """
        return "There doesn't seem to be any recovery for this error."
    }
    
    // MARK: - <Equatable>
    
    public static func == (lhs: DoomError, rhs: DoomError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
