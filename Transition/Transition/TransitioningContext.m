//
//  TransitioningContext.m
//  Transition
//
//  Created by kimiLin on 2017/2/5.
//  Copyright © 2017年 KimiLin. All rights reserved.
//

#import "TransitioningContext.h"

@interface TransitioningContext ()
@property(nonatomic, strong) UIView *containerView;
@property(nonatomic, assign, getter=isAnimated) BOOL animated;

@property(nonatomic, assign, getter=isInteractive) BOOL interactive; // This indicates whether the transition is currently interactive.

@property(nonatomic, assign) BOOL transitionWasCancelled;

@property(nonatomic, assign) UIModalPresentationStyle presentationStyle;

@property (nonatomic, copy) NSDictionary * info;

@end

@implementation TransitioningContext

- (instancetype)initWithContainer:(UIView *)container fromController:(UIViewController *)fromVC toController:(UIViewController *)toVC {
    self = [super init];
    if (self) {
        self.interactive = NO;
        self.animated = YES;
        self.presentationStyle = UIModalPresentationCustom;
        self.transitionWasCancelled = NO;
        self.containerView = container;
        self.info = @{
                      UITransitionContextFromViewControllerKey:fromVC,
                      UITransitionContextToViewControllerKey:toVC,
                      UITransitionContextFromViewKey:fromVC.view,
                      UITransitionContextToViewKey:toVC.view
                      };
    }
    return self;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {}

- (void)finishInteractiveTransition {
    NSLog(@"%s",__func__);
    if (self.completion) {
        self.completion(YES);
    }
}

- (void)cancelInteractiveTransition {
}

- (void)completeTransition:(BOOL)didComplete {
    NSLog(@"%s",__func__);
    if (self.completion) {
        self.completion(didComplete);
    }
}
- (nullable __kindof UIViewController *)viewControllerForKey:(UITransitionContextViewControllerKey)key {
    return [self.info objectForKey:key];
}
- (CGRect)initialFrameForViewController:(UIViewController *)vc {
    return self.containerView.bounds;
}

- (CGRect)finalFrameForViewController:(UIViewController *)vc {
    return self.containerView.bounds;
}

@end
