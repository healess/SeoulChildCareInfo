//
//  SearchAroundChildInfoService.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "LocationAnnotation.h"


@interface SearchAroundChildInfoService : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate,NSXMLParserDelegate>
{

	//검색한 유치원 위치 한곳만 표시해 줄건지 
	BOOL isOneKindergarten;
	
	//최초호출인지(기준점)
	BOOL isFirstQuery;
	
	//Location manager
	CLLocationManager *locationManager;
	
	//위경도 저장변수
	double  centerLocationLat,centerLocationLong;//검색의 중심지
	double	locationLat,locationLong;//주변유치원
	
	
	UIActivityIndicatorView *activityIndicator;
	IBOutlet UITextField *inputAddress;
	IBOutlet UILabel *addre;//주소표시라벨
	IBOutlet UILabel *villagename; //동이름표라벨
	IBOutlet UIButton *renew;
	IBOutlet MKMapView *mapView;
	LocationAnnotation *centerLocationAnnotation;
	LocationAnnotation *locationAnnotation;
	NSMutableArray *kinderAnnotanions;  //유치원의 annotation 을 담는 어레이.
	
	
	
	//region, span
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	
	
	//FOR SOAP
	NSMutableData *webData;
	NSXMLParser *xmlParser;
	NSMutableArray * childInfoServiceList;
	NSString * currentElement;
	NSMutableDictionary * item;
	NSMutableString * currentFacilityName, * currentAddress,* currentTelephone, *currentFacilityID;
	
	UIView *subview;
	
}

//FOR MAP
@property (nonatomic, assign) BOOL isOneKindergarten;
@property (nonatomic, assign) BOOL isFirstQuery;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator; 
@property (nonatomic, assign) double	centerLocationLat;
@property (nonatomic, assign) double	centerLocationLong;
@property (nonatomic, assign) double	locationLat;
@property (nonatomic, assign) double	locationLong;
@property (nonatomic, assign) IBOutlet	UITextField *inputAddress;
@property (nonatomic, assign) IBOutlet	UILabel *addre;
@property (nonatomic, assign) IBOutlet	UILabel *villagename;
@property (nonatomic, assign) IBOutlet  UIButton *renew;
@property (nonatomic, retain) IBOutlet	MKMapView *mapView;
@property (nonatomic, retain) LocationAnnotation *centerLocationAnnotation;
@property (nonatomic, retain) LocationAnnotation *locationAnnotation;
@property (nonatomic, retain) NSMutableArray *kinderAnnotanions;//유치원의 annotation 을 담는 어레이.
@property (nonatomic, assign) MKCoordinateRegion region;
@property (nonatomic, assign) MKCoordinateSpan span;

//FOR SOAP
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;


//FOR MAP
- (IBAction) POINT_POSITON_ON_MAP_BY_ADDRESS;
- (IBAction) POINT_MY_POSITION;
- (void) GET_LATLONG_BY_ADDRESS:(NSString*) address;
-(IBAction) GO_BACK;

//FOR SOAP
-(void) GET_KINDERGARTEN_INFO_BY_VILLAGE_NAME:(NSString*)VillageName;
@end
