//
//  LabelPickerComponentTests.swift
//  LabelPicker
//
//  Created by KojimaTatsuya on 2017/04/03.
//  Copyright © 2017年 komaji. All rights reserved.
//

import XCTest
@testable import LabelPicker

class LabelPickerComponentTests: XCTestCase {
    
    let labelPickerComponent = LabelPickerComponent(
        items: ["1"],
        itemAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)],
        maxItemWidth: 10.0,
        labelName: "num",
        labelAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)],
        labelNameWidth: 30.0
    )
    
    func testMaxContentWidth() {
        XCTAssertEqual(labelPickerComponent.maxContentWidth, 40.0)
    }
    
    func testAttributedLabelName() {
        let attributedLabel = NSAttributedString(
            string: "num",
            attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)]
        )
        
        XCTAssertTrue(labelPickerComponent.attributedLabelName.isEqual(to: attributedLabel))
    }
    
    func testAttributedItem() {
        let attributedItem = NSAttributedString(
            string: "1",
            attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)]
        )
        
        XCTAssertTrue(labelPickerComponent.attributedItem(index: 0).isEqual(to: attributedItem))
    }
    
}
