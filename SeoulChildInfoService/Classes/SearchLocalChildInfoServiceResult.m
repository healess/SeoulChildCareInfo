//
//  SearchLocalChildInfoServiceResult.m
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//
/*
 > 지역보육시설목록조회 API
 XML의 INPUT and OUTPUT
 <INPUT>
 Region	string	서울시 자치구 [자치구코드표]
 District	string	자치구 내 행정동
 CRTypePublic	string	시설유형-국공립(Y/N)
 CRTypeCorporate	string	시설유형-법인(Y/N)
 CRTypePrivate	string	시설유형-민간(Y/N)
 CRTypeHome	string	시설유형-가정(Y/N)
 CRTypeParent	string	시설유형-부모협동(Y/N)
 CRTypeJob	string	시설유형-직장(Y/N)
 CRSpecSeoul	string	시설특성-서울형어린합집(Y/N)
 CRSpecDisableTotal	string	시설특성-장애아통합(Y/N)
 CRSpecDisableFull	string	시설특성-장애아전담(Y/N)
 CRSpecMultiCul	string	시설특성-다문화시설(Y/N)
 CRSpecBaby	string	시설특성-영아전담시설(Y/N)
 CRSpecTime	string	시설특성-시간연장(Y/N)
 CRSpecTimeAS	string	시설특성-방과후전담(Y/N)
 Certification	string	평가인증유무(Y/N)
 Vehicle	string	차량운행여부(Y/N)
 FacilityName	string	시설명
 PageNum	int	페이지번호
 <OUTPUT>
 TotalFacilityCount	int	총 시설물 갯수
 TotalPageNumber	int	시설물 리스트 페이지 갯수
 PageNumber	int	현재 페이지 번호
 PageFacilityCount	int	현재 페이지 시설물 리스트 갯수
 LocalChildFacilityList		지역 시설물 정보 내역[0~*]
 ListNumber	int	게시물번호
 FacilityName	string	시설명
 Type	string	시설유형
 Certification	string	평가인증여부
 Seoul	string	서울형어린이집여부
 FixedNumber	int	정원
 PresentNumber	int	현원
 Telephone	string	시설 전화번호
 Fax	string	팩스번호
 Address	string	시설 주소
 FacilityID	string	시설 아이디
 */

#import "SearchLocalChildInfoServiceResult.h"
#import "SearchLocalChildInfoServiceContent.h"


@implementation SearchLocalChildInfoServiceResult

@synthesize  webData, xmlParser;
@synthesize segGoPage;



 
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
/*
    [super viewDidLoad];
	//테이블상단 버튼 추가를 위한 툴바 추가
	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
	//툴바 내 버튼 추가
	toolbar.items = [NSArray arrayWithObjects:
					 [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(action)] autorelease],
									nil];
	
	
	[self.view addSubview:toolbar];
	[toolbar release];
	
	*/
	
	
    [super viewDidLoad];
	inputPageNum=1;//최초 로딩시 초기화 필요
	CGRect tableViewFrame=CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height-49);
	//	CGRect tableViewFrame=CGRectMake(0.0, 0.0, 320, 430);
	mainTableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];//UITableViewStylePlain UITableViewStyleGrouped
	mainTableView.autoresizingMask=(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
	mainTableView.delegate=self;
	mainTableView.dataSource=self;	
	//	self.view=mainTableView;
	
	[self.view addSubview:mainTableView]; //뷰에 추가
	
	//테이블상단 버튼 추가를 위한 툴바 추가
	/*
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
	toolBar.tintColor=[[UIColor alloc] initWithRed:0.0 green:1.0 blue:0.7 alpha:0.0];
	//toolBar.barStyle = UIBarStyleBlackTranslucent; //스타일 선택
	[self.view addSubview:toolBar]; //뷰에 추가
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"뒤로" style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
	UIBarButtonItem *preButton = [[UIBarButtonItem alloc] initWithTitle:@"이전"  style:UIBarButtonItemStyleBordered target:self action:@selector(goPrePage)];
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"다음"  style:UIBarButtonItemStyleBordered target:self action:@selector(goNextPage)];
	UIBarButtonItem *splitItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	toolBar.items = [NSArray arrayWithObjects:backButton,splitItem ,preButton, nextButton, nil];
	//	toolBar.items = [NSArray arrayWithObjects:nextButton, nil];
	
	[toolBar release];	
	*/ 
	//	[mainTableView reloadData];
	
}
/*==========================================================================================================================
 네비게이션바 뒤로가기
 ==========================================================================================================================*/
