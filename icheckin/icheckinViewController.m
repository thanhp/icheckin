//
//  icheckinViewController.m
//  icheckin
//
//  Created by Thanh Pham on 2/2/13.
//  Copyright (c) 2013 Thanh Pham. All rights reserved.
//

#import "icheckinViewController.h"

#import "icheckinAppDelegate.h"

@interface icheckinViewController ()

- (IBAction)logoutButtonWasPressed:(id)sender;

- (IBAction)perfomLogin:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@end


@implementation icheckinViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
     
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
//    [self.spinner stopAnimating];
}

- (IBAction)logoutButtonWasPressed:(id)sender {
    icheckinAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate logoutSession];

}

- (IBAction)perfomLogin:(id)sender {
//    [self.spinner startAnimating];
    
    icheckinAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
    
}
@end
