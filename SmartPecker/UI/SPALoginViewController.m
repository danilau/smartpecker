//
//  SPALoginViewController.m
//  SmartPecker
//
//  Created by majstrak on 04.05.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPALoginViewController.h"
#import "SPANavigationController.h"
#import "SPAScheduleViewController.h"
#import "SPASubjectsViewController.h"
#import "JASidePanelController.h"
#import "SPANetworkCoordinator.h"
#import "SPANetworkCoordinatorDelegate.h"
#import "SPAAppDelegate.h"

@interface SPALoginViewController (){
    UIActivityIndicatorView *_indicator;
}

@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIImageView *loginImageView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *logoVerticalSpaceConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loginTextFieldVerticalSpaceConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *passwordTextFieldVerticalSpaceConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *forgetPasswordButtonVerticalSpaceConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loginButtonVerticalSpaceConstraint;

@end

@implementation SPALoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"SmartPecker"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //Check if the device has 3.5 inches screen size
    if([[UIScreen mainScreen] bounds].size.height == 480.0f){
        self.logoVerticalSpaceConstraint.constant -= 20.0f;
        self.loginTextFieldVerticalSpaceConstraint.constant -= 25.0f;
        self.passwordTextFieldVerticalSpaceConstraint.constant -= 30.0f;
        self.forgetPasswordButtonVerticalSpaceConstraint.constant -= 30.0f;
        self.loginButtonVerticalSpaceConstraint.constant -= 30.0f;
    }
   
    [self.loginTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.passwordTextField setKeyboardType:UIKeyboardTypeDefault];
    [self.loginTextField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchDownLoginButton:(id)sender {
    
    SPANetworkCoordinator* coord = [SPANetworkCoordinator sharedNetworkCoordinator];
    coord.delegate = self;
    [coord makeAuthenticationWithName:self.loginTextField.text  AndPass:self.passwordTextField.text];
    if(_indicator == nil){
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.frame = CGRectMake(0.0,0.0,47.0,47.0);
        NSLog(@"%f",self.loginImageView.frame.origin.x);
        _indicator.center = self.loginImageView.center;
        [self.view addSubview:_indicator];
    }
    self.loginImageView.hidden = YES;
    
    [_indicator startAnimating];
    
}

#pragma mark - SPANetworkCoordinatorDelegate

- (void) didMakeAuthenticationAttemptWithResult:(BOOL) authenticated AndData:(NSData *)data{
    [_indicator stopAnimating];
    if(authenticated){
        
        
        SPAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        SPAScheduleViewController *spaScheduleViewController = [[SPAScheduleViewController alloc] init];
        
        appDelegate.jaSidePanelController = [[JASidePanelController alloc] init];
        appDelegate.spaNavigationController = [[SPANavigationController alloc] initWithRootViewController:spaScheduleViewController];
        
        
        SPASubjectsViewController *spaSubjectsViewController = [[SPASubjectsViewController alloc] init];
        
        appDelegate.jaSidePanelController.centerPanel = appDelegate.spaNavigationController;
        appDelegate.jaSidePanelController.leftPanel = spaSubjectsViewController;
        
        //appDelegate.jaSidePanelController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:appDelegate.jaSidePanelController animated:NO completion:nil];
        
    }else{
        self.loginImageView.hidden = NO;
    }
}

@end
