//
//  ViewController.swift
//  FBStreamAnimation
//
//  Created by Jeff Kral on 3/25/17.
//  Copyright © 2017 Jeff Kral. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let curvedView = CurvedView(frame: view.frame)
        //curvedView.backgroundColor = .yellow
        
        //view.addSubview(curvedView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

    }
    
    func handleTap() {
        (0...10).forEach { (_) in
            generateAnimatedViews()
        }
    }
    
    fileprivate func generateAnimatedViews() {
        
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "thumbs_up") : #imageLiteral(resourceName: "heart")
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
    }
}



func customPath() -> UIBezierPath {
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))
    
    let randomYShift = 200 + drand48() * 300
    
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
    
    let endpoint = CGPoint(x: 400, y: 200)
    path.addCurve(to: endpoint, controlPoint1: cp1, controlPoint2: cp2)
    
    return path
}
    
    
class CurvedView: UIView {
        
    override func draw(_ rect: CGRect) {
        
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
    }
}



