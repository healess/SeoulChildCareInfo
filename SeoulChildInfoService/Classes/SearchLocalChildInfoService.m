//
//  SearchLocalChildInfoService.m
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//
/*
 종합검색관련 검색 항목 출력
 위 클래스는 단순히 XML로 값 전달을 위한 화면
 */
#import "SearchLocalChildInfoService.h"
#import "SearchLocalChildInfoServiceResult.h"


@implementation SearchLocalChildInfoService
@synthesize inputDistrictName,inputFacilityName,delegate;
@synthesize kukgong;	//국공립
@synthesize bupin;		//법인
@synthesize mingan;		//민간
@synthesize gajung;		//가정
@synthesize bumohyup;	//부모협동
@synthesize jikjnag;	//직장
@synthesize damunhwa;	//다문화시설
@synthesize chaunhang;	//차량운행
@synthesize toolbar;
@synthesize prevButton;
/*==========================================================================================================================
 네비게이션바 뒤로가기
 ==========================================================================================================================*/
-(IBAction)GO_BACK
{
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	//체크박스 처리를 위한 메소드 정의
	[kukgong		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[bupin			addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[mingan			addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[gajung			addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[bumohyup		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[jikjnag		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[damunhwa		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[chaunhang		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[seoulhyung		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];	
	[jangtong		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[jangjun		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[youngjun		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[timeyunjang	addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[banggwajun		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	[pyungin		addTarget:self action:@selector(check_button_Touched:) forControlEvents:UIControlEventTouchUpInside];
	
	//테이블상단 버튼 추가를 위한 툴바 추가
	/*
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
	
	//	toolBar.barStyle = UIBarStyleBlackTranslucent; //스타일 선택
	[self.view addSubview:toolBar]; //뷰에 추가
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"뒤로" style:UIBarButtonItemStyleBordered target:self action:@selector(action)];

	toolBar.items = [NSArray arrayWithObjects:backButton,nil];
	//	toolBar.items = [NSArray arrayWithObjects:nextButton, nil];
	
	[toolBar release];
	 */
	
	
	//이전단계의 화면이 없다면 "이전" 버튼을 숨긴다.
	NSLog(@"이전화면수: %d",self.navigationController.viewControllers.count);
	if(self.navigationController.viewControllers.count<2)
	{
		[prevButton setHidden:TRUE];
	}
	else
	{
		[prevButton setHidden:FALSE];
	}

	
	
	//피커뷰 추가
	//피커뷰 구현
	toolbar = [UIToolbar new];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [toolbar sizeToFit];
    [toolbar setFrame:CGRectMake(0,215,400,50)];
	toolbar.hidden = YES;
	
	regionValues = [[NSArray alloc] initWithObjects:@"강남구",@"강동구",@"강북구",@"강서구",@"관악구",@"광진구",@"구로구",@"금천구",@"노원구"
					,@"도봉구",@"동대문구",@"동작구",@"마포구",@"서대문구",@"서초구",@"성동구",@"성북구",@"송파구",@"양천구",@"영등포구",@"용산구",@"은평구",@"종로구",@"중구",@"중랑구",nil];
	
	
	regionValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	regionValuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,265,400,160)];
	//	yearValuePicker.backgroundColor = [UIColor blueColor];
	regionValuePicker.showsSelectionIndicator = TRUE;
	regionValuePicker.hidden = YES;
	regionValuePicker.dataSource = self;
	regionValuePicker.delegate = self;
	
	
	
}
/*==========================================================================================================================
체크박스 버튼 누를때 처리.(토글처리)
==========================================================================================================================*/
-(void) check_button_Touched:(UIButton*)sender
{
	
	if([sender.titleLabel.text isEqualToString:@"N"])
	{
		[sender setTitle:@"Y" forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"btn_check_yes.png"] forState:UIControlStateNormal];
	}
	else 
	{
		[sender setTitle:@"N" forState:UIControlStateNormal];
		[sender setImage:[UIImage imageNamed:@"btn_check_no.png"] forState:UIControlStateNormal];
	}
}




//상단 툴바내 버튼 클릭 시 호출 메소드 (뒤로가기)
- (void)action {
	[self.view removeFromSuperview];
	
}



//피커별 열 갯수 설정 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{	
	return 1;
}

//피커내 로우수 결정
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [regionValues count];
}	

//컬럼 별 피커 값 설정
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [regionValues objectAtIndex:row];
}
//버튼에 피커 Value 셋 하는 부분
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	NSString *regionValue  = [regionValues objectAtIndex:[pickerView selectedRowInComponent:0]];
	
	if([regionValue isEqualToString:@"강남구"])
	{
		inputRegionCode=@"11680";
	}else if([regionValue isEqualToString:@"강동구"]){
		inputRegionCode=@"11740";
	}else if([regionValue isEqualToString:@"강북구"]){
		inputRegionCode=@"11305";
	}else if([regionValue isEqualToString:@"강서구"]){
		inputRegionCode=@"11500";
	}else if([regionValue isEqualToString:@"관악구"]){
		inputRegionCode=@"11620";
	}else if([regionValue isEqualToString:@"광진구"]){
		inputRegionCode=@"11215";
	}else if([regionValue isEqualToString:@"구로구"]){
		inputRegionCode=@"11530";
	}else if([regionValue isEqualToString:@"금천구"]){
		inputRegionCode=@"11545";
	}else if([regionValue isEqualToString:@"노원구"]){
		inputRegionCode=@"11350";
	}else if([regionValue isEqualToString:@"도봉구"]){
		inputRegionCode=@"11320";
	}else if([regionValue isEqualToString:@"동대문구"]){
		inputRegionCode=@"11230";
	}else if([regionValue isEqualToString:@"동작구"]){
		inputRegionCode=@"11590";
	}else if([regionValue isEqualToString:@"마포구"]){
		inputRegionCode=@"11440";
	}else if([regionValue isEqualToString:@"서대문구"]){
		inputRegionCode=@"11410";
	}else if([regionValue isEqualToString:@"서초구"]){
		inputRegionCode=@"11650";
	}else if([regionValue isEqualToString:@"성동구"]){
		inputRegionCode=@"11200";
	}else if([regionValue isEqualToString:@"성북구"]){
		inputRegionCode=@"11290";
	}else if([regionValue isEqualToString:@"송파구"]){
		inputRegionCode=@"11710";
	}else if([regionValue isEqualToString:@"양천구"]){
		inputRegionCode=@"11470";
	}else if([regionValue isEqualToString:@"영등포구"]){
		inputRegionCode=@"11560";
	}else if([regionValue isEqualToString:@"용산구"]){
		inputRegionCode=@"11170";
	}else if([regionValue isEqualToString:@"은평구"]){
		inputRegionCode=@"11380";
	}else if([regionValue isEqualToString:@"종로구"]){
		inputRegionCode=@"11110";
	}else if([regionValue isEqualToString:@"중구"]){
		inputRegionCode=@"11140";
	}else if([regionValue isEqualToString:@"중랑구"]){
		inputRegionCode=@"11260";
	}
	
	[inputRegion setTitle:regionValue forState:UIControlStateNormal];	
}
//각 분리된 항목별 디스플레이면적
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 280.0;
	
	return componentWidth;
	
}
//높이설정
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}
//툴바생성
- (void)createToolbarItems{  
	
	/*UIBarButtonItem *systemItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:mItem     target:self action:@selector(action:)];
	 
	 NSArray *items = [NSArray arrayWithObjects: systemItem,  nil];
	 
	 [self.toolbar setItems:items animated:NO];
	 */
	UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"선택" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed:)] autorelease];
	//[toolbar setItems:[NSArray arrayWithObjects:sendButton, cancelButton, nil]];
	
	[toolbar setItems:[NSArray arrayWithObjects:doneButton, nil]];	
}
//뷰제거
- (void)disappearAll{
	if ( !regionValuePicker.hidden) 
	{
		regionValuePicker.hidden = YES;		
	}
	if ( !toolbar.hidden) 
	{
		toolbar.hidden = YES;
	}	
}
- (void) doneButtonPressed:(id)sender
{
	[self disappearAll];
}
//버튼 클릭 시 해당 피커 호출 
-(IBAction) showRegionValuePicker{	
	if ( regionValuePicker.hidden) {
		regionValuePicker.hidden = NO;
		[self.view addSubview:regionValuePicker];	
		toolbar.hidden = NO;
		[self.view addSubview:toolbar];
		[self createToolbarItems];
	}
	else {
		regionValuePicker.hidden = YES;
		toolbar.hidden = YES;
		[regionValuePicker removeFromSuperview];
	}
}

//배경 클릭 시 키보드 제거 혹은 피커 뷰 제거 기능
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[inputDistrictName resignFirstResponder];
	[inputFacilityName resignFirstResponder];//확인 필요
}



