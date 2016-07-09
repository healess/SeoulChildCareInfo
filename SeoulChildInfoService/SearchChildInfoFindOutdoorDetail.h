//
//  SearchChildInfoFindOutdoorDetail.h
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 18..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchChildInfoFindOutdoorDetail : UIViewController {
	NSMutableData *webData;
	NSXMLParser *xmlParser;
	
	NSString * currentElement;//현제 항목값 체크
	
	IBOutlet UILabel *infoTitle;
	IBOutlet UILabel *address;
	IBOutlet UILabel *tel;
	IBOutlet UILabel *openTime;	
	IBOutlet UILabel *priceInfo;
	IBOutlet UITextView *infoContent;		
	
    UIView *subview;
	NSString * currentFacilityID;//사설아이디값 저장
	NSString *tempInfoContent;

	UIActivityIndicatorView *activityIndicator; 
	
}
-(IBAction)searchChildInfoServiceDetail:(id)sender;
-(IBAction)GO_BACK;
-(IBAction)GO_MAP;
-(IBAction)CALL_TELEPHONE;
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property(nonatomic, retain) IBOutlet UILabel *infoTitle;
@property(nonatomic, retain) IBOutlet UILabel *address;
@property(nonatomic, retain) IBOutlet UILabel *tel;
@property(nonatomic, retain) IBOutlet UILabel *openTime;
@property(nonatomic, retain) IBOutlet UILabel *priceInfo;
@property(nonatomic, retain) IBOutlet UITextView *infoContent;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator; 
@end
