//
//  MainMenuViewController.m
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//
/*
 최초 로딩시 실행되는 메인 메뉴 해당 화면에서 각 화면 으로 분기
 */
#import "MainMenuViewController.h"
#import "SearchLocalChildInfoService.h"
#import "SearchLocalChildInfoServiceByName.h"
#import "SearchAroundChildInfoService.h"
#import "SearchChildInfoNewsService.h"
#import "SearchChildInfoServiceSite.h"
#import "SearchChildInfoHealthService.h"
#import "SearchChildInfoBookService.h"
#import "SearchCounselPhoneInfo.h"
#import "SearchChildInfoFindOutdoor.h"
#import "FacebookPR.h"
#import "ShowDeveloperInfo.h"



@implementation MainMenuViewController
//@synthesize navigationController;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//navigationController=[[UINavigationController alloc] init];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

//종합검색
-(IBAction)searchChildInfoService:(id)sender
{
	
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	
	SearchLocalChildInfoService *searchLocalChildInfoService= [[SearchLocalChildInfoService alloc] init];
	//	[searchLocalChildInfoServiceResult passParaToXML:inputDistrict.text FacilityName:@"대치"];
	
	
	CGRect newFrame = searchLocalChildInfoService.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchLocalChildInfoService.view.frame = newFrame;
	subview=searchLocalChildInfoService.view;	
	[self.view addSubview:subview];
	 */
	
	SearchLocalChildInfoService *searchLocalChildInfoService =
	[[SearchLocalChildInfoService alloc] initWithNibName:@"SearchLocalChildInfoService" bundle:nil];
	[self.navigationController  pushViewController:searchLocalChildInfoService animated:YES];
	[searchLocalChildInfoService release];
	 

}

//명칭검색
-(IBAction)searchChildInfoServiceByName:(id)sender
{
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	
	SearchLocalChildInfoServiceByName *searchLocalChildInfoServiceByName= [[SearchLocalChildInfoServiceByName alloc] init];
	//	[searchLocalChildInfoServiceResult passParaToXML:inputDistrict.text FacilityName:@"대치"];
	
	
	CGRect newFrame = searchLocalChildInfoServiceByName.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchLocalChildInfoServiceByName.view.frame = newFrame;
	subview=searchLocalChildInfoServiceByName.view;	
	[self.view addSubview:subview];
	 */
	SearchLocalChildInfoServiceByName *searchLocalChildInfoServiceByName =
	[[SearchLocalChildInfoServiceByName alloc] initWithNibName:@"SearchLocalChildInfoServiceByName" bundle:nil];
	[self.navigationController  pushViewController:searchLocalChildInfoServiceByName animated:YES];
	[searchLocalChildInfoServiceByName release];
	
	
	
}
//주변검색
-(IBAction)searchAroundChildInfoService:(id)sender
{
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	
	SearchAroundChildInfoService *searchAroundChildInfoService= [[SearchAroundChildInfoService alloc] init];
//	[searchLocalChildInfoServiceResult passParaToXML:inputDistrict.text FacilityName:@"대치"];
	
	
	CGRect newFrame = searchAroundChildInfoService.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchAroundChildInfoService.view.frame = newFrame;
	subview=searchAroundChildInfoService.view;	
	[self.view addSubview:subview];
	*/
	
	SearchAroundChildInfoService *searchAroundChildInfoService =
	[[SearchAroundChildInfoService alloc] initWithNibName:@"SearchAroundChildInfoService" bundle:nil];
	[self.navigationController  pushViewController:searchAroundChildInfoService animated:YES];
	[searchAroundChildInfoService release];
	
	
	
}
//보육관련뉴스정보
-(IBAction)searchChildInfoNewsService:(id)sender
{
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoNewsService *searchChildInfoNewsService= [[SearchChildInfoNewsService alloc] init];
	[searchChildInfoNewsService passParaToXML:1];
	
	CGRect newFrame = searchChildInfoNewsService.view.frame;
	searchChildInfoNewsService.view.frame = newFrame;
	subview=searchChildInfoNewsService.view;	
	[self.view addSubview:subview];	
	*/
	
	SearchChildInfoNewsService *searchChildInfoNewsService =
	[[SearchChildInfoNewsService alloc] initWithNibName:@"SearchChildInfoNewsService" bundle:nil];
	[searchChildInfoNewsService passParaToXML:1];
	[self.navigationController  pushViewController:searchChildInfoNewsService animated:YES];
	[searchChildInfoNewsService release];
	
	
}

