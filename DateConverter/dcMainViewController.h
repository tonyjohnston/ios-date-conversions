//
//  dcMainViewController.h
//  DateConverter
//
//  Created by Tony Johnston on 10/31/11.
//  Copyright (c) 2011 iNET Interactive, Inc. All rights reserved.
//

#import "dcFlipsideViewController.h"

@interface dcMainViewController : UIViewController <dcFlipsideViewControllerDelegate, UIPopoverControllerDelegate>{
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UITextView *textDisplay;
    IBOutlet UILabel *labelDisplay;
}

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UITextView *textDisplay;
@property (nonatomic, retain) UILabel *labelDisplay;
@property (nonatomic, retain) NSMutableArray *calendars;

-(IBAction)dateFieldChanged:(id)sender;
-(IBAction)calendarChanged:(id)sender;
@end
