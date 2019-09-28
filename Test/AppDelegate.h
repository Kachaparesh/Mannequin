//
//  AppDelegate.h
//  Test
//
//  Created by Paresh Kacha on 27/02/17.
//  Copyright © 2017 Appgalaxies.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

