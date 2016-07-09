//
//  SeoulChildInfoServiceAppDelegate.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchLocalChildInfoService.h"
#import "MainMenuViewController.h"
#import "SearchLocalChildInfoService.h"
#import "SearchChildInfoFindOutdoor.h"
#import "CalculateChildcareChaService.h"
#import "FavoriteChildInfo.h"

@interface SeoulChildInfoServiceAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
    UIWindow *window;
    UITabBarController *tabBarController;
	
	//탭바에 할당된 네비게이션 컨트롤들
	UINavigationController *tab1NavigationController;
	UINavigationController *tab2NavigationController;
	UINavigationController *tab3NavigationController;
	UINavigationController *tab4NavigationController;
	UINavigationController *tab5NavigationController;
	
	//초기화면의 ViewController
	MainMenuViewController *mainMenuViewController;
	SearchLocalChildInfoService *searchLocalChildInfoService;
	SearchChildInfoFindOutdoor *searchChildInfoFindOutdoor;
	CalculateChildcareChaService *calculateChildcareChaService;
	FavoriteChildInfo *favoriteChildInfo;

//	IBOutlet SearchLocalChildInfoService *viewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) UINavigationController *tab1NavigationController;
@property (nonatomic, retain) UINavigationController *tab2NavigationController;
@property (nonatomic, retain) UINavigationController *tab3NavigationController;
@property (nonatomic, retain) UINavigationController *tab4NavigationController;
@property (nonatomic, retain) UINavigationController *tab5NavigationController;

@property (nonatomic, retain) MainMenuViewController *mainMenuViewController;				//메인 ViewController
@property (nonatomic, retain) SearchLocalChildInfoService *searchLocalChildInfoService;		//검색 ViewController
@property (nonatomic, retain) SearchChildInfoFindOutdoor *searchChildInfoFindOutdoor;		//나들이 ViewController
@property (nonatomic, retain) CalculateChildcareChaService *calculateChildcareChaService;	//계산 ViewController
@property (nonatomic, retain) FavoriteChildInfo *favoriteChildInfo;							//즐겨찾기 ViewController



//@property (nonatomic, retain) SearchLocalChildInfoService *viewController;

@end
