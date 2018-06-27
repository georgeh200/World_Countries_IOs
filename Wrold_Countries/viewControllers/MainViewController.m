//
//  ViewController.m
//  Wrold_Countries
//
//  Created by George Gameal on 20/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "MainViewController.h"
#import "CountryViewController.h"
#import "WCCountry.h"
#import "VCountryCell.h"
#import "WorldCountries.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
   
    self.worldCountries=[WorldCountries sharedInstance];
    
    
  

    
    
    self.vLoading.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [self.vLoading startAnimating];
   
    
    [self.worldCountries getFromCash:^{
        [self countriesLoadSuccess];
    }];

 [self performSelectorInBackground:@selector(fetchCountries) withObject:nil];
    
}

-(void)fetchCountries
{
    
    [self.worldCountries getAllCountries:^() {
        //this callback may be called from background, so we should confirm to be executed on main thread
        [self performSelectorOnMainThread:@selector(countriesLoadSuccess) withObject:nil waitUntilDone:NO];
    } withFailure:^(NSInteger statusCode) {
        [self countriesLoadFailed:statusCode];
    }];
}

-(void)countriesLoadSuccess
{
    [self.vLoading stopAnimating];
    self.vLoading.hidden=YES;
    if(!self.scrolling)
    [self.collectionView reloadData];
    else self.shouldReloadDataTable=YES;
}

-(void)countriesLoadFailed:(NSInteger)statusCode
{
    
    // HERE WE SHOULD CHECK THE USER CONNECTIVITY AND THE STATUS CODE TO DELIVER THE USER A REASONABLE MESSAGE
    // FOR THE TEST I WILL CONSIDER THAT USER IS NOT CONNECTED
    
    NSString* title=@"Connection Error";
    NSString* message=@"We are sorry, Application must connect in the first run.";
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        exit(0);
       
    }];
    [alert addAction:okAction];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}




/*- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.scrolling=YES;
    [self.view endEditing:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.shouldReloadDataTable)
    {
        self.shouldReloadDataTable=NO;
        [self.collectionView reloadData];
        
    }
    self.scrolling=NO;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate&&self.shouldReloadDataTable)
    {
        self.shouldReloadDataTable=NO;
        [self.collectionView reloadData];
        
    }
    if(!decelerate)
    {
        self.scrolling=NO;
    }
    
}*/



#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.worldCountries getFilteredCountriesCount];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WCCountry* country=[self.worldCountries getCountry: indexPath.row];
    static NSString *cellIdentifier = @"cellIdentifier";
    VCountryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
   
    
    [cell startWithCountry:country];
    
    
    return cell;
}

#pragma UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CountryViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"CountryView"];
    myViewController.country=[self.worldCountries getCountry: indexPath.row];
    [self presentViewController:myViewController animated:NO completion:nil];
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
