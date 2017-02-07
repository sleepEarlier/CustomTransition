//
//  Animator.m
//  PushAnimator
//
//  Created by kimiLin on 2017/2/6.
//  Copyright © 2017年 KimiLin. All rights reserved.
//

#import "Animator.h"

@implementation Animator

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    UIView *fromView = fromVC.view, *toView = toVC.view;
    
    toView.frame = container.bounds;
    
    toView.alpha = 0;
    [container addSubview:toView];
    
    CGAffineTransform scale = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:1.0 animations:^{
        fromView.transform = scale;
        fromView.alpha = 0.;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        // 转场可能被取消，因此不应该在此处操作fromView remove from super
        fromView.alpha = 1.;
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:(![transitionContext transitionWasCancelled]) && finished];
    }];
    
}

@end
