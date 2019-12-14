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
        items: ItemsComponent(
            items: ["1"],
            attributes: [.font: UIFont.systemFont(ofSize: 16.0)],
            maxWidth: 10.0
        ),
        label: LabelComponent(
            name: "num",
            attributes: [.font: UIFont.systemFont(ofSize: 16.0)],
            width: 30.0
        )
    )
    
    func testMaxContentWidth() {
        XCTAssertEqual(labelPickerComponent.maxContentWidth, 40.0)
    }
    
    func testAttributedLabelName() {
        let attributedLabel = NSAttributedString(
            string: "num",
            attributes: [.font: UIFont.systemFont(ofSize: 16.0)]
        )
        
        XCTAssertTrue(labelPickerComponent.label.attributedName.isEqual(to: attributedLabel))
    }
    
    func testAttributedItem() {
        let attributedItem = NSAttributedString(
            string: "1",
            attributes: [.font: UIFont.systemFont(ofSize: 16.0)]
        )
        
        XCTAssertTrue(labelPickerComponent.attributedItem(index: 0).isEqual(to: attributedItem))
    }
    
}
