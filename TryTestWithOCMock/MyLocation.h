//
//  MyLocation.h
//  TryTestWithOCMock
//
//  Created by Henry AT on 8/30/16.
//  Copyright © 2016 Apps4s. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyLocation : NSObject <CLLocationManagerDelegate>

// Para los Test:
@property BOOL geocodePending;
-(float)calculateSpeedInMPH:(float)speedInMetersPerSecond;
// - - - - - - -
@property (nonatomic, strong) CLLocationManager *locationManager;
@property float speed;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) CLGeocoder *geocoder;

-(void)startLocationUpdates;
-(void)updatePostalCode:(CLLocation *)newLocation withHandler:(CLGeocodeCompletionHandler)completionhandler;


@end