//보육관련건강정보
-(IBAction)searchChildInfoHealthService:(id)sender
{
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoHealthService *searchChildInfoHealthService= [[SearchChildInfoHealthService alloc] init];
	[searchChildInfoHealthService passParaToXML:1];
	
	CGRect newFrame = searchChildInfoHealthService.view.frame;
	searchChildInfoHealthService.view.frame = newFrame;
	subview=searchChildInfoHealthService.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoHealthService *searchChildInfoHealthService =
	[[SearchChildInfoHealthService alloc] initWithNibName:@"SearchChildInfoHealthService" bundle:nil];
	[searchChildInfoHealthService passParaToXML:1];
	[self.navigationController  pushViewController:searchChildInfoHealthService animated:YES];
	[searchChildInfoHealthService release];
}
//보육관련도서정보
-(IBAction)searchChildInfoBookService:(id)sender
{
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoBookService *searchChildInfoBookService= [[SearchChildInfoBookService alloc] init];
	[searchChildInfoBookService passParaToXML:1];
	
	CGRect newFrame = searchChildInfoBookService.view.frame;
	searchChildInfoBookService.view.frame = newFrame;
	subview=searchChildInfoBookService.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoBookService *searchChildInfoBookService =
	[[SearchChildInfoBookService alloc] initWithNibName:@"SearchChildInfoBookService" bundle:nil];
	[searchChildInfoBookService passParaToXML:1];
	[self.navigationController  pushViewController:searchChildInfoBookService animated:YES];
	[searchChildInfoBookService release];
}
//보육관련사이트
-(IBAction)searchChildInfoServiceSite:(id)sender
{
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	
	SearchChildInfoServiceSite *searchChildInfoServiceSite= [[SearchChildInfoServiceSite alloc] init];
	//	[searchLocalChildInfoServiceResult passParaToXML:inputDistrict.text FacilityName:@"대치"];
	
	
	CGRect newFrame = searchChildInfoServiceSite.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchChildInfoServiceSite.view.frame = newFrame;
	subview=searchChildInfoServiceSite.view;	
	[self.view addSubview:subview];
	 */
	SearchChildInfoServiceSite *searchChildInfoServiceSite =
	[[SearchChildInfoServiceSite alloc] initWithNibName:@"SearchChildInfoServiceSite" bundle:nil];
	[self.navigationController  pushViewController:searchChildInfoServiceSite animated:YES];
	[searchChildInfoServiceSite release];
	
	
	
}
//페이스북
-(IBAction) FACEBOOK_PR
{
	FacebookPR *facebookPR =
	[[FacebookPR alloc] initWithNibName:@"FacebookPR" bundle:nil];
	[self.navigationController  pushViewController:facebookPR animated:YES];
	[facebookPR release];
	
}
//상담안내
-(IBAction)searchCounselPhoneInfo:(id)sender
{
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	
	SearchCounselPhoneInfo *searchCounselPhoneInfo= [[SearchCounselPhoneInfo alloc] init];
	//	[searchLocalChildInfoServiceResult passParaToXML:inputDistrict.text FacilityName:@"대치"];
	
	
	CGRect newFrame = searchCounselPhoneInfo.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchCounselPhoneInfo.view.frame = newFrame;
	subview=searchCounselPhoneInfo.view;	
	[self.view addSubview:subview];
	 */
	SearchCounselPhoneInfo *searchCounselPhoneInfo =
	[[SearchCounselPhoneInfo alloc] initWithNibName:@"SearchCounselPhoneInfo" bundle:nil];
	[self.navigationController  pushViewController:searchCounselPhoneInfo animated:YES];
	[searchCounselPhoneInfo release];
	
	
}

//개발자정보보기
-(IBAction)showDeveloperInfo:(id)sender
{
	ShowDeveloperInfo *showDeveloperInfo =
	[[ShowDeveloperInfo alloc] initWithNibName:@"ShowDeveloperInfo" bundle:nil];
	[self.navigationController  pushViewController:showDeveloperInfo animated:YES];
	[showDeveloperInfo release];
	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];

}


@end
