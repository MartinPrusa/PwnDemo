//
//  PwnLoader.m
//  PwnDemo
//
//  Created by Martin Prusa on 3/17/18.
//  Copyright © 2018 Martin Prusa. All rights reserved.
//

#import "PwnLoader.h"
#import "PwndBA-Swift.h"

@implementation PwnLoader
static void __attribute__((constructor)) initialize(void){
    NSLog(@"==== Code Injection in Action====");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        static PwnUI *pwnUI;
        pwnUI = [PwnUI new];
        [pwnUI hijackAppWindow];
    });
}
@end
