//
//  SearchChildInfoFindOutdoorResult.h
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 18..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchChildInfoFindOutdoorResult : UIViewController {
	NSMutableData *webData;
	NSXMLParser *xmlParser;
	
	NSMutableArray * childInfoServiceList;
	NSString * currentElement;
	NSMutableDictionary * item;
	NSMutableString * currentTitle, * currentRegDate, *currentChildInfoID;
	//	id<SearchLocalChildInfoServiceResultDelegate> delegate;//값 전달 딜리게이트
    UIView *subview;
	//	IBOutlet UIToolbar *toolBar;
	UITableView *mainTableView;
	
	int inputPageNum;
	NSString *inputoutdoorType;//전역변수 다음 조회시 사용
	NSString *inputRegionType;//전역변수 다음 조회시 사용
	
	
}
//@property(nonatomic, retain) IBOutlet UIToolbar *toolBar;

//@property(nonatomic, retain) int *inputPageNum;
//@property(nonatomic, retain) NSString *soapMessage;

@property (retain,nonatomic) UITableView *mainTableView;
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;


-(IBAction)GO_BACK;
-(IBAction)GO_PREV;
-(IBAction)GO_NEXT;
@end
