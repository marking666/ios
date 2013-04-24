//
//  VacacionesViewController.m
//  Pepsico
//
//  Created by marking daniel cuevas ceron on 18/04/13.
//  Copyright (c) 2013 marking daniel cuevas ceron. All rights reserved.
//

#import "VacacionesViewController.h"

@interface VacacionesViewController ()

@end

@implementation VacacionesViewController
@synthesize web=_web;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //basic HTTP authentication
    NSString *surl=@"http://vanjaweb.dyndns.org:8080/pepsicoMobile/vacaciones.do";
    NSURL *url=[NSURL URLWithString:surl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:12];
    
    self.web.scalesPageToFit=YES;
    
    
    
    [self.web loadRequest:request];
    
    (void)[NSURLConnection connectionWithRequest:request delegate:self];
    
	// Do any additional setup after loading the view.
}


- (void)viewDidUnload
{
    [self setWeb:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // shadowPath, shadowOffset, and rotation is handled by ECSlidingViewController.
    // You just need to set the opacity, radius, and color.
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuBoard"];
    }
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSString *user = [[NSUserDefaults standardUserDefaults]  stringForKey: @"userName"];
    NSString *password = [[NSUserDefaults standardUserDefaults]  stringForKey: @"password"];
    
    
    NSURLCredential * cred = [NSURLCredential credentialWithUser:user
                                                        password:password
                                                     persistence:NSURLCredentialPersistenceForSession];
    [[NSURLCredentialStorage sharedCredentialStorage]setCredential:cred forProtectionSpace:[challenge protectionSpace]];
    
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection;
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
