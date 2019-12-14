//
//  LabelPickerComponent.swift
//  LabelPicker
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import UIKit

public struct LabelPickerComponent {
    
    public let itemSet: ItemSet
    public let labelName: String
    public let labelAttributes: [NSAttributedStringKey: Any]
    public let labelNameWidth: CGFloat
    
    public init(itemSet: ItemSet, labelName: String, labelAttributes: [NSAttributedStringKey: Any], labelNameWidth: CGFloat) {
        self.itemSet = itemSet
        self.labelName = labelName
        self.labelAttributes = labelAttributes
        self.labelNameWidth = labelNameWidth
    }
    
    public func attributedItem(index: Int) -> NSAttributedString {
        return NSAttributedString(string: itemSet.items[index], attributes: itemSet.attributes)
    }
    
}

extension LabelPickerComponent {
    
    var maxContentWidth: CGFloat {
        return itemSet.maxWidth + labelNameWidth
    }
    
    var attributedLabelName: NSAttributedString {
        return NSAttributedString(string: labelName, attributes: labelAttributes)
    }

}
