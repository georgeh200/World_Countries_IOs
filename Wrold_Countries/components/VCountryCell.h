//
//  VCountryRowTableViewCell.h
//  World_Countries
//
//  Created by George Gameal on 21/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WCCountry.h"
@interface VCountryCell : UITableViewCell

@property(weak,nonatomic) WCCountry* country;

@property (weak, nonatomic) IBOutlet UILabel *lblCountryName;
@property (weak, nonatomic) IBOutlet UIImageView *imgCountryFlag;

-(void)startWithCountry:(WCCountry*)country;

@end
