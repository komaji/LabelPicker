//
//  LabelPickerComponent.swift
//  LabelPicker
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import Foundation
import UIKit

public struct LabelPickerComponent {
    
    public let items: [String]
    public let itemAttributes: [NSAttributedStringKey: Any]
    public let maxItemWidth: CGFloat
    public let labelName: String
    public let labelAttributes: [NSAttributedStringKey: Any]
    public let labelNameWidth: CGFloat
    
    public init(items: [String], itemAttributes: [NSAttributedStringKey: Any], maxItemWidth: CGFloat, labelName: String, labelAttributes: [NSAttributedStringKey: Any], labelNameWidth: CGFloat) {
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

extension LabelPickerComponent {
    
    var maxContentWidth: CGFloat {
        return maxItemWidth + labelNameWidth
    }
    
    var attributedLabelName: NSAttributedString {
        return NSAttributedString(string: labelName, attributes: labelAttributes)
    }

}
