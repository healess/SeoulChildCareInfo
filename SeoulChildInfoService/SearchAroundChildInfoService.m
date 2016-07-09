//
//  SearchAroundChildInfoService.m
//  SeoulChildInfoService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//
/* 현 위치를 토데로 어린이집을 가져오는 부분 현 위치값만 가져오면 Data출력 가능
 
 */
#import "SearchAroundChildInfoService.h"
#import "SearchLocalChildInfoServiceContent.h"
#import "JSON.h"

@implementation SearchAroundChildInfoService
@synthesize locationManager;
@synthesize centerLocationLat,centerLocationLong;
@synthesize locationLat,locationLong;
@synthesize inputAddress;
@synthesize addre;
@synthesize villagename;
@synthesize renew;
@synthesize activityIndicator;
@synthesize mapView;
@synthesize centerLocationAnnotation;
@synthesize locationAnnotation;
@synthesize kinderAnnotanions;
@synthesize region;
@synthesize span;
@synthesize isOneKindergarten;
@synthesize isFirstQuery;
@synthesize webData, soapResults,xmlParser; //FOR SOAP

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


/*==========================================================================================================================
 최초 View 로드시..버튼한번 눌러주는 효과.
 ==========================================================================================================================*/
- (void)viewDidLoad 
{
	
    [super viewDidLoad];
	//테이블상단 버튼 추가를 위한 툴바 추가
	
	/*
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
	
	
	//지도초기화
	mapView.showsUserLocation=NO;
	mapView.mapType=MKMapTypeStandard;
	mapView.delegate=self;
	
	//위치 업데이트 서비스를 시작한다.
	self.locationManager=[[CLLocationManager alloc] init];
	self.locationManager.delegate=self;	
	
	
	//kinderAnnotanions 배열초기화
	kinderAnnotanions=[[NSMutableArray alloc]init];
	
	
	//처음에  새쿼리다.
	self.isFirstQuery=TRUE;
	
	
	//서울특별시로 처음에 한번 표시
	////[self GET_LATLONG_BY_ADDRESS:[@"대한민국 서울특별시 중구 덕수궁길 15" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	//[self GET_LATLONG_BY_ADDRESS:[@"대한민국 서울특별시 종로구" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	//처음에 내 위치 한번 표시
	if(self.isOneKindergarten==FALSE)
	{
		[self POINT_MY_POSITION];	
	}
}

/*==========================================================================================================================
 뒤로가기
 ==========================================================================================================================*/
-(IBAction) GO_BACK
{
	[self.navigationController popViewControllerAnimated:YES];
}

/*==========================================================================================================================
 주소로 지도에 위치를 표시한다(버튼클릭)
 ==========================================================================================================================*/
- (IBAction) POINT_POSITON_ON_MAP_BY_ADDRESS
{
	//인디케이터 작동
	activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50 )];
	[activityIndicator setCenter:self.view.center];
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[self.view addSubview:activityIndicator];	
	[activityIndicator startAnimating];        
	[activityIndicator setHidden:NO];
	[renew setEnabled:NO];
	
	//키보드를 숨긴다.
	[self.inputAddress resignFirstResponder];
	
	//새쿼리다.
	self.isFirstQuery=TRUE;
	
	//주소로 위경도 얻어오기
	NSLog(@"주소입력값:%@",self.inputAddress.text);
	
	
	//유치원한군데만 나타내나.
	NSLog(@"isOneKindergarten=%u",isOneKindergarten);
	if(isOneKindergarten==TRUE)
	{
		NSLog(@"유치원한군데만 나타내라네요");
	}
	[self GET_LATLONG_BY_ADDRESS:[self.inputAddress.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	
	//인디케이터죽이기
	[activityIndicator stopAnimating];        
	[activityIndicator setHidden:YES];
	[renew setEnabled:YES];	
	
	
	
	
}
/*==========================================================================================================================
 주소를 던져주면 위경도 정보를 알아내어 지도에 표시해 준다.
 ==========================================================================================================================*/
-(void) GET_LATLONG_BY_ADDRESS:(NSString*)address
{
	//Google GeoCode 읽어오기
	NSString *urlString=[@"http://maps.googleapis.com/maps/api/geocode/json?address=" stringByAppendingString:address];
	urlString=[urlString stringByAppendingString:@"&sensor=true&language=ko"];
	//NSLog(@"%@",urlString);
	NSURL *url=[NSURL URLWithString:urlString];
	
	
	//결과를 스트링으로 받아와서..(JSON 형태로 되어있다)
	NSString *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	NSDictionary *JSONResult=[jsonString JSONValue];
	NSLog(@"%@",jsonString);
	
	NSArray *results;
	NSDictionary *node;
	NSString *formatted_address;
	NSString *village_name;
	NSString *city_name=nil;
	
	if([[JSONResult objectForKey:@"status"] isEqualToString:@"OK"])
	{
		
		//JSON 결과값 가져오기
		results=[JSONResult objectForKey:@"results"];
		
		//Node 하나 가져오기
		if(self.isFirstQuery)
		{
			//행정구역이 전국구로 서로 겹칠때 (ex. 대치) 서울것만 가져온다.
			for(int i=0;i<[results count];i++)
			{
				if([city_name isEqualToString:@"서울특별시"])
				{
					break;
				}
				//동이름으로 검색된 여러개의 결과 중에서 도시이름 가져오기
				node=[results objectAtIndex:i];
				for(int j=0;j<[[node objectForKey:@"address_components"] count];j++)
				{
					if([[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] count]==2)
					{
						if([[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"locality"] &&
						   [[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:1] isEqualToString:@"political"]
						   )
						{
							city_name=[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"long_name"];
							
						}
					}	
				}
			}	
			
		}
		else
		{
			//여러개가 리턴된 주소 정보에서 행정구역 정보만 가져와서 동이름만 가져온다.
			for(int i=0;i<[results count];i++)
			{
				node=[results objectAtIndex:i];
				if([[node objectForKey:@"types"] count]==1)
				{
					if([[[node objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"political"])
					{
						NSLog(@"political 발견");
						break;
					}
				}
			}
		}
		
		
		//주소가져오기
		formatted_address=[node objectForKey:@"formatted_address"];
		
		//위경도가져오기
		NSString *lat=[[[node objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
		NSString *lng=[[[node objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
		self.locationLat  = [lat doubleValue];
		self.locationLong = [lng doubleValue];
		
		//동이름 가져오기
		for(int j=0;j<[[node objectForKey:@"address_components"] count];j++)
		{
			if([[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] count]==2)
			{
				if([[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"sublocality"] &&
				   [[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:1] isEqualToString:@"political"]
				   )
				{
					village_name=[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"long_name"];
					break;
				}
			}	
		}
		
		//도시이름 가져오기
		for(int j=0;j<[[node objectForKey:@"address_components"] count];j++)
		{
			if([[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] count]==2)
			{
				if([[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"locality"] &&
				   [[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:1] isEqualToString:@"political"]
				   )
				{
					city_name=[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"long_name"];
					break;
				}
			}	
		}
		
		
		
		//찍어본다
		NSLog(@"주소로 위경도 검색(전체주소):%@",formatted_address);
		NSLog(@"주소로 위경도 검색(가져온 동명칭):%@",village_name);
		NSLog(@"주소로 위경도 검색(가져온 도시명칭):%@",city_name);
		
		
		//Location 정보
		CLLocationCoordinate2D location;
		location.latitude	=self.locationLat;
		location.longitude=self.locationLong;	
		
		//최초호출이라면
		if(self.isFirstQuery)
		{
			NSLog(@"=========새검색시작======");
			
			//현위치의 Annotation 추가
			[mapView removeAnnotation:centerLocationAnnotation];//이전것을 일단 클리어
			if(centerLocationAnnotation)
			{
				[centerLocationAnnotation release];
			}
			centerLocationAnnotation=[[LocationAnnotation alloc] initWithCoordinate:location];
			//[centerLocationAnnotation setCurrentTitle:[node objectForKey:@"FacilityName"]];
			//[centerLocationAnnotation setCurrentSubTitle:[node objectForKey:@"Address"]];
			//[centerLocationAnnotation setCurrentFacilityID:[node objectForKey:@"FacilityID"]];
			[centerLocationAnnotation setCurrentCenter:TRUE];
			[mapView addAnnotation:centerLocationAnnotation];
			
			
			//전환후
			self.isFirstQuery=FALSE;
			
			//주소를 라벨에 한번 찍어 주고
			self.addre.text=[@"주소:" stringByAppendingString:formatted_address];
			self.villagename.text=[@"검색기준:" stringByAppendingString:village_name];
			
			//중심좌표를 기억한다.
			self.centerLocationLat	=self.locationLat;
			self.centerLocationLong	=self.locationLong;
			
			//CenterLocation 정보(검색의 중심점)
			CLLocationCoordinate2D centerLocation;
			centerLocation.latitude	=self.centerLocationLat;
			centerLocation.longitude=self.centerLocationLong;
			
			//확대비율과 중심점.
			span.latitudeDelta=0.05;
			span.longitudeDelta=0.05;
			region.span=span;
			region.center=centerLocation;
			[mapView setRegion:region animated:FALSE];
			[mapView regionThatFits:region];
			
			
			//서울특별시로 검색하지 않았을 경우
			if(![city_name isEqualToString:@"서울특별시"])
			{
				[self ShowMessageBox:@"서울시특별시에 없는 행정구역 명입니다. \n보육시설 검색은 서울특별시만 가능합니다."];
				return;
			}
			
			
			//SOAP 호출해서 주변 유치원 정보를 가져온다.
			if(isOneKindergarten==FALSE)
			{
				//village_name=self.inputAddress.text;
				[self GET_KINDERGARTEN_INFO_BY_VILLAGE_NAME:village_name];
			}

			
		}
		
	}
	else
	{
		[self ShowMessageBox:@"올바른 주소를 입력해 주십시요."];
		NSLog(@"구글 GeoCoding 서비스 에러: 올바른 주소를 입력해 주십시요."); 
		return;
		
	}
	
}


/*==========================================================================================================================
 내위치를 지도에 표시해 준다 (버튼클릭)
 ==========================================================================================================================*/
-(IBAction) POINT_MY_POSITION
{
	//인디케이터 작동
	activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50 )];
	[activityIndicator setCenter:self.view.center];
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[self.view addSubview:activityIndicator];	
	[activityIndicator startAnimating];        
	[activityIndicator setHidden:NO];
	[renew setEnabled:NO];
	
	NSLog(@"현위치로.......");
	
	//키보드를 숨긴다.
	[self.inputAddress resignFirstResponder];
	
	//텍스트박스 클리어
	inputAddress.text=@"";
	
	//새쿼리다.
	self.isFirstQuery=TRUE;
	
	//위치업데이트 서비스 실시
	[self.locationManager startUpdatingLocation];
	
	//인디케이터죽이기
	[activityIndicator stopAnimating];        
	[activityIndicator setHidden:YES];
	[renew setEnabled:YES];
	

}

/*==========================================================================================================================
 위치정보가 업데이트 될때마다 자동으로 호출되는 CallBack 메소드
 ==========================================================================================================================*/
-(void) locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation*) newLocation 
		   fromLocation:(CLLocation*)oldLocation
{
	
	//위치변경이 없다면
	if((self.locationLat==newLocation.coordinate.latitude)&&(self.locationLong==newLocation.coordinate.longitude))
	{
		NSLog(@"위치변동없음");
		//return;
	}
	
	//좌표정보업데이트
	self.locationLat  = newLocation.coordinate.latitude;
	self.locationLong = newLocation.coordinate.longitude;
	
	//////////////////////////////////////////////테스트(서울시를 돌아다닐 수는 없으므로)//////////////////////////////////////////////
	//self.locationLat=37.55675290;
	//self.locationLong=126.94929550;
	
	//위도경도 스트링 변환
	NSString *Lat=[[NSString alloc] initWithFormat:@"%f",self.locationLat];
	NSString *Long=[[NSString alloc] initWithFormat:@"%f",self.locationLong];
	NSString *LatLong;		
	LatLong=[Lat stringByAppendingString:@","];
	LatLong=[LatLong stringByAppendingString:Long];
	NSLog(@"%@",LatLong);
	
	
	//URL 구성
	NSString *urlString;
	urlString=[@"http://maps.googleapis.com/maps/api/geocode/json?latlng=" stringByAppendingString:LatLong];
	urlString=[urlString stringByAppendingString:@"&sensor=false"];
	NSURL *url=[NSURL URLWithString:urlString];
	
	
	//결과를 스트링으로 받아와서..(JSON 형태로 되어있다)
	NSString *jsonString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	NSDictionary *JSONResult=[jsonString JSONValue];
	//NSLog(@"%@",jsonString);
	
	NSDictionary *node;
	NSString *formatted_address;
	NSString *village_name;
	NSString *city_name;
	
	
	if([[JSONResult objectForKey:@"status"] isEqualToString:@"OK"])
	{
		NSArray *results=[JSONResult objectForKey:@"results"];
		
		//여러개가 리턴된 주소 정보에서 행정구역 정보만 가져와서 동이름만 가져온다.
		for(int i=0;i<[results count];i++)
		{
			node=[results objectAtIndex:i];
			if([[node objectForKey:@"types"] count]==1)
			{
				if([[[node objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"political"])
				{
					NSLog(@"political 발견");
					break;
				}
			}
		}
		
		//주소가져오기
		formatted_address=[node objectForKey:@"formatted_address"];
		
		//동이름 가져오기
		for(int j=0;j<[[node objectForKey:@"address_components"] count];j++)
		{
			if([[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] count]==2)
			{
				if([[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"sublocality"] &&
				   [[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:1] isEqualToString:@"political"]
				   )
				{
					village_name=[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"long_name"];
					break;
				}
			}	
			
		}
		
		//도시이름 가져오기
		for(int j=0;j<[[node objectForKey:@"address_components"] count];j++)
		{
			if([[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] count]==2)
			{
				if([[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"locality"] &&
				   [[[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"types"] objectAtIndex:1] isEqualToString:@"political"]
				   )
				{
					city_name=[[[node objectForKey:@"address_components"] objectAtIndex:j] objectForKey:@"long_name"];
					break;
				}
			}	
		}
		
		NSLog(@"위경도로 주소검색(전체주소):%@",formatted_address);
		NSLog(@"위경도로 주소검색(가져온 동명칭):%@",village_name);
		NSLog(@"위경도로 주소검색(가져온 도시명칭):%@",city_name);
		
		
		
		//Location 정보
		CLLocationCoordinate2D location;
		location.latitude	=self.locationLat;
		location.longitude	=self.locationLong;
		
		
		//최초호출이라면
		if(self.isFirstQuery)
		{
			
			//현위치의 Annotation 추가
			[mapView removeAnnotation:centerLocationAnnotation];//이전것을 일단 클리어
			if(centerLocationAnnotation)
			{
				[centerLocationAnnotation release];
			}
			centerLocationAnnotation=[[LocationAnnotation alloc] initWithCoordinate:location];
			[centerLocationAnnotation setCurrentCenter:TRUE];
			[mapView addAnnotation:centerLocationAnnotation];
			
			
			//전환후
			self.isFirstQuery=FALSE;
			
			//주소를 라벨에 한번 찍어 주고
			self.addre.text=[@"주소:" stringByAppendingString:formatted_address];
			self.villagename.text=[@"검색기준:" stringByAppendingString:village_name];
			
			//중심좌표를 기억한다.
			self.centerLocationLat	=self.locationLat;
			self.centerLocationLong	=self.locationLong;
			
			//위치정보 업데이트 STOP
			[self.locationManager stopUpdatingLocation];
			
			//CenterLocation 정보(검색의 중심점)
			CLLocationCoordinate2D centerLocation;
			centerLocation.latitude	=self.centerLocationLat;
			centerLocation.longitude=self.centerLocationLong;
			
			//확대비율과 중심점.
			span.latitudeDelta=0.05;
			span.longitudeDelta=0.05;
			region.span=span;
			region.center=centerLocation;
			[mapView setRegion:region animated:FALSE];
			[mapView regionThatFits:region];
			
			//서울특별시로 검색하지 않았을 경우
			if(![city_name isEqualToString:@"서울특별시"])
			{
				[self ShowMessageBox:@"현위치는 서울특별시가 아닙니다.\n주변 보육시설 검색은 서울특별시만 가능합니다."];
				return;
			}
			
			
			//SOAP 호출해서 주변 유치원 정보를 가져온다.
			[self GET_KINDERGARTEN_INFO_BY_VILLAGE_NAME:village_name];
		}
	}
	else
	{
		[self ShowMessageBox:@"올바른 주소를 입력해 주십시요."];
		NSLog(@"구글 GeoCoding 서비스 에러: 올바른 주소를 입력해 주십시요."); 
		return;
	}
	
	
}
/*==========================================================================================================================
 현재위치를 가져오지 못했을때..
 ==========================================================================================================================*/
-(void) locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error
{
	[self ShowMessageBox:@"인터넷에 연결되어 있지 않거나. 구글 지도서비스 장애 입니다..\n 3G 혹은 와이파이망을 확인해 주시거나 잠시후 다시 시도해 주세요"];
}
/*==========================================================================================================================
 annotation 이미지를 보여준다.
 ==========================================================================================================================*/
-(MKAnnotationView*) mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>) annotation
{
	MKAnnotationView *annView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	
	UIButton *btnDetailInfo=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	btnDetailInfo.frame=CGRectMake(0,0,23,23);
	btnDetailInfo.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
	btnDetailInfo.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
	
	annView.rightCalloutAccessoryView=btnDetailInfo;
	
	LocationAnnotation *temp=annView.annotation;
	if([temp currentCenter])
	{
		if(self.isOneKindergarten==TRUE)
		{
			annView.image=[UIImage imageNamed:@"kindergarten.png"];
			self.isOneKindergarten=FALSE;
		}
		else
		{
			annView.image=[UIImage imageNamed:@"myposition.png"];
		}

	}
	else
	{
		annView.image=[UIImage imageNamed:@"kindergarten.png"];
		//NSLog(@"=========kindergarten.png======");
	}
	
	annView.canShowCallout=YES;
	return annView;
	
}
/*==========================================================================================================================
 annotation 이미지를 터치할때.
 ==========================================================================================================================*/
-(void) mapView:(MKMapView*)mapView annotationView:(MKAnnotationView*)view calloutAccessoryControlTapped:(UIControl*)control
{
	
	//현재선택된 annotation 가지고 오기		
	LocationAnnotation *ann=view.annotation;
	
	
	/*
	//subview 초기화
	subview = [[UIView alloc] initWithFrame:CGRectMake(30,30,250,350)];
	
	//원격함수호출(facilityID전달)
	SearchLocalChildInfoServiceContent *searchLocalChildInfoServiceContent= [[SearchLocalChildInfoServiceContent alloc] init];
	[searchLocalChildInfoServiceContent passParaToXML:ann.facilityID];
	
	//subview 활성화	
	CGRect newFrame = searchLocalChildInfoServiceContent.view.frame;
	newFrame.size.height = newFrame.size.height -1;
	searchLocalChildInfoServiceContent.view.frame = newFrame;
	subview=searchLocalChildInfoServiceContent.view;	
	[self.view addSubview:subview];	
	*/
	
	
	SearchLocalChildInfoServiceContent *searchLocalChildInfoServiceContent =
	[[SearchLocalChildInfoServiceContent alloc] initWithNibName:@"SearchLocalChildInfoServiceContent" bundle:nil];
	[searchLocalChildInfoServiceContent passParaToXML:ann.facilityID];
	[self.navigationController  pushViewController:searchLocalChildInfoServiceContent animated:YES];
	[searchLocalChildInfoServiceContent release];
	
}



/*==========================================================================================================================
 "동이름"을 인자로 받아 서울시 공공정보 API 를 호출한다.
 ==========================================================================================================================*/
-(void) GET_KINDERGARTEN_INFO_BY_VILLAGE_NAME:(NSString*)VillageName
{
	//NSString *VillageName=@"대치2동";
	NSString *inputFacilityName=@"";
	
	NSLog(@"XML확인");
	
	childInfoServiceList = [[NSMutableArray alloc] init];
	
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
							 "<Region></Region>\n" //자치구 코드
							 "<District>%@</District>\n" //자치구 내 동
							 "<CRTypePublic>N</CRTypePublic>\n" //시설유형-국공립(Y/N)
							 "<CRTypeCorporate>N</CRTypeCorporate>\n" //시설유형-법인(Y/N)
							 "<CRTypePrivate>N</CRTypePrivate>\n" //시설유형-민간(Y/N)
							 "<CRTypeHome>N</CRTypeHome>\n"  //시설유형-가정(Y/N)
							 "<CRTypeParent>N</CRTypeParent>\n" //시설유형-부모협동(Y/N)
							 "<CRTypeJob>N</CRTypeJob>\n" //시설유형-직장(Y/N)
							 "<CRSpecSeoul>N</CRSpecSeoul>\n"  //시설특성-서울형어린합집(Y/N)
							 "<CRSpecDisableTotal>N</CRSpecDisableTotal>\n" //시설특성-장애아통합(Y/N)
							 "<CRSpecDisableFull>N</CRSpecDisableFull>\n" //시설특성-장애아전담(Y/N)
							 "<CRSpecMultiCul>N</CRSpecMultiCul>\n" //시설특성-다문화시설(Y/N)
							 "<CRSpecBaby>N</CRSpecBaby>\n"  //시설특성-영아전담시설(Y/N)
							 "<CRSpecTime>N</CRSpecTime>\n"  //시설특성-시간연장(Y/N)
							 "<CRSpecTimeAS>N</CRSpecTimeAS>\n" //시설특성-방과후전담(Y/N)
							 "<Certification>N</Certification>\n" //평가인증유무(Y/N)
							 "<Vehicle></Vehicle>\n"  //차량운행여부(Y/N)
							 "<FacilityName></FacilityName>\n"  //시설명
							 "<PageNum>1</PageNum>\n"   //페이지번호
							 "</q0:LocalChildFacilityListRequest>\n"
							 "</soapenv:Body>\n"
							 "</soapenv:Envelope>\n",VillageName , inputFacilityName //파라미터 추가해야함
							 ];
	
	
	NSLog(@"%@",soapMessage);
	
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
	[webData appendData:data];//받아온 data 를...
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	[connection release];
	[webData release];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"결과확인 XML");
	//NSLog(@"%@",theXML);
	
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
	if ([elementName isEqualToString:@"FacilityName"]) 
	{	
		item = [[NSMutableDictionary alloc] init];
		currentFacilityName = [[NSMutableString alloc] init];
		currentAddress=[[NSMutableString alloc] init];//주소
		currentTelephone = [[NSMutableString alloc] init];
		currentFacilityID = [[NSMutableString alloc] init];	
	}
}


//XML내 항목 값을 가져와서 변수에 담음
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if ([currentElement isEqualToString:@"FacilityName"])
	{
		[currentFacilityName appendString:string];
		//NSLog(@"%@",string);
	} 
	else if ([currentElement isEqualToString:@"Address"]) 
	{
		[currentAddress appendString:string];
		//NSLog(@"%@",string);
	}
	else if ([currentElement isEqualToString:@"Telephone"]) 
	{
		[currentTelephone appendString:string];
	}
	else if ([currentElement isEqualToString:@"FacilityID"]) 
	{
		[currentFacilityID appendString:string];
	}
}


//XML로딩 종료시 실행
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	//NSLog(@"didEndElement %@", elementName); 
	
	if( [elementName isEqualToString:@"FacilityName"])
	{
		[item setObject:currentFacilityName forKey:@"FacilityName"];
		[item setObject:currentAddress		forKey:@"Address"];
		[item setObject:currentTelephone forKey:@"Telephone"];
		[item setObject:currentFacilityID forKey:@"FacilityID"];
		[childInfoServiceList addObject:[item copy]];
		//		recordResults = FALSE;
	}
}

//XML의 경우 서버와의 통신으로 데이터 수신에 시간이 걸림 아래 메소드는 최종 로딩 후 호출
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	NSLog(@"all done!");
	NSLog(@"childInfoServiceList array has %d items", [childInfoServiceList count]);
	//[self.view reloadData];
	
	
	NSMutableDictionary *node;
	CLLocationCoordinate2D location;
	
	
	//이전것들을 클리어
	[mapView removeAnnotations:kinderAnnotanions];
	
	
	for(int i=0;i<[childInfoServiceList count];i++)
	{
		
		node=[childInfoServiceList objectAtIndex:i];
		NSLog(@"[%0d]%@",i,[node objectForKey:@"Address"]);
		[self GET_LATLONG_BY_ADDRESS:[[node objectForKey:@"Address"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		
		
		//Location 정보
		location.latitude	=self.locationLat;
		location.longitude=self.locationLong;
		
		
		//Annotataion추가
		locationAnnotation=[[LocationAnnotation alloc] initWithCoordinate:location];
		[locationAnnotation setCurrentTitle:[node objectForKey:@"FacilityName"]];
		[locationAnnotation setCurrentSubTitle:[node objectForKey:@"Address"]];
		[locationAnnotation setCurrentFacilityID:[node objectForKey:@"FacilityID"]];
		[locationAnnotation setCurrentCenter:FALSE];
		[mapView addAnnotation:locationAnnotation];
		[kinderAnnotanions addObject:locationAnnotation]; //annotation 배열에추가
		[locationAnnotation release]; 
		
	}
	
	
	//보육시설이 없을경우
	if( [childInfoServiceList count]==0)
	{
		[self ShowMessageBox:@"주변에 보육시설이 없습니다."];
	}
	
}

//상단 툴바내 버튼 클릭 시 호출 메소드 (뒤로가기)
- (void)action 
{
	[self.view removeFromSuperview];
	
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


- (void)dealloc 
{
    [super dealloc];
	[kinderAnnotanions dealloc];
}

@end
