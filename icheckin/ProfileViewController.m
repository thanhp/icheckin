//
//  ProfileViewController.m
//  icheckin
//
//  Created by Thanh Pham on 2/2/13.
//  Copyright (c) 2013 Thanh Pham. All rights reserved.
//

#import "ProfileViewController.h"
#import "icheckinAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import <CoreLocation/CoreLocation.h>

@interface ProfileViewController ()

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) FBPlacePickerViewController *placePickerController;
    
@end


@implementation ProfileViewController

- (void)populateUserDetails
{
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.userNameLabel.text = user.name;
                 self.userProfileImage.profileID = user.id;
                 
             }
         }];
    }
}

- (void) saveLocation {
    float latitude = self.locationManager.location.coordinate.latitude;
    float longitude = self.locationManager.location.coordinate.longitude;
    NSLog(@" %f %f",latitude,longitude);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

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
	[[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(sessionStateChanged:)
     name:SCSessionStateChangedNotification
     object:nil];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    // We don't want to be notified of small changes in location,
    // preferring to use our last cached results, if any.
    self.locationManager.distanceFilter = 50;
    [self.locationManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (!oldLocation ||
        (oldLocation.coordinate.latitude != newLocation.coordinate.latitude &&
         oldLocation.coordinate.longitude != newLocation.coordinate.longitude)) {
            
            // To-do, add code for triggering view controller update
            NSLog(@"Got location: %f, %f",
                  newLocation.coordinate.latitude,
                  newLocation.coordinate.longitude);
        }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.placePickerController = nil;
}

- (void)sessionStateChanged:(NSNotification*)notification {
    [self populateUserDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
