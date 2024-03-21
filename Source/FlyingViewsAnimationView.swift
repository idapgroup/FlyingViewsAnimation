//
//  AnimatedView.swift
//  FlyingViewsAnimation
//
//  Created by Filipp Kosenko on 20.03.2024.
//

import UIKit

final class AdvancedFlyingViewsView: UIView {
    
    // MARK: -
    // MARK: Variables

    private var item: (() -> UIView)?
    private var itemSize: CGFloat = 10
    private var colors: [UIColor] = [.red, .blue, .green]
    private var angle: CGFloat = 0
    private var items: [UIView] = [];
    private var isAnimating = false
    private var timer = Timer()
    
    private let defaultImage = UIImage(systemName: "circle.fill")
    
    // MARK: -
    // MARK: Init
    
    public init() {
        super.init(frame: CGRect())
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setup()
    }
    
    // MARK: -
    // MARK: Public
    
    public func set(item: @escaping () -> UIView) {
        self.item = item
    }
    
    public func setItem(size: CGFloat) {
        self.itemSize = size
    }
    
    public func set(colors: [UIColor]) {
        self.colors = colors
    }
    
    public func set(angle: CGFloat) {
        self.angle = angle
    }
    
    public func start() {
        if !self.isAnimating {
            self.isAnimating = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true, block: { [weak self] (timer) in
                self?.addItem()
            })
        }
    }
    
    public func stop() {
        self.isAnimating = false
        self.timer.invalidate()
        self.removeItems()
    }
    
    // MARK: -
    // MARK: Private
    
    private func setup() {
        self.backgroundColor = .white
        self.clipsToBounds = true
    }
    
    private func removeItems() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
        self.items.removeAll()
    }

    private func addItem() {
        let view = self.addView(point: self.getSpawnCoordinates())
        self.items.append(view)
        self.animate(view: view, diff: self.frame.height, angle: self.angle)
    }
    
    private func getSpawnCoordinates() -> CGPoint {
        let tangentLineLength: Double = sqrt(pow(self.frame.height, 2) + pow(self.frame.width, 2))
        let centerPoint = CGPoint(x:self.frame.width / 2, y: self.frame.height / 2)
        let radius: CGFloat = tangentLineLength / 2
        
        let tangentMidPoint = CGPoint(
            x: centerPoint.x + radius * sin(self.deg2rad(angle)),
            y: centerPoint.y + (-radius * cos(self.deg2rad(angle)))
        )
        
        let xTangentEndPointOffset = (tangentLineLength / 2) * cos(self.deg2rad(angle))
        let yTangentEndPointOffset = ( -tangentLineLength / 2) * sin(self.deg2rad(angle))
        
        let tangentEndPoint1 = CGPoint(
            x: tangentMidPoint.x - xTangentEndPointOffset,
            y: tangentMidPoint.y + yTangentEndPointOffset
        )
        let tangentEndPoint2 = CGPoint(
            x: tangentMidPoint.x + xTangentEndPointOffset,
            y: tangentMidPoint.y - yTangentEndPointOffset
        )
        
        let xRange = self.rangeBy(tangentEndPoint1.x, tangentEndPoint2.x)
        let yRange = self.rangeBy(tangentEndPoint1.y, tangentEndPoint2.y)
        
        if self.lengthOf(xRange) > self.lengthOf(yRange) {
            let xSpawnOffset = CGFloat.random(in: xRange)
            let xOffset = xSpawnOffset - tangentMidPoint.x
            let ySpawnOffset = tangentMidPoint.y + (xOffset * tan(self.deg2rad(self.angle)))
            
            return CGPoint(x: xSpawnOffset, y: ySpawnOffset)
        } else {
            let ySpawnOffset = CGFloat.random(in: yRange)
            let yOffset = ySpawnOffset - tangentMidPoint.y
            var xSpawnOffset: Double = 0
            if tangentMidPoint.x > centerPoint.x {
                xSpawnOffset = tangentMidPoint.x + (yOffset * cos(self.deg2rad(self.angle)))
            } else {
                xSpawnOffset = tangentMidPoint.x - (yOffset * cos(self.deg2rad(self.angle)))
            }

            return CGPoint(x: xSpawnOffset, y: ySpawnOffset)
        }
    }
    
    private func addView(point: CGPoint) -> UIView {
        let view = self.item?() ?? UIImageView(image: self.defaultImage)
        view.tintColor = colors.randomElement()
        view.frame = CGRect(x: point.x, y: point.y, width: self.itemSize, height: self.itemSize)
        self.addSubview(view)
        
        return view
    }
    
    private func animate(view: UIView, diff: CGFloat, angle: CGFloat) {
        let pathLength = self.frame.height * 1.5
        let offsetX = -pathLength * sin(self.deg2rad(angle))
        let offsetY = pathLength * cos(self.deg2rad(angle))
        
        UIView.animate(withDuration: Double.random(in: 1...9), delay: 0.0, options: [.curveLinear], animations: {
            view.frame = CGRectOffset(view.frame, offsetX, offsetY)
        }, completion: {_ in
            view.removeFromSuperview()
            self.items = self.items.filter { $0 != view }
        })
    }
    
    private func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    private func rangeBy(_ coordinate1: CGFloat, _ coordinate2: CGFloat) -> ClosedRange<CGFloat> {
        return min(coordinate1, coordinate2)...max(coordinate1, coordinate2)
    }
    
    private func lengthOf(_ range: ClosedRange<CGFloat>) -> Double {
        return range.upperBound - range.lowerBound
    }
}
