//
//  ViewController.m
//  Test
//
//  Created by Paresh Kacha on 27/02/17.
//  Copyright © 2017 Appgalaxies.com. All rights reserved.
//

#import "ViewController.h"
@import SceneKit;
@interface ViewController ()<UIGestureRecognizerDelegate>
{
    __weak IBOutlet UILabel *touchedLocationLabel;
    __weak IBOutlet UILabel *bodyPartLabel;
    float currentAngleY;
    NSMutableArray * nodes;
}
@property (weak, nonatomic) IBOutlet SCNView *sceneView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    nodes = [NSMutableArray new];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customMehtod:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:self.sceneView.gestureRecognizers];
    self.sceneView.gestureRecognizers = gestureRecognizers;

//    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
//    [panRecognizer setMinimumNumberOfTouches:1];
//    [panRecognizer setMaximumNumberOfTouches:1];
//    [gestureRecognizers addObject:panRecognizer];
//    [gestureRecognizers addObjectsFromArray:self.sceneView.gestureRecognizers];
//    [self.sceneView addGestureRecognizer:panRecognizer];
    self.sceneView.scene = [SCNScene sceneNamed:@"GameData.scnassets/standard-male-figure.scn"];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSMutableDictionary * dict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"SelectedParts"] mutableCopy];
    if(dict)
    {
        for (NSString * key in dict) {
            NSArray * array = [key componentsSeparatedByString:@","];
            SCNVector3 selectedBodyPartLocation = SCNVector3Make([array[0] floatValue], [array[1] floatValue], [array[2] floatValue]);
            SCNSphere * sphere = [SCNSphere sphereWithRadius:.15];
            sphere.firstMaterial.multiply.contents = [UIColor redColor];
            sphere.firstMaterial.reflective.contents = [UIColor redColor];
            sphere.firstMaterial.transparent.contents = [UIColor redColor];
            SCNNode *shapeNode = [SCNNode nodeWithGeometry: sphere];
            shapeNode.position = selectedBodyPartLocation;
            [nodes addObject:shapeNode];
            [_sceneView.scene.rootNode addChildNode:shapeNode];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)customMehtod:(UIGestureRecognizer *)sender
{
    CGPoint p = [sender locationInView:self.sceneView];
    NSMutableArray *hitResults = nil;
    hitResults = [[self.sceneView hitTest:p options:nil] mutableCopy];
    
    if([hitResults count] > 0){
        __block SCNHitTestResult *result = [hitResults objectAtIndex:0];
        if([result.node.name isEqualToString:@"Body_M_GeoRndr"])
        {
            NSString * BodyArea = @"";
            if(result.localCoordinates.x > -4.1 &&  result.localCoordinates.x < -2.24)
            {
                if(result.localCoordinates.z < -1.1)
                {
                    BodyArea = @"Right Arm - Back";
                }
                else
                {
                    BodyArea = @"Right Arm - Front";
                }
            }
            else if (result.localCoordinates.x > -8 &&  result.localCoordinates.x < -4.1)
            {
                if(result.localCoordinates.x > -5)
                {
                    if(result.localCoordinates.z < -1)
                    {
                        BodyArea = @"Right Forearm - Back";
                    }
                    else
                    {
                        BodyArea = @"Right Forearm - Front";
                    }
                }
                else if(result.localCoordinates.x < -5.9)
                {
                    if(result.localCoordinates.z < -.61)
                    {
                        BodyArea = @"Right Forearm - Back";
                    }
                    else
                    {
                        BodyArea = @"Right Forearm - Front";
                    }
                }
                else
                {
                    if(result.localCoordinates.z < -.81)
                    {
                        BodyArea = @"Right Forearm - Back";
                    }
                    else
                    {
                        BodyArea = @"Right Forearm - Front";
                    }
                }
            }
            else if (result.localCoordinates.x > 2.24 &&  result.localCoordinates.x < 4.1)
            {
                if(result.localCoordinates.z < -1.1)
                {
                    BodyArea = @"Left Arm - Back";
                }
                else
                {
                    BodyArea = @"Left Arm - Front";
                }
            }
            else if (result.localCoordinates.x > 4.1 &&  result.localCoordinates.x < 8)
            {
                if(result.localCoordinates.x > -5)
                {
                    if(result.localCoordinates.z < -1)
                    {
                        BodyArea = @"Left Forearm - Back";
                    }
                    else
                    {
                        BodyArea = @"Left Forearm - Front";
                    }
                }
                else if(result.localCoordinates.x < -5.9)
                {
                    if(result.localCoordinates.z < -.61)
                    {
                        BodyArea = @"Left Forearm - Back";
                    }
                    else
                    {
                        BodyArea = @"Left Forearm - Front";
                    }
                }
                else
                {
                    if(result.localCoordinates.z < -.81)
                    {
                        BodyArea = @"Left Forearm - Back";
                    }
                    else
                    {
                        BodyArea = @"Left Forearm - Front";
                    }
                }
            }
            else if (result.localCoordinates.y < 1.2)
            {
                if(result.localCoordinates.z < -0.6)
                {
                    if(result.localCoordinates.x < 0)
                    {
                        BodyArea = @"Right Foot - Back";
                    }
                    else
                    {
                        BodyArea = @"Left Foot - Back";
                    }
                }
                else
                {
                    if(result.localCoordinates.x < 0)
                    {
                        BodyArea = @"Right Foot - Front";
                    }
                    else
                    {
                        BodyArea = @"Left Foot - Front";
                    }
                }
            }
            else if (result.localCoordinates.y > 1.2 && result.localCoordinates.y < 5.4)
            {
                if(result.localCoordinates.z < -1.2)
                {
                    if(result.localCoordinates.x < 0)
                    {
                        BodyArea = @"Right Leg - Back";
                    }
                    else
                    {
                        BodyArea = @"Left Leg - Back";
                    }
                }
                else
                {
                    if(result.localCoordinates.x < 0)
                    {
                        BodyArea = @"Right Leg - Front";
                    }
                    else
                    {
                        BodyArea = @"Left Leg - Front";
                    }
                }
            }
            else if (result.localCoordinates.y > 5.4 && result.localCoordinates.y < 9.5)
            {
                if(result.localCoordinates.z < -0.6)
                {
                    if(result.localCoordinates.x < 0)
                    {
                        BodyArea = @"Right Thigh - Back";
                    }
                    else
                    {
                        BodyArea = @"Left Thigh - Back";
                    }
                }
                else
                {
                    if(result.localCoordinates.x < 0)
                    {
                        BodyArea = @"Right Thigh - Front";
                    }
                    else
                    {
                        BodyArea = @"Left Thigh - Front";
                    }
                }
            }
            else if (result.localCoordinates.y > 9.5 && result.localCoordinates.y < 12.8)
            {
                if(result.localCoordinates.z < -0.6)
                {
                    BodyArea = @"Back";
                }
                else
                {
                    BodyArea = @"Stomach";
                }
            }
            else if ((result.localCoordinates.y > 12.8 && result.localCoordinates.y < 15) && (result.localCoordinates.x < 2.24 && result.localCoordinates.x > -2.24))
            {
                if(result.localCoordinates.z < -1.36)
                {
                    BodyArea = @"Chest - Back";
                }
                else
                {
                    BodyArea = @"Chest - Front";
                }
            }
            else if ((result.localCoordinates.y > 15 && result.localCoordinates.y < 15.96) && (result.localCoordinates.x > -.67 && result.localCoordinates.x < .67))
            {
                if(result.localCoordinates.z > -.76)
                {
                    BodyArea = @"Neck - Front";
                }
                else
                {
                    BodyArea = @"Back";
                }
            }
            else if ((result.localCoordinates.y > 16 && result.localCoordinates.y < 16.6) && (result.localCoordinates.x > -.67 && result.localCoordinates.x < .67))
            {
                if(result.localCoordinates.z < -.76)
                {
                    BodyArea = @"Neck - Back";
                }
                else
                {
                    BodyArea = @"Head - Front";
                }
            }
            else if (result.localCoordinates.y > 15.8 && result.localCoordinates.z > -.76)
            {
                BodyArea = @"Head - Front";
            }
            else if (result.localCoordinates.y > 16.6 && result.localCoordinates.z < -.76)
            {
                BodyArea = @"Head - Back";
            }
            bodyPartLabel.text = BodyArea;
            NSString * touchLocation = [NSString stringWithFormat:@"%@,%@,%@",[NSNumber numberWithFloat:result.localCoordinates.x],[NSNumber numberWithFloat:result.localCoordinates.y],[NSNumber numberWithFloat:result.localCoordinates.z]];
            touchedLocationLabel.text = [NSString stringWithFormat:@"%@ %@",touchLocation,BodyArea];
            SCNSphere * sphere = [SCNSphere sphereWithRadius:.15];
            sphere.firstMaterial.multiply.contents = [UIColor redColor];
            sphere.firstMaterial.reflective.contents = [UIColor redColor];
            sphere.firstMaterial.transparent.contents = [UIColor redColor];
            SCNNode *shapeNode = [SCNNode nodeWithGeometry: sphere];
            shapeNode.position = SCNVector3Make(result.localCoordinates.x, result.localCoordinates.y, (result.localCoordinates.z+.1)*1.1);
            shapeNode.name = @"Sphere";
            [nodes addObject:shapeNode];
            [result.node addChildNode:shapeNode];
            NSMutableDictionary * dict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"SelectedParts"] mutableCopy];
            if(!dict)
            {
                dict = [NSMutableDictionary new];
            }
            
            if(![[dict allKeys] containsObject:touchLocation])
            {
                [dict setValue:BodyArea forKey:touchLocation];
                [[NSUserDefaults standardUserDefaults] setValue:dict forKey:@"SelectedParts"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            NSLog(@"stored body parts %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SelectedParts"]);
        }
        else
        {
            [result.node removeFromParentNode];
        }
    }
}
- (IBAction)goToNextScreen:(id)sender {
    UIImage *image = [_sceneView snapshot];
    NSLog(@"%@",image);
}
- (IBAction)resetSelection:(id)sender {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    for (SCNNode * node in nodes) {
        [node removeFromParentNode];
    }
}
-(void)panGestureRecognizer:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:sender.view];
    float newAngleY = (float)(translation.x)*(float)(M_PI)/180.0;
    newAngleY += currentAngleY;
    self.sceneView.scene.rootNode.rotation = SCNVector4Make(0, 1, 0, newAngleY);
    if(sender.state == UIGestureRecognizerStateEnded) {
        currentAngleY = newAngleY;
    }
}
-(void)handlePan:(UIPanGestureRecognizer *)recognizer
{
}
@end
