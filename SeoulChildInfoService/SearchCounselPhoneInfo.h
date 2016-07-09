//
//  SearchCounselPhoneInfo.h
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 23..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchCounselPhoneInfo : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UITableView	 *mainTableView;
	IBOutlet UITableViewCell *tableViewCell;

	NSArray *staff_dist;	//자치구
	NSArray *staff_respon;	//담당업무
	NSArray *staff_depart;	//부서
	NSArray *staff_names;	//성명
	NSArray *staff_tel;		//전화번호
	
}
@property (nonatomic,retain) IBOutlet UITableView *mainTableView;
@property (nonatomic,retain) IBOutlet UITableViewCell *tableViewCell;
-(IBAction)GO_BACK;
-(void) check_button_Touched:(UIButton*)sender;
@end
