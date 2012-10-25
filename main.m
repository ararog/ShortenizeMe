//
//  main.m
//  ShortenizeMe
//
//  Created by ROGERIO ARAUJO on 12/09/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Services.h"

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    Services *serviceProvider = [[Services alloc] init];
    
    NSRegisterServicesProvider(serviceProvider, @"ShortenizeMe");
	NSUpdateDynamicServices();
	
    NS_DURING
	[[NSRunLoop currentRunLoop] run];
    NS_HANDLER
	NSLog(@"%@", localException);
    NS_ENDHANDLER
	
    [serviceProvider release];
    [pool release];
	
    exit(0);       // insure the process exit status is 0
    return 0;      // ...and make main fit the ANSI spec.
}
