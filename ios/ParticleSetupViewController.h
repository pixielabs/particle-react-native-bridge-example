//
//  ParticleSetupViewController.h
//  ParticleSampleApp
//
//  Created by Abigail McPhillips on 28/02/2018.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticleSetup.h"

@interface ParticleSetupViewController : UIViewController <ParticleSetupMainControllerDelegate>

// Property for assigning a block to be run when setup is finished.
// (See ParticleSetupBridge for this in action).
@property (copy) void (^setupFinishedHandler) (ParticleSetupMainControllerResult, ParticleDevice *);

@end

