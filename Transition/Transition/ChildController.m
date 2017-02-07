//
//  ChildController.m
//  Transition
//
//  Created by kimiLin on 2017/2/5.
//  Copyright © 2017年 KimiLin. All rights reserved.
//

#import "ChildController.h"

@interface ChildController ()

@end

@implementation ChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *l = [UILabel new];
    l.text = self.text;
    [l sizeToFit];
    l.center = self.view.center;
    l.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:l];
    self.view.backgroundColor = self.bgColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)description {
    return self.text;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
