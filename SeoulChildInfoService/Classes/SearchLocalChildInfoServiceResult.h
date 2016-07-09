//
//  SearchLocalChildInfoServiceResult.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SearchLocalChildInfoService.h"
//@protocol SearchLocalChildInfoServiceResultDelegate;


@interface SearchLocalChildInfoServiceResult : UIViewController
{//<UITableViewDelegate, UITableViewDataSource> {//SearchLocalChildInfoServiceDelegate,
	

	NSMutableData *webData;
	NSXMLParser *xmlParser;
	
	NSMutableArray * childInfoServiceList;
	NSString * currentElement;
	NSMutableDictionary * item;
	NSMutableString * currentFacilityName, * currentTelephone, *currentFacilityID;
//	id<SearchLocalChildInfoServiceResultDelegate> delegate;//값 전달 딜리게이트
    UIView *subview;
	UITableView *mainTableView;
	int inputPageNum;
	NSString * inputDistrict;//전역변수 다음 조회시 사용
	NSString * inputRegion;
	NSString * inputFacilityName;

	NSString * inputPublic;
	NSString * inputCorporate;	
	NSString * inputPrivate;
	NSString * inputHome;	
	NSString * inputParent;
	NSString * inputJob;	
	NSString * inputSeoul;
	NSString * inputDisableTotal;	
	NSString * inputDisableFull;
	NSString * inputMultiCul;	
	NSString * inputBaby;
	NSString * inputTime;		
	NSString * inputTimeAS;		
	NSString * inputCertification;		
	NSString * inputVehicle;	
	
	IBOutlet UISegmentedControl *segGoPage;

}
-(IBAction)GO_BACK;
-(IBAction)GO_PREV;
-(IBAction)GO_NEXT;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segGoPage;
//@property (nonatomic,assign) id<SearchLocalChildInfoServiceResultDelegate> delegate;

@end
/*
@protocol SearchLocalChildInfoServiceResultDelegate<NSObject>;

@required

-(void) passParaToXML:(NSString*)inputFacilityID;


@end*/