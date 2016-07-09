//
//  SearchChildInfoBookServiceContent.h
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 20..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchChildInfoBookServiceContent : UIViewController {
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	NSString * currentElement;
	IBOutlet UIWebView		*infoWebComment;	//HTML정보가 리턴되므로 WebView를 사용
	NSString *cotentInfo ;
	
}

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic,retain) IBOutlet UIWebView		*infoWebComment;	//HTML정보가 리턴되므로 WebView를 사용
-(IBAction)GO_BACK;
@end
