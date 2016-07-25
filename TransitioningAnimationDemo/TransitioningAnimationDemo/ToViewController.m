//
//  ToViewController.m
//  TransitioningAnimationDemo
//
//  Created by lizq on 16/3/17.
//  Copyright (c) 2016年 w jf. All rights reserved.
//

#import "ToViewController.h"
#import "LQTransformAnimation.h"

@interface ToViewController () <UINavigationControllerDelegate>
@property (strong, nonatomic) LQTransformAnimation *animation;
@end

@implementation ToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [self randomColor];
    self.animation = [[LQTransformAnimation alloc] init];
    self.navigationController.delegate = self;


    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 100, 70)];
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];


}

- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC {

    if (operation == UINavigationControllerOperationPop) {
        
        self.animation.transitionStyle =  UINavigationTransitionDismiss;
        return self.animation;
    }else {
        return  nil;
    }

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
