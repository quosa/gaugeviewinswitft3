//   .-
//  `+d/
//  -hmm/
//  ommmm/
//  `mmmmm/
//  `mmmmm/ .:+ssyso+-`
//  `mmmmmsydmmmmmmmmmho.
//  `mmmmmmh+:---/+ssssyd:
//  `mmmmmh.     /     .md-
//  `mmmmmo..-`       .ommo
//  `mmmmm+..`    ./oydmmm/
//  `mmmmm/      /dmmmmmmh`
//  `mmmmm/    `smmmmmmms`
//  `mmmmm/  `+dmmmmmy+.
//  :::::.   `-::-.`
//
//  GaugeView.swift
//  GaugeView
//
//  Created by Luca D'Incà on 18/10/15.
//  Copyright © 2015 BELKA S.R.L. All rights reserved.
//

import UIKit

@IBDesignable
open class GaugeView: UIView {
  
  ///
  // Class proprty
  ///
  
  fileprivate var label: UILabel!
  
  fileprivate var gaugeLayer: GaugeLayer!
  
  //Gauge property
  @IBInspectable open var startAngle: Float = 0.0
  
  @IBInspectable open var radius: CGFloat {
    return min(self.bounds.width, self.bounds.height)/2
  }
  
  @IBInspectable open var thickness: CGFloat = 20 {
    didSet {
      if let gaugeLayer = gaugeLayer {
        self.setNeedsDisplay()
        gaugeLayer.setNeedsDisplay()
      }
    }
  }
  
  open var animationDuration: Float = 0.5
  
  @IBInspectable open var percentage: Float = 20 {
    didSet {
      if let gaugeLayer = gaugeLayer {
        gaugeLayer.stopAngle  = convertPercentageInRadius(percentage)
        self.accessibilityValue = "\(percentage)%"
      }
    }
  }
  
  @IBInspectable open var gaugeBackgroundColor: UIColor = UIColor.gray {
    didSet {
      if let gaugeLayer = gaugeLayer {
        self.setNeedsDisplay()
        gaugeLayer.setNeedsDisplay()
      }
    }
  }
  
  @IBInspectable open var gaugeColor: UIColor = UIColor.red {
    didSet {
      if let gaugeLayer = gaugeLayer {
        self.setNeedsDisplay()
        gaugeLayer.setNeedsDisplay()
      }
    }
  }
  
  //Label property
  @IBInspectable open var labelText: String = "" {
    didSet {
      label.text = labelText
      updateTextLabel()
    }
  }
  
  @IBInspectable open var labelFont: UIFont? {
    didSet {
      if let labelFont = labelFont {
        label.font = labelFont
        updateTextLabel()
      }
    }
  }
  
  @IBInspectable open var labelColor: UIColor? {
    didSet {
      if let labelColor = labelColor {
        label.textColor = labelColor
        updateTextLabel()
      }
    }
  }
  
  ///
  // Class methods
  ///
  
  //MARK: - Init methods
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }

  required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
  }
  
  //MARK: - Draw method
  override open func draw(_ rect: CGRect) {
    super.draw(rect)
    
    gaugeLayer.radius = radius
    gaugeLayer.thickness = thickness
    gaugeLayer.frame = self.bounds
    gaugeLayer.gaugeBackgroundColor = gaugeBackgroundColor
    gaugeLayer.gaugeColor = gaugeColor
    gaugeLayer.animationDuration = animationDuration
    gaugeLayer.startAngle = convertDegreesToRadius(startAngle)
    gaugeLayer.stopAngle = convertPercentageInRadius(percentage)
    
    updateTextLabel()
  }
  
  //MARK: - Setup method
  fileprivate func setup() {
    createGaugeView()
    createTitleLabel()
    
    setupAccessibility()
  }
  
  fileprivate func setupAccessibility() {
    self.isAccessibilityElement = true
  }
  
  fileprivate func createGaugeView() {
    gaugeLayer = GaugeLayer(layer: layer)
    
    gaugeLayer.radius = radius
    gaugeLayer.thickness = thickness
    gaugeLayer.frame = self.bounds
    gaugeLayer.gaugeBackgroundColor = gaugeBackgroundColor
    gaugeLayer.gaugeColor = gaugeColor
    gaugeLayer.animationDuration = animationDuration
    gaugeLayer.startAngle = convertDegreesToRadius(startAngle)
    gaugeLayer.stopAngle = convertPercentageInRadius(percentage)
    
    layer.addSublayer(gaugeLayer)
    
    self.backgroundColor = UIColor.clear
  }
  
  fileprivate func createTitleLabel() {
    label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
    
    updateTextLabel()
    
    self.addSubview(label)
  }
  
  fileprivate func updateTextLabel() {
    label.sizeToFit()
    label.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
  }
  
  //MARK: - Utility method
  fileprivate func convertPercentageInRadius(_ percentage: Float) -> Float {
    return convertDegreesToRadius((360.0 / 100.0 * percentage) + startAngle)
  }
  
  fileprivate func convertDegreesToRadius(_ degrees: Float) -> Float {
    return ((Float(Double.pi) * degrees) / 180.0)
  }
  
}
