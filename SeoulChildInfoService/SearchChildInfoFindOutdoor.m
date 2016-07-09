//
//  SearchChildInfoFindOutdoor.m
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 15..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchChildInfoFindOutdoor.h"
#import "SearchChildInfoFindOutdoorResult.h"


@implementation SearchChildInfoFindOutdoor
@synthesize segRegion;

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
	regionValue=@"서울";
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

//============================================================================================================
// 서울,경기 인천 segmented control 선택시..
//============================================================================================================
-(IBAction) segRegionSelected
{
	if([segRegion selectedSegmentIndex]==0)
	{		
		regionValue=@"서울";
	}
	else if([segRegion selectedSegmentIndex]==1)
	{
		regionValue=@"경기";
	}
	else if([segRegion selectedSegmentIndex]==2)
	{
		regionValue=@"인천";
	}	
	NSLog(regionValue); 
}

//박물관
-(IBAction)searchMuseum:(id)sender
{
	
	/*
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult= [[SearchChildInfoFindOutdoorResult alloc] init];
	//[searchChildInfoNewsService passParaToXML];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"01"];
	
	CGRect newFrame = searchChildInfoFindOutdoorResult.view.frame;
	//		newFrame.origin.y=40;
	//	newFrame.size.height =130;// newFrame.size.height -1;
	//	newFrame.size.height = newFrame.size.height -40;
	
	searchChildInfoFindOutdoorResult.view.frame = newFrame;
	subview=searchChildInfoFindOutdoorResult.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult =
	[[SearchChildInfoFindOutdoorResult alloc] initWithNibName:@"SearchChildInfoFindOutdoorResult" bundle:nil];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"01"];
	[self.navigationController  pushViewController:searchChildInfoFindOutdoorResult animated:YES];
	[searchChildInfoFindOutdoorResult release];
}
//고궁
-(IBAction)searchPalace:(id)sender
{
	/*
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult= [[SearchChildInfoFindOutdoorResult alloc] init];
	//[searchChildInfoNewsService passParaToXML];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"02"];
	
	CGRect newFrame = searchChildInfoFindOutdoorResult.view.frame;
	//		newFrame.origin.y=40;
	//	newFrame.size.height =130;// newFrame.size.height -1;
	//	newFrame.size.height = newFrame.size.height -40;
	
	searchChildInfoFindOutdoorResult.view.frame = newFrame;
	subview=searchChildInfoFindOutdoorResult.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult =
	[[SearchChildInfoFindOutdoorResult alloc] initWithNibName:@"SearchChildInfoFindOutdoorResult" bundle:nil];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"02"];
	[self.navigationController  pushViewController:searchChildInfoFindOutdoorResult animated:YES];
	[searchChildInfoFindOutdoorResult release];
	
}
//유원지
-(IBAction)searchGarden:(id)sender
{
	/*
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult= [[SearchChildInfoFindOutdoorResult alloc] init];
	//[searchChildInfoNewsService passParaToXML];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"03"];
	
	CGRect newFrame = searchChildInfoFindOutdoorResult.view.frame;
	//		newFrame.origin.y=40;
	//	newFrame.size.height =130;// newFrame.size.height -1;
	//	newFrame.size.height = newFrame.size.height -40;
	
	searchChildInfoFindOutdoorResult.view.frame = newFrame;
	subview=searchChildInfoFindOutdoorResult.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult =
	[[SearchChildInfoFindOutdoorResult alloc] initWithNibName:@"SearchChildInfoFindOutdoorResult" bundle:nil];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"03"];
	[self.navigationController  pushViewController:searchChildInfoFindOutdoorResult animated:YES];
	[searchChildInfoFindOutdoorResult release];
	
}
//테마파크
-(IBAction)searchTema:(id)sender
{
	/*
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult= [[SearchChildInfoFindOutdoorResult alloc] init];
	//[searchChildInfoNewsService passParaToXML];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"04"];
	
	CGRect newFrame = searchChildInfoFindOutdoorResult.view.frame;
	//		newFrame.origin.y=40;
	//	newFrame.size.height =130;// newFrame.size.height -1;
	//	newFrame.size.height = newFrame.size.height -40;
	
	searchChildInfoFindOutdoorResult.view.frame = newFrame;
	subview=searchChildInfoFindOutdoorResult.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult =
	[[SearchChildInfoFindOutdoorResult alloc] initWithNibName:@"SearchChildInfoFindOutdoorResult" bundle:nil];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"04"];
	[self.navigationController  pushViewController:searchChildInfoFindOutdoorResult animated:YES];
	[searchChildInfoFindOutdoorResult release];
	
}
//공원
-(IBAction)searchPark:(id)sender
{
	/*
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult= [[SearchChildInfoFindOutdoorResult alloc] init];
	//[searchChildInfoNewsService passParaToXML];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"05"];
	
	CGRect newFrame = searchChildInfoFindOutdoorResult.view.frame;
	//		newFrame.origin.y=40;
	//	newFrame.size.height =130;// newFrame.size.height -1;
	//	newFrame.size.height = newFrame.size.height -40;
	
	searchChildInfoFindOutdoorResult.view.frame = newFrame;
	subview=searchChildInfoFindOutdoorResult.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult =
	[[SearchChildInfoFindOutdoorResult alloc] initWithNibName:@"SearchChildInfoFindOutdoorResult" bundle:nil];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"05"];
	[self.navigationController  pushViewController:searchChildInfoFindOutdoorResult animated:YES];
	[searchChildInfoFindOutdoorResult release];
	
}
//공연장
-(IBAction)searchPerform:(id)sender
{
	/*
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult= [[SearchChildInfoFindOutdoorResult alloc] init];
	//[searchChildInfoNewsService passParaToXML];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"06"];
	
	CGRect newFrame = searchChildInfoFindOutdoorResult.view.frame;
	//		newFrame.origin.y=40;
	//	newFrame.size.height =130;// newFrame.size.height -1;
	//	newFrame.size.height = newFrame.size.height -40;
	
	searchChildInfoFindOutdoorResult.view.frame = newFrame;
	subview=searchChildInfoFindOutdoorResult.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult =
	[[SearchChildInfoFindOutdoorResult alloc] initWithNibName:@"SearchChildInfoFindOutdoorResult" bundle:nil];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"06"];
	[self.navigationController  pushViewController:searchChildInfoFindOutdoorResult animated:YES];
	[searchChildInfoFindOutdoorResult release];
	
}
//체험관
-(IBAction)searchExp:(id)sender
{
	/*
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult= [[SearchChildInfoFindOutdoorResult alloc] init];
	//[searchChildInfoNewsService passParaToXML];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"07"];
	
	CGRect newFrame = searchChildInfoFindOutdoorResult.view.frame;
	//		newFrame.origin.y=40;
	//	newFrame.size.height =130;// newFrame.size.height -1;
	//	newFrame.size.height = newFrame.size.height -40;
	
	searchChildInfoFindOutdoorResult.view.frame = newFrame;
	subview=searchChildInfoFindOutdoorResult.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult =
	[[SearchChildInfoFindOutdoorResult alloc] initWithNibName:@"SearchChildInfoFindOutdoorResult" bundle:nil];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"07"];
	[self.navigationController  pushViewController:searchChildInfoFindOutdoorResult animated:YES];
	[searchChildInfoFindOutdoorResult release];
	
}
//기타
-(IBAction)searchEtc:(id)sender
{
	/*
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];	
	subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];
	
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult= [[SearchChildInfoFindOutdoorResult alloc] init];
	//[searchChildInfoNewsService passParaToXML];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"08"];
	
	CGRect newFrame = searchChildInfoFindOutdoorResult.view.frame;
	//		newFrame.origin.y=40;
	//	newFrame.size.height =130;// newFrame.size.height -1;
	//	newFrame.size.height = newFrame.size.height -40;
	
	searchChildInfoFindOutdoorResult.view.frame = newFrame;
	subview=searchChildInfoFindOutdoorResult.view;	
	[self.view addSubview:subview];	
	 */
	SearchChildInfoFindOutdoorResult *searchChildInfoFindOutdoorResult =
	[[SearchChildInfoFindOutdoorResult alloc] initWithNibName:@"SearchChildInfoFindOutdoorResult" bundle:nil];
	[searchChildInfoFindOutdoorResult passParaToXML:1 sido:regionValue outdoorType:@"08"];
	[self.navigationController  pushViewController:searchChildInfoFindOutdoorResult animated:YES];
	[searchChildInfoFindOutdoorResult release];
	
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
