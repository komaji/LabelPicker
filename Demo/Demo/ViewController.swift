//
//  ViewController.swift
//  Demo
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: LabelPickerView! {
        didSet {
            pickerView.components = timeComponents
            pickerView.rowHeight = 30.0
            pickerView.contentSeparateWidth = 5.0
        }
    }
    
    @IBOutlet weak var pickerFrameView: UIView!
    
    let timeComponents: [LabelPickerComponent] = {
        let hours = (1...24).map { "\($0)" }
        let min = (0...60).map { "\($0)" }
        let sec = (0...60).map { "\($0)" }
        let attributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)
        ]
        
        return [
            LabelPickerComponent(
                items: hours,
                itemAttributes: attributes,
                maxItemWidth: 20.0,
                labelName: "hours",
                labelAttributes: attributes,
                labelNameWidth: 50.0
            ),
            LabelPickerComponent(
                items: min,
                itemAttributes: attributes,
                maxItemWidth: 20.0,
                labelName: "min",
                labelAttributes: attributes,
                labelNameWidth: 30.0
            ),
            LabelPickerComponent(
                items: sec,
                itemAttributes: attributes,
                maxItemWidth: 20.0,
                labelName: "sec",
                labelAttributes: attributes,
                labelNameWidth: 30.0
            ),
        ]
    }()
    
    let dateComponents: [LabelPickerComponent] = {
        let year = (1970...2017).map { "\($0)" }
        let month = (1...12).map { "\($0)" }
        let day = (1...31).map { "\($0)" }
        let attributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)
        ]
        
        return [
            LabelPickerComponent(
                items: year,
                itemAttributes: attributes,
                maxItemWidth: 40.0,
                labelName: "year",
                labelAttributes: attributes,
                labelNameWidth: 40.0
            ),
            LabelPickerComponent(
                items: month,
                itemAttributes: attributes,
                maxItemWidth: 20.0,
                labelName: "month",
                labelAttributes: attributes,
                labelNameWidth: 50.0
            ),
            LabelPickerComponent(
                items: day,
                itemAttributes: attributes,
                maxItemWidth: 20.0,
                labelName: "day",
                labelAttributes: attributes,
                labelNameWidth: 30.0
            ),
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = LabelPickerView(frame: pickerFrameView.bounds)
        pickerView.components = dateComponents
        pickerView.rowHeight = 30.0
        pickerView.componentsWidthEqual = false
        
        pickerFrameView.addSubview(pickerView)
    }
    
}

