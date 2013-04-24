//
//  VacacionesViewController.h
//  Pepsico
//
//  Created by marking daniel cuevas ceron on 18/04/13.
//  Copyright (c) 2013 marking daniel cuevas ceron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface VacacionesViewController : UIViewController
- (IBAction)revealMenu:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *web;
@end
