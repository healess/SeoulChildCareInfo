//  CalculateChildcareChaService.m
//  ChildService
//
//  Created by JUNG BUM SEO/SU SANG KIM on 12. 07. 13
//  Copyright 2012 JUNG BUM SEO/SU SANG KIM All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalculateChildcareChaService : UIViewController {
	IBOutlet UITextField *familyCount;
	IBOutlet UITextField *incomeMonth;
	IBOutlet UITextField *generalProperty;
	IBOutlet UITextField *FinanceProperty;
	IBOutlet UITextField *PrivateCar;
	IBOutlet UITextField *Dept;

	IBOutlet UILabel *recognizeIncome;
	IBOutlet UILabel *resultStandard;
	IBOutlet UILabel *detailStandard;
	
	
	NSMutableData *webData;
	NSXMLParser *xmlParser;
	NSString * currentElement;
	

}
@property(nonatomic, retain) IBOutlet UITextField *familyCount;
@property(nonatomic, retain) IBOutlet UITextField *incomeMonth;
@property(nonatomic, retain) IBOutlet UITextField *generalProperty;
@property(nonatomic, retain) IBOutlet UITextField *FinanceProperty;
@property(nonatomic, retain) IBOutlet UITextField *PrivateCar;
@property(nonatomic, retain) IBOutlet UITextField *Dept;


@property(nonatomic, retain) IBOutlet UILabel *recognizeIncome;
@property(nonatomic, retain) IBOutlet UILabel *resultStandard;
@property(nonatomic, retain) IBOutlet UILabel *detailStandard;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;


-(IBAction)buttonClick: (id) sender;
@end
