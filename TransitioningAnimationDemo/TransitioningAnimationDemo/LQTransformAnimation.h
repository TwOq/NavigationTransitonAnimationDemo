//
//  TransformAnimation.h
//  TransitioningAnimationDemo
//
//  Created by lizq on 16/3/17.
//  Copyright (c) 2016年 w jf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UINavigationTransitionStyle) {
    //默认push
    UINavigationTransitionPush = 0,
    //默认pop
    UINavigationTransitionPop,
    //翻转 2D
    UINavigationTransitionFlip,
    //淡入淡出
    UINavigationTransitionFade,
    //左上角淡出，缩放淡入
    UINavigationTransitionLeftScale,
    //中心缩放
    UINavigationTransitionCenterScale,
    //旋转
    UINavigationTransitionRotation,
    //淡出 3D
    UINavigationTransitionFade3DPush,
    //淡入 3D
    UINavigationTransitionFade3DPop,
    //present
    UINavigationTransitionPresent,
    //dismiss
    UINavigationTransitionDismiss,
};

@interface LQTransformAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (assign, nonatomic) float duration; //动画时间
@property (assign, nonatomic) UINavigationTransitionStyle transitionStyle;

@end
