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
            pickerView.components = components
            pickerView.rowHeight = 30.0
        }
    }
    
    let components: [PickerComponent] = {
        let items = (1...100).map { "\($0)" }
        let attributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)
        ]
        
        return [
            PickerComponent(
                items: items,
                itemAttributes: attributes,
                label: "hours",
                labelAttributes: attributes,
                maxItemWidth: 30.0,
                labelWidth: 50.0
            ),
            PickerComponent(
                items: items,
                itemAttributes: attributes,
                label: "min",
                labelAttributes: attributes,
                maxItemWidth: 30.0,
                labelWidth: 30.0
            ),
            PickerComponent(
                items: items,
                itemAttributes: attributes,
                label: "sec",
                labelAttributes: attributes,
                maxItemWidth: 30.0,
                labelWidth: 30.0
            ),
        ]
    }()
    
}

