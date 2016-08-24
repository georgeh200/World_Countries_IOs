
//  Created by George Kastour on 01/10/15.
//  Copyright © 2015 George. All rights reserved.
//

#import "AFBridge.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLRequestSerialization.h"

@implementation AFBridge

+(void)executeRequest:(NSString*)link withMothod:(NSString*)method withParameters:(NSDictionary*)parameters
          withSuccess:(void (^)(id json))successBlock withFailure:(void (^)(NSInteger statusCode))failureBlock
{
    
    
    
  
    
    
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     manager.requestSerializer=[AFJSONRequestSerializer serializer ];
   
    
    
    if([method isEqualToString:@"GET"])
    {
        

       
        [manager GET:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            successBlock(responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            failureBlock(operation.response.statusCode);
            
        }];
        
    }else if([method isEqualToString:@"POST"])
    {
        
        if(parameters==nil)
            parameters  = [NSMutableDictionary dictionary];
        [AFBridge printJson:parameters];
       
        
        [manager POST:link parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
             successBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
            failureBlock(operation.response.statusCode);
            
        }];
    }
    else if([method isEqualToString:@"PUT"])
    {
        if(parameters==nil)
            parameters  = [NSMutableDictionary dictionary];
        
        
        [manager PUT:link parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",link);
             [AFBridge printJson:parameters];
            [AFBridge printJson:responseObject];
            successBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            failureBlock(operation.response.statusCode);
            
        }];
    }

    else if([method isEqualToString:@"DELETE"])
    {
        
        
        [manager DELETE:link parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            successBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            failureBlock(operation.response.statusCode);
            
        }];
    }
    
    

    
}





+ (void) printJson:(NSDictionary *)param
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        
    } else
    {
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json: %@", jsonString);
    }
}












@end
