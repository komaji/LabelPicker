//
//  ViewController.swift
//  Demo
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: PickerView! {
        didSet {
            pickerView.components = timeComponents
            pickerView.rowHeight = 30.0
        }
    }
    
    @IBOutlet weak var pickerFrameView: UIView!
    
    let timeComponents: [PickerComponent] = {
        let hours = (1...24).map { "\($0)" }
        let min = (0...60).map { "\($0)" }
        let sec = (0...60).map { "\($0)" }
        let attributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)
        ]
        
        return [
            PickerComponent(
                items: hours,
                itemAttributes: attributes,
                label: "hours",
                labelAttributes: attributes,
                maxItemWidth: 30.0,
                labelWidth: 50.0
            ),
            PickerComponent(
                items: min,
                itemAttributes: attributes,
                label: "min",
                labelAttributes: attributes,
                maxItemWidth: 30.0,
                labelWidth: 30.0
            ),
            PickerComponent(
                items: sec,
                itemAttributes: attributes,
                label: "sec",
                labelAttributes: attributes,
                maxItemWidth: 30.0,
                labelWidth: 30.0
            ),
        ]
    }()
    
    let dateComponents: [PickerComponent] = {
        let year = (1970...2017).map { "\($0)" }
        let month = (1...12).map { "\($0)" }
        let day = (1...31).map { "\($0)" }
        let attributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)
        ]
        
        return [
            PickerComponent(
                items: year,
                itemAttributes: attributes,
                label: "year",
                labelAttributes: attributes,
                maxItemWidth: 40.0,
                labelWidth: 40.0,
                widthRelativeRatio: 8.0
            ),
            PickerComponent(
                items: month,
                itemAttributes: attributes,
                label: "month",
                labelAttributes: attributes,
                maxItemWidth: 20.0,
                labelWidth: 50.0,
                widthRelativeRatio: 7.0
            ),
            PickerComponent(
                items: day,
                itemAttributes: attributes,
                label: "day",
                labelAttributes: attributes,
                maxItemWidth: 20.0,
                labelWidth: 30.0,
                widthRelativeRatio: 5.0
            ),
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = PickerView(frame: pickerFrameView.bounds)
        pickerView.components = dateComponents
        pickerView.rowHeight = 30.0
        
        pickerFrameView.addSubview(pickerView)
    }
    
}

