//
//  SearchLocalChildInfoServiceDetail.m
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

/*보육시설항목상세조회 API
 XML의 INPUT and OUTPUT
 <INPUT>
 FacilityID	string	시설 아이디
 <OUTPUT>
DetailContent	string	시설 상세정보(HTML출력으로 보완 필요)
 */

#import "SearchLocalChildInfoServiceDetail.h"


@implementation SearchLocalChildInfoServiceDetail
@synthesize  webData, xmlParser;
@synthesize	infoWebComment;		//정보 2012.3.4 추가 by 서정범
@synthesize activityIndicator;

/*==========================================================================================================================
 메세지 박스 띄우기.
 ==========================================================================================================================*/
-(void) ShowMessageBox:(NSString*)message
{
	UIAlertView *warn;
	warn= [[UIAlertView alloc]	initWithTitle:nil
									 message:message
									delegate:self
						   cancelButtonTitle:@"확인"
						   otherButtonTitles:nil];
	
	[warn show];		
	[warn release];
	
}
/*==========================================================================================================================
 상세정보가 제공되지 않을경우 이전으로 돌아간다.
 ==========================================================================================================================*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{ 
	[self.navigationController popViewControllerAnimated:YES];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	//인디케이터 작동
	activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50 )];
	[activityIndicator setCenter:self.view.center];
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[self.view addSubview:activityIndicator];	
	[activityIndicator startAnimating];        
	[activityIndicator setHidden:NO];
	
	/*
	//테이블상단 버튼 추가를 위한 툴바 추가
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
	
	//	toolBar.barStyle = UIBarStyleBlackTranslucent; //스타일 선택
	[self.view addSubview:toolBar]; //뷰에 추가
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"뒤로" style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
	UIBarButtonItem *preButton = [[UIBarButtonItem alloc] initWithTitle:@"이전"  style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"다음"  style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
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
-(void)passParaToXML:(NSString *)inputFacilityID
{
	//initialize
	cotentInfo=@"";
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
							 "<q0:localChildFacilityItemDetailRequest>\n"
							 "<FacilityID>%@</FacilityID>\n"
							 "</q0:localChildFacilityItemDetailRequest>\n"
							 "</soapenv:Body>\n"
							 "</soapenv:Envelope>\n",inputFacilityID
							 ];

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
	NSLog(@"theXML");
	
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

	if ([currentElement isEqualToString:@"DetailContent"]) {
		NSLog(@"1");

			NSLog(string);
		
		cotentInfo=[cotentInfo stringByAppendingString:string];
	}
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

}


/*
 Implement loadView if you want to create a view hierarchy programmatically
 - (void)loadView {
 }
 */

/*
 Implement viewDidLoad if you need to do additional setup after loading the view.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */


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
	
	NSLog(@"Last!!");
	
	//[activityIndicator stopAnimating];
	//[activityIndicator removeFromSuperview];
	NSString *tempCotentInfo;
	tempCotentInfo=@"";
	tempCotentInfo=[tempCotentInfo stringByAppendingString:@"<HTML>"];
	tempCotentInfo=[tempCotentInfo stringByAppendingString:@"<BODY STYLE='background-color: transparent'>"];
	tempCotentInfo=[tempCotentInfo stringByAppendingString:cotentInfo];
	tempCotentInfo=[tempCotentInfo stringByAppendingString:@"</BODY>"];
	tempCotentInfo=[tempCotentInfo stringByAppendingString:@"</HTML>"];
	NSLog(tempCotentInfo);
	//HTML 로드 theXML 출력값이 HTML이모르 WebView에 출력해야한다.
	infoWebComment.scalesPageToFit=YES;
	[infoWebComment setBackgroundColor:[UIColor clearColor]]; 
	[infoWebComment setOpaque:NO]; //배경을 투명하게
	[infoWebComment loadHTMLString:tempCotentInfo baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];	
	NSLog(@"all done!");
	//인디케이터죽이기
	[activityIndicator stopAnimating];        
	[activityIndicator setHidden:YES];
	
	
	if([cotentInfo length]<10)
	{
		
		[self ShowMessageBox:@"해당교육기관은 상세정보가 제공되지 않습니다."];
		
	}
	
	//	NSLog(@"childInfoServiceList array has %d items", [childInfoServiceList count]);
	
	
	
	
}

- (void)viewDidUnload {
    [super viewDidUnload];

	
	    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
