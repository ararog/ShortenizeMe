//
//  ParserDelegate.m
//  ShortenizeMe
//
//  Created by ROGERIO ARAUJO on 12/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ParserDelegate.h"
#import "ShortURL.h"

@implementation ParserDelegate

@synthesize shortUrl;

NSString *value;

- (id) init {
	NSLog(@"Delegate instanciado.");
	shortUrl = [[ShortURL alloc] init];
	
	return [super init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	value = string;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (qName) {
        elementName = qName;
    }
	value = nil;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (qName) {
        elementName = qName;
    }
	
	if([elementName isEqualToString:@"title"])
		shortUrl.title = value;
	else  if([elementName isEqualToString:@"url"])
		shortUrl.sourceUrl = value;
	else  if([elementName isEqualToString:@"migre"])
		shortUrl.value = value;
}
@end
