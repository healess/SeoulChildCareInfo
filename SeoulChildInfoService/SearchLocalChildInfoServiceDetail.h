//
//  SearchLocalChildInfoServiceDetail.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchLocalChildInfoServiceDetail : UIViewController {
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;

	NSString * currentElement;
	IBOutlet UIWebView		*infoWebComment;	//HTML정보가 리턴되므로 WebView를 사용
	NSString *cotentInfo ;
	UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic,retain) IBOutlet UIWebView		*infoWebComment;	//HTML정보가 리턴되므로 WebView를 사용
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator; 
-(IBAction) GO_BACK;

@end
