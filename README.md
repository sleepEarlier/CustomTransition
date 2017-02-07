# CustomTransition
Demo shows how to custom transition

### transition by call addChildViewController
![addChildViewController](https://github.com/sleepEarlier/CustomTransition/blob/master/addChild.gif)


1. provide an Animator object confirm to `UIViewControllerAnimatedTransitioning`, and implement `- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext` method which return duration of animation, implement `- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext` method which perform the custom animation, dont forget to invoke `[transitionContext completeTransition:]` when animation complete.

2. provide an TransitioningContext object which confirm to `UIViewControllerContextTransitioning`, this object will pass to Animator and used in Animator's `animateTransition:` method as the parameter. Implement the property and methods in the protocal.

3. call `[animator animateTransition:context]` to perform custom transition

### transition under navigation controller
![pop](https://github.com/sleepEarlier/CustomTransition/blob/master/pop.gif)

1. set navigation controller's delegate, implement the follow method:
```objective-C
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
```

if you want a interactive transition, implement this method as well:
```objective-C
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
```


####Learn from
[View Controller 转场](https://objccn.io/issue-5-3/)

[自定义 ViewController 容器转场](https://objccn.io/issue-12-3/)

[BlurTransition](https://github.com/Vaberer/BlurTransition)


