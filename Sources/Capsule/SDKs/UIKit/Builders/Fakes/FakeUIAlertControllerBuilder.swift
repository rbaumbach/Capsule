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

open class FakeUIAlertControllerBuilderProtocol: Fake, UIAlertControllerBuilderProtocol {
    // MARK: - Captured properties
    
    public var buildAlertTitle: String?
    public var buildAlertMessage: String?
    public var buildAlertStyle: UIAlertController.Style?
    public var buildAlertActions: [UIAlertActionWrapper]?
    
    // MARK: - Stubbed properties
    
    public var stubbedAlertController = UIAlertController()
    
    // MARK: - Init methods
    
    public override init() { }
    
    // MARK: - <UIAlertControllerBuilderProtocol>
    
    public func buildAlertController(title: String,
                                     message: String,
                                     style: UIAlertController.Style,
                                     actions: [UIAlertActionWrapper]) -> UIAlertController {
        buildAlertTitle = title
        buildAlertMessage = message
        buildAlertStyle = style
        buildAlertActions = actions
        
        return stubbedAlertController
    }
}
