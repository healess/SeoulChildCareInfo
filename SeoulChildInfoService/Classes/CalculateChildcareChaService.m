//
//  CalculateChildcareChaService.m
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//
/*조건별보육료계산조회 API <현제 서버 담당자 확인 필요>
 XML의 INPUT and OUTPUT
 <INPUT>
 FamilyCount	int	가구원수
 IncomeMonth	long	월소득
 GeneralProperty	long	일반재산
 FinanceProperty	long	금융재산
 PrivateCar	int	자동차
 Dept	long	부채
 <OUTPUT>
 RecognizeIncome	double	소득인정액
 ResultStandard	string	선정기준 결과
 DetailStandard	string	지원대상 계층확인
 RegionOfficeUrl	string	자치구 홈페이지
 */
#import "CalculateChildcareChaService.h"


@implementation CalculateChildcareChaService
@synthesize  familyCount;
@synthesize  incomeMonth;
@synthesize  generalProperty;
@synthesize  FinanceProperty;
@synthesize  PrivateCar;
@synthesize  Dept;
@synthesize  webData, xmlParser;



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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
}

-(IBAction)buttonClick:(id)sender
{
	
	//입력값 널체크
	if([familyCount.text isEqualToString:@""])
	{
		[self ShowMessageBox:@"가구원수를 입력해 주세요"];
		return;
	}
	if([incomeMonth.text isEqualToString:@""])
	{
		[self ShowMessageBox:@"월소득을 입력해 주세요"];
		return;
	}
	if([PrivateCar.text isEqualToString:@""])
	{
		[self ShowMessageBox:@"자동차 대수를  입력해 주세요"];
		return;
	}
	if([generalProperty.text isEqualToString:@""])
	{
		[self ShowMessageBox:@"일반재산을 입력해 주세요"];
		return;
	}
	if([FinanceProperty.text isEqualToString:@""])
	{
		[self ShowMessageBox:@"금융재산을 입력해 주세요"];
		return;
	}
	if([Dept.text isEqualToString:@""])
	{
		[self ShowMessageBox:@"부채를 입력해 주세요"];
		return;
	}
	
	
	NSString *soapMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:q0=\"http://apiiseoul.seoul.go.kr/CalculateChildcareChargeService/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n"
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
							 "<q0:CalcChildChargeRequest>\n"							 
							 "<FamilyCount>%@</FamilyCount>\n" 
							 "<IncomeMonth>%@</IncomeMonth>\n" 
							 "<GeneralProperty>%@</GeneralProperty>\n" 
							 "<FinanceProperty>%@</FinanceProperty>\n" 
							 "<PrivateCar>%@</PrivateCar>\n" 
							 "<Dept>%@</Dept>\n" 
							 "</q0:CalcChildChargeRequest>\n"
							 "</soapenv:Body>\n"
							 "</soapenv:Envelope>\n", familyCount.text,incomeMonth.text,generalProperty.text,FinanceProperty.text,PrivateCar.text,Dept.text
							 
		 ];

	NSLog(soapMessage);
	
	NSURL *url = [NSURL URLWithString:@"http://iseoulapi.seoul.go.kr/soap/CalcChildChargeService"];

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
	
	
	
	[self.familyCount resignFirstResponder];
	[self.incomeMonth resignFirstResponder];
	[self.generalProperty resignFirstResponder];
	[self.FinanceProperty resignFirstResponder];
	[self.PrivateCar resignFirstResponder];
	[self.Dept resignFirstResponder];
	
	
	
	

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
	if ([currentElement isEqualToString:@"RecognizeIncome"]) {
		recognizeIncome.text=string;
	}
	else if ([currentElement isEqualToString:@"ResultStandard"]) {
		resultStandard.text=string;
	}
	else if ([currentElement isEqualToString:@"DetailStandard"]) {
		detailStandard.text=string;
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
//배경 클릭 시 키보드 제거 혹은 피커 뷰 제거 기능
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[familyCount resignFirstResponder];
	[incomeMonth resignFirstResponder];//확인 필요
	[generalProperty resignFirstResponder];
	[FinanceProperty resignFirstResponder];//확인 필요
	[PrivateCar resignFirstResponder];
	[Dept resignFirstResponder];//확인 필요
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc 
{
	[xmlParser release];
	[super dealloc];
}



@end
