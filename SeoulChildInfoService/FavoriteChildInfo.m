//
//  FavoriteChildInfo.m
//  SeoulChildInfoService
//
//  Created by JUNG-BUM SEO on 12. 8. 19..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteChildInfo.h"
#import "SearchLocalChildInfoServiceContent.h"

@implementation FavoriteChildInfo
@synthesize navigationBar;
@synthesize editButton;

#pragma mark -
#pragma mark View lifecycle
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
	
	CGRect tableViewFrame=CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height-50);
	mainTableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];//UITableViewStylePlain UITableViewStyleGrouped
	mainTableView.autoresizingMask=(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
	mainTableView.delegate=self;
	mainTableView.dataSource=self;	
	//self.view=mainTableView;
	[self.view addSubview:mainTableView]; //뷰에 추가
	
	/*
	//툴바구성
	toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"편집" style:UIBarButtonItemStyleBordered target:self action:@selector(editTable)];
	UIBarButtonItem *splitItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	toolBar.items = [NSArray arrayWithObjects:backButton,splitItem,nil];
	[self.view addSubview:toolBar]; //뷰에 추가
	*/
	
}

/*==========================================================================================================================
 테이블 에디트 모드 진입
 ==========================================================================================================================*/
- (IBAction)editTable
{
	
	[mainTableView setEditing:!mainTableView.editing animated:YES];
	
	
	/*
	//툴바사용
	if(mainTableView.editing)
	{
		[[toolBar.items objectAtIndex:0] setTitle:@"완료"];
		[[toolBar.items objectAtIndex:0] setStyle:UIBarButtonItemStyleDone];
	}
	else
	{
		[[toolBar.items objectAtIndex:0] setTitle:@"편집"];
		[[toolBar.items objectAtIndex:0] setStyle:UIBarButtonItemStyleBordered];
	}
	 */
	
	
	//네비게이션버튼
	if(mainTableView.editing)
	{
		//[editButton setTitle:@"완료"];
		//[editButton setStyle:UIBarButtonItemStyleDone];
		[editButton setImage:[UIImage imageNamed:@"btn_finish.png"] forState:UIControlStateNormal];

	}
	else
	{
		//[editButton setTitle:@"편집"];
		//[editButton setStyle:UIBarButtonItemStyleBordered];
		[editButton setImage:[UIImage imageNamed:@"btn_edit.png"] forState:UIControlStateNormal];
	}
	
	
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
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"keyFavoriteKindergartenCount"];
}

/*==========================================================================================================================
 각 Row 별로  Edit 가능여부를 설정함.
 ==========================================================================================================================*/ 
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
{
	// Return NO if you do not want the specified item to be editable.
	return YES;
}


/*==========================================================================================================================
 순서이동 가능 여부를 설정함.
 ==========================================================================================================================*/ 
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
	/*
	 int row = indexPath.row;
	 int count = [[NSUserDefaults standardUserDefaults] integerForKey:@"keyFavoriteKindergartenCount"];
	 
	 if (row <count) 
	 {
	 return YES;
	 }
	 else
	 {
	 return NO;
	 }*/
	return NO;
}

/*==========================================================================================================================
 각 Row 별로  Edit 스타일을 정한다 (delete)
 ==========================================================================================================================*/

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
		   editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSUInteger row = [indexPath row];
	NSUInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"keyFavoriteKindergartenCount"];
	
	if (row <count) 
	{
		return UITableViewCellEditingStyleDelete;
	}
	else
	{
		return UITableViewCellEditingStyleNone;
	}
}


/*==========================================================================================================================
 테이블의 내용 뿌려주기
 ==========================================================================================================================*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    //셀모양구성
	//cell.textLabel.text=[[NSString stringWithFormat:@"%d ",indexPath.row] stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:[@"keyFavoriteKindergartenFacilityName" stringByAppendingFormat:@"%d",indexPath.row]]];
	cell.textLabel.text=[[NSUserDefaults standardUserDefaults] stringForKey:[@"keyFavoriteKindergartenFacilityName" stringByAppendingFormat:@"%d",indexPath.row]];
    return cell;
}

/*==========================================================================================================================
 테이블에서 한 Row 클릭할때
 ==========================================================================================================================*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	SearchLocalChildInfoServiceContent *searchLocalChildInfoServiceContent= [[SearchLocalChildInfoServiceContent alloc] init];
	[searchLocalChildInfoServiceContent passParaToXML:[[NSUserDefaults standardUserDefaults] stringForKey:[@"keyFavoriteKindergartenFacilityID" stringByAppendingFormat:@"%d",indexPath.row]]];
	 
	 CGRect newFrame = searchLocalChildInfoServiceContent.view.frame;
	 newFrame.size.height = newFrame.size.height -1;
	 searchLocalChildInfoServiceContent.view.frame = newFrame;
	 subview=searchLocalChildInfoServiceContent.view;	
	 [self.view addSubview:subview];
	 */
	
	SearchLocalChildInfoServiceContent *searchLocalChildInfoServiceContent =
				[[SearchLocalChildInfoServiceContent alloc] initWithNibName:@"SearchLocalChildInfoServiceContent" bundle:nil];
	[searchLocalChildInfoServiceContent passParaToXML:[[NSUserDefaults standardUserDefaults] stringForKey:[@"keyFavoriteKindergartenFacilityID" stringByAppendingFormat:@"%d",indexPath.row]]];
	[self.navigationController  pushViewController:searchLocalChildInfoServiceContent animated:YES];
	[searchLocalChildInfoServiceContent release];
	
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
	if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
		// Delete the row from the data source.
		//[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
		//현재 favorite 갯수
		int favoriteKindergartenCount;
		favoriteKindergartenCount=[[NSUserDefaults standardUserDefaults] integerForKey:@"keyFavoriteKindergartenCount"];		
		
		//현재것을지우고
		[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[@"keyFavoriteKindergartenFacilityID" stringByAppendingFormat:@"%d",indexPath.row]];
		[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:[@"keyFavoriteKindergartenFacilityName" stringByAppendingFormat:@"%d",indexPath.row]];
		
		NSLog(@"%d",indexPath.row);
		for(int i=indexPath.row;i<favoriteKindergartenCount;i++)
		{
			[[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] stringForKey:[@"keyFavoriteKindergartenFacilityID" stringByAppendingFormat:@"%d",i+1]] forKey:[@"keyFavoriteKindergartenFacilityID" stringByAppendingFormat:@"%d",i]];
			[[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] stringForKey:[@"keyFavoriteKindergartenFacilityName" stringByAppendingFormat:@"%d",i+1]] forKey:[@"keyFavoriteKindergartenFacilityName" stringByAppendingFormat:@"%d",i]];
			
		}
		
		//favorite 카운트 감소
		favoriteKindergartenCount--;
		[[NSUserDefaults standardUserDefaults] setInteger:favoriteKindergartenCount  forKey:@"keyFavoriteKindergartenCount"];	
		
		//테이블 Reload 후 메세지
		[mainTableView reloadData];
		[self ShowMessageBox:@"삭제완료"];
	}   
	else if (editingStyle == UITableViewCellEditingStyleInsert) 
	{
		//
	}		
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



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    //[toolBar release];
}


- (void)dealloc {
    [super dealloc];
}


@end

