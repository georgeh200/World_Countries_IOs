//
//  WorldCountries.m
//  World_Countries
//
//  Created by George Gameal on 22/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "WorldCountries.h"
#import "WCServices.h"

@implementation WorldCountries

+ (WorldCountries*) sharedInstance
{
    
    static WorldCountries* me = nil;
    if( me == nil ) {
        
        me = [[WorldCountries alloc] init];
        
    }
    
    return me;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.arrCountries=[[NSMutableArray alloc]init];
        self.arrFilteredCountries=[[NSMutableArray alloc]init];
    }
    
    return self;
    
}


-(WCCountry*)getCountry:(int)index
{
    return (WCCountry*)self.arrFilteredCountries[index];
}
-(int)getFilteredCountriesCount
{
    return self.arrFilteredCountries.count;
}

-(void)getFromCash:(void (^)())successCallback
{
    NSArray* arr=[WCCountry listCountries];
    
    if(arr.count>0)
    {
       
        [self setCountriesFromCash:arr];
        successCallback();
    }
}

-(void)getAllCountries:(void (^)())successCallback
withFailure:(void (^)(NSInteger statusCode))failureCallback
{
    
   
  
    [[WCServices sharedInstance]getAllcountries:^(id json) {
        
        [self parseCountriesJson:json];
        successCallback();
        [self performSelectorOnMainThread:@selector(saveCountriesFromJson:) withObject:json waitUntilDone:NO];
       

        
        
    } withFailure:^(NSInteger statusCode) {
        
      //  if(!cached)
        failureCallback(statusCode);
    }];
}

-(void)getCountryDetails:(WCCountry*)country withSuccess:(void (^)(NSDictionary* dic ))successCallback
             withFailure:(void (^)(NSInteger statusCode))failureCallback
{
    
    // get data from local cach
    NSDictionary* dic=  [country getCountryInfoByCode];
    
    if(dic!=nil)
        successCallback(dic);
    
        
    // refresh data from server
    [[WCServices sharedInstance]getCountryByCode:country.code withsuccess:^(id json) {
        
        successCallback(json[0]);
        
        [self performSelectorInBackground:@selector(saveCountriesFromJson:) withObject:json];
    } withFailure:^(NSInteger statusCode) {
        // we can view a notification for the user to be connected to get fresh data from server
    }];
    
    
}
-(void)setCountriesFromCash:(NSArray*)arr
{
    [self.arrCountries removeAllObjects];
    [self.arrFilteredCountries removeAllObjects];
    
    for(WCCountry* country in arr)
    {

        [self.arrCountries addObject:country];
        [self.arrFilteredCountries addObject:country];
    }
}
-(void)parseCountriesJson:(id)json
{
    [self.arrCountries removeAllObjects];
    [self.arrFilteredCountries removeAllObjects];
  
     WCCountry* country=nil;
    for(NSDictionary* dic in json)
    {
        country=[[WCCountry alloc]init];
        country.code=dic[@"alpha2Code"];
        country.name=dic[@"name"];
        [self.arrCountries addObject:country];
        [self.arrFilteredCountries addObject:country];
     
    }
}

-(void)saveCountriesFromJson:(id)json
{
    WCCountry* country=nil;
    for(NSDictionary* dic in json)
    {
        country=[[WCCountry alloc]init];
        country.code=dic[@"alpha2Code"];
        country.name=dic[@"name"];
        [country save:dic];
    }
}

-(void)filterCountries:(NSString*)filterText
{
    WCCountry* temp=nil;
    [self.arrFilteredCountries removeAllObjects];
    for(int j=0;j<self.arrCountries.count;j++)
    {
        temp=(WCCountry*)[self.arrCountries objectAtIndex:j];
        
        if(filterText==nil||[filterText isEqualToString:@""] ||([[temp.name lowercaseString] rangeOfString:filterText].location!=NSNotFound))
            [self.arrFilteredCountries addObject:temp];
    }
    
}

@end
