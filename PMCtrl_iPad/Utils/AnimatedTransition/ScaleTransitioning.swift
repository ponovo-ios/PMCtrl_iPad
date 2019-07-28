//
//  ScaleTransitioning.swift
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/1.
//  Copyright © 2017年 ponovo. All rights reserved.
//

import Foundation
import UIKit

//转场上下文
class STContext:NSObject{
    var sourceView:UIView
    var destinationView:UIView
    
    init(sourceView:UIView,destinationView:UIView) {
        self.sourceView = sourceView
        self.destinationView = destinationView
    }
}

//转场上下文转换器
protocol STContextConvertor {
    func convertContext(_ from:UIViewController,_ to:UIViewController)->STContext?
    func convertInverseContext(_ from:UIViewController,_ to:UIViewController)->STContext?
    func convertContext(_ from:UIViewController,_ to:UIViewController,isInverse:Bool)->STContext?
}

extension STContextConvertor {
    func convertContext(_ from:UIViewController,_ to:UIViewController,isInverse:Bool)->STContext?{
        if isInverse {
            return convertInverseContext(from,to)
        }else{
            return convertContext(from,to)
        }
    }
}

//转场动画
class ScaleTransitioning<T:STContextConvertor>:NSObject,UIViewControllerAnimatedTransitioning{
    
    fileprivate var contextConvertor:T
    fileprivate var isInverse:Bool
    
    init(contextConvertor:T,isInverse:Bool=false){
        self.contextConvertor = contextConvertor
        self.isInverse = isInverse
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        let fromVC:UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC:UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let context:STContext? = contextConvertor.convertContext(fromVC,toVC, isInverse: self.isInverse)
        if context == nil {
            transitionContext.completeTransition(false)
            return
        }
        if isInverse {
            self.doInverseAnimateTransition(transitionContext,context!)
        }else{
            self.doAnimateTransition(transitionContext,context!)
        }
    }
    
    fileprivate func doAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning,_ context:STContext){
        
        let sourceView:UIView = context.sourceView
        let toVC:UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let destinationView:UIView = context.destinationView
        let containerView:UIView = transitionContext.containerView
        
        //snapShot
        let snapShotView:UIView = self.getSnapShotView(sourceView)//sourceView.snapshotViewAfterScreenUpdates(false)!
        snapShotView.frame = containerView.convert(sourceView.frame, from: sourceView.superview)
        sourceView.isHidden = true
        
        //to
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0
        destinationView.isHidden = true
        
        //add to container
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapShotView)
        
        //do animation
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveLinear, animations: {
            containerView.layoutIfNeeded()
            toVC.view.alpha = 1
            snapShotView.frame = containerView.convert(destinationView.frame, from: destinationView.superview)
        }) { (b) in
            destinationView.isHidden = false
            sourceView.isHidden = false
            snapShotView.removeFromSuperview()
            //通知系统自定义专场已完成！！！！
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    fileprivate func doInverseAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning,_ context:STContext){
        
        let fromVC:UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC:UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let sourecView:UIView = context.sourceView
        let destinationView:UIView = context.destinationView
        let containerView:UIView = transitionContext.containerView
        
        //snapShot
        let snapShotView:UIView = self.getSnapShotView(sourecView)//snapshotViewAfterScreenUpdates(false)!
        snapShotView.frame = containerView.convert(sourecView.frame, from: sourecView.superview)
        sourecView.isHidden = true
        
        //to
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        destinationView.isHidden = true
        
        //add to container
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(snapShotView)
        
        //do  animation
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveLinear, animations: {
            fromVC.view.alpha = 0
            snapShotView.frame = containerView.convert(destinationView.frame, from: destinationView.superview)
        }) { (b) in
            snapShotView.removeFromSuperview()
            sourecView.isHidden = false
            destinationView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
       
    }
    
    //获取快照
    fileprivate func getSnapShotView(_ view:UIView)->UIView{
        let image:UIImage = view.toImage()
        let snapShotView:UIImageView = UIImageView()
        snapShotView.image = image
        return snapShotView
    }
}
