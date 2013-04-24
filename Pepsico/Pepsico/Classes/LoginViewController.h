//
//  LoginViewController.h
//  Pepsico
//
//  Created by marking daniel cuevas ceron on 17/04/13.
//  Copyright (c) 2013 marking daniel cuevas ceron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController<MBProgressHUDDelegate,UIScrollViewDelegate> {
	MBProgressHUD *HUD;
  
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)revealMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userTxt;

@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
- (IBAction)login:(id)sender;


- (void)myTask;
-(void) loginPost;
@end
