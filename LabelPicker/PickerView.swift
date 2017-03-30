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
            if rowHeight != .leastNormalMagnitude {
                updateLabelFrame()
            }
        }
    }
    
    public var rowHeight: CGFloat = .leastNormalMagnitude {
        didSet {
            if !components.isEmpty {
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
    
    public convenience init(frame: CGRect, components: [PickerComponent], rowHeight: CGFloat) {
        self.init(frame: frame)
        
        self.components = components
        self.rowHeight = rowHeight
    }
    
    fileprivate var labels: [UILabel] = []
    
    fileprivate let separateWidth: CGFloat = 5.0
    
    fileprivate var separeteCount: Int {
        return components.count - 1
    }
    
    fileprivate var componentRelativeRatioSum: Double {
        return components.map { $0.widthRelativeRatio }.reduce(0, +)
    }
    
    fileprivate func componentWidthRetio(of component: PickerComponent) -> Double {
        return component.widthRelativeRatio / componentRelativeRatioSum
    }
    
    fileprivate func componentWidth(of component: PickerComponent) -> CGFloat {
        return (bounds.width - separateWidth * CGFloat(separeteCount))
            * CGFloat(componentWidthRetio(of: component))
    }
    
    fileprivate func componentItemViewWidth(of component: PickerComponent) -> CGFloat {
        return componentWidth(of: component) / 2.0
            + (component.maxItemWidth - component.defaultWidth / 2.0)
    }
    
    fileprivate func componentLabelWidth(of component: PickerComponent) -> CGFloat {
        return componentWidth(of: component) - componentItemViewWidth(of: component)
    }
    
    fileprivate func setLabels() {
        labels = components.enumerated().map { index, component in
            let label = UILabel()
            label.attributedText = component.attributedLabel
            label.textAlignment = .left
            
            return label
        }
        
        labels.forEach { addSubview($0) }
    }
    
    fileprivate func updateLabelFrame() {
        components.enumerated().forEach { index, component in
            labels[index].frame = labelFrame(withComponentIndex: index)
        }
    }
    
    fileprivate func leftComponentWidth(withComponentIndex index: Int) -> CGFloat {
        var widthSum: CGFloat = 0.0
        
        for i in 0..<index {
            widthSum += componentWidth(of: components[i])
        }
        
        return widthSum
    }
    
    fileprivate func labelFrame(withComponentIndex index: Int) -> CGRect {
        let x = leftComponentWidth(withComponentIndex: index)
            + componentItemViewWidth(of: components[index])
            + separateWidth * CGFloat(index)
        let y = bounds.height / 2.0 - rowHeight / 2.0
        
        return CGRect(x: x, y: y, width: componentLabelWidth(of: components[index]), height: rowHeight)
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
        
        let pickerComponent = components[component]
        
        let componentView = UIView()
        let itemView = UIView()
        let itemLabel = UILabel()
        
        itemView.frame = itemViewFrame(of: pickerComponent)
        
        itemLabel.frame = itemLabelFrame(of: pickerComponent)
        itemLabel.attributedText = components[component].attributedItem(index: row)
        itemLabel.textAlignment = .center
        
        componentView.addSubview(itemView)
        itemView.addSubview(itemLabel)
        
        return componentView
    }
    
    private func itemViewFrame(of component: PickerComponent) -> CGRect {
        return CGRect(x: 0.0, y: 0.0, width: componentItemViewWidth(of: component), height: rowHeight)
    }
    
    private func itemLabelFrame(of component: PickerComponent) -> CGRect {
        let maxItemWidth = component.maxItemWidth
        let x = componentItemViewWidth(of: component) - maxItemWidth
        
        return CGRect(x: x, y: 0.0, width: maxItemWidth, height: rowHeight)
    }
    
}
