//
//  SearchChildInfoNewsService.h
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 12..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchChildInfoNewsService : UIViewController {
	NSMutableData *webData;
	NSXMLParser *xmlParser;
	
	NSMutableArray * childInfoServiceList;
	NSString * currentElement;
	NSMutableDictionary * item;
	NSMutableString * currentTitle, * currentRegDate, *currentChildInfoID;
    UIView *subview;
	UITableView *mainTableView;

	int inputPageNum;
}
@property (retain,nonatomic) UITableView *mainTableView;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
-(IBAction)GO_BACK;
-(IBAction)GO_PREV;
-(IBAction)GO_NEXT;
@end
