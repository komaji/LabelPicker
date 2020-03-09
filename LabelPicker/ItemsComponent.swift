//
//  ItemsComponent.swift
//  LabelPicker
//
//  Created by komaji on 2019/12/14.
//  Copyright © 2019 komaji. All rights reserved.
//

import UIKit

public struct ItemsComponent {
    
    public let items: [String]
    public let attributes: [NSAttributedString.Key: Any]
    public let maxWidth: CGFloat
    
    public init(items: [String], attributes: [NSAttributedString.Key: Any], maxWidth: CGFloat) {
        self.items = items
        self.attributes = attributes
        self.maxWidth = maxWidth
    }
    
}
