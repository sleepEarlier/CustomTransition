//
//  ContainerController.m
//  Transition
//
//  Created by kimiLin on 2017/2/5.
//  Copyright © 2017年 KimiLin. All rights reserved.
//

#import "ContainerController.h"
#import "ChildController.h"
#import "Animator.h"
#import "TransitioningContext.h"

@interface ContainerController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (nonatomic, strong) NSMutableArray *ctrs;
@property (nonatomic, weak) IBOutlet UIButton *tempBtn;
@end

@implementation ContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 0;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [self transitionFrom:_selectedIndex to:selectedIndex];
    _selectedIndex = selectedIndex;
}

- (void)transitionFrom:(NSInteger)from to:(NSInteger)to {
    if (self.childViewControllers.count < 1) {
        ChildController *vc = self.ctrs[self.selectedIndex];
        vc.view.translatesAutoresizingMaskIntoConstraints = YES;
        vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        vc.view.frame = self.container.bounds;
        [self.container addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
    else {
        ChildController *fromVC = self.ctrs[from];
        ChildController *toVC = self.ctrs[to];
        UIView *fromView = fromVC.view;
        UIView *toView = toVC.view;
        
        toView.frame = self.container.bounds;
        
        
        Animator *animator = [[Animator alloc] init];
        TransitioningContext *context = [[TransitioningContext alloc] initWithContainer:self.container fromController:fromVC toController:toVC];
        context.completion = ^(BOOL didComplete) {
            [self addChildViewController:toVC];
            [toVC didMoveToParentViewController:self];
            [fromVC willMoveToParentViewController:nil];
            NSLog(@"%@ did move to parent", toVC.text);
            
            if (didComplete) {
                [fromView removeFromSuperview];
                [fromVC removeFromParentViewController];
                NSLog(@"%@ did remove from parent", fromVC.text);
            }
            
            
            if ([animator respondsToSelector:@selector(animationEnded:)]) {
                [animator animationEnded:didComplete];
            }
            NSLog(@"child:%@",self.childViewControllers);
            NSLog(@"==========================");
        };
        
        [animator animateTransition:context];
    }
}

- (IBAction)onButtonTaped:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    self.tempBtn.selected = !self.tempBtn.selected;
    sender.selected = !sender.selected;
    self.tempBtn = sender;
    self.selectedIndex = sender.tag;
}



- (NSMutableArray *)ctrs {
    if (!_ctrs) {
        _ctrs = @[].mutableCopy;
        NSArray *cls = @[
                         [UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1],
                         [UIColor colorWithRed:1 green:0.4f blue:0.8f alpha:1],
                         [UIColor colorWithRed:1 green:0.8f blue:0.4f alpha:1]
                         ];
        NSArray *tls = @[@"First",@"Second",@"Third"];
        for (int i = 0 ; i < 3; i++) {
            ChildController *ch = [ChildController new];
            ch.preferredContentSize = [UIScreen mainScreen].bounds.size;
            ch.text = tls[i];
            ch.bgColor = cls[i];
            [_ctrs addObject:ch];
        }
        
    }
    return _ctrs;
}

@end
