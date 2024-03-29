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

import UIKit

public protocol StoryboardBuilderProtocol {
    func buildInitialViewController<T: UIViewController>(name: String) -> T
    func buildViewController<T: UIViewController>(name: String, identifier: String) -> T
}

open class StoryboardBuilder: StoryboardBuilderProtocol {
    // MARK: - Init methods
    
    public init() { }
    
    // MARK: - Public methods
    
    public func buildInitialViewController<T: UIViewController>(name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            preconditionFailure("Unable to instantiate intial view controller from storyboard named: \(name)")
        }
        
        return viewController
    }
    
    public func buildViewController<T: UIViewController>(name: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            preconditionFailure("Unable to instantiate view controller with identifier: \(identifier) from storyboard named: \(name)")
        }
        
        return viewController
    }
}
