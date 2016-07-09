//
//  LocationAnnotation.h
//  SexyOfKorea
//
//  Created by 서정범 on 12. 1. 7..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface LocationAnnotation : NSObject<MKAnnotation> 
{
	CLLocationCoordinate2D coordinate;
	NSString *currentSubTitle;
	NSString *currentTitle;
	NSString *currentFacilityID;
	BOOL	 currentCenter;
}
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *currentTitle;
@property (nonatomic,retain) NSString *currentSubTitle;
@property (nonatomic,retain) NSString *currentFacilityID;
@property (nonatomic,assign) BOOL currentCenter;

-(NSString*)title;
-(NSString*)subtitle;
-(NSString*)facilityID;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c;

@end
