//
//  VCountryRowTableViewCell.m
//  World_Countries
//
//  Created by George Gameal on 21/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "VCountryCell.h"

@implementation VCountryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
 //   [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)startWithCountry:(WCCountry*)country
{
    self.country=country;
    self.lblCountryName.text=self.country.name;
    
    NSString* flagImgString=[NSString stringWithFormat:@"%@.png",[self.country.code lowercaseString]];
    UIImage* img=[UIImage imageNamed:flagImgString];
    
    if(img!=nil)
    {
        [self.imgCountryFlag setImage:img];
    }
    else
        NSLog(@"no flag for the country");
    
   }

@end
