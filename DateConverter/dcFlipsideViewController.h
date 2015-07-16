//
//  dcFlipsideViewController.h
//  DateConverter
//
//  Created by Tony Johnston on 10/31/11.
//  Copyright (c) 2011 iNET Interactive, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class dcFlipsideViewController;

@protocol dcFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(dcFlipsideViewController *)controller;
@end

@interface dcFlipsideViewController : UIViewController;

@property (weak, nonatomic) IBOutlet id <dcFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
