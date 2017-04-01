//
//  PickerView.swift
//  Demo
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import UIKit

public class PickerView: UIPickerView {
    
    public var components: [PickerComponent] = [] {
        didSet {
            setLabels()
            if existRequiredValues {
                updateLabelFrame()
            }
        }
    }
    
    public var rowHeight: CGFloat = .leastNormalMagnitude {
        didSet {
            if existRequiredValues {
                updateLabelFrame()
            }
        }
    }
    
    public var componentsWidthEqual: Bool = true {
        didSet {
            if existRequiredValues {
                updateLabelFrame()
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.dataSource = self
        self.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
        self.delegate = self
    }
    
    var existRequiredValues: Bool {
        return !components.isEmpty && rowHeight != .leastNormalMagnitude
    }
    
    var labels: [UILabel] = []
    
    let separateWidth: CGFloat = 5.0
    
    var separeteCount: Int {
        return components.count - 1
    }
    
    var componentsWidthSum: CGFloat {
        return bounds.width - separateWidth * CGFloat(separeteCount)
    }
    
    var componentsMaxContentWidthSum: CGFloat {
        return components.map { $0.maxContentWidth }.reduce(0.0, +)
    }
    
    var componentsSidePaddingSum: CGFloat {
        return componentsWidthSum - componentsMaxContentWidthSum
    }
    
    func componentSidePaddingSum(of component: PickerComponent) -> CGFloat {
        if componentsWidthEqual {
            return componentWidth(of: component) - component.maxContentWidth
        } else {
            return componentsSidePaddingSum / CGFloat(components.count)
        }
    }
    
    func componentSidePadding(of component: PickerComponent) -> CGFloat {
        return componentSidePaddingSum(of: component) / 2.0
    }
    
    func componentWidth(of component: PickerComponent) -> CGFloat {
        if componentsWidthEqual {
            return componentsWidthSum / CGFloat(components.count)
        } else {
            return component.maxContentWidth + componentSidePaddingSum(of: component)
        }
    }
    
    func setLabels() {
        labels = components.enumerated().map { index, component in
            let label = UILabel()
            label.attributedText = component.attributedLabel
            label.textAlignment = .center
            
            return label
        }
        
        labels.forEach { addSubview($0) }
    }
    
    func updateLabelFrame() {
        components.enumerated().forEach { index, component in
            labels[index].frame = labelFrame(withComponentIndex: index)
        }
    }
    
    func leftComponentsWidth(withComponentIndex index: Int) -> CGFloat {
        var widthSum: CGFloat = 0.0
        
        for i in 0..<index {
            widthSum += componentWidth(of: components[i])
        }
        
        return widthSum
    }
    
    func labelFrame(withComponentIndex index: Int) -> CGRect {
        let x = leftComponentsWidth(withComponentIndex: index)
                + componentSidePadding(of: components[index])
                + components[index].maxItemWidth
                + separateWidth * CGFloat(index)
        let y = bounds.height / 2.0 - rowHeight / 2.0
        
        return CGRect(x: x, y: y, width: components[index].labelNameWidth, height: rowHeight)
    }
    
}

extension PickerView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].items.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowHeight
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return componentWidth(of: components[component])
    }
    
}

extension PickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let reusingView = view, let reusingItemLable = reusingView.subviews.first as? UILabel {
            reusingItemLable.attributedText = components[component].attributedItem(index: row)
            
            return reusingView
        }
        
        let itemLabel = UILabel()
        itemLabel.frame = itemLabelFrame(of: components[component])
        itemLabel.attributedText = components[component].attributedItem(index: row)
        itemLabel.textAlignment = .center
        
        let componentView = UIView()
        componentView.addSubview(itemLabel)
        
        return componentView
    }
    
    func itemLabelFrame(of component: PickerComponent) -> CGRect {
        return CGRect(x: componentSidePadding(of: component), y: 0.0, width: component.maxItemWidth, height: rowHeight)
    }
    
}
