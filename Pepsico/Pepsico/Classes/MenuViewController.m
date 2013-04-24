//
//  MenuViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation MenuViewController
@synthesize menuItems;

- (void)awakeFromNib
{
  self.menuItems = [NSArray arrayWithObjects:@"Pendientes", @"Recibo de Nomina", @"Vacaciones",@"" ,@"",nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.slidingViewController setAnchorRightRevealAmount:280.0f];
  self.slidingViewController.underLeftWidthLayout = ECFullWidth;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"MenuItemCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
  //cell.backgroundColor=[UIColor blueColor];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier =@"LoginBoard"; //[NSString stringWithFormat:@"%@Top", [self.menuItems objectAtIndex:indexPath.row]];
    
    switch(indexPath.row) {
        case 0:
           identifier =@"PendientesBoard"; 
            break;
        case 1:
           identifier =@"NominaBoard"; 
            break;
        case 2:
            identifier =@"VacacionesBoard";
            break;

         
     
    }
    
   
  UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
  
  [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
  }];
}

- (IBAction)logout:(id)sender {
    
   
        //HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        //[self.navigationController.view addSubview:HUD];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];

        // Set determinate mode
       // HUD.mode = MBProgressHUDModeDeterminate;
        
        HUD.delegate = self;
        HUD.labelText = @"Cerrando Sesion...";
        
        // myProgressTask uses the HUD instance to update progress
        [HUD showWhileExecuting:@selector(logOut_) onTarget:self withObject:nil animated:YES];
     
    
}
- (void)logOut_ {
	// Do something usefull in here instead of sleeping ...
	sleep(2);
    NSString *identifier =@"LoginBoard";
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
    
    [self eraseCredentials];
    
}

- (void) eraseCredentials{
   
 
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
           NSLog(@"Deleting cookie for domain: %@", [each domain]);
        [cookieStorage deleteCookie:each];
    }
    
    NSDictionary *credentialsDict = [[NSURLCredentialStorage sharedCredentialStorage] allCredentials];
    
    if ([credentialsDict count] > 0) {
        // the credentialsDict has NSURLProtectionSpace objs as keys and dicts of userName => NSURLCredential
        NSEnumerator *protectionSpaceEnumerator = [credentialsDict keyEnumerator];
        id urlProtectionSpace;
        
        // iterate over all NSURLProtectionSpaces
        while (urlProtectionSpace = [protectionSpaceEnumerator nextObject]) {
            NSEnumerator *userNameEnumerator = [[credentialsDict objectForKey:urlProtectionSpace] keyEnumerator];
            id userName;
            
            // iterate over all usernames for this protectionspace, which are the keys for the actual NSURLCredentials
            while (userName = [userNameEnumerator nextObject]) {
                NSURLCredential *cred = [[credentialsDict objectForKey:urlProtectionSpace] objectForKey:userName];
                NSLog(@"cred to be removed: %@", cred);
                [[NSURLCredentialStorage sharedCredentialStorage] removeCredential:cred forProtectionSpace:urlProtectionSpace];
            }
        }
    }
}

@end
