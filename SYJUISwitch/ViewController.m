//
//  ViewController.m
//  SYJUISwitch
//
//  Created by syj on 2021/8/17.
//

#import "ViewController.h"
#import "SYJUISwitch.h"

@interface ViewController ()
@property (nonatomic, strong) SYJUISwitch *syjSwitch;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    SYJUISwitch *syjSwitch = [[SYJUISwitch alloc] init];
    [self.view addSubview:syjSwitch];
    syjSwitch.frame = CGRectMake(100, 200, 51, 31);
    self.syjSwitch = syjSwitch;
    [syjSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
    
    UISwitch *sss = [[UISwitch alloc] init];
    [self.view addSubview:sss];
    sss.frame = CGRectMake(100, 100, 51, 31);
    [sss addTarget:self action:@selector(switchValueChange2:) forControlEvents:UIControlEventValueChanged];

    
    UIButton *changeButton = [[UIButton alloc] init];
    changeButton.frame = CGRectMake(100, 260, 80, 40);
    [changeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [changeButton setTitle:@"改变颜色" forState:UIControlStateNormal];
    changeButton.backgroundColor = UIColor.greenColor;
    [changeButton addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
    
}

- (void)changeColor {
    self.syjSwitch.onTintColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    self.syjSwitch.offTintColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
//    self.syjSwitch.thumbTintColor = UIColor.orangeColor;
//    [self.syjSwitch setOn:!self.syjSwitch.isOn animated:YES];
//    self.syjSwitch.thumbSize = CGSizeMake(20, 20);
//    [self.syjSwitch setThumbSize:CGSizeMake(20, 20) animated:YES];
//    self.syjSwitch.thumbSize = CGSizeMake(20, 20);
}


- (void)switchValueChange:(SYJUISwitch *)syjSwitch {
    NSLog(@"自定义改变：%d", syjSwitch.isOn);
}

- (void)switchValueChange2:(UISwitch *)syjSwitch {
    NSLog(@"系统改变：%d", syjSwitch.isOn);
}


@end
