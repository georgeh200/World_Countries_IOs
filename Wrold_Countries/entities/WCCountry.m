//
//  WBCountry.m
//  World_Countries
//
//  Created by George Gameal on 21/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "WCCountry.h"
#import "AppDelegate.h"


@implementation WCCountry

 static NSString* MODEL_NAME=@"WC_COUNTRY_MODEL";


-(BOOL)save:(NSDictionary*)dic
{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];

    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    
    
    NSManagedObject* countryModel=[self getCountryModelByCode:self.code];
    NSError *error = nil;
    if(countryModel)
    {
       
        [countryModel setValue: self.code forKey:@"code"];
            [countryModel setValue:data forKey:@"dic"];
         [countryModel setValue:self.name forKey:@"name"];
        
            if (![context save:&error]) {
                return false;
            }
            return true;
        
    }
    
    
    
    
    
   
    countryModel = [NSEntityDescription
                 insertNewObjectForEntityForName:MODEL_NAME
                 inManagedObjectContext:context];
    
    [countryModel setValue: self.code forKey:@"code"];
     [countryModel setValue: self.name forKey:@"name"];
    [countryModel setValue:data forKey:@"dic"];
    
    
    
    
    
    if (![context save:&error]) {
        return false;
    }
    return true;
}

-(NSDictionary*)getCountryInfoByCode
{
     NSManagedObject* countryModel=[self getCountryModelByCode:self.code];
    if(countryModel==nil)
        return nil;
   NSData* data= [countryModel valueForKey:@"dic"];
    return (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}


-(NSManagedObject*)getCountryModelByCode:(NSString*)code
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:MODEL_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"code == %@", code];
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    if(results.count>0)
        return (NSManagedObject*)results[0];
    else return nil;
}


+(NSMutableArray*)listCountries
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:MODEL_NAME];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    
    NSMutableArray* arrCountries=[[NSMutableArray alloc]init];
    
    if(results!=nil)
        
    {
        NSManagedObject* object=nil;
        WCCountry* country=nil;
        
        for(int j=0;j<results.count;j++)
        {
            object=(NSManagedObject*)results[j];
            country=[[WCCountry alloc]init];
            country.code=[object valueForKey:@"code"];
            country.name=[object valueForKey:@"name"];
            [arrCountries addObject:country];
            country=nil;
            country=nil;
        }
    }
    
    return arrCountries;
}

@end
