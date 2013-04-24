//
//  PendientesListViewController.h
//  Pepsico
//
//  Created by marking daniel cuevas ceron on 19/04/13.
//  Copyright (c) 2013 marking daniel cuevas ceron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "MBProgressHUD.h"


@interface PendientesListViewController : UITableViewController<MBProgressHUDDelegate,UITableViewDataSource, UITabBarControllerDelegate>
{
    NSArray *pendientes;
    NSMutableData *responseData;
    MBProgressHUD *HUD;
    long long expectedLength;
	long long currentLength;
    
}

 

- (IBAction)revealMenu:(id)sender;
@property (nonatomic, retain) UIImageView *customImage;
@property (nonatomic, retain) NSArray *pendientes;
@property (nonatomic, retain) NSMutableData *responseData;
@end
