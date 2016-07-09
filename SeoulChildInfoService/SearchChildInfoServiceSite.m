//
//  SearchChildInfoServiceSite.m
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//
/*
 http://iseoul.seoul.go.kr/php/index.php?pno=060801
 위 사이트의 보육관련사이트 출력 (관련 앱참조 필요)
 */
#import "SearchChildInfoServiceSite.h"


@implementation SearchChildInfoServiceSite
@synthesize  mainTableView;//,inputPageNum;//,soapMessage;//,toolBar;
/*==========================================================================================================================
 네비게이션바 뒤로가기
 ==========================================================================================================================*/
-(IBAction)GO_BACK
{
	[self.navigationController popViewControllerAnimated:YES];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	CGRect tableViewFrame=CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height-49);
	//	CGRect tableViewFrame=CGRectMake(0.0, 0.0, 320, 430);
	mainTableView = [[UITableView alloc]initWithFrame:tableViewFrame style:UITableViewStylePlain];//UITableViewStylePlain UITableViewStyleGrouped
	mainTableView.autoresizingMask=(UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
	mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
	mainTableView.delegate=self;
	mainTableView.dataSource=self;	
	//	self.view=mainTableView;
	
	[self.view addSubview:mainTableView]; //뷰에 추가	
	
	/*
	
	//테이블상단 버튼 추가를 위한 툴바 추가
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)];
	
	//	toolBar.barStyle = UIBarStyleBlackTranslucent; //스타일 선택
	[self.view addSubview:toolBar]; //뷰에 추가
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"뒤로" style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
	
	toolBar.items = [NSArray arrayWithObjects:backButton,nil];
	//	toolBar.items = [NSArray arrayWithObjects:nextButton, nil];
	
	[toolBar release];
	 */
	
	
}
//상단 툴바내 버튼 클릭 시 호출 메소드 (뒤로가기)
- (void)action {
	[self.view removeFromSuperview];
	
}


///////////////// 아래 부터는 테이블 관련 메소드 /////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	return 1;
}

//테이블 뷰의 셀 겟수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 65;
}

