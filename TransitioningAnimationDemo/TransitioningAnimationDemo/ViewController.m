//
//  ViewController.m
//  TransitioningAnimationDemo
//
//  Created by lizq on 16/3/17.
//  Copyright (c) 2016年 w jf. All rights reserved.
//

#import "ViewController.h"
#import "ToViewController.h"
#import "LQTransformAnimation.h"

@interface ViewController ()<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) LQTransformAnimation *animation;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转场动画";
    self.animation = [[LQTransformAnimation alloc] init];
    self.animation.duration = 0.75;

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];



}

-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        _dataArray[0] = @"UINavigationTransitionPush";
        _dataArray[1] = @"UINavigationTransitionPop";
        _dataArray[2] = @"UINavigationTransitionFlip";
        _dataArray[3] = @"UINavigationTransitionFade";
        _dataArray[4] = @"UINavigationTransitionLeftScale";
        _dataArray[5] = @"UINavigationTransitionCenterScale";
        _dataArray[6] = @"UINavigationTransitionRotation";
        _dataArray[7] = @"UINavigationTransitionFade3DPush";
        _dataArray[8] = @"UINavigationTransitionFade3DPop";
        _dataArray[9] = @"UINavigationTransitionPresent";
        _dataArray[10] = @"UINavigationTransitionDismiss";
    }
    return _dataArray;
}


#warning  每次视图显示需要将导航的代理重新指向当前视图控制器
-(void)viewDidAppear:(BOOL)animated {

    self.navigationController.delegate = self;
}

-(void)buttonClick:(UIButton *)button {
    
}


#pragma mark_tabelviewdelegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.animation.transitionStyle = indexPath.row;
    ToViewController *vc = [[ToViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark _导航代理方法
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                 animationControllerForOperation:(UINavigationControllerOperation)operation
                                              fromViewController:(UIViewController *)fromVC
                                                toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return self.animation;
    }else if (operation == UINavigationControllerOperationPop) {
        self.animation.transitionStyle = UINavigationTransitionDismiss;
        return self.animation;
    }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
