//
//  SearchCounselPhoneInfo.m
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 23..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchCounselPhoneInfo.h"


@implementation SearchCounselPhoneInfo
@synthesize mainTableView;
@synthesize tableViewCell;
/*==========================================================================================================================
 네비게이션바 뒤로가기
 ==========================================================================================================================*/
-(IBAction)GO_BACK
{
	[self.navigationController popViewControllerAnimated:YES];
}

/*==========================================================================================================================
 메세지 박스 띄우기.
 ==========================================================================================================================*/
-(void) ShowMessageBox:(NSString*)message
{
	UIAlertView *warn;
	warn= [[UIAlertView alloc]	initWithTitle:nil
									 message:message
									delegate:nil
						   cancelButtonTitle:@"확인"
						   otherButtonTitles:nil];
	
	[warn show];		
	[warn release];
	
}

/*==========================================================================================================================
 View 로드시 초기화
 ==========================================================================================================================*/
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	//SubView로 Table 추가
	
	//CGRect tableViewFrame=CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height-50);
	//mainTableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];//UITableViewStylePlain UITableViewStyleGrouped
	mainTableView.autoresizingMask=(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
	mainTableView.delegate=self;
	mainTableView.dataSource=self;	
	//self.view=mainTableView;
	[self.view addSubview:mainTableView]; //뷰에 추가
	
	
	//자치구
	staff_dist=[[NSArray alloc] initWithObjects:@"강남",@"강동",@"강서",@"강북",@"관악",@"광진",@"구로",@"금천",@"노원",@"도봉",@"동대문",@"동작",
				@"마포",@"서초",@"성동",@"성북",@"송파",@"서대문",@"양천",@"영등포",@"용산",@"은평",@"종로",@"중구",@"중랑",nil];
	
	//담당업무
	staff_respon=[[NSArray alloc] initWithObjects:@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",
				  @"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",@"총괄담당",nil];	
	
	//부서
	staff_depart=[[NSArray alloc] initWithObjects:@"가정복지과",@"가정복지과",@"가정복지과",@"여성가족과",@"가정복지과",@"가정복지과",@"가정복지과",@"가정복지과",@"여성가족과",@"가정복지과",
				  @"가정복지과",@"가정복지과",@"가정복지과",@"여성복지과",@"가정복지과",@"가정복지과",@"여성복지과",@"가정복지과",@"여성복지과",@"가정복지과",@"가정복지과",@"가정복지과",@"가정복지과",@"가정복지과",@"가정복지과",nil];
	
	
	//성명
	staff_names=[[NSArray alloc] initWithObjects:@"유선미",@"박은미",@"김수경",@"이중원",@"이한우",@"안경숙",@"김윤재",@"김귀영",@"강하순",@"박종호",@"진수미",
				 @"김은진",@"김은숙",@"이제근",@"함정은",@"이민이",@"차성자",@"조경아",@"박은경",@"이준재",@"전상철",@"김병환",@"종충영",@"김수정",@"이경희",nil];
				 
	//전화번호
	staff_tel=[[NSArray alloc] initWithObjects:@"2104-1644",@"480-1783",@"2600-6755",@"901-6687",@"880-3469",
			   @"450-7543",@"860-3020",@"2627-1414",@"2116-3727",@"2289-1491",@"2127-4622",@"820-9720",@"3153-8903",
			   @"2155-6700",@"2286-5439",@"920-3277",@"2147-2775",@"330-1359",@"2620-3390",@"2670-3358",@"2199-7140",@"351-7103",@"731-1333",
			   @"3396-5412",@"2094-1776",nil];	
	
}


/*==========================================================================================================================
 테이블 섹션 갯수
 ==========================================================================================================================*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

/*==========================================================================================================================
 섹션내 Row 갯수(즐겨찾기수 만큼)
 ==========================================================================================================================*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 25;
}



/*==========================================================================================================================
 테이블의 내용 뿌려주기
 ==========================================================================================================================*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[[NSBundle mainBundle] loadNibNamed:@"SearchCounselPhoneInfoCell" owner:self options:nil];
		cell=tableViewCell;
    }
	
	//[cell.backgroundView setBackgroundColor:[UIColor blueColor]];
	 
	
	
	UILabel *lblDist;
	lblDist=(UILabel*)[cell viewWithTag:1];
	lblDist.text=[staff_dist objectAtIndex:indexPath.row];
	
	
	UILabel *lblRole;
	lblRole=(UILabel*)[cell viewWithTag:2];
	lblRole.text=[staff_respon objectAtIndex:indexPath.row];
	
	
	UILabel *lblDept;
	lblDept=(UILabel*)[cell viewWithTag:3];
	lblDept.text=[staff_depart objectAtIndex:indexPath.row];
	
	
	UILabel *lblName;
	lblName=(UILabel*)[cell viewWithTag:4];
	lblName.text=[staff_names objectAtIndex:indexPath.row];
	
	
	UILabel *lblTel;
	lblTel=(UILabel*)[cell viewWithTag:5];
	lblTel.text=[staff_tel objectAtIndex:indexPath.row];
	//[btnTel		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	
	
	UIButton *btnCall;
    btnCall=(UIButton*)[cell viewWithTag:6];
	[btnCall setTitle:[staff_tel objectAtIndex:indexPath.row] forState:UIControlStateNormal];
	[btnCall		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
    
	return cell;
}

/*==========================================================================================================================
 전화번호 항목을 눌렀을때 전화를 건다
 ==========================================================================================================================*/

-(void) check_button_Touched:(UIButton*)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"telprompt:02-" stringByAppendingString:sender.titleLabel.text]]];
	NSLog(@"%@",sender.titleLabel.text);
}

/*==========================================================================================================================
 테이블에서 한 Row 클릭할때
 ==========================================================================================================================*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
}
/*==========================================================================================================================
 즐겨찾기를 다시 보여줄때 자동 refresh
 ==========================================================================================================================*/
- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];
	[mainTableView reloadData];
}

/*==========================================================================================================================
 삭제하기
 ==========================================================================================================================*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
}


- (void)willTransitionToState:(UITableViewCellStateMask)state
{
	[self ShowMessageBox:@"willTransitionToState"];
}


- (void)didTransitionToState:(UITableViewCellStateMask)state
{
	[self ShowMessageBox:@"didTransitionToState"];
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
{
}


/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    //[toolBar release];
}

- (void)dealloc 
{
    [super dealloc];
}


@end
