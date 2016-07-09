//
//  UntitledViewController.h
//  Untitled
//
//  Created by JUNG-BUM SEO on 12. 7. 2..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface FacebookPR : UIViewController <FBSessionDelegate, FBRequestDelegate, FBDialogDelegate>
{
	Facebook *facebook;//페이스북
	UIActivityIndicatorView *activityIndicator;
	IBOutlet UIButton *btnLoginOut;
	IBOutlet UIButton *btnFeed;
	IBOutlet UIButton *btnPhoto;
	UIImage *img; //체이스북에 올릴 이미지
	IBOutlet UITextView *textView;
}

@property (nonatomic, retain) Facebook *facebook; //페이스북
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator; 
@property (nonatomic, retain) IBOutlet UIButton *btnLoginOut;
@property (nonatomic, retain) IBOutlet UIButton *btnFeed;
@property (nonatomic, retain) IBOutlet UIButton *btnPhoto;
@property (nonatomic, retain) UIImage *img;
@property (nonatomic, retain) UITextView *textView;

-(IBAction) FACEBOOK_LOGINOUT;
-(IBAction) GRAPH_TEST;
-(IBAction) GO_BACK;

@end

