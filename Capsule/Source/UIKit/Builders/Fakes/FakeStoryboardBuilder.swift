//MIT License
//
//Copyright (c) 2019 Ryan Baumbach <github@ryan.codes>
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

class FakeStoyboardBuilder: StoryboardBuilderProtocol {
    // MARK: - Captured properties
    
    var capturedBuildInitialViewControllerName: String?
    
    var capturedBuildViewControllerName: String?
    var capturedBuildViewControllerIdentifier: String?
    
    // MARK: - Stubbed properties
    
    var stubbedBuildInitialViewController = UIViewController()
    
    var stubbedBuildViewController = UIViewController()
    
    // MARK: - <StoryboardBuilderProtocol>
    
    func buildInitialViewController<T: UIViewController>(name: String) -> T {
        guard let stubbedBuildInitialViewController = stubbedBuildViewController as? T else {
            preconditionFailure("FakeStoryboardBuilder.stubbedBuildInitialViewController property has not been set properly")
        }
        
        capturedBuildInitialViewControllerName = name
        
        return stubbedBuildInitialViewController
    }
    
    func buildViewController<T: UIViewController>(name: String, identifier: String) -> T {
        guard let stubbedBuildViewController = stubbedBuildViewController as? T else {
            preconditionFailure("FakeStoryboardBuilder.stubbedBuildViewController property has not been set properly")
        }
        
        capturedBuildViewControllerName = name
        capturedBuildViewControllerIdentifier = identifier
        
        return stubbedBuildViewController
    }
}
