//
//  LabelPickerView.swift
//  LabelPicker
//
//  Created by KojimaTatsuya on 2017/03/30.
//  Copyright © 2017年 komaji. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public protocol LabelPickerDelegate: AnyObject {
    func didSelect(item: String, inComponent component: Int, currentItems: [String])
}

public class LabelPickerView: UIPickerView {
    
    public enum Spacing {
        case equal
        case fill
    }
    
    let componentSeparateWidth: CGFloat = 5.0
    
    var labels: [UILabel] = []
    
    public weak var labelPickerDelegate: LabelPickerDelegate?
    
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
    
    public var spacing: Spacing = .equal {
        didSet {
            if existRequiredValues {
                updateLabelsFrame()
            }
        }
    }
    
    public var contentSeparateWidth: CGFloat = 0.0 {
        didSet {
            if existRequiredValues {
                updateLabelsFrame()
            }
        }
    }
    
    override public var frame: CGRect {
        didSet {
            if existRequiredValues {
                updateLabelsFrame()
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
    
    public func updateLabelsFrame() {
        components.enumerated().forEach { index, component in
            labels[index].frame = labelFrame(withComponentIndex: index)
        }
    }
    
    public func updateLabelName(to name: String, atIndex index: Int) {
        guard components.indices ~= index else { return }
        
        let target = components[index]
        let updatedLabel = LabelComponent(
            name: name,
            attributes: target.label.attributes,
            width: target.label.width
        )
        let updated = LabelPickerComponent(items: target.items, label: updatedLabel)
        
        components[index] = updated
    }
    
}

extension LabelPickerView {
    
    var existRequiredValues: Bool {
        return !components.isEmpty && rowHeight != .leastNormalMagnitude
    }
    
    var componentSeparateCount: Int {
        return components.count - 1
    }
    
    var componentsContentSeparateWidthSum: CGFloat {
        return contentSeparateWidth * CGFloat(components.count)
    }
    
    var componentsWidthSum: CGFloat {
        return bounds.width - componentSeparateWidth * CGFloat(componentSeparateCount)
    }
    
    var componentsMaxContentWidthSum: CGFloat {
        return components.map { $0.maxContentWidth }.reduce(0.0, +)
    }
    
    var componentsSidePaddingSum: CGFloat {
        return componentsWidthSum
                - (componentsMaxContentWidthSum + componentsContentSeparateWidthSum)
    }
    
    func componentSidePaddingSum(of component: LabelPickerComponent) -> CGFloat {
        switch spacing {
        case .equal:
            return componentWidth(of: component)
                    - component.maxContentWidth
                    - contentSeparateWidth
        case .fill:
            return componentsSidePaddingSum / CGFloat(components.count)
        }
    }
    
    func componentSidePadding(of component: LabelPickerComponent) -> CGFloat {
        return componentSidePaddingSum(of: component) / 2.0
    }
    
    func componentWidth(of component: LabelPickerComponent) -> CGFloat {
        switch spacing {
        case .equal:
            return componentsWidthSum / CGFloat(components.count)
        case .fill:
            return component.maxContentWidth
                    + componentSidePaddingSum(of: component)
                    + contentSeparateWidth
        }
    }
    
    func leftComponentsWidth(withComponentIndex index: Int) -> CGFloat {
        return (0..<index).reduce(0.0) { $0 + componentWidth(of: components[$1]) }
    }
    
    func labelFrame(withComponentIndex index: Int) -> CGRect {
        let component = components[index]
        let x = leftComponentsWidth(withComponentIndex: index)
                + componentSeparateWidth * CGFloat(index)
                + componentWidth(of: component)
                - component.label.width
                - componentSidePadding(of: component)
        let y = bounds.height / 2.0 - rowHeight / 2.0
        
        return CGRect(x: x, y: y, width: component.label.width, height: rowHeight)
    }
    
    func setLabels() {
        labels = components.map { component in
            let label = UILabel()
            label.attributedText = component.label.attributedName
            label.textAlignment = .center
            
            return label
        }
        subviews.filter { $0 is UILabel }.forEach { $0.removeFromSuperview() }
        labels.forEach { addSubview($0) }
    }
    
}

extension LabelPickerView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].items.items.count
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
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentItems: [String] = components.enumerated().map { offset, _component in
            let row = pickerView.selectedRow(inComponent: offset)
            return _component.items.items[row]
        }
        
        labelPickerDelegate?.didSelect(
            item: currentItems[component],
            inComponent: component,
            currentItems: currentItems
        )
    }
    
    func itemLabelFrame(of component: LabelPickerComponent) -> CGRect {
        return CGRect(
            x: componentSidePadding(of: component),
            y: 0.0,
            width: component.items.maxWidth,
            height: rowHeight
        )
    }
    
}
#endif
