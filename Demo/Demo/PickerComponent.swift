//
//  PickerComponent.swift
//  Demo
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import Foundation
import UIKit

public struct PickerComponent {
    
    public let items: [String]
    public let itemAttributes: [String: Any]
    public let label: String
    public let labelAttributes: [String: Any]
    public let maxItemWidth: CGFloat
    public let labelWidth: CGFloat
    public let widthRelativeRatio: Double
    
    public var defaultWidth: CGFloat {
        return maxItemWidth + labelWidth
    }
    
    public var attributedLabel: NSAttributedString {
        return NSAttributedString(string: label, attributes: labelAttributes)
    }
    
    public init(items: [String], itemAttributes: [String: Any], label: String, labelAttributes: [String: Any],  maxItemWidth: CGFloat, labelWidth: CGFloat, widthRelativeRatio: Double = 1.0) {
        self.items = items
        self.itemAttributes = itemAttributes
        self.label = label
        self.labelAttributes = labelAttributes
        self.maxItemWidth = maxItemWidth
        self.labelWidth = labelWidth
        self.widthRelativeRatio = widthRelativeRatio
    }
    
    public func attributedItem(index: Int) -> NSAttributedString {
        return NSAttributedString(string: items[index], attributes: itemAttributes)
    }
    
}
