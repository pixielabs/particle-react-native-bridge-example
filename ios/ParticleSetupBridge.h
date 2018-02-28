//
//  ParticleSetupBridge.h
//  ParticleSampleApp
//
//  Created by Abigail McPhillips on 28/02/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "ParticleSetup.h"
#import "ParticleSetupViewController.h"

@interface ParticleSetupBridge : RCTEventEmitter <RCTBridgeModule>

// We keep a copy of our ParticleSetupViewController for memory reasons.
@property (nonatomic, retain) ParticleSetupViewController *particleSetup;

@end


