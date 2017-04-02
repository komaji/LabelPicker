//
//  LabelPickerViewTests.swift
//  LabelPicker
//
//  Created by KojimaTatsuya on 2017/04/02.
//  Copyright © 2017年 komaji. All rights reserved.
//

import XCTest
@testable import LabelPicker

class LabelPickerViewTests: XCTestCase {
    
    let numLabelPickerComponent = LabelPickerComponent(
        items: ["1"],
        itemAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)],
        maxItemWidth: 10.0,
        labelName: "num",
        labelAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)],
        labelNameWidth: 30.0
    )
    let charLabelPickerComponent = LabelPickerComponent(
        items: ["a"],
        itemAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)],
        maxItemWidth: 10.0,
        labelName: "char",
        labelAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)],
        labelNameWidth: 40.0
    )
    var labelPickerView: LabelPickerView!
    
    override func setUp() {
        super.setUp()
        
        labelPickerView = LabelPickerView()
        labelPickerView.bounds = CGRect(x: 0.0, y: 0.0, width: 205.0, height: 100.0)
        labelPickerView.components = [numLabelPickerComponent]
    }
    
    func testExistRequiredValues() {
        labelPickerView.components = []
        
        XCTAssertFalse(labelPickerView.existRequiredValues)
        
        labelPickerView.components.append(numLabelPickerComponent)
        
        XCTAssertFalse(labelPickerView.existRequiredValues)
        
        labelPickerView.components = []
        labelPickerView.rowHeight = 30.0
        
        XCTAssertFalse(labelPickerView.existRequiredValues)
        
        labelPickerView.components.append(numLabelPickerComponent)
        
        XCTAssertTrue(labelPickerView.existRequiredValues)
    }
    
    func testComponentsSepareteCount() {
        XCTAssertEqual(labelPickerView.componentSeparateCount, 0)
        
        labelPickerView.components.append(numLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.componentSeparateCount, 1)
    }
    
    func testComponentsContentSeparateWidthSum() {
        labelPickerView.contentSeparateWidth = 10.0
        
        XCTAssertEqual(labelPickerView.componentsContentSeparateWidthSum, 10.0)
        
        labelPickerView.components.append(numLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.componentsContentSeparateWidthSum, 20.0)
    }
    
    func testComponentsWidthSum() {
        XCTAssertEqual(labelPickerView.componentsWidthSum, 205.0)
        
        labelPickerView.components.append(numLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.componentsWidthSum, 200.0)
    }
    
    func testComponentsMaxContentWidthSum() {
        XCTAssertEqual(labelPickerView.componentsMaxContentWidthSum, 40.0)
        
        labelPickerView.components.append(charLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.componentsMaxContentWidthSum, 90.0)
    }
    
    func testComponentsSidePaddingSum() {
        XCTAssertEqual(labelPickerView.componentsSidePaddingSum, 165)
        
        labelPickerView.contentSeparateWidth = 10.0
        
        XCTAssertEqual(labelPickerView.componentsSidePaddingSum, 155)
        
        labelPickerView.components.append(charLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.componentsSidePaddingSum, 90)
    }
    
    func testComponentSidePaddingSum() {
        labelPickerView.components.append(charLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.componentSidePaddingSum(of: numLabelPickerComponent), 60.0)
        XCTAssertEqual(labelPickerView.componentSidePaddingSum(of: charLabelPickerComponent), 50.0)
        
        labelPickerView.componentsWidthEqual = false
        
        XCTAssertEqual(labelPickerView.componentSidePaddingSum(of: numLabelPickerComponent), 55.0)
        XCTAssertEqual(labelPickerView.componentSidePaddingSum(of: charLabelPickerComponent), 55.0)
    }
    
    func testComponentSidePadding() {
        labelPickerView.components.append(charLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.componentSidePadding(of: numLabelPickerComponent), 30.0)
        XCTAssertEqual(labelPickerView.componentSidePadding(of: charLabelPickerComponent), 25.0)
    }
    
    func testComponentWidth() {
        labelPickerView.components.append(charLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.componentWidth(of: numLabelPickerComponent), 100.0)
        XCTAssertEqual(labelPickerView.componentWidth(of: charLabelPickerComponent), 100.0)
        
        labelPickerView.componentsWidthEqual = false
        
        XCTAssertEqual(labelPickerView.componentWidth(of: numLabelPickerComponent), 95.0)
        XCTAssertEqual(labelPickerView.componentWidth(of: charLabelPickerComponent), 105.0)
    }
    
    func testLeftComponentsWidth() {
        labelPickerView.components.append(charLabelPickerComponent)
        
        XCTAssertEqual(labelPickerView.leftComponentsWidth(withComponentIndex: 0), 0.0)
        XCTAssertEqual(labelPickerView.leftComponentsWidth(withComponentIndex: 1), 100.0)
    }
    
    func testLabelFrame() {
        labelPickerView.components.append(charLabelPickerComponent)
        labelPickerView.rowHeight = 30.0
        
        XCTAssertEqual(
            labelPickerView.labelFrame(withComponentIndex: 0),
            CGRect(x: 40.0, y: 35.0, width: 30.0, height: 30.0)
        )
        XCTAssertEqual(
            labelPickerView.labelFrame(withComponentIndex: 1),
            CGRect(x: 140.0, y: 35.0, width: 40.0, height: 30.0)
        )
    }
    
    func testItemLabelFrame() {
        labelPickerView.components.append(charLabelPickerComponent)
        labelPickerView.rowHeight = 30.0
        
        XCTAssertEqual(
            labelPickerView.itemLabelFrame(of: numLabelPickerComponent),
            CGRect(x: 30.0, y: 0.0, width: 10.0, height: 30.0)
        )
        XCTAssertEqual(
            labelPickerView.itemLabelFrame(of: charLabelPickerComponent),
            CGRect(x: 25.0, y: 0.0, width: 10.0, height: 30.0)
        )
    }
    
}
