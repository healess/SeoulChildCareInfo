//
//  SearchChildInfoBookService.m
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 20..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchChildInfoBookService.h"
#import "SearchChildInfoBookServiceContent.h"

@implementation SearchChildInfoBookService

@synthesize  webData, xmlParser,mainTableView;//,inputPageNum;//,soapMessage;//,toolBar;


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
-(IBAction)GO_PREV
{
	if(inputPageNum>1){
		inputPageNum--;//0보다 작아지면 값이 안보임
	}else{
		[self ShowMessageBox:@"첫페이지입니다."];
	}
	[self passParaToXML:inputPageNum];	
}
/*==========================================================================================================================
 다음페이지
 ==========================================================================================================================*/
-(IBAction)GO_NEXT
{
	inputPageNum++;
	[self passParaToXML:inputPageNum];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	inputPageNum=1;//최초 로딩시 초기화 필요
    [super viewDidLoad];
	CGRect tableViewFrame=CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height-49);
	//	CGRect tableViewFrame=CGRectMake(0.0, 0.0, 320, 430);
	mainTableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];//UITableViewStylePlain UITableViewStyleGrouped
	mainTableView.autoresizingMask=(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
	mainTableView.delegate=self;
	mainTableView.dataSource=self;		
	[self.view addSubview:mainTableView]; //뷰에 추가
	
	
	/*
	//테이블상단 버튼 추가를 위한 툴바 추가
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
	NSLog(@"viewDidLoad"); 
	
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
}
//상단 툴바내 버튼 클릭 시 호출 메소드 (뒤로가기)
- (void)action {
	[self.view removeFromSuperview];
}
//상단 툴바내 다음 클릭 시 호출 메소드 (다음)
- (void)goNextPage {
	inputPageNum++;
	[self passParaToXML:inputPageNum];
}
//상단 툴바내 이전 클릭 시 호출 메소드 (이전)
- (void)goPrePage {
	if(inputPageNum>1){
		inputPageNum--;//0보다 작아지면 값이 안보임
	}else{
		[self ShowMessageBox:@"첫페이지입니다."];
	}
	[self passParaToXML:inputPageNum];	
}
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
	//테이블 셀 내 뉴스 제목을 셋팅
	[cell setText:[[childInfoServiceList objectAtIndex: storyIndex] objectForKey: @"Title"]];
    return cell;	
	
}

//테이블 셀 클릭시 실행 되는 메소드
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic
	NSLog(@"STEP6"); 
	
	int curIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	NSString * curID = [[childInfoServiceList objectAtIndex: curIndex] objectForKey: @"ChildInfoID"];
	NSLog(@"%@",curID); 
	
	
	/*
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	
	SearchChildInfoBookServiceContent *searchChildInfoBookServiceContent= [[SearchChildInfoBookServiceContent alloc] init];
	[searchChildInfoBookServiceContent passParaToXML:curID];
	
	NSLog(@"테이블 클릭 실행"); 
	
	CGRect newFrame = searchChildInfoBookServiceContent.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchChildInfoBookServiceContent.view.frame = newFrame;
	subview=searchChildInfoBookServiceContent.view;	
	[self.view addSubview:subview];
	 */
	
	SearchChildInfoBookServiceContent *searchChildInfoBookServiceContent =
	[[SearchChildInfoBookServiceContent alloc] initWithNibName:@"SearchChildInfoBookServiceContent" bundle:nil];
	[searchChildInfoBookServiceContent passParaToXML:curID];
	[self.navigationController  pushViewController:searchChildInfoBookServiceContent animated:YES];
	[searchChildInfoBookServiceContent release];
	
}

///////////////// 아래 부터는 XML관련 메소드 /////////////////////
//입력 XML실행 부분
//-(void)passParaToXML
-(void)passParaToXML:(int *)inputPageNum

{
	
	childInfoServiceList = [[NSMutableArray alloc] init];
	//NSLog(@"XML확인2 + %i",inputPageNum);
	NSString *soapMessage = [NSString stringWithFormat:
							 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
							 "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:q0=\"http://apiiseoul.seoul.go.kr/SearchChildcareInformationService/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n"
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
							 "<q0:ChildcareInfoListRequest>\n"
							 "<ChildInfoType>04</ChildInfoType>\n"
							 "<viewNotice>Y</viewNotice>\n"
							 "<PageNum>%@</PageNum>\n"
							 "<searchType>subject</searchType>\n"
							 "<searchKeyword/>\n"
							 "<outdoorSido/>\n"
							 "<outdoorGugun/>\n"
							 "<outdoorType/>\n"
							 "</q0:ChildcareInfoListRequest>\n"
							 "</soapenv:Body>\n"
							 "</soapenv:Envelope>\n",[[NSString alloc] initWithFormat:@"%i", inputPageNum]  //파라미터 수정으로 테스트 
							 ];
	
	
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
		//	NSLog(@"STEP11"); 
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
	//NSLog(@"결과확인 XML");
	//NSLog(theXML);
	
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
	if ([elementName isEqualToString:@"Title"]) {	
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentRegDate = [[NSMutableString alloc] init];
		currentChildInfoID = [[NSMutableString alloc] init];	
	}
}
//XML내 항목 값을 가져와서 변수에 담음
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	//NSLog(@"currentElement %@", string); 
	
	if ([currentElement isEqualToString:@"Title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"RegDate"]) {
		[currentRegDate appendString:string];
	} else if ([currentElement isEqualToString:@"ChildInfoID"]) {
		[currentChildInfoID appendString:string];
	}
}
//XML로딩 종료시 실행
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	//	NSLog(@"didEndElement %@", elementName); 
	
	if( [elementName isEqualToString:@"Title"])
	{
		[item setObject:currentTitle forKey:@"Title"];
		[item setObject:currentRegDate forKey:@"RegDate"];
		[item setObject:currentChildInfoID forKey:@"ChildInfoID"];
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
	//[self.view reloadData];
	[mainTableView reloadData];
	//	[childInfoServiceList release];
	
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
