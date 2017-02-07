//
//  NavigationDelegate.m
//  PushAnimator
//
//  Created by kimiLin on 2017/2/6.
//  Copyright © 2017年 KimiLin. All rights reserved.
//

#import "NavigationDelegate.h"
#import "Animator.h"

@interface NavigationDelegate ()
@property(nullable, nonatomic,strong) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong) Animator *animator;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransitioning;
@end

@implementation NavigationDelegate

- (void)awakeFromNib {
    [super awakeFromNib];
    self.animator = [Animator new];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.navigationController.view addGestureRecognizer:pan];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    
    UIView *view = pan.view;
    CGPoint translate = [pan translationInView:view];
    UIGestureRecognizerState state = pan.state;
    CGFloat target = [UIScreen mainScreen].bounds.size.width;
    CGFloat fraction = MIN(1, MAX(0, translate.x / target));
    
    if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled) {
        
        
        if (fraction >= 0.5) {
            NSLog(@"finish");
            [self.interactiveTransitioning finishInteractiveTransition];
        }
        else {
            NSLog(@"cancel");
            [self.interactiveTransitioning cancelInteractiveTransition];
        }
        self.interactiveTransitioning = nil;
    }
    else if (state == UIGestureRecognizerStateChanged) {
        NSLog(@"fraction:%@",@(fraction));
        [self.interactiveTransitioning updateInteractiveTransition:fraction];
    }
    else if (state == UIGestureRecognizerStateBegan) {
        if (translate.x > 0) {
            NSLog(@"begin");
            self.interactiveTransitioning = [UIPercentDrivenInteractiveTransition new];
            // 开始带动画的POP
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    // NS_AVAILABLE_IOS(7_0)
    return self.interactiveTransitioning;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    // NS_AVAILABLE_IOS(7_0);
    if (operation == UINavigationControllerOperationPop) {
        return self.animator;
    }
    return nil;
}

@end