-(IBAction)GO_BACK
{
	[self.navigationController popViewControllerAnimated:YES];
}


/*==========================================================================================================================
 이전페이지
 ==========================================================================================================================*/

-(IBAction) GO_PREV
{
	NSLog(@"이전페이지");
	if(inputPageNum>1){
		inputPageNum--;//0보다 작아지면 값이 안보임
	}else{
		[self ShowMessageBox:@"첫페이지입니다."];
	}
	[self passParaToXML:inputRegion DistrictName:inputDistrict 
				 Public:inputPublic
			  Corporate:inputCorporate
				Private:inputPrivate
				   Home:inputHome
				 Parent:inputParent
					Job:inputJob
				  Seoul:inputSeoul
		   DisableTotal:inputDisableTotal
			DisableFull:inputDisableFull
			   MultiCul:inputMultiCul
				   Baby:inputBaby
				   Time:inputTime
				 TimeAS:inputTimeAS
		  Certification:inputCertification
				Vehicle:inputVehicle 
		   FacilityName:inputFacilityName inputPageNum:inputPageNum];
}
/*==========================================================================================================================
 다음페이지
 ==========================================================================================================================*/
-(IBAction) GO_NEXT
{
	
	NSLog(@"다음페이지");
	inputPageNum++;	
	[self passParaToXML:inputRegion DistrictName:inputDistrict 
				 Public:inputPublic
			  Corporate:inputCorporate
				Private:inputPrivate
				   Home:inputHome
				 Parent:inputParent
					Job:inputJob
				  Seoul:inputSeoul
		   DisableTotal:inputDisableTotal
			DisableFull:inputDisableFull
			   MultiCul:inputMultiCul
				   Baby:inputBaby
				   Time:inputTime
				 TimeAS:inputTimeAS
		  Certification:inputCertification
				Vehicle:inputVehicle
	 
		   FacilityName:inputFacilityName inputPageNum:inputPageNum];
}




/*
//상단 툴바내 다음 클릭 시 호출 메소드 (다음)
- (void)goNextPage {
	inputPageNum++;	
	[self passParaToXML:inputRegion DistrictName:inputDistrict FacilityName:inputFacilityName inputPageNum:inputPageNum];
	
	
}
//상단 툴바내 이전 클릭 시 호출 메소드 (이전)
- (void)goPrePage {
	if(inputPageNum>1){
		inputPageNum--;//0보다 작아지면 값이 안보임
	}else{
		[self ShowMessageBox:@"첫페이지입니다."];
	}
	[self passParaToXML:inputRegion DistrictName:inputDistrict FacilityName:inputFacilityName inputPageNum:inputPageNum];
}
 */
//============================================================================================================
// 메세지박스를 원하는 텍스트로 띄워준다.
//============================================================================================================
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

///////////////// 아래 부터는 테이블 관련 메소드 /////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSLog(@"STEP8"); 
	
	return 1;
}

//테이블 뷰의 셀 겟수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"STEP7"); 

	NSLog(@"리스트 수: %i", [childInfoServiceList count]);

	return [childInfoServiceList count];
}

//테이블에 값 뿌려주는 부분
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"STEP5"); 
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	//테이블 셀 내 어린이집 명을 셋팅
	[cell setText:[[childInfoServiceList objectAtIndex: storyIndex] objectForKey: @"FacilityName"]];

    return cell;	
	
}

//테이블 셀 클릭시 실행 되는 메소드
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic
	NSLog(@"STEP6"); 

	int curIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	NSString * curID = [[childInfoServiceList objectAtIndex: curIndex] objectForKey: @"FacilityID"];
	NSLog(@"%@",curID); 
	
	
	/*

	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	
	SearchLocalChildInfoServiceContent *earchLocalChildInfoServiceContent= [[SearchLocalChildInfoServiceContent alloc] init];
	[earchLocalChildInfoServiceContent passParaToXML:curID];
	
	NSLog(@"테이블 클릭 실행"); 
	
	CGRect newFrame = earchLocalChildInfoServiceContent.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	earchLocalChildInfoServiceContent.view.frame = newFrame;
	subview=earchLocalChildInfoServiceContent.view;	
	[self.view addSubview:subview];
	 */
	
	SearchLocalChildInfoServiceContent *searchLocalChildInfoServiceContent =
	[[SearchLocalChildInfoServiceContent alloc] initWithNibName:@"SearchLocalChildInfoServiceContent" bundle:nil];
	[searchLocalChildInfoServiceContent passParaToXML:curID];
	[self.navigationController  pushViewController:searchLocalChildInfoServiceContent animated:YES];
	[searchLocalChildInfoServiceContent release];
	
	
}

