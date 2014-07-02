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
#import "SPAAppDelegate.h"
#import "SPAModelCoordinator.h"

@interface SPALoginViewController (){
    UIActivityIndicatorView *_indicator;
    BOOL _authenticated;
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
        _authenticated = NO;
        
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
    SPAModelCoordinator* modelCoordinator = [SPAModelCoordinator sharedModelCoordinator];
    
    [modelCoordinator activateViaWebServiceWithLogin:self.loginTextField.text AndPassword:self.passwordTextField.text];
    
    if(_indicator == nil){
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.frame = CGRectMake(0.0,0.0,47.0,47.0);
        _indicator.center = self.loginImageView.center;
        [self.view addSubview:_indicator];
    }
    self.loginImageView.hidden = YES;
    
    [_indicator startAnimating];
    
}


#pragma mark - SPAModelActivationDelegate

- (void) modelActivationDone{
    
    if(_authenticated == YES){
        
        
        [_indicator stopAnimating];
  
        
        SPAAppDelegate *appDelegate = (SPAAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        SPAScheduleViewController *spaScheduleViewController = [[SPAScheduleViewController alloc] init];
        
        appDelegate.jaSidePanelController = [[JASidePanelController alloc] init];
        appDelegate.spaNavigationController = [[SPANavigationController alloc] initWithRootViewController:spaScheduleViewController];
        
        
        SPASubjectsViewController *spaSubjectsViewController = [[SPASubjectsViewController alloc] init];
        
        appDelegate.jaSidePanelController.centerPanel = appDelegate.spaNavigationController;
        appDelegate.jaSidePanelController.leftPanel = spaSubjectsViewController;
        
        SPAModelCoordinator* modelCoordinator = [SPAModelCoordinator sharedModelCoordinator];
        modelCoordinator.subjectsActivationDelegate = (id<SPAModelSubjectsActivationDelegate>)spaSubjectsViewController;
        spaSubjectsViewController.spaScheduleViewController = spaScheduleViewController;
        
        //appDelegate.jaSidePanelController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:appDelegate.jaSidePanelController animated:NO completion:nil];
        });
    }

}

- (void)modelAuthenticationDoneWithError:(BOOL) error{
    _authenticated = !error;

    if(error == YES){
    
        [_indicator stopAnimating];
        self.loginImageView.hidden = NO;
    
    }
}

@end
