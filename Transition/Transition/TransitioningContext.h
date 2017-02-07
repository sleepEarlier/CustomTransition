//
//  TransitioningContext.h
//  Transition
//
//  Created by kimiLin on 2017/2/5.
//  Copyright © 2017年 KimiLin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TransitioningContext : NSObject<UIViewControllerContextTransitioning>

- (instancetype)initWithContainer:(UIView *)container fromController:(UIViewController *)fromVC toController:(UIViewController *)toVC;

@property (nonatomic, copy) void (^completion)(BOOL didComplete);

@end
