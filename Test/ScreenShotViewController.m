//
//  ScreenShotViewController.m
//  Test
//
//  Created by Paresh Kacha on 09/03/17.
//  Copyright © 2017 Appgalaxies.com. All rights reserved.
//

#import "ScreenShotViewController.h"

@interface ScreenShotViewController ()

@end

@implementation ScreenShotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
