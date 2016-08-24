//
//  WBCountry.h
//  World_Countries
//
//  Created by George Gameal on 21/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WCCountry : NSObject

@property(copy,nonatomic) NSString* name;
@property(copy,nonatomic) NSString* code;

-(BOOL)save:(NSDictionary*)dic;
-(NSDictionary*)getCountryInfoByCode;
+(NSMutableArray*)listCountries;
@end
