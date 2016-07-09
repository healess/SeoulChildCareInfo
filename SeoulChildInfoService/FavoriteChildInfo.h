//
//  FavoriteChildInfo.h
//  SeoulChildInfoService
//
//  Created by JUNG-BUM SEO on 12. 8. 19..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


//@interface FavoriteChildInfo : UITableViewController 
@interface FavoriteChildInfo : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	UIView *subview;
	UITableView *mainTableView;
	//UIToolbar *toolBar;
	IBOutlet UINavigationBar *navigationBar;
	IBOutlet UIButton *editButton;
	
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIButton *editButton;
- (IBAction)editTable;
@end
