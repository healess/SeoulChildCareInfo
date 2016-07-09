//
//  SearchLocalChildInfoServiceByName.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchLocalChildInfoServiceByName : UIViewController {
	IBOutlet UIButton *inputRegion;
	IBOutlet UITextField *inputDistrict;
	IBOutlet UITextField *inputFacilityName;
	UIView *subview;
	
	//피커뷰 추가 
	NSArray *regionValues;//성별 입력 피커 내 배열값
	UIPickerView *regionValuePicker; //나이 년도 입력 피커
	NSString * inputRegionCode;
	//툴바사용
	UIToolbar                       *toolbar;

}
@property (nonatomic,retain) IBOutlet UIButton *inputRegion;

-(IBAction)buttonClick: (id) sender;
//피커뷰 추가 
-(IBAction) showRegionValuePicker;
-(IBAction)GO_BACK;
@property (nonatomic, retain) UIToolbar   *toolbar;


@end
