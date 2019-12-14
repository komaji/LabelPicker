//
//  LabelPickerComponent.swift
//  LabelPicker
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import UIKit

public struct LabelPickerComponent {
    
    public let items: ItemsComponent
    public let label: LabelComponent
    
    public init(items: ItemsComponent, label: LabelComponent) {
        self.items = items
        self.label = label
    }
    
    public func attributedItem(index: Int) -> NSAttributedString {
        return NSAttributedString(string: items.items[index], attributes: items.attributes)
    }
    
}

extension LabelPickerComponent {
    
    var maxContentWidth: CGFloat {
        return items.maxWidth + label.width
    }

}
