//
//  ParticleSetupViewController.m
//  ParticleSampleApp
//
//  Created by Abigail McPhillips on 28/02/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "ParticleSetupViewController.h"
#import "ParticleDevice.h"

@interface ParticleSetupViewController ()

@end

@implementation ParticleSetupViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

// This is the message the Particle SDK Setup Controller will send us when it finishes.
// Either succesfully or not.
-(void)particleSetupViewController:(ParticleSetupMainController *)controller didFinishWithResult:(ParticleSetupMainControllerResult)result device:(ParticleDevice *)device
{
  NSLog(@"The device ID is: %@", device.id);
  NSLog(@"The device name is: %@", device.name);
  
  // If someone has given us a handler (closure) to call, call it.
  // This is where the message gets passed back to ParticleSetupBridge.
  if (self.setupFinishedHandler != nil) {
    [self setupFinishedHandler](result, device);
  }
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

