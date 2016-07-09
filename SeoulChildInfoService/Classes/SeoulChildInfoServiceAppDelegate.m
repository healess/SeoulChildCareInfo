//
//  SeoulChildInfoServiceAppDelegate.m
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//
/*
  현제 딜리게이트 사용은 없고 개별 클래스에 구현된 상태이나 즐겨찾기및 기타 기능시 사용 예정
 */
#import "SeoulChildInfoServiceAppDelegate.h"


@implementation SeoulChildInfoServiceAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize tab1NavigationController;
@synthesize tab2NavigationController;
@synthesize tab3NavigationController;
@synthesize tab4NavigationController;
@synthesize tab5NavigationController;
@synthesize mainMenuViewController;
@synthesize searchLocalChildInfoService;
@synthesize searchChildInfoFindOutdoor;
@synthesize calculateChildcareChaService;
@synthesize favoriteChildInfo;

#pragma mark -
#pragma mark Application lifecycle

//============================================================================================================
// 기본값 설정 및 기억준비 (initialize 는 NSObject 의 클래스 매소드로서 오브젝트 사용전 호출되는 메소드임)
//============================================================================================================
+(void) initialize
{
	if([self class]==[SeoulChildInfoServiceAppDelegate class])
	{			
		//옵션의 키와 값들을 담는 NSDictionary를 생성
		
		NSDictionary *dicOptionDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
										   
										   @"",@"keyFavoriteKindergartenFacilityID0",//FacilityID0~9..10은 삭제용 공백
										   @"",@"keyFavoriteKindergartenFacilityID1",
										   @"",@"keyFavoriteKindergartenFacilityID2",
										   @"",@"keyFavoriteKindergartenFacilityID3",
										   @"",@"keyFavoriteKindergartenFacilityID4",
										   @"",@"keyFavoriteKindergartenFacilityID5",
										   @"",@"keyFavoriteKindergartenFacilityID6",
										   @"",@"keyFavoriteKindergartenFacilityID7",
										   @"",@"keyFavoriteKindergartenFacilityID8",
										   @"",@"keyFavoriteKindergartenFacilityID9",
										   @"",@"keyFavoriteKindergartenFacilityID10",
										   
										   
										   @"",@"keyFavoriteKindergartenFacilityName0",//FacilityName0~9...10은 삭제용 공백
										   @"",@"keyFavoriteKindergartenFacilityName1",
										   @"",@"keyFavoriteKindergartenFacilityName2",
										   @"",@"keyFavoriteKindergartenFacilityName3",
										   @"",@"keyFavoriteKindergartenFacilityName4",
										   @"",@"keyFavoriteKindergartenFacilityName5",
										   @"",@"keyFavoriteKindergartenFacilityName6",
										   @"",@"keyFavoriteKindergartenFacilityName7",
										   @"",@"keyFavoriteKindergartenFacilityName8",
										   @"",@"keyFavoriteKindergartenFacilityName9",	
										   @"",@"keyFavoriteKindergartenFacilityName10",	
										   
										   0,@"keyFavoriteKindergartenCount",			//현재 Favorite갯수
										   nil];
		
		
		//사용자가 앱을 설치하고 처음 실행항 때 적용하는 옵션값 등록 (dictionary 정보 이용)
		[[NSUserDefaults standardUserDefaults] registerDefaults:dicOptionDefaults];
	}
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	//초기화면 딜레이(3초)
	[NSThread sleepForTimeInterval:0.1];
    
	
	
	//네비게이션컨트롤
	tab1NavigationController=[[UINavigationController alloc] init];
	tab2NavigationController=[[UINavigationController alloc] init];
	tab3NavigationController=[[UINavigationController alloc] init];
	tab4NavigationController=[[UINavigationController alloc] init];
	tab5NavigationController=[[UINavigationController alloc] init];
	
	tab1NavigationController.navigationBarHidden=YES;
	tab2NavigationController.navigationBarHidden=YES;
	tab3NavigationController.navigationBarHidden=YES;
	tab4NavigationController.navigationBarHidden=YES;
	tab5NavigationController.navigationBarHidden=YES;
	
	//탭바에 네비게이션을 연결
	tabBarController.viewControllers=[NSArray arrayWithObjects:tab1NavigationController,tab2NavigationController,tab3NavigationController,tab4NavigationController,tab5NavigationController,nil];
	
	
	
	//첫번째 탭 View 지정및 아이콘 지정
	mainMenuViewController=[[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
	[tab1NavigationController initWithRootViewController:mainMenuViewController];
	//[tab1NavigationController pushViewController:mainMenuViewController animated:NO];
	[mainMenuViewController release];
	UITabBarItem *item1=[[UITabBarItem alloc] initWithTitle:@"메인" image:[UIImage imageNamed:@"home.png"] tag:0];
	mainMenuViewController.tabBarItem=item1;
	[item1 release];
	
		
	
	//두번째 탭 View 지정및 아이콘 지정
	searchLocalChildInfoService=[[SearchLocalChildInfoService alloc] initWithNibName:@"SearchLocalChildInfoService" bundle:nil];
	[tab2NavigationController pushViewController:searchLocalChildInfoService animated:NO];
	[searchLocalChildInfoService release];
	UITabBarItem *item2=[[UITabBarItem alloc] initWithTitle:@"검색" image:[UIImage imageNamed:@"search.png"] tag:1];
	searchLocalChildInfoService.tabBarItem=item2;
	[item2 release];
	
	
	//세번째 탭 View 지정및 아이콘 지정
	searchChildInfoFindOutdoor=[[SearchChildInfoFindOutdoor alloc] initWithNibName:@"SearchChildInfoFindOutdoor" bundle:nil];
	[tab3NavigationController pushViewController:searchChildInfoFindOutdoor animated:NO];
	[searchChildInfoFindOutdoor release];
	UITabBarItem *item3=[[UITabBarItem alloc] initWithTitle:@"나들이" image:[UIImage imageNamed:@"sunny.png"] tag:2];
	searchChildInfoFindOutdoor.tabBarItem=item3;
	[item3 release];
	
	
	//네번째 탭 View 지정및 아이콘 지정
	calculateChildcareChaService=[[CalculateChildcareChaService alloc] initWithNibName:@"CalculateChildcareChaService" bundle:nil];
	[tab4NavigationController pushViewController:calculateChildcareChaService animated:NO];
	[calculateChildcareChaService release];
	UITabBarItem *item4=[[UITabBarItem alloc] initWithTitle:@"계산" image:[UIImage imageNamed:@"cal1.png"] tag:3];
	calculateChildcareChaService.tabBarItem=item4;
	[item4 release];
	
	
	//다섯번째 탭 View 지정및 아이콘 지정
	favoriteChildInfo=[[FavoriteChildInfo alloc] initWithNibName:@"FavoriteChildInfo" bundle:nil];
	[tab5NavigationController pushViewController:favoriteChildInfo animated:NO];
	[favoriteChildInfo release];
	UITabBarItem *item5=[[UITabBarItem alloc] initWithTitle:@"즐겨찾기" image:[UIImage imageNamed:@"favorite.png"] tag:4];
	favoriteChildInfo.tabBarItem=item5;
	[item5 release];	
	
	
	
	//탭바컨트롤을 윈도우에 추가
	[self.window addSubview:tabBarController.view];
	//[self.window addSubview:viewController.view];

    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc 
{
    [mainMenuViewController release];
	[searchLocalChildInfoService release];
	[searchChildInfoFindOutdoor release];
	[calculateChildcareChaService release];
	[favoriteChildInfo release];
	
	
	[tab1NavigationController release];
    [tab2NavigationController release];
    [tab3NavigationController release];
    [tab4NavigationController release];
    [tab5NavigationController release];

	
	[tabBarController release];
    [window release];
    [super dealloc];
}

@end

