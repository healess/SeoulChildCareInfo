//
//  SearchLocalChildInfoServiceContent.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SearchLocalChildInfoServiceResult.h"


@interface SearchLocalChildInfoServiceContent : UIViewController{//<SearchLocalChildInfoServiceResultDelegate> {
	NSMutableData *webData;
	NSXMLParser *xmlParser;

	NSString * currentElement;//현제 항목값 체크

	IBOutlet UILabel *facilityName;
	IBOutlet UILabel *address;
	IBOutlet UILabel *telephone;
	IBOutlet UILabel *presidentName;	
	IBOutlet UILabel *cRType;//시설유형
	IBOutlet UILabel *cRSpec;//시설특성
	IBOutlet UILabel *openDate;//개원일
	IBOutlet UILabel *vehicle;//차량운행
	IBOutlet UILabel *certification;//평가인증유무
	IBOutlet UILabel *govSupport;//정부지원여부
	IBOutlet UILabel *accidentInsurance;//상해부험가입여부
	IBOutlet UILabel *fireInsurance;//화재보험가입여부	
	IBOutlet UILabel *compensationInsurance;//배상보험가입여부요청
	IBOutlet UILabel *fixedNumber;//정원	
	IBOutlet UILabel *presentNumber;//현원
	
    UIView *subview;
	NSString * currentFacilityID;//사설아이디값 저장

	
}
-(IBAction)searchChildInfoServiceDetail:(id)sender;
-(void)passParaToXML:(NSString *)inputFacilityID;
-(IBAction) GO_BACK;
-(IBAction) CALL_TELEPHONE;
-(IBAction) ADD_FAVORITE;
-(IBAction) GO_DETAIL;
-(IBAction) GO_MAP;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;

@property(nonatomic, retain) IBOutlet UILabel *facilityName;
@property(nonatomic, retain) IBOutlet UILabel *address;
@property(nonatomic, retain) IBOutlet UILabel *telephone;
@property(nonatomic, retain) IBOutlet UILabel *presidentName;
@property(nonatomic, retain) IBOutlet UILabel *cRType;
@property(nonatomic, retain) IBOutlet UILabel *cRSpec;
@property(nonatomic, retain) IBOutlet UILabel *openDate;
@property(nonatomic, retain) IBOutlet UILabel *vehicle;
@property(nonatomic, retain) IBOutlet UILabel *certification;
@property(nonatomic, retain) IBOutlet UILabel *govSupport;
@property(nonatomic, retain) IBOutlet UILabel *accidentInsurance;
@property(nonatomic, retain) IBOutlet UILabel *fireInsurance;
@property(nonatomic, retain) IBOutlet UILabel *compensationInsurance;
@property(nonatomic, retain) IBOutlet UILabel *fixedNumber;
@property(nonatomic, retain) IBOutlet UILabel *presentNumber;
@end

