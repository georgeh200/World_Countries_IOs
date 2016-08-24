//
//  HeaderViewController.m
//  World_Countries
//
//  Created by George Gameal on 21/08/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "HeaderViewController.h"

@interface HeaderViewController ()

@end

@implementation HeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // prepare and start map image animation
      NSArray *imagesArray = [NSArray arrayWithObjects:
     [UIImage imageNamed:@"map0.png"],
     [UIImage imageNamed:@"map1.png"],
     [UIImage imageNamed:@"map2.png"],
     [UIImage imageNamed:@"map3.png"],nil];
     
     
     self.imgMapAnimation.animationImages = imagesArray;
     self.imgMapAnimation.animationDuration = 1.5f;
     self.imgMapAnimation.animationRepeatCount = 0;
     [self.imgMapAnimation startAnimating];
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

@end
