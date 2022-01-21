//
//  Extensions.swift
//  tictactoe
//
//  Created by Steve Cooper on 5.07.2021.
//

import UIKit

extension UIView {
    func roundCornersTopLeft(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCornersBottomLeft(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCornersTopRight(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCornersBottomRight(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCornersNone(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
