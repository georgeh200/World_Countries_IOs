//
//  ViewController.h
//  Wrold_Countries
//
//  Created by George Gameal on 20/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WorldCountries;
@interface MainViewController : UIViewController< UITableViewDataSource ,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblCountries;
@property (weak, nonatomic) IBOutlet UIImageView *imgMapAnimation;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *vLoading;
@property(assign,nonatomic)BOOL scrolling;
@property(assign,nonatomic)BOOL shouldReloadDataTable;


@property (weak, nonatomic) IBOutlet UIView *header;



@property(weak,nonatomic)WorldCountries* worldCountries;



@end

