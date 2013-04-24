//
//  PendienteDetailViewController.h
//  Pepsico
//
//  Created by marking daniel cuevas ceron on 19/04/13.
//  Copyright (c) 2013 marking daniel cuevas ceron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendienteDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (strong, nonatomic)  NSURL *url;
@end
