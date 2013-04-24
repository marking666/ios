//
//  PendienteDetailViewController.m
//  Pepsico
//
//  Created by marking daniel cuevas ceron on 19/04/13.
//  Copyright (c) 2013 marking daniel cuevas ceron. All rights reserved.
//

#import "PendienteDetailViewController.h"

@interface PendienteDetailViewController ()

@end

@implementation PendienteDetailViewController
@synthesize web=_web;
@synthesize url=_url;

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
	// Do any additional setup after loading the view.
    //basic HTTP authentication
  //  NSString *surl=@"http://vanjaweb.dyndns.org:8080/pepsicoMobile/vacaciones.do";
  // NSURL *_url=[NSURL URLWithString:surl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:12];
    
    self.web.scalesPageToFit=YES;
    
    
    
    [self.web loadRequest:request];
    
    (void)[NSURLConnection connectionWithRequest:request delegate:self];
    
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
