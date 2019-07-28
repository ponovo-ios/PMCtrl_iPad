//
//  UIView+Animation_Extension.swift
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/27.
//  Copyright © 2017年 ponovo. All rights reserved.
//

import UIKit
@objc public enum ShakeDirection:Int {
    case horizontal = 0
    case vertical = 1
}

extension UIView{
    public func shake(a:Int = 3,b:CGFloat = 8.0){
        
    }
    // 扩展UIView增加抖动方法
    //
    // - Parameters:
    //   - direction: 抖动方向（默认是水平方向）
    //   - times: 抖动次数（默认6次）
    //   - interval: 每次抖动时间（默认0.2秒）
    //   - delta: 抖动偏移量（默认4）
    //   - completion: 抖动动画结束后的回调
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 6, interval: TimeInterval = 0.2, delta: CGFloat = 4, completion: (() -> Void)? = nil) {
        //播放动画
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:

                self.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
                //如果当前不是最后一次抖动，则继续播放动画（总次数减1，偏移位置变成相反的）
            else {
                self.shake(direction: direction, times: times - 1,  interval: interval, delta: delta * -1, completion:completion)
            }
        }
    }
}
