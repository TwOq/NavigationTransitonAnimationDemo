//
//  TransformAnimation.m
//  TransitioningAnimationDemo
//
//  Created by lizq on 16/3/17.
//  Copyright (c) 2016年 w jf. All rights reserved.
//

#import "LQTransformAnimation.h"
#import <objc/runtime.h>

#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define DURATIONKYE @"durationkey"

@implementation LQTransformAnimation



- (void)setDuration:(float)duration {
    objc_setAssociatedObject(self, DURATIONKYE, [NSNumber numberWithFloat:duration], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSNumber *numeber = objc_getAssociatedObject(self, DURATIONKYE);
    if (numeber != nil) {
        _duration = [numeber floatValue];
    }else{
        _duration = 0.5;
    }
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    
    switch (self.transitionStyle) {
        case 0:
            [self pushAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 1:
            [self popAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 2:
            [self flipAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 3:
            [self fadeAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 4:
            [self leftScaleAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 5:
            [self centerScaleAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 6:
            [self rotationAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 7:
            [self fadeAnimation3DPush:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 8:
            [self fadeAnimation3DPop:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 9:
            [self presentAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
        case 10:
            [self dismissAnimation:transitionContext fromViewController:fromVC toViewController:toVC];
            break;
    }
}

- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
    fromViewController:(UIViewController *)fromVC
      toViewController:(UIViewController *)toVC {
    
    toVC.view.transform = CGAffineTransformMakeTranslation(WIDTH, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation(-WIDTH, 0);
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromVC.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
   fromViewController:(UIViewController *)fromVC
     toViewController:(UIViewController *)toVC {

    [[transitionContext containerView] insertSubview:fromVC.view aboveSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation(WIDTH, 0);
    } completion:^(BOOL finished) {
        fromVC.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)leftScaleAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
    fromViewController:(UIViewController *)fromVC
      toViewController:(UIViewController *)toVC {
    
    toVC.view.transform = CGAffineTransformMakeScale(0.3, 0.3);
    toVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
        fromVC.view.transform = CGAffineTransformMakeTranslation(-WIDTH, -HEIGHT);
        toVC.view.alpha = 1;
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromVC.view.alpha = 1;
        fromVC.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)centerScaleAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
       fromViewController:(UIViewController *)fromVC
         toViewController:(UIViewController *)toVC {
    
    toVC.view.transform = CGAffineTransformMakeTranslation(WIDTH, HEIGHT);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeScale(0.001, 0.001);
    } completion:^(BOOL finished) {
        toVC.view.transform = CGAffineTransformMakeTranslation(0, 0);
        toVC.view.transform = CGAffineTransformMakeScale(0.001, 0.001);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            fromVC.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }];
}

- (void)fadeAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
    fromViewController:(UIViewController *)fromVC
      toViewController:(UIViewController *)toVC {
    
    toVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVC.view.alpha = 1;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


- (void)flipAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
    fromViewController:(UIViewController *)fromVC
      toViewController:(UIViewController *)toVC {
    
    fromVC.view.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    toVC.view.transform = CGAffineTransformMakeTranslation(WIDTH, HEIGHT);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeScale(-0.000001, 1.0);
    } completion:^(BOOL finished) {
        toVC.view.transform = CGAffineTransformMakeScale(-0.000001, 1.0);
        fromVC.view.transform = CGAffineTransformMakeTranslation(WIDTH, HEIGHT);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            fromVC.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }];
}

- (void)rotationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
  fromViewController:(UIViewController *)fromVC
    toViewController:(UIViewController *)toVC {
    
    toVC.view.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeScale(-0.00001, -0.00001);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            fromVC.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }];
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
       fromViewController:(UIViewController *)fromVC
         toViewController:(UIViewController *)toVC {

    toVC.view.transform = CGAffineTransformMakeTranslation(0, HEIGHT);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
      fromViewController:(UIViewController *)fromVC
        toViewController:(UIViewController *)toVC {
    
    [[transitionContext containerView] insertSubview:fromVC.view aboveSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation(0, HEIGHT);
    } completion:^(BOOL finished) {
        fromVC.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


#pragma mark_ 3D动画

- (void)fadeAnimation3DPush:(id<UIViewControllerContextTransitioning>)transitionContext
  fromViewController:(UIViewController *)fromVC
    toViewController:(UIViewController *)toVC {
    
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D = CATransform3DScale(transform3D, 0.5, 0.5, 1);
    toVC.view.transform = CGAffineTransformMakeTranslation(WIDTH, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.layer.transform = transform3D;
        fromVC.view.alpha = 0.4;
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromVC.view.layer.transform = CATransform3DIdentity;
        fromVC.view.alpha = 1;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)fadeAnimation3DPop:(id<UIViewControllerContextTransitioning>)transitionContext
        fromViewController:(UIViewController *)fromVC
          toViewController:(UIViewController *)toVC {
    
    [[transitionContext containerView] insertSubview:fromVC.view aboveSubview:toVC.view];
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D = CATransform3DScale(transform3D, 0.5, 0.5, 1);
    toVC.view.layer.transform = transform3D;
    toVC.view.alpha = 0.4;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
        toVC.view.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformMakeTranslation(WIDTH, 0);
    } completion:^(BOOL finished) {
        fromVC.view.layer.transform = CATransform3DIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}




@end
