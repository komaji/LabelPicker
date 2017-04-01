//
//  LabelPickerView.swift
//  LabelPicker
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

import UIKit

public class LabelPickerView: UIPickerView {
        
    let separateWidth: CGFloat = 5.0
    
    public var components: [LabelPickerComponent] = [] {
        didSet {
            setLabels()
            if existRequiredValues {
                updateLabelsFrame()
            }
        }
    }
    
    public var rowHeight: CGFloat = .leastNormalMagnitude {
        didSet {
            if existRequiredValues {
                updateLabelsFrame()
            }
        }
    }
    
    public var componentsWidthEqual: Bool = true {
        didSet {
            if existRequiredValues {
                updateLabelsFrame()
            }
        }
    }
    
    var labels: [UILabel] = []
    
    var existRequiredValues: Bool {
        return !components.isEmpty && rowHeight != .leastNormalMagnitude
    }
    
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
    
    func componentSidePaddingSum(of component: LabelPickerComponent) -> CGFloat {
        if componentsWidthEqual {
            return componentWidth(of: component) - component.maxContentWidth
        } else {
            return componentsSidePaddingSum / CGFloat(components.count)
        }
    }
    
    func componentSidePadding(of component: LabelPickerComponent) -> CGFloat {
        return componentSidePaddingSum(of: component) / 2.0
    }
    
    func componentWidth(of component: LabelPickerComponent) -> CGFloat {
        if componentsWidthEqual {
            return componentsWidthSum / CGFloat(components.count)
        } else {
            return component.maxContentWidth + componentSidePaddingSum(of: component)
        }
    }
    
    func leftComponentsWidth(withComponentIndex index: Int) -> CGFloat {
        return (0..<index).reduce(0.0) { $0 + componentWidth(of: components[$1]) }
    }
    
    func labelFrame(withComponentIndex index: Int) -> CGRect {
        let component = components[index]
        let x = leftComponentsWidth(withComponentIndex: index)
                + componentSidePadding(of: component)
                + component.maxItemWidth
                + separateWidth * CGFloat(index)
        let y = bounds.height / 2.0 - rowHeight / 2.0
        
        return CGRect(x: x, y: y, width: components[index].labelNameWidth, height: rowHeight)
    }
    
    func setLabels() {
        labels = components.map { component in
            let label = UILabel()
            label.attributedText = component.attributedLabel
            label.textAlignment = .center
            
            return label
        }
        
        labels.forEach { addSubview($0) }
    }
    
    func updateLabelsFrame() {
        components.enumerated().forEach { index, component in
            labels[index].frame = labelFrame(withComponentIndex: index)
        }
    }
    
}

extension LabelPickerView: UIPickerViewDataSource {
    
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

extension LabelPickerView: UIPickerViewDelegate {
    
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
    
    func itemLabelFrame(of component: LabelPickerComponent) -> CGRect {
        return CGRect(x: componentSidePadding(of: component), y: 0.0, width: component.maxItemWidth, height: rowHeight)
    }
    
}
