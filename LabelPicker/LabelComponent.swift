//
//  LabelComponent.swift
//  LabelPicker
//
//  Created by komaji on 2019/12/14.
//  Copyright © 2019 komaji. All rights reserved.
//

import UIKit

public struct LabelComponent {
    
    public let name: String
    public let attributes: [NSAttributedString.Key: Any]
    public let width: CGFloat
    
    var attributedName: NSAttributedString {
        return NSAttributedString(string: name, attributes: attributes)
    }
    
}
