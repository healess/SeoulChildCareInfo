//
//  SearchChildInfoServiceSite.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchChildInfoServiceSite : UIViewController {
	UITableView *mainTableView;

}
@property (retain,nonatomic) UITableView *mainTableView;
-(IBAction)GO_BACK;
@end
