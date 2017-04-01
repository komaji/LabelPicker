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
    public let maxItemWidth: CGFloat
    public let labelName: String
    public let labelAttributes: [String: Any]
    public let labelNameWidth: CGFloat
    
    public var maxContentWidth: CGFloat {
        return maxItemWidth + labelNameWidth
    }
    
    public var attributedLabel: NSAttributedString {
        return NSAttributedString(string: labelName, attributes: labelAttributes)
    }
    
    public init(items: [String], itemAttributes: [String: Any], maxItemWidth: CGFloat, labelName: String, labelAttributes: [String: Any], labelNameWidth: CGFloat) {
        self.items = items
        self.itemAttributes = itemAttributes
        self.maxItemWidth = maxItemWidth
        self.labelName = labelName
        self.labelAttributes = labelAttributes
        self.labelNameWidth = labelNameWidth
    }
    
    public func attributedItem(index: Int) -> NSAttributedString {
        return NSAttributedString(string: items[index], attributes: itemAttributes)
    }
    
}
