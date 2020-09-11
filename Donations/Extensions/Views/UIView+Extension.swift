//
//  UIView+Extension.swift
//  Donations
//
//  Created by Ярослав Стрельников on 11.09.2020.
//

import Foundation
import UIKit

var statusBarHeight: CGFloat {
    get {
        if #available(iOS 13.0, *) {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
                  let scene = window.windowScene,
                  let statusBarManager = scene.statusBarManager else { return 0 }
            return statusBarManager.statusBarFrame.height
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}

extension UIView {
    // Задать скругления
    func setCorners(_ radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    // Сделать обводку
    func drawBorder(_ radius: CGFloat, width: CGFloat, color: UIColor = UIColor.clear) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.shouldRasterize = false
        self.layer.rasterizationScale = 2
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
}
extension UIView {
    func addDashedBorder() {
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.extendedBlue.cgColor
        shapeLayer.strokeColor = UIColor.extendedBlue.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [4, 2]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 10).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}
class DashedLineView: UIView {

    override func draw(_ rect: CGRect) {

        let path = UIBezierPath(roundedRect: rect, cornerRadius: 10.5)

        UIColor.adaptableWhite.setFill()
        path.fill()

        UIColor.color(from: 0x3F8AE0).setStroke()
        path.lineWidth = 1

        let dashPattern : [CGFloat] = [8, 4]
        path.setLineDash(dashPattern, count: 2, phase: 0)
        path.stroke()
    }
}
@IBDesignable
class TextField: UITextField {
    @IBInspectable var insetX: CGFloat = 12
    @IBInspectable var insetY: CGFloat = 12

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}
