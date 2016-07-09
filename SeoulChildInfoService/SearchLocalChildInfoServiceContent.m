//
//  SearchLocalChildInfoServiceContent.m
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

/*지역보육시설항목조회 API
 XML의 INPUT and OUTPUT
 <INPUT>
 FacilityID	string	시설 아이디
 <OUTPUT>
 FacilityName	string	시설명
 CRType	string	시설유형
 CRSpec	string	시설특성
 FixedNumber	int	정원
 PresentNumber	int	현원
 PresidentName	string	시설장명
 OpenDate	string	개원일
 Vehicle	string	차량운행
 Certification	string	평가인증유무
 Telephone	string	시설 전화번호
 Address	string	시설 주소
 GovSupport	string	정부지원여부
 AccidentInsurance	string	상해부험가입여부
 FireInsurance	string	화재보험가입여부
 CompensationInsurance	string	배상보험가입여부
 */

#import "SearchLocalChildInfoServiceContent.h"
#import "SearchLocalChildInfoServiceDetail.h"
#import "SearchAroundChildInfoService.h"


@implementation SearchLocalChildInfoServiceContent
@synthesize  webData, xmlParser; 


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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	//테이블상단 버튼 추가를 위한 툴바 추가
	/*
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
	
	//	toolBar.barStyle = UIBarStyleBlackTranslucent; //스타일 선택
	[self.view addSubview:toolBar]; //뷰에 추가
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"뒤로" style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
	UIBarButtonItem *preButton = [[UIBarButtonItem alloc] initWithTitle:@"즐겨찾기"  style:UIBarButtonItemStyleBordered target:self action:@selector(addFavorite)];
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"상세정보"  style:UIBarButtonItemStyleBordered target:self action:@selector(searchChildInfoServiceDetail)];
	UIBarButtonItem *splitItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	toolBar.items = [NSArray arrayWithObjects:backButton,splitItem ,preButton, nextButton, nil];
	//	toolBar.items = [NSArray arrayWithObjects:nextButton, nil];
	
	[toolBar release];
	 */
	
}


/*==========================================================================================================================
뒤로가기
 ==========================================================================================================================*/
-(IBAction) GO_BACK
{
	[self.navigationController popViewControllerAnimated:YES];
}
/*==========================================================================================================================
 위치보기
 ==========================================================================================================================*/
-(IBAction) GO_MAP
{
	
	SearchAroundChildInfoService *searchAroundChildInfoService =
	[[SearchAroundChildInfoService alloc] initWithNibName:@"SearchAroundChildInfoService" bundle:nil];
	
	searchAroundChildInfoService.isOneKindergarten=TRUE;
	[self.navigationController  pushViewController:searchAroundChildInfoService animated:YES];
	[searchAroundChildInfoService.inputAddress setText:address.text];

	[searchAroundChildInfoService POINT_POSITON_ON_MAP_BY_ADDRESS];
	[searchAroundChildInfoService release];
	
}
/*==========================================================================================================================
 전화걸기
 ==========================================================================================================================*/
-(IBAction) CALL_TELEPHONE
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"telprompt:" stringByAppendingString:telephone.text]]];
	NSLog(@"%@",telephone.text);
}

/*==========================================================================================================================
 즐겨찾기 추가
 ==========================================================================================================================*/
-(IBAction) ADD_FAVORITE
{
	//현재 favorite 갯수
	int favoriteKindergartenCount;
	favoriteKindergartenCount=[[NSUserDefaults standardUserDefaults] integerForKey:@"keyFavoriteKindergartenCount"];
	NSLog(@"현재 즐겨찾기수: %d",favoriteKindergartenCount);
	
	//즐겨찾기의 최대 허용갯수는 10개
	if(favoriteKindergartenCount>=10)
	{
		[self ShowMessageBox:@"더이상 추가할 수 없습니다.\n즐겨찾기 최대 개수는 10개 입니다."];
		return;
	}
	
	//현재 favorite 에 이미 추가되어 있는지 확인한다
	for(int i=0;i<favoriteKindergartenCount;i++)
	{
		
		if([[[NSUserDefaults standardUserDefaults] stringForKey:[@"keyFavoriteKindergartenFacilityID" stringByAppendingFormat:@"%d",i]] isEqualToString:currentFacilityID])
		{
			[self ShowMessageBox:@"이미등록된 즐겨찾기입니다!"];
			return;
		}
		
	}
	
	//새로운 즐겨찾기라면 새롭게 추가
	[[NSUserDefaults standardUserDefaults] setObject:currentFacilityID forKey:[@"keyFavoriteKindergartenFacilityID" stringByAppendingFormat:@"%d",favoriteKindergartenCount]];
	[[NSUserDefaults standardUserDefaults] setObject:facilityName.text forKey:[@"keyFavoriteKindergartenFacilityName" stringByAppendingFormat:@"%d",favoriteKindergartenCount]];
	
	//favorite 카운트 증가
	favoriteKindergartenCount++;
	[[NSUserDefaults standardUserDefaults] setInteger:favoriteKindergartenCount  forKey:@"keyFavoriteKindergartenCount"];	
	
	[self ShowMessageBox:@"즐겨찾기에 추가되었습니다."];
}

