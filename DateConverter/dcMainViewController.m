//
//  dcMainViewController.m
//  DateConverter
//
//  Created by Tony Johnston on 10/31/11.
//  Copyright (c) 2011 iNET Interactive, Inc. All rights reserved.
//

#import "dcMainViewController.h"

@implementation dcMainViewController

@synthesize flipsidePopoverController = _flipsidePopoverController;
@synthesize textDisplay = textDisplay;
@synthesize datePicker = datePicker;
@synthesize labelDisplay = labelDisplay;
@synthesize calendars = calendars;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSDate *now = [[NSDate alloc] init];
	[datePicker setDate:now animated:YES];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)dateFieldChanged:(id)sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
	NSDate *datePicked = picker.date;
	
	// Break apart the date into its components
	NSCalendar *calendar = [[NSCalendar alloc]
						  initWithCalendarIdentifier:@"NSGregorianCalendar"];	

	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
	NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:datePicked];
	
	int theDay = dateComponents.day; 
	int theMonth = dateComponents.month; 
	int theYear = dateComponents.year; 
	
	// Create a new string to describe the date
	NSString *newLabel = [[NSString alloc]
						  initWithFormat:@"%d %d, %d",
						  theDay,theMonth,theYear];
	
	NSString *newText = [[NSString alloc] 
						 initWithFormat:@"Using the %@ calendar, the date you selected translates to the day %d, the month %d, the year %d.",
						 @"Gregorian",theDay,theMonth,theYear];
	
	// Change the UI elements to reflect date changes
	textDisplay.text = newText;
    labelDisplay.text = newLabel;
//    labelDisplay.text = calType;
}

- (IBAction)calendarChanged{
	NSDate *datePicked = datePicker.date;
	
	// Break apart the date into its components
	NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:@"NSGregorianCalendar"];	
    
	unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
	NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:datePicked];
	
	int theDay = dateComponents.day; 
	int theMonth = dateComponents.month; 
	int theYear = dateComponents.year; 
	
	// Create a new string to describe the date
	NSString *newLabel = [[NSString alloc]
						  initWithFormat:@"%@ %d %d, %d",
						  @"NSGregorianCalendar",theDay,theMonth,theYear];
	
	NSString *newText = [[NSString alloc] 
						 initWithFormat:@"Using the %@ calendar, the date you selected translates to the day %d, the month %d, the year %d.",
						 @"NSGregorianCalendar",theDay,theMonth,theYear];
	
	// Change the UI elements to reflect date changes
	textDisplay.text = newText;
}  


#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(dcFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

@end
