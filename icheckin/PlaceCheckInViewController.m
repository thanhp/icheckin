//
//  PlaceCheckInViewController.m
//  icheckin
//
//  Created by Thanh Pham on 2/2/13.
//  Copyright (c) 2013 Thanh Pham. All rights reserved.
//

#import "PlaceCheckInViewController.h"

@interface PlaceCheckInViewController ()

@property (weak, nonatomic) IBOutlet UITableView *nearByPlaceView;

@end

@implementation PlaceCheckInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