//테이블에 값 뿌려주는 부분
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	//테이블 셀 내 뉴스 제목을 셋팅
	if(indexPath.row== 0){
	    [cell setText:@"중앙보육정보센터"];  
	}else if(indexPath.row==1){
	    [cell setText:@"광주광역시보육정보센터"];  
	}else if(indexPath.row==2){
	    [cell setText:@"대전광역시보육정보센터"]; 
	}else if(indexPath.row==3){
	    [cell setText:@"인천광역시보육정보센터"];    
	}else if(indexPath.row==4){
	    [cell setText:@"직장보육시설지원센터"];   
	}else if(indexPath.row==5){
	    [cell setText:@"서울특별시보육정보센터"]; 
	}else if(indexPath.row==6){
	    [cell setText:@"대구광역시보육정보센터"];   
	}else if(indexPath.row==7){
	    [cell setText:@"부산광역시보육정보센터"]; 
	}else if(indexPath.row==8){
	    [cell setText:@"울산광역시보육정보센터"];    
	}else if(indexPath.row==9){
		[cell setText:@"강원도보육정보센터"]; 	
	}else if(indexPath.row==10){
	    [cell setText:@"경상남도보육정보센터"];  
	}else if(indexPath.row==11){
	    [cell setText:@"전남보육정보센터"]; 
	}else if(indexPath.row==12){
	    [cell setText:@"제주도보육정보센터"];    
	}else if(indexPath.row==13){
	    [cell setText:@"충청북도보육정보센터"];   
	}else if(indexPath.row==14){
	    [cell setText:@"경기도보육정보센터"]; 
	}else if(indexPath.row==15){
	    [cell setText:@"경상북도보육정보센터"];   
	}else if(indexPath.row==16){
	    [cell setText:@"전북보육정보센터"]; 
	}else if(indexPath.row==17){
	    [cell setText:@"충청남도보육정보센터"];    
	}else if(indexPath.row==18){
		[cell setText:@"강남구보육정보센터"];      
	}else if(indexPath.row==19){
	    [cell setText:@"강동구보육정보센터"];  
	}else if(indexPath.row==20){
	    [cell setText:@"관악구보육정보센터"]; 
	}else if(indexPath.row==21){
	    [cell setText:@"금천구보육정보센터"];    
	}else if(indexPath.row==22){
	    [cell setText:@"노원구보육정보센터"];   
	}else if(indexPath.row==23){
	    [cell setText:@"도봉구보육정보센터"]; 
	}else if(indexPath.row==24){
	    [cell setText:@"동작구보육정보센터"];   
	}else if(indexPath.row==25){
	    [cell setText:@"부평구보육정보센터"]; 
	}else if(indexPath.row==26){
	    [cell setText:@"서초구보육정보센터"];    
	}else if(indexPath.row==27){
		[cell setText:@"성동구보육정보센터"];      
	}else if(indexPath.row==28){
	    [cell setText:@"안산시보육정보센터"];  
	}else if(indexPath.row==29){
	    [cell setText:@"부천시보육정보센터"]; 
	}else if(indexPath.row==30){
	    [cell setText:@"안양시보육정보센터"];    
	}else if(indexPath.row==31){
	    [cell setText:@"성남시보육정보센터"];   
	}else if(indexPath.row==32){
	    [cell setText:@"의왕시보육정보센터"]; 
	}else if(indexPath.row==33){
	    [cell setText:@"강릉시보육정보센터"];   
	}else if(indexPath.row==34){
	    [cell setText:@"고양시보육정보센터"]; 
	}else if(indexPath.row==35){
	    [cell setText:@"진주시보육정보센터"];    
	}else if(indexPath.row==36){
		[cell setText:@"시흥시보육정보센터"];      
	}else if(indexPath.row==37){
	    [cell setText:@"이천시보육정보센터"];  
	}else if(indexPath.row==38){
	    [cell setText:@"평택시보육정보센터"]; 
	}else if(indexPath.row==39){
	    [cell setText:@"의정부시보육정보센터"];    
	}else if(indexPath.row==40){
	    [cell setText:@"서울특별시녹색장난감도서관"];   
	}else if(indexPath.row==41){
	    [cell setText:@"강동구 동동레코텍"]; 
	}else if(indexPath.row==42){
	    [cell setText:@"구로구 꿈나무장난감나라"];   
	}else if(indexPath.row==43){
	    [cell setText:@"금천구 장난감나라"]; 
	}else if(indexPath.row==44){
	    [cell setText:@"동작구 로야장난감대여점"];    
	}else if(indexPath.row==45){
		[cell setText:@"성동구 무지개장난감세상"];      
	}else if(indexPath.row==46){
	    [cell setText:@"용산구 아이노리장난감나라"];  
	}else if(indexPath.row==47){
	    [cell setText:@"서초구 놀이감도서관"]; 
	}else if(indexPath.row==48){
	    [cell setText:@"노원구 놀이아띠"];    
	}else if(indexPath.row==49){
	    [cell setText:@"열린유아교육학회"];   
	}else if(indexPath.row==50){
	    [cell setText:@"한국아동학회"]; 
	}else if(indexPath.row==51){
	    [cell setText:@"한국영유아보육학회"];   
	}else if(indexPath.row==52){
	    [cell setText:@"한국유아교육학회"]; 
	}else if(indexPath.row==53){
	    [cell setText:@"대한아동복지학회"];    
	}else if(indexPath.row==54){
		[cell setText:@"한국가족복지학회"];   
		
	}else if(indexPath.row==55){
	    [cell setText:@"한국부모교육학회"];   
	}else if(indexPath.row==56){
	    [cell setText:@"한국방과후아동지도학회"]; 
	}else if(indexPath.row==57){
	    [cell setText:@"한국보육시설연합회"];   
	}else if(indexPath.row==58){
	    [cell setText:@"서울시보육시설연합회"]; 
	}else if(indexPath.row==59){
	    [cell setText:@"서울시민간분과위원회"];    
	}else if(indexPath.row==60){
		[cell setText:@"서울시가정분과위원회"];   		
	}else if(indexPath.row==61){
	    [cell setText:@"서울시영아전담위원회"];   
	}else if(indexPath.row==62){
	    [cell setText:@"전국어린이집연합회"]; 
	}else if(indexPath.row==63){
	    [cell setText:@"(사)공동육아와 공동체교육"];   
	}else if(indexPath.row==64){
	    [cell setText:@"(사)어린이도서연구회"]; 
	}
	return cell;	
	
}

