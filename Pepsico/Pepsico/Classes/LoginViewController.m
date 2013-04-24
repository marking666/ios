//
//  LoginViewController.m
//  Pepsico
//
//  Created by marking daniel cuevas ceron on 17/04/13.
//  Copyright (c) 2013 marking daniel cuevas ceron. All rights reserved.
//

#import "LoginViewController.h"
#import <unistd.h>


@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@interface LoginViewController ()

@end

@implementation LoginViewController


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
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [_scrollView addGestureRecognizer:tapGesture];
    
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.view.backgroundColor = backgroundColor;
    
    
    
    
	// Do any additional setup after loading the view.
}
-(void)hideKeyboard
{
    
    [_userTxt resignFirstResponder];
    [_passwordTxt resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     }

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ss");
    [_userTxt resignFirstResponder];
    [_passwordTxt resignFirstResponder];


}

- (IBAction)login:(id)sender {
    [_userTxt resignFirstResponder];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Verificando.";
    
	[HUD showAnimated:YES whileExecutingBlock:^{
		[self loginPost];
	} completionBlock:^{
     [HUD removeFromSuperview];
        NSString *identifier =@"PendientesBoard";
         
        UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
            self.slidingViewController.topViewController = newTopViewController;
           [self.slidingViewController anchorTopViewTo:ECRight];
       
		
		}];
    
    
    /*HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Verificando.";
	
	[HUD showWhileExecuting:@selector(loginPost) onTarget:self withObject:nil animated:YES];
    
 
	HUD.minSize = CGSizeMake(135.f, 135.f);
	*/
	//[HUD showWhileExecuting:@selector(myMixedTask) onTarget:self withObject:nil animated:YES];
    
}

#pragma mark -
#pragma mark Execution code

- (void)myTask {
	// Do something usefull in here instead of sleeping ...
	sleep(3);
}
- (void) alertStatus:(NSString *)msg :(NSString *) title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)l{
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.108:8080/pepsicoMobile/auth.do?user=%@&password=%@", [_userTxt text],[_passwordTxt text]]]];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
     NSInteger success = [(NSNumber *) [json objectForKey:@"success"] integerValue];
       NSLog(@"%d",success);
   // NSArray *response = [json objectForKey:@"resultMessage"];
     NSLog(@"%@",json);

}
-(void) loginPost{
    @try {
        
        if([[_userTxt text] isEqualToString:@""] || [[_passwordTxt text] isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"user=%@&password=%@",[_userTxt text],[_passwordTxt text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://vanjaweb.dyndns.org:8080/pepsicoMobile/auth.do"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
         //   [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
              NSLog(@"urlData ==> %@", urlData);
            NSLog(@"Response code: %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                //SBJsonParser *jsonParser = [SBJsonParser new];
                
                NSError* error2;
                NSDictionary* json = [NSJSONSerialization
                                      JSONObjectWithData:urlData //1
                                      
                                      options:kNilOptions
                                      error:&error2];
                
                
                
               
                //NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                NSLog(@"%@",json);
               
                NSInteger success = [(NSNumber *) [json objectForKey:@"success"] integerValue];
                //NSLog(@"%d",success);
                if(success == 1)
                {
                   NSLog(@"Login SUCCESS");
                    HUD.mode = MBProgressHUDModeCustomView;
                    HUD.labelText = @"Login Success!";
                    sleep(1);
                     
                  //  NSString *identifier =@"MainBoard";
                //    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
                  //    self.slidingViewController.topViewController = newTopViewController;
                //    [self.slidingViewController anchorTopViewTo:ECRight];
                    
                    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                    [settings setValue:_userTxt.text forKey:@"userName"];
                    [settings setValue:_passwordTxt.text forKey:@"password"];
                    
                    NSInteger nomina = [(NSNumber *) [json objectForKey:@"nomina"] integerValue];
                    NSString *name= (NSString*)[json objectForKey:@"name"];
                    NSLog(name);
                    
                      [settings setInteger:nomina forKey:@"nomina"];

                    [settings synchronize];
                    
                } else {
                    
                    NSString *error_msg = (NSString *) [json objectForKey:@"error_message"];
                  //  HUD.mode = MBProgressHUDModeCustomView;
                   // HUD.labelText = error_msg;
                   // sleep(1);
                  
                    //[self.slidingViewController anchorTopViewTo:ECRight];
                  
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
              //  [self alertStatus:@"Connection Failed" :@"Login Failed!"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Login Failed." :@"Login Failed!"];
    }

}

- (void)myMixedTask {
	// Indeterminate mode
	sleep(2);
	// Switch to determinate mode
	HUD.mode = MBProgressHUDModeDeterminate;
	HUD.labelText = @"Progress";
	float progress = 0.0f;
	while (progress < 1.0f)
	{
		progress += 0.01f;
		HUD.progress = progress;
		usleep(50000);
	}
	// Back to indeterminate mode
	HUD.mode = MBProgressHUDModeIndeterminate;
	HUD.labelText = @"Cleaning up";
	sleep(2);
	// The sample image is based on the work by www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	//HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Completed";
	sleep(2);
}

@end
