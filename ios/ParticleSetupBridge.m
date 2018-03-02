//
//  ParticleSetupBridge.m
//  ParticleSampleApp
//
//  Created by Abigail McPhillips on 28/02/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "ParticleSetupBridge.h"
#import "AppDelegate.h"
#import "ParticleCloud.h"

@implementation ParticleSetupBridge

// We're a React Native native module called ParticleSetup
RCT_EXPORT_MODULE(RCTParticleSetup);

// We're exporting a method called setup.
RCT_EXPORT_METHOD(setup) {

  // Set up setup controller; this is the thing that's going to do all the fancy
  // device setup and wifi stuff. ParticleSetupMainController comes from the Particle SDK.
  ParticleSetupMainController *setupController = [[ParticleSetupMainController alloc] init];

  // Set up an instance of _our_ ViewController. This is the thing that receives
  // the 'callback' from the Particle SDK code when device setup has succeeded.
  if(self.particleSetup == nil) {

    ParticleSetupViewController *vc = [[ParticleSetupViewController alloc] init];
    self.particleSetup = vc;

    // Memory safety; don't strongly hold h through self.
    // If we don't do this, I think the `h` closure and this bridge module will be
    // tightly coupled and so can never be cleaned up.
    __weak ParticleSetupBridge *weakSelf = self;
    void (^h)(ParticleSetupMainControllerResult, ParticleDevice*) = ^ (ParticleSetupMainControllerResult result, ParticleDevice* device) {

      // This is the code that will run when Particle finishes setting up a device (or fails).
      NSLog(@"Inside setupFinishedHandler in bridge");
      NSLog(@"%@", device.id);
      NSLog(@"%@", device.name);

      // Get a proper instance of the bridge back.
      ParticleSetupBridge *strongSelf = weakSelf;

      // Check it hasn't been cleaned up by the garbage collector
      if (strongSelf == nil) {
        NSLog(@"ParticleSetupBridge has gone away. Cannot notify React Native app.");
        // Ignore; setup bridge has gone away.
      } else {
        // Wahoo! Send a DeviceSetup event to React Native.
        [strongSelf sendEventWithName:@"DeviceSetup" body:@{@"id": device.id, @"name": device.name}];
      }
    };

    // Set property on _our_ view controller, which will be called as part of it handling
    // a message from the Particle SDK when device setup finishes.
    self.particleSetup.setupFinishedHandler = h;
  }

  // Tell the Particle SDK Controller that our new ViewController is its Delegate (so it
  // sends us that crucial 'device setup finished' message).
  [setupController setDelegate:self.particleSetup];

  // You get told off for accessing the sharedApplication instance from a background
  // thread, so dispatch some code off to the main queue.
  dispatch_async(dispatch_get_main_queue(), ^{

    // Get root to show from AppDelegate. This won't work if we have more than one
    // native ViewController (e.g. with the native navigation libraries you can get).
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    // Present the Particle SDK setup controller to the user; show the user the Particle
    // setup!
    [delegate.window.rootViewController presentViewController:setupController animated:YES completion:nil];
  });
}

// React Native requires you to list the names of events you might emit.
- (NSArray<NSString *> *)supportedEvents
{
  return @[@"DeviceSetup"];
}

@end