-(IBAction)buttonClick:(id)sender
{	
	//뷰호출 및 값 전달로 XML실행
	//subview = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height)];	
	//SearchLocalChildInfoServiceResult *searchLocalChildInfoServiceResult=[[SearchLocalChildInfoServiceResult alloc] init];
	SearchLocalChildInfoServiceResult *searchLocalChildInfoServiceResult =
	[[SearchLocalChildInfoServiceResult alloc] initWithNibName:@"SearchLocalChildInfoServiceResult" bundle:nil];
	
	[searchLocalChildInfoServiceResult passParaToXML:inputRegionCode DistrictName:inputDistrictName.text
											  Public:kukgong.titleLabel.text
										   Corporate:bupin.titleLabel.text
											 Private:mingan.titleLabel.text
												Home:gajung.titleLabel.text
											  Parent:bumohyup.titleLabel.text
												 Job:jikjnag.titleLabel.text
											   Seoul:seoulhyung.titleLabel.text
										DisableTotal:jangtong.titleLabel.text
										 DisableFull:jangjun.titleLabel.text
											MultiCul:damunhwa.titleLabel.text
												Baby:youngjun.titleLabel.text
												Time:timeyunjang.titleLabel.text
											  TimeAS:banggwajun.titleLabel.text
									   Certification:pyungin.titleLabel.text
											 Vehicle:chaunhang.titleLabel.text
										FacilityName:inputFacilityName.text inputPageNum:1];
	
	NSLog(@"STEP1"); 
	[self.navigationController  pushViewController:searchLocalChildInfoServiceResult animated:YES];
	[searchLocalChildInfoServiceResult release];
	/*
	CGRect newFrame = searchLocalChildInfoServiceResult.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchLocalChildInfoServiceResult.view.frame = newFrame;
	subview=searchLocalChildInfoServiceResult.view;	
	[self.view addSubview:subview];
	 */
	NSLog(@"STEP3"); 

}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc 
{

	[super dealloc];
}


@end
