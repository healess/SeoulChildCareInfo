//
//  SearchChildInfoFindOutdoor.h
//  SeoulChildInfoService
//
//  Created by Susang Kim on 12. 8. 15..
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchChildInfoFindOutdoor : UIViewController {
    UIView *subview;
	IBOutlet UISegmentedControl *segRegion;
	NSString *regionValue;
	
}
@property (nonatomic,retain) IBOutlet UISegmentedControl *segRegion;

-(IBAction) segRegionSelected;
-(IBAction)searchMuseum: (id) sender;
-(IBAction)searchPalace: (id) sender;
-(IBAction)searchGarden: (id) sender;
-(IBAction)searchTema: (id) sender;
-(IBAction)searchPark: (id) sender;
-(IBAction)searchPerform: (id) sender;
-(IBAction)searchExp: (id) sender;
-(IBAction)searchEtc: (id) sender;

@end