/*==========================================================================================================================
상세 정보 화면 이동
==========================================================================================================================*/
-(IBAction) GO_DETAIL
{
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	SearchLocalChildInfoServiceDetail *searchLocalChildInfoServiceDetail= [[SearchLocalChildInfoServiceDetail alloc] init];
	[searchLocalChildInfoServiceDetail passParaToXML:currentFacilityID];
	CGRect newFrame = searchLocalChildInfoServiceDetail.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchLocalChildInfoServiceDetail.view.frame = newFrame;
	subview=searchLocalChildInfoServiceDetail.view;	
	[self.view addSubview:subview];
	 */
	
	SearchLocalChildInfoServiceDetail *searchLocalChildInfoServiceDetail =
	[[SearchLocalChildInfoServiceDetail alloc] initWithNibName:@"SearchLocalChildInfoServiceDetail" bundle:nil];
	[searchLocalChildInfoServiceDetail passParaToXML:currentFacilityID];
	[self.navigationController  pushViewController:searchLocalChildInfoServiceDetail animated:YES];
	[SearchLocalChildInfoServiceDetail release];
	
	
	
	
}
//앞 화면에서 파라미터를 넘겨받아 입력 XML에 담아 호출
-(void)passParaToXML:(NSString *)inputFacilityID
{
	//입력XML값
	NSString *soapMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:q0=\"http://apiiseoul.seoul.go.kr/SearchLocalChildcareInformationService/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n"
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
							 "<q0:LocalChildFacilityItemRequest>\n"
							 "<FacilityID>%@</FacilityID>\n"
							 "</q0:LocalChildFacilityItemRequest>\n"
							 "</soapenv:Body>\n"
							 "</soapenv:Envelope>\n",inputFacilityID
							 
							 ];
	//선택된 사설아이디값 글로벌 변수에 저장
	currentFacilityID = [inputFacilityID copy];
	//입력 XML확인
	//NSLog(soapMessage);
	//요청 url내용
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
//접속 수 수신 처리 메소드
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
//XML의 데이터 송수신 시 에러 발생시 실행됨
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	[self ShowMessageBox:@"인터넷에 연결되어 있지 않거나. 서울시 웹서비스 장애입니다.\n 3G 혹은 와이파이망을 확인해 주시거나 잠시후 다시 시도해 주세요"];
	[connection release];
	[webData release];
}
//XML의 데이터 송수신 후 결과값을 가져오는 메소드
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
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
//XML로딩 시작시 실행
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	//글로벌 변수에 현제 항목값을 카피해둔다 
	currentElement = [elementName copy];
}
//실제 결과값을 차자 화면에 셋
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if ([currentElement isEqualToString:@"FacilityName"]) {
		facilityName.text=string;

	} else if ([currentElement isEqualToString:@"Telephone"]) {
		telephone.text=string;
	} else if ([currentElement isEqualToString:@"Address"]) {
		address.text=string;
	}
     else if ([currentElement isEqualToString:@"PresidentName"]) {
		 presidentName.text=string;
	 }
	
	else if ([currentElement isEqualToString:@"CRType"]) {
		cRType.text=string;
		
	} else if ([currentElement isEqualToString:@"CRSpec"]) {
		cRSpec.text=string;
	} else if ([currentElement isEqualToString:@"OpenDate"]) {
		openDate.text=string;
	}
	else if ([currentElement isEqualToString:@"Vehicle"]) {
		vehicle.text=string;
	}	
	else if ([currentElement isEqualToString:@"Certification"]) {
		certification.text=string;
	}	else if ([currentElement isEqualToString:@"GovSupport"]) {
		govSupport.text=string;
	} else if ([currentElement isEqualToString:@"AccidentInsurance"]) {
		accidentInsurance.text=string;
	}
	else if ([currentElement isEqualToString:@"FireInsurance"]) {
		fireInsurance.text=string;
	}	
	else if ([currentElement isEqualToString:@"CompensationInsurance"]) {
		compensationInsurance.text=string;
	}	
	else if ([currentElement isEqualToString:@"FixedNumber"]) {
		fixedNumber.text=string;
	}	
	else if ([currentElement isEqualToString:@"PresentNumber"]) {
		presentNumber.text=string;
	}	
}
//XML로딩 종료시 실행
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	NSLog(@"didEndElement %@", elementName); 
	/*
	if( [elementName isEqualToString:@"FacilityName"])
	{

	}
	 */
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

//XML의 경우 서버와의 통신으로 데이터 수신에 시간이 걸림 아래 메소드는 최종 로딩 후 호출
- (void)parserDidEndDocument:(NSXMLParser *)parser {
	NSLog(@"all done!");

}
//뒤로가기
-(IBAction)backResult:(id)sender{
	[self.view removeFromSuperview];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (void)dealloc {
    [super dealloc];
}


@end
