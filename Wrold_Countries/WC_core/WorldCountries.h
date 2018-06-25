//
//  WorldCountries.h
//  World_Countries
//
//  Created by George Gameal on 22/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCCountry.h"
@interface WorldCountries : NSObject

+ (WorldCountries*) sharedInstance;



@property(strong,nonatomic)NSMutableArray* arrCountries;
@property(strong,nonatomic)NSMutableArray* arrFilteredCountries;
-(void)getFromCash:(void (^)())successCallback;
-(void)getAllCountries:(void (^)())success
           withFailure:(void (^)(NSInteger statusCode))failure;

-(void)getCountryDetails:(WCCountry*)country withSuccess:(void (^)(NSDictionary* dic ))successCallback
             withFailure:(void (^)(NSInteger statusCode))failureCallback;

-(void)filterCountries:(NSString*)filterText;
-(WCCountry*)getCountry:(int)index;
-(int)getFilteredCountriesCount;


@end
