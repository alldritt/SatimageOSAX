//
//  AppDelegate.h
//  OSAXHost
//
//  Created by Mark Alldritt on 2018-10-08.
//  Copyright © 2018 Mark Alldritt. All rights reserved.
//

#import <Cocoa/Cocoa.h>


#define AUTO_QUIT_DELAY (600.0)



@interface AppDelegate : NSObject <NSApplicationDelegate>

-(void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *) reply;

@end

