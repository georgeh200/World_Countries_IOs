//
//  CountryViewController.h
//  World_Countries
//
//  Created by George Gameal on 21/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCCountry.h"
@interface CountryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnAllCountries;

@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIImageView *imgFlag;

@property (weak, nonatomic) IBOutlet UILabel *lblCountryName;

@property (weak, nonatomic) IBOutlet UILabel *lblCapital;


@property (weak, nonatomic) IBOutlet UILabel *lblCallingCode;

@property (weak, nonatomic) IBOutlet UILabel *lblPopulation;

@property (weak, nonatomic) IBOutlet UITextView *txtDetails;

@property(weak,nonatomic)WCCountry* country;
@property(strong,nonatomic)NSDictionary* countryInfo;

- (IBAction)btnAllCountriestouchUpInside:(id)sender;

@end
