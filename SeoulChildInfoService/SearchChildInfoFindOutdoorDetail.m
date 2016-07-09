//
//  SearchChildInfoFindOutdoorDetail.m
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 18..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchChildInfoFindOutdoorDetail.h"
#import "SearchAroundChildInfoService.h"


@implementation SearchChildInfoFindOutdoorDetail
@synthesize  webData, xmlParser; 

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
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"telprompt:" stringByAppendingString:tel.text]]];
	NSLog(@"%@",tel.text);
}


/*==========================================================================================================================
 네비게이션바 뒤로가기
 ==========================================================================================================================*/
-(IBAction)GO_BACK
{
	[self.navigationController popViewControllerAnimated:YES];
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
	UIBarButtonItem *preButton = [[UIBarButtonItem alloc] initWithTitle:@"즐겨찾기"  style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"상세정보"  style:UIBarButtonItemStyleBordered target:self action:@selector(searchChildInfoServiceDetail)];
	UIBarButtonItem *splitItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

	toolBar.items = [NSArray arrayWithObjects:backButton, nil];	
	//	toolBar.items = [NSArray arrayWithObjects:nextButton, nil];
	
	[toolBar release];
	*/
	
}
//상단 툴바내 버튼 클릭 시 호출 메소드 (뒤로가기)
- (void)action {
	[self.view removeFromSuperview];
	
}

//앞 화면에서 파라미터를 넘겨받아 입력 XML에 담아 호출
-(void)passParaToXML:(NSString *)inputFacilityID
{
	
	//인디케이터 작동
	activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50 )];
	[activityIndicator setCenter:self.view.center];
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[self.view addSubview:activityIndicator];	
	[activityIndicator startAnimating];        
	[activityIndicator setHidden:NO];
	
	//입력XML값
	//XML호출전 임시값 초기화 (내용 잘림문제 해결)
	tempInfoContent=@"";

	NSString *soapMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:q0=\"http://apiiseoul.seoul.go.kr/SearchChildcareInformationService/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n"
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
							 "<q0:ChildcareInfoItemRequest>\n"
							 "<ChildInfoType>05</ChildInfoType>\n"
							  "<ChildInfoID>524</ChildInfoID>\n"
							 "</q0:ChildcareInfoItemRequest>\n"
							 "</soapenv:Body>\n"
							 "</soapenv:Envelope>\n",inputFacilityID
							 
							 ];
	
	
	//선택된 사설아이디값 글로벌 변수에 저장
	currentFacilityID = [inputFacilityID copy];
	//입력 XML확인
	//NSLog(soapMessage);
	//요청 url내용
	NSURL *url = [NSURL URLWithString:@"http://iseoulapi.seoul.go.kr/soap/SearchChildInfoService"];
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
	if ([currentElement isEqualToString:@"InfoTitle"]) {
		infoTitle.text=string;
		
	} else if ([currentElement isEqualToString:@"Address"]) {
		address.text=string;
	} else if ([currentElement isEqualToString:@"Tel"]) {
		tel.text=string;
	}
	else if ([currentElement isEqualToString:@"OpenTime"]) {
		openTime.text=string;
	}
	else if ([currentElement isEqualToString:@"PriceInfo"]) {
		priceInfo.text=string;
	}
	else if ([currentElement isEqualToString:@"InfoContent"]) {
	//	infoContent.text=string;
		tempInfoContent=[tempInfoContent stringByAppendingString:string];
		[infoContent setText:tempInfoContent];
	}
}
//XML로딩 종료시 실행
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	//인디케이터죽이기
	[activityIndicator stopAnimating];        
	[activityIndicator setHidden:YES];
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
