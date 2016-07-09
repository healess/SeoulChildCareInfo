//
//  LocationAnnotation.m
//  SexyOfKorea
//
//  Created by 서정범 on 12. 1. 7..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationAnnotation.h"
#import <MapKit/MapKit.h>


@implementation LocationAnnotation
@synthesize coordinate;
@synthesize currentTitle;
@synthesize currentSubTitle;
@synthesize currentFacilityID;
@synthesize currentCenter;

-(NSString*)subtitle
{
	return currentSubTitle;
}

-(NSString*)title
{
	return currentTitle;
}

-(NSString*)facilityID
{
	return currentFacilityID;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c
{
	coordinate=c;
	return self;
}

@end
