//
//  ViewController.swift
//  Demo
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerFrameView1: UIView! {
        didSet {
            let pickerView = LabelPickerView(frame: pickerFrameView1.bounds)
            pickerView.components = dateComponents
            pickerView.rowHeight = 30.0
            
            pickerFrameView1.addSubview(pickerView)
        }
    }
    
    @IBOutlet weak var pickerFrameView2: UIView! {
        didSet {
            let pickerView = LabelPickerView(frame: pickerFrameView2.bounds)
            pickerView.components = dateComponents
            pickerView.rowHeight = 30.0
            pickerView.spacing = .fill
            
            pickerFrameView2.addSubview(pickerView)
        }
    }

    let dateComponents: [LabelPickerComponent] = {
        let year = (1970...2017).map { "\($0)" }
        let month = (1...12).map { "\($0)" }
        let day = (1...31).map { "\($0)" }
        let attributes: [NSAttributedStringKey: Any] = [
            .font: UIFont.systemFont(ofSize: 16.0)
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
    
}

