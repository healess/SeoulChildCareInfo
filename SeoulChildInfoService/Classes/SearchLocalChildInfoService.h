//
//  SearchLocalChildInfoService.h
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchLocalChildInfoServiceDelegate;


@interface SearchLocalChildInfoService : UIViewController
{
	IBOutlet UIButton *inputRegion;
	IBOutlet UITextField *inputDistrictName;
	IBOutlet UITextField *inputFacilityName;

	id<SearchLocalChildInfoServiceDelegate> delegate;//값 전달 딜리게이트
    UIView *subview;
		
	IBOutlet UIButton *kukgong;		//국공립
	IBOutlet UIButton *bupin;		//법인
	IBOutlet UIButton *mingan;		//민간
	IBOutlet UIButton *gajung;		//가정
	IBOutlet UIButton *bumohyup;	//부모협동
	IBOutlet UIButton *jikjnag;		//직장
	IBOutlet UIButton *seoulhyung;	//서울형어린이집
	IBOutlet UIButton *jangtong;	//장애아통합
	IBOutlet UIButton *jangjun;		//장애아전담
	IBOutlet UIButton *damunhwa;	//다문화시설
	IBOutlet UIButton *chaunhang;	//차량운행
	IBOutlet UIButton *youngjun;	//영아전담시설
	IBOutlet UIButton *timeyunjang;	//시간연장
	IBOutlet UIButton *banggwajun;	//방과후전담
	IBOutlet UIButton *pyungin;		//평가인증여부
	IBOutlet UIButton *prevButton; //이전버튼
	
	//피커뷰 추가 
	NSArray *regionValues;//성별 입력 피커 내 배열값
	UIPickerView *regionValuePicker; //나이 년도 입력 피커
	NSString * inputRegionCode;
	//툴바사용
	UIToolbar                       *toolbar;
	
}
@property (nonatomic,retain) IBOutlet UIButton *inputRegion;   //구검색
@property(nonatomic, retain) IBOutlet UITextField *inputFacilityName;
@property(nonatomic, retain) IBOutlet UITextField *inputDistrictName;
@property (retain,nonatomic) UITableView *mainTableView;

@property (nonatomic,assign) id<SearchLocalChildInfoServiceDelegate> delegate;

@property(nonatomic, retain) IBOutlet UIButton *kukgong;	//국공립
@property(nonatomic, retain) IBOutlet UIButton *bupin;		//법인
@property(nonatomic, retain) IBOutlet UIButton *mingan;		//민간
@property(nonatomic, retain) IBOutlet UIButton *gajung;		//가정
@property(nonatomic, retain) IBOutlet UIButton *bumohyup;	//부모협동
@property(nonatomic, retain) IBOutlet UIButton *jikjnag;	//직장
@property(nonatomic, retain) IBOutlet UIButton *damunhwa;	//다문화시설
@property(nonatomic, retain) IBOutlet UIButton *chaunhang;	//차량운행
@property(nonatomic, retain) IBOutlet UIButton *seoulhyung;	//서울형어린이집
@property(nonatomic, retain) IBOutlet UIButton *jangtong;	//장애아통합
@property(nonatomic, retain) IBOutlet UIButton *jangjun;		//장애아전담
@property(nonatomic, retain) IBOutlet UIButton *youngjun;	//영아전담시설
@property(nonatomic, retain) IBOutlet UIButton *timeyunjang;	//시간연장
@property(nonatomic, retain) IBOutlet UIButton *banggwajun;	//방과후전담
@property(nonatomic, retain) IBOutlet UIButton *pyungin;		//평가인증여부
@property(nonatomic, retain) IBOutlet UIButton *prevButton;


-(IBAction)GO_BACK;
-(IBAction) buttonClick: (id) sender;

//피커뷰 추가 
-(IBAction) showRegionValuePicker;
@property (nonatomic, retain) UIToolbar   *toolbar;
@end

@protocol SearchLocalChildInfoServiceDelegate<NSObject>;

@required

-(void) passParaToXML:(NSString*)inputDistrict FacilityName:(NSString*)inputFacilityName;


@end