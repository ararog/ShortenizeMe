//
//  ShorURL.h
//  ShortenizeMe
//
//  Created by ROGERIO ARAUJO on 12/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ShortURL : NSObject {
    NSString *title;
    NSString *error;
    NSString *ident;
    NSString *sourceUrl;
    NSString *value;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *error;
@property (nonatomic, retain) NSString *ident;
@property (nonatomic, retain) NSString *sourceUrl;
@property (nonatomic, retain) NSString *value;

@end
