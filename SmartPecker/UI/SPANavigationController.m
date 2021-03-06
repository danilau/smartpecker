//
//  SPANavigationController.m
//  SmartPecker
//
//  Created by majstrak on 04.05.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPANavigationController.h"

@interface SPANavigationController ()

@end

@implementation SPANavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0f green:209/255.0f blue:184/255.0f alpha:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* statusBarBackView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
    statusBarBackView.backgroundColor = [UIColor whiteColor];
    [self.navigationBar.superview addSubview:statusBarBackView];
    
    UIView* statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
    statusBarView.backgroundColor = [UIColor colorWithRed:230/255.0f green:209/255.0f blue:184/255.0f alpha:0.85];
    statusBarView.alpha = 1.0;
    [self.view addSubview:statusBarView];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
