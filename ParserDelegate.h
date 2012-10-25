//
//  ParserDelegate.h
//  ShortenizeMe
//
//  Created by ROGERIO ARAUJO on 12/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ShortURL.h"

@interface ParserDelegate : NSObject {
    ShortURL *shortUrl;
}

@property (nonatomic, retain) ShortURL *shortUrl;

@end
