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
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16.0)
        ]
        
        let itemsComponents = [(year, 40.0), (month, 20.0), (day, 20.0)]
            .map { ItemsComponent(items: $0, attributes: attributes, maxWidth: $1) }
        let labelComponents = [("year", 40.0), ("month", 50.0), ("day", 30.0)]
            .map { LabelComponent(name: $0, attributes: attributes, width: $1) }
        
        return zip(itemsComponents, labelComponents).map(LabelPickerComponent.init)
    }()
    
}

