//
//  MenuViewController.h
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/23/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MBProgressHUD.h"
@interface MenuViewController : UIViewController <UITableViewDataSource, UITabBarControllerDelegate,MBProgressHUDDelegate>
{
	MBProgressHUD *HUD;
    
}
- (IBAction)logout:(id)sender;
 
	
 
@end
