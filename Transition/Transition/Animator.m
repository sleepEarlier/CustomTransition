//
//  Animator.m
//  Transition
//
//  Created by kimiLin on 2017/2/5.
//  Copyright © 2017年 KimiLin. All rights reserved.
//

#import "Animator.h"

@implementation Animator

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *container = [transitionContext containerView];
    
    
    [toView.layer removeAllAnimations];
    toView.alpha = 0.;
    toView.transform = CGAffineTransformIdentity;
    toView.frame = container.bounds;
    
    [fromView.layer removeAllAnimations];
    fromView.alpha = 1.;
    fromView.transform = CGAffineTransformIdentity;
    fromView.frame = container.bounds;
    
    [container addSubview:toView];
    
    CGAffineTransform trans = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    
    [UIView animateWithDuration:1. delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        NSLog(@"during animation");
        fromView.transform = trans;
        fromView.alpha = 0.;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        NSLog(@"Animation Finish:%@",@(finished));
        if (finished) {
            fromView.transform = CGAffineTransformIdentity;
            toView.transform = CGAffineTransformIdentity;
            fromView.alpha = 0;
            toView.alpha = 1.0;
            fromView.frame = container.bounds;
            toView.frame = container.bounds;
            
        }
        if (!toView.superview) {
            [container addSubview:toView];
        }
        
        [transitionContext completeTransition:(![transitionContext transitionWasCancelled]) && finished];
    }];
    
}

//@optional

/// A conforming object implements this method if the transition it creates can
/// be interrupted. For example, it could return an instance of a
/// UIViewPropertyAnimator. It is expected that this method will return the same
/// instance for the life of a transition.
//- (id <UIViewImplicitlyAnimating>) interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
//    // NS_AVAILABLE_IOS(10_0)
//    
//}

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted {
    NSLog(@"%s",__func__);
}

@end
