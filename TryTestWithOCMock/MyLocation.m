//
//  MyLocation.m
//  TryTestWithOCMock
//
//  Created by Henry AT on 8/30/16.
//  Copyright © 2016 Apps4s. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation

@synthesize geocodePending;
@synthesize locationManager;
@synthesize speed;
@synthesize postalCode;
@synthesize geocoder;

-(id)init{
  self = [super init];
  if (!self) {
    return nil;
  }
  
  postalCode = @"Unknown";
  geocodePending = NO;
  geocoder = [[CLGeocoder alloc] init];
  
  locationManager = [[CLLocationManager alloc] init];
  locationManager.delegate = self;
  [locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
  [locationManager setDistanceFilter:kCLDistanceFilterNone];
  
  return self;
}


-(void)startLocationUpdates{
  [locationManager startUpdatingLocation];
}

-(void)updatePostalCode:(CLLocation *)newLocation withHandler:(CLGeocodeCompletionHandler)completionhandler{
  
  if (geocodePending) {
    return;
  }
  geocodePending = YES;
  [geocoder reverseGeocodeLocation:newLocation completionHandler:completionhandler]; // de coordenadas -> Nombre
  
}

-(float)calculateSpeedInMPH:(float)speedInMetersPerSecond{
  float speedInMetersPerHour = speedInMetersPerSecond * 60 * 60;
  return speedInMetersPerHour / 1609.344;
}

#pragma mark - Locationmanager Delegate methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
  
  CLLocation *newLocation = [locations lastObject];
  [self updatePostalCode:newLocation withHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    CLPlacemark *placemark = [placemarks objectAtIndex:0];
    postalCode = [placemark postalCode];
    geocodePending = NO;
  }];

  float speedLocal = [self calculateSpeedInMPH:[newLocation speed]];
  speed = speedLocal;
}

@end
