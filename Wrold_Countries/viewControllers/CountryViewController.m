//
//  CountryViewController.m
//  World_Countries
//
//  Created by George Gameal on 21/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CountryViewController.h"
#import "HeaderViewController.h"
#import "WorldCountries.h"

@interface CountryViewController ()

@end

@implementation CountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HeaderViewController *headerView = [storyboard instantiateViewControllerWithIdentifier:@"HeaderView"];
    headerView.view.frame = self.header.bounds;
    [self.header addSubview:headerView.view];
    [self addChildViewController:headerView];
    
    [self viewBasicInfo];
    [ self getCountryDetails];
    
    
}

-(void)getCountryDetails
{
    
   
   
    
    [[WorldCountries sharedInstance]getCountryDetails:self.country withSuccess:^(NSDictionary *dic) {
         [self performSelectorOnMainThread:@selector(viewDetails:) withObject:dic waitUntilDone:NO];
    } withFailure:^(NSInteger statusCode) {
        // we can notify the user to connect to get fresh data as current data is offline
    }];
    
    
}



-(void)viewBasicInfo
{
    
    self.lblCountryName.text=self.country.name;
    NSString* flagImgString=[NSString stringWithFormat:@"%@.png",[self.country.code lowercaseString]];
    UIImage* img=[UIImage imageNamed:flagImgString];
    
    if(img!=nil)
    {
        [self.imgFlag setImage:img];
    }
    else
        NSLog(@"no flag for the country");
}

-(void)viewDetails:(NSDictionary*)dic
{
    self.lblCallingCode.text=[dic[@"callingCodes"] componentsJoinedByString:@","];
    self.lblCapital.text=dic[@"capital"];
    self.lblPopulation.text=[NSString stringWithFormat:@"%d",[dic[@"population"]intValue] ]  ;
    
    
    
    //just quic fix for the details
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if(!error)
   self.txtDetails.text=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    else self.txtDetails.text=@"error occured while parsing details";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnAllCountriestouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