//테이블 셀 클릭시 실행 되는 메소드
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic
	
	//	int curIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	
	//	NSString * curID = [[childInfoServiceList objectAtIndex: curIndex] objectForKey: @"ChildInfoID"];
	//	NSLog(@"%@",curID); 
	/*
	 subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	 
	 SearchChildInfoFindOutdoorDetail *searchChildInfoFindOutdoorDetail= [[SearchChildInfoFindOutdoorDetail alloc] init];
	 [searchChildInfoFindOutdoorDetail passParaToXML:curID];
	 
	 NSLog(@"테이블 클릭 실행"); 
	 
	 CGRect newFrame = searchChildInfoFindOutdoorDetail.view.frame;
	 newFrame.size.height = newFrame.size.height -1;
	 searchChildInfoFindOutdoorDetail.view.frame = newFrame;
	 subview=searchChildInfoFindOutdoorDetail.view;	
	 [self.view addSubview:subview];*/
	
	NSURL *url =@"";
	if(indexPath.row== 0){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.educare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 1){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.kjedu.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 2){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.djcare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 3){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.icda.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 4){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.escac.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 5){
		NSURL *url = [[NSURL alloc] initWithString: @"http://children.seoul.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 6){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.tgcare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 7){
		NSURL *url = [[NSURL alloc] initWithString: @"http://busan.childcare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 8){
		NSURL *url = [[NSURL alloc] initWithString: @"http://ulsan.childcare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 9){
		NSURL *url = [[NSURL alloc] initWithString: @"http://gangwon.childcare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 10){
		NSURL *url = [[NSURL alloc] initWithString: @"http://gyeongnam.childcare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 11){
		NSURL *url = [[NSURL alloc] initWithString: @"http://jeonnam.childcare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 12){
		NSURL *url = [[NSURL alloc] initWithString: @"http://jeju.childcare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 13){
		NSURL *url = [[NSURL alloc] initWithString: @" http://www.cbeducare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 14){
		NSURL *url = [[NSURL alloc] initWithString: @"http://gyeonggi.childcare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 15){
		NSURL *url = [[NSURL alloc] initWithString: @"http://gyeongbuk.childcare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 16){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.jbcare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 17){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.cnicare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 18){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.gncare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 19){
		NSURL *url = [[NSURL alloc] initWithString: @"http://papanet.gangdong.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 20){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.gwanak.go.kr/educare/main.html"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 21){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.happycare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 22){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.nwccic.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 23){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.doccic.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 24){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.dccic.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 25){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.jbpeducare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 26){
		NSURL *url = [[NSURL alloc] initWithString: @"http://youngua.seocho.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 27){
		NSURL *url = [[NSURL alloc] initWithString: @"http://ccic.sd.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 28){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.ansanbo6.com/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 29){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.bucheoni.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 30){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.aycteducare.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 31){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.sneducare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 32){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.uweducare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 33){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.kneducare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 34){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.echild.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 35){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.jinjucare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 36){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.shccic.net/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 37){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.goodcare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 38){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.supercare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 39){
		NSURL *url = [[NSURL alloc] initWithString: @"http://icare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 40){
		NSURL *url = [[NSURL alloc] initWithString: @"http://children.seoul.go.kr/G_library/index.html"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 41){
		NSURL *url = [[NSURL alloc] initWithString: @"http://papanet.gangdong.go.kr/toyworld/search_toy01.php"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 42){
		NSURL *url = [[NSURL alloc] initWithString: @"http://toy.guro.go.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 43){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.toyworld.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 44){
		NSURL *url = [[NSURL alloc] initWithString: @"http://djtoy.linkone.co.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 45){
		NSURL *url = [[NSURL alloc] initWithString: @"http://sdtoy.linkone.co.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 46){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.yongsan-toy.or.kr/main.asp"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 47){
		NSURL *url = [[NSURL alloc] initWithString: @"http://youngua.seocho.go.kr"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 48){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.nwccic.or.kr/php/index.php?pno=030201"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 49){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.open33.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 50){
		NSURL *url = [[NSURL alloc] initWithString: @"http://childkorea.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 51){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.kce.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 52){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.ksece.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 53){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.daehancw.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 54){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.familywelfare.net/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 55){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.parentedu.net/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 56){
		NSURL *url = [[NSURL alloc] initWithString: @"http://afterschool.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 57){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.koreaeducare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 58){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.kseca.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 59){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.citycare.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 60){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.citycare06.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 61){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.idul06.com/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 62){
		NSURL *url = [[NSURL alloc] initWithString: @"http://kpnea.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 63){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.gongdong.or.kr/"];
		[[UIApplication sharedApplication] openURL:url];	
	}else if(indexPath.row== 64){
		NSURL *url = [[NSURL alloc] initWithString: @"http://www.childbook.org/"];
		[[UIApplication sharedApplication] openURL:url];	
	}							
	
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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
