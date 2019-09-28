//
//  SingleSelectionViewController.m
//  Test
//
//  Created by Paresh Kacha on 09/03/17.
//  Copyright © 2017 Appgalaxies.com. All rights reserved.
//

#import "SingleSelectionViewController.h"
#import "ScreenShotViewController.h"
#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)
@interface SingleSelectionViewController ()
<UIGestureRecognizerDelegate>
{
    __weak IBOutlet UILabel *touchedLocationLabel;
    float currentAngleY;
    SCNNode * selectedNode;
}
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@end

@implementation SingleSelectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
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
}
-(void)viewDidAppear:(BOOL)animated
{
    self.sceneView.scene = [SCNScene sceneNamed:@"GameData.scnassets/standard-male-figure.scn"];

    if(selectedNode)
    {
        [selectedNode removeFromParentNode];
    }
    NSMutableDictionary * dict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"SelectedPartsSingleSelection"] mutableCopy];
    if(dict)
    {
        for (NSString * key in dict) {
            NSArray * array = [key componentsSeparatedByString:@","];
            SCNVector3 selectedBodyPartLocation = SCNVector3Make([array[0] floatValue], [array[1] floatValue], [array[2] floatValue]);
            BodyArea = [dict valueForKey:key];
            SCNSphere * sphere = [SCNSphere sphereWithRadius:.15];
            sphere.firstMaterial.multiply.contents = [UIColor redColor];
            sphere.firstMaterial.reflective.contents = [UIColor redColor];
            sphere.firstMaterial.transparent.contents = [UIColor redColor];
            SCNNode *shapeNode = [SCNNode nodeWithGeometry: sphere];
            shapeNode.position = selectedBodyPartLocation;
            selectedNode = shapeNode;
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
            [selectedNode removeFromParentNode];
            BodyArea = @"";
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
            NSString * touchLocation = [NSString stringWithFormat:@"%@,%@,%@",[NSNumber numberWithFloat:result.localCoordinates.x],[NSNumber numberWithFloat:result.localCoordinates.y],[NSNumber numberWithFloat:result.localCoordinates.z]];
            touchedLocationLabel.text = [NSString stringWithFormat:@"%@ %@",touchLocation,BodyArea];
            SCNSphere * sphere = [SCNSphere sphereWithRadius:.15];
            sphere.firstMaterial.multiply.contents = [UIColor redColor];
            sphere.firstMaterial.reflective.contents = [UIColor redColor];
            sphere.firstMaterial.transparent.contents = [UIColor redColor];
            SCNNode *shapeNode = [SCNNode nodeWithGeometry: sphere];
            shapeNode.position = SCNVector3Make(result.localCoordinates.x, result.localCoordinates.y, (result.localCoordinates.z)*1.1);
            shapeNode.name = @"Sphere";
            selectedNode = shapeNode;
            [result.node addChildNode:shapeNode];
            [[NSUserDefaults standardUserDefaults] setValue:@{touchLocation:BodyArea} forKey:@"SelectedPartsSingleSelection"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else
        {
            [result.node removeFromParentNode];
        }
    }
}
- (IBAction)goToNextScreen:(id)sender {
    self.sceneView.scene = [SCNScene sceneNamed:@"GameData.scnassets/standard-male-figure.scn"];
    NSMutableDictionary * dict = [[[NSUserDefaults standardUserDefaults] valueForKey:@"SelectedPartsSingleSelection"] mutableCopy];
    if(dict)
    {
        for (NSString * key in dict) {
            NSArray * array = [key componentsSeparatedByString:@","];
            SCNVector3 selectedBodyPartLocation = SCNVector3Make([array[0] floatValue], [array[1] floatValue], [array[2] floatValue]);
            BodyArea = [dict valueForKey:key];
            SCNSphere * sphere = [SCNSphere sphereWithRadius:.15];
            sphere.firstMaterial.multiply.contents = [UIColor yellowColor];
            sphere.firstMaterial.reflective.contents = [UIColor yellowColor];
            sphere.firstMaterial.transparent.contents = [UIColor yellowColor];
            SCNNode *shapeNode = [SCNNode nodeWithGeometry: sphere];
            shapeNode.position = selectedBodyPartLocation;
            selectedNode = shapeNode;
            [_sceneView.scene.rootNode addChildNode:shapeNode];
        }
    }
    if(selectedNode)
    {
        SCNBillboardConstraint * billCons = [SCNBillboardConstraint billboardConstraint];
        billCons.freeAxes = SCNBillboardAxisY;
        self.sceneView.pointOfView.constraints = @[billCons];
        CameraAngle = 0;
        CGFloat cameraPosition = 10;
        NSString * backOrFront = [[[BodyArea componentsSeparatedByString:@"-"] lastObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if([backOrFront isEqualToString:@"Back"])
        {
            CameraAngle = DEGREES_TO_RADIANS(180);
            cameraPosition = -10;
        }
        SCNAction * actionOfRotation = [SCNAction rotateToX:0 y:CameraAngle z:0 duration:0.0];
        isCameraPositionChanged = YES;
        self.sceneView.pointOfView.position = SCNVector3Make(selectedNode.position.x, selectedNode.position.y, cameraPosition);
        [self.sceneView.scene.rootNode runAction:actionOfRotation completionHandler:^{
            dispatch_async(dispatch_get_main_queue(),^{
                UIImage *image = [_sceneView snapshot];
                [self performSegueWithIdentifier:@"showImage" sender:image];
                [self.sceneView.scene.rootNode runAction:[actionOfRotation reversedAction]];
            });
        }];
    }
    else
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please select body part." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController: alert animated:YES completion:^{
            
        }];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender
{
    ScreenShotViewController * vc = (ScreenShotViewController *)segue.destinationViewController;
    vc.image = (UIImage *)sender;
}
@end
