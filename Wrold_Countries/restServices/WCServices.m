
//  Created by George Gameal on 24/01/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "WCServices.h"
#import "AFBridge.h"

@implementation WCServices


+ (WCServices*) sharedInstance
{
    
    static WCServices* me = nil;
    if( me == nil ) {
        //    [AFBridge testPUT];
        me = [[WCServices alloc] init];
       
    }
    
    return me;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSString * pathString = [[NSBundle mainBundle] pathForResource:@"services" ofType:@"plist"];
        
        self.urlDictionary = [NSDictionary dictionaryWithContentsOfFile:pathString];
        
        self.host = [self.urlDictionary objectForKey:@"host"];
       
        self.version=[self.urlDictionary objectForKey:@"version"];
        
        self.url=[NSString stringWithFormat:@"%@/%@",self.host,self.version];
        
    }
    
    return self;
    
}




-(void) getAllcountries:(void (^)(id json))success
             withFailure:(void (^)(NSInteger statusCode))failure
{
   
    
    
    NSDictionary * itemDictionary =[self.urlDictionary objectForKey:@"all-countries"];
    NSString * link = [itemDictionary objectForKey:@"link"];
    NSString * method = [itemDictionary objectForKey:@"type"];
    
   
    NSString * fullLink = [NSString stringWithFormat:@"%@%@",self.url,link];
    
    
   
    [AFBridge executeRequest:fullLink withMothod:method withParameters:nil  withSuccess:^(id JSON) {
        
        if(success)
            success(JSON);
        
        
    } withFailure:^(NSInteger statusCode) {
        if(failure)
            failure(statusCode);
        
    } ];


}


-(void) getCountryByCode:(NSString*) code withsuccess: (void (^)(id json))success
             withFailure:(void (^)(NSInteger statusCode))failure
{
    
    NSDictionary * itemDictionary =[self.urlDictionary objectForKey:@"load-country-by-code"];
    NSString * link = [itemDictionary objectForKey:@"link"];
    NSString * method = [itemDictionary objectForKey:@"type"];
    
    
    NSString * fullLink = [NSString stringWithFormat:@"%@%@%@",self.url,link,code];
    
    
    
    [AFBridge executeRequest:fullLink withMothod:method withParameters:nil  withSuccess:^(id JSON) {
        
        if(success)
            success(JSON);
        
        
    } withFailure:^(NSInteger statusCode) {
        if(failure)
            failure(statusCode);
        
    } ];
    
    
}












@end