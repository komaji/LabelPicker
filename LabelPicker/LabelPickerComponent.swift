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
    public let label: LabelComponent
    
    public init(itemSet: ItemSet, label: LabelComponent) {
        self.itemSet = itemSet
        self.label = label
    }
    
    public func attributedItem(index: Int) -> NSAttributedString {
        return NSAttributedString(string: itemSet.items[index], attributes: itemSet.attributes)
    }
    
}

extension LabelPickerComponent {
    
    var maxContentWidth: CGFloat {
        return itemSet.maxWidth + label.width
    }

}
