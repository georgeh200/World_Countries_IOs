
//  Created by George Gameal on 24/01/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCServices : NSObject

@property(nonatomic,copy) NSString* host;
@property(nonatomic,copy) NSString* version;
@property(nonatomic,copy) NSString* url;

@property(nonatomic,strong) NSDictionary* urlDictionary;
+ (WCServices*) sharedInstance;




-(void) getAllcountries:(void (^)(id json))success
             withFailure:(void (^)(NSInteger statusCode))failure;
-(void) getCountryByCode:(NSString*) code withsuccess: (void (^)(id json))success
            withFailure:(void (^)(NSInteger statusCode))failure;

@end