///////////////// 아래 부터는 XML관련 메소드 /////////////////////
//입력 XML실행 부분
-(void)passParaToXML:(NSString *)inputRegionValue DistrictName:(NSString *)inputDistrictValue 
			  Public:(NSString *)inputkukgong
		   Corporate:(NSString *)inputbupin
			 Private:(NSString *)inputmingan
				Home:(NSString *)inputgajung
			  Parent:(NSString *)inputbumohyup
				 Job:(NSString *)inputjikjnag
			   Seoul:(NSString *)inputseoulhyung
		DisableTotal:(NSString *)inputjangtong
		 DisableFull:(NSString *)inputjangjun
			MultiCul:(NSString *)inputdamunhwa
				Baby:(NSString *)inputyoungjun
				Time:(NSString *)inputtimeyunjang
			  TimeAS:(NSString *)inputbanggwajun
	   Certification:(NSString *)inputpyungin
			 Vehicle:(NSString *)inputVehicleValue
		FacilityName:(NSString*)inputFacilityNameValue inputPageNum:(int *)inputPageNum
{
	NSLog(@"XML확인");
	
	childInfoServiceList = [[NSMutableArray alloc] init];
	inputDistrict	=inputDistrictValue;
	inputRegion = inputRegionValue;
	inputFacilityName = inputFacilityNameValue;
	inputPublic=inputkukgong;
	inputCorporate=inputbupin;
	inputPrivate=inputmingan;
	inputHome=inputgajung;
	inputParent=inputbumohyup;
	inputJob=inputjikjnag;
	inputSeoul=inputseoulhyung;
	inputDisableTotal=inputjangtong;
	inputDisableFull=inputjangjun;
	inputMultiCul=inputdamunhwa;
	inputBaby=inputyoungjun;
	inputTime=inputtimeyunjang;
	inputTimeAS=inputbanggwajun;
	inputCertification=inputpyungin;
	inputVehicle=inputVehicleValue;
	
	
	NSString *soapMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:q0=\"http://apiiseoul.seoul.go.kr/SearchLocalChildcareInformationService/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n"
							 "<soapenv:Header>\n"
							 "<q0:ComMsgHeaderRequest>\n"				 
							 "<RequestMsgID/>\n"
							 "<ServiceKey>sOn6eWoTwmLaHpiX+M3nFUgXA4s4oCXH1zQHlAXa82uzoEgmdx7/U6cAbWtNX2goLncYmXTeqO2ArvtLM8WKgQ==</ServiceKey>\n"
							 "<RequestTime/>\n"
							 "<CallBackURI/>\n"
							 "<priMsgHeader>\n"
							 "<test_val1/>\n"
							 "<test_val2/>\n"							 
							 "</priMsgHeader>\n"
							 "</q0:ComMsgHeaderRequest>\n"
							 "</soapenv:Header>\n"
							 "<soapenv:Body>\n"
							 "<q0:LocalChildFacilityListRequest>\n"
							 "<Region>%@</Region>\n" //자치구 코드
							 "<District>%@</District>\n" //자치구 내 동
							 "<CRTypePublic>%@</CRTypePublic>\n" //시설유형-국공립(Y/N)
							 "<CRTypeCorporate>%@</CRTypeCorporate>\n" //시설유형-법인(Y/N)
							 "<CRTypePrivate>%@</CRTypePrivate>\n" //시설유형-민간(Y/N)
							 "<CRTypeHome>%@</CRTypeHome>\n"  //시설유형-가정(Y/N)
							 "<CRTypeParent>%@</CRTypeParent>\n" //시설유형-부모협동(Y/N)
							 "<CRTypeJob>%@</CRTypeJob>\n" //시설유형-직장(Y/N)
							 "<CRSpecSeoul>%@</CRSpecSeoul>\n"  //시설특성-서울형어린합집(Y/N)
							 "<CRSpecDisableTotal>%@</CRSpecDisableTotal>\n" //시설특성-장애아통합(Y/N)
							 "<CRSpecDisableFull>%@</CRSpecDisableFull>\n" //시설특성-장애아전담(Y/N)
							 "<CRSpecMultiCul>%@</CRSpecMultiCul>\n" //시설특성-다문화시설(Y/N)
							 "<CRSpecBaby>%@</CRSpecBaby>\n"  //시설특성-영아전담시설(Y/N)
							 "<CRSpecTime>%@</CRSpecTime>\n"  //시설특성-시간연장(Y/N)
							 "<CRSpecTimeAS>%@</CRSpecTimeAS>\n" //시설특성-방과후전담(Y/N)
							 "<Certification>%@</Certification>\n" //평가인증유무(Y/N)
							 "<Vehicle>%@</Vehicle>\n"  //차량운행여부(Y/N)
							 "<FacilityName>%@</FacilityName>\n"  //시설명
							 "<PageNum>%@</PageNum>\n"   //페이지번호
							 "</q0:LocalChildFacilityListRequest>\n"
							 "</soapenv:Body>\n"
							 "</soapenv:Envelope>\n",inputRegion, inputDistrict ,
							 inputPublic,
							 inputCorporate,
							 inputHome,
							 inputHome,
							 inputParent,
							 inputJob,
							 inputSeoul,
							 inputDisableTotal,
							 inputDisableFull,
							 inputMultiCul,
							 inputBaby,
							 inputTime,
							 inputTimeAS,
							 inputCertification,
							 inputVehicle,
							 inputFacilityName , [[NSString alloc] initWithFormat:@"%i", inputPageNum]  //파라미터 추가해야함
							 ];
	
	
	NSLog(soapMessage);
	
	NSURL *url = [NSURL URLWithString:@"http://iseoulapi.seoul.go.kr/soap/SearchLocalChildInfoService"];
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: @"http://viium.com/Hello" forHTTPHeaderField:@"SOAPAction"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if( theConnection )
	{
		NSLog(@"STEP11"); 
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theConnection is NULL");
	}
	
}	

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	
	[self ShowMessageBox:@"인터넷에 연결되어 있지 않거나. 서울시 웹서비스 장애입니다.\n 3G 혹은 와이파이망을 확인해 주시거나 잠시후 다시 시도해 주세요"];
	
	[connection release];
	[webData release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"결과확인 XML");
	NSLog(theXML);
	
	[theXML release];
	
	if( xmlParser )
	{
		[xmlParser release];
	}
	
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
	[xmlParser setDelegate: self];
	[xmlParser setShouldResolveExternalEntities: YES];
	[xmlParser parse];
	
	[connection release];
	[webData release];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	//현제 항목 값 카피
	currentElement = [elementName copy];
	//테이블에 출력을 위한 값 초기화
	if ([elementName isEqualToString:@"FacilityName"]) {	
	item = [[NSMutableDictionary alloc] init];
	currentFacilityName = [[NSMutableString alloc] init];
	currentTelephone = [[NSMutableString alloc] init];
	currentFacilityID = [[NSMutableString alloc] init];	
	}
}
//XML내 항목 값을 가져와서 변수에 담음
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if ([currentElement isEqualToString:@"FacilityName"]) {
		[currentFacilityName appendString:string];
	} else if ([currentElement isEqualToString:@"Telephone"]) {
		[currentTelephone appendString:string];
	} else if ([currentElement isEqualToString:@"FacilityID"]) {
			[currentFacilityID appendString:string];
	}
}
//XML로딩 종료시 실행
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	NSLog(@"didEndElement %@", elementName); 
	
	if( [elementName isEqualToString:@"FacilityName"])
	{
		[item setObject:currentFacilityName forKey:@"FacilityName"];
		[item setObject:currentTelephone forKey:@"Telephone"];
		[item setObject:currentFacilityID forKey:@"FacilityID"];
		[childInfoServiceList addObject:[item copy]];
//		recordResults = FALSE;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



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
    
    // Release any cached data, images, etc. that aren't in use.
}

/*
-(IBAction)cancel:(id)sender{
	[self.view removeFromSuperview];
}
*/


//XML의 경우 서버와의 통신으로 데이터 수신에 시간이 걸림 아래 메소드는 최종 로딩 후 호출
- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	NSLog(@"all done!");
	NSLog(@"childInfoServiceList array has %d items", [childInfoServiceList count]);
	[mainTableView reloadData];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[xmlParser release];
	
}

@end
