//
//  MainMenuViewController.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainMenuViewController : UIViewController
{
    UIView *subview;
    UIView *subview2;
	//UINavigationController *navigationController;
	
}
//@property (nonatomic, retain) UINavigationController *navigationController;
-(IBAction)searchChildInfoService: (id) sender;
-(IBAction)searchChildInfoServiceByName: (id) sender;
-(IBAction)searchAroundChildInfoService: (id) sender;
-(IBAction)searchChildInfoServiceSite: (id) sender;
-(IBAction)searchChildInfoNewsService: (id) sender;
-(IBAction)searchChildInfoHealthService: (id) sender;
-(IBAction)searchChildInfoBookService: (id) sender;
-(IBAction)searchCounselPhoneInfo: (id) sender;
-(IBAction)FACEBOOK_PR;
-(IBAction)showDeveloperInfo:(id)sender;

@end
