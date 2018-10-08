//
//  AppDelegate.m
//  OSAXHost
//
//  Created by Mark Alldritt on 2018-10-08.
//  Copyright © 2018 Mark Alldritt. All rights reserved.
//

#import "AppDelegate.h"
#import "StubScriptSuiteRegistry.h"


@interface AppDelegate () {
    NSUInteger count, prevcount;
}

@end

OSErr handleAnyAppleEvent(const AppleEvent *eventDesc, AppleEvent *replyDesc, SRefCon handlerRefcon) {
    AEDesc eventDescCopy, replyDescCopy;
    OSErr err = AEDuplicateDesc(eventDesc, &eventDescCopy);
    if (err) return err;
    err = AEDuplicateDesc(replyDesc, &replyDescCopy);
    if (err) return err;
    NSAppleEventDescriptor *event = [[NSAppleEventDescriptor alloc] initWithAEDescNoCopy: &eventDescCopy];
    NSAppleEventDescriptor *reply = [[NSAppleEventDescriptor alloc] initWithAEDescNoCopy: &replyDescCopy];
    //NSLog(@"CALL: %@", event);
    [((__bridge AppDelegate *)handlerRefcon) handleAppleEvent: event withReplyEvent: reply];
    //NSLog(@"REPLY: %@", reply);
    return AEDuplicateDesc(reply.aeDesc, replyDesc);
}


@implementation AppDelegate

+ (void)initialize {
    //  Prevent AppKit from installing its own AppleEvent and scripting hooks
    [NSScriptSuiteRegistry setSharedScriptSuiteRegistry: [StubScriptSuiteRegistry new]];

}


- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
    // ensure embedded OSAXen are loaded
    NSAppleEventDescriptor *event = [NSAppleEventDescriptor appleEventWithEventClass: 'ascr' eventID: 'gdut'
                                                                    targetDescriptor: [NSAppleEventDescriptor currentProcessDescriptor]
                                                                            returnID: kAutoGenerateReturnID
                                                                       transactionID: kAnyTransactionID];
    NSError *error = nil;
    [event sendEventWithOptions: kAEWaitReply timeout: kAEDefaultTimeout error: &error];
    
    if (error.code != 0 && error.code != -1708) {
        NSLog(@"The 'load OSAXen' event (ascr/gdut) failed for some reason: %@", error);
    }

#if FALSE
    //  Test that the event handlers were loaded
    NSAppleEventDescriptor *event2 = [NSAppleEventDescriptor appleEventWithEventClass: 'SATI' eventID: 'UPPE'
                                                                     targetDescriptor: [NSAppleEventDescriptor currentProcessDescriptor]
                                                                             returnID: kAutoGenerateReturnID
                                                                        transactionID: kAnyTransactionID];
    [event2 setDescriptor:[NSAppleEventDescriptor descriptorWithString:@"Hello World"] forKeyword:keyDirectObject];
    error = nil;
    NSAppleEventDescriptor* reply = [event2 sendEventWithOptions: kAEWaitReply timeout: kAEDefaultTimeout error: &error];
    
    NSLog(@"sendEventWithOptions 2 -> %@, error: %@", reply, error);
#endif

    //  Establish a wildcard handler to catch all OSAXen events.
    OSErr err = AEInstallEventHandler(typeWildCard, typeWildCard, NewAEEventHandlerUPP(&handleAnyAppleEvent), (__bridge SRefCon)self, 0);
    if (err != noErr) {
        NSLog(@"Failed to install wildcard Apple event handler.");
    }

    //  Setup the auto-terminate timer
    prevcount = 0;
    count = 0;
    [NSTimer scheduledTimerWithTimeInterval: AUTO_QUIT_DELAY repeats: YES block: ^(NSTimer *timer) {
        if (self->prevcount == self->count) { [NSApp terminate: self]; }
        self->prevcount = self->count;
    }];

}


- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *) reply {
    // repackage the received Apple event for sending to self
    NSAppleEventDescriptor *osaxEvent = [NSAppleEventDescriptor appleEventWithEventClass: event.eventClass eventID: event.eventID
                                                                        targetDescriptor: [NSAppleEventDescriptor currentProcessDescriptor]
                                                                                returnID: kAutoGenerateReturnID
                                                                           transactionID: kAnyTransactionID];
    for (NSInteger i = 1; i <= event.numberOfItems; i++) {
        AEKeyword key = [event keywordForDescriptorAtIndex: i];
        [osaxEvent setDescriptor: [event descriptorForKeyword: key] forKeyword: key];
    }
    
    //  Remove the wildcard handler so we don't recur
    OSStatus err = AERemoveEventHandler(typeWildCard, typeWildCard, NewAEEventHandlerUPP(&handleAnyAppleEvent), 0);
    
    //  Run the repackaged AppleEvent
    NSError *error = nil;
    NSAppleEventDescriptor *osaxReply = [osaxEvent sendEventWithOptions: kAEWaitReply timeout: kAEDefaultTimeout error: &error];
    if (osaxReply) {
        for (NSInteger i = 1; i <= osaxReply.numberOfItems; i++) {
            AEKeyword key = [osaxReply keywordForDescriptorAtIndex: i];
            [reply setDescriptor: [osaxReply descriptorForKeyword: key] forKeyword: key];
        }
    }
    else {
        [reply setDescriptor: [NSAppleEventDescriptor descriptorWithInt32: (int)error.code] forKeyword: keyErrorNumber];
    }
    
    //  Restore the wildcard event handler so we can respond to other events.
    err = AEInstallEventHandler(typeWildCard, typeWildCard, NewAEEventHandlerUPP(&handleAnyAppleEvent), (__bridge SRefCon)self, 0);

    //  Suppress auto-quite for another AUTO_QUIT_DELAY interval
    count++;
}


@end
