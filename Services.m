//
//  Services.m
//  ShortenizeMe
//
//  Created by ROGERIO ARAUJO on 12/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Services.h"
#import "ParserDelegate.h"

@implementation Services
- (void)shorten:(NSPasteboard *)pboard
				   userData:(NSString *)data
					  error:(NSString **)error
{
	
    NSString *pboardString;
    NSString *newString;
    NSArray *types;
	
    types = [pboard types];
	
    if (![types containsObject:NSStringPboardType] || !(pboardString = [pboard stringForType:NSStringPboardType])) {
        *error = NSLocalizedString(@"Error: Pasteboard doesn't contain a string.",
								   @"Pasteboard couldn't give string.");
        return;
    }
	
	NSURL *urlSelecionada = [[NSURL alloc] initWithString: pboardString];
	
	if(urlSelecionada == nil) {
		[[NSAlert alertWithMessageText:NSLocalizedString(@"Error", nil) defaultButton:@"Ok" 
					  alternateButton:nil 
						  otherButton:nil 
			informativeTextWithFormat: @"The selected text doesn't contain a valid URL!"] runModal];
	}
	
	NSString *urlMigreMe = @"http://migre.me/api.xml?url=";
	
	NSString *escapedURL = [pboardString stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
	
	NSString *urlRequest = [urlMigreMe stringByAppendingString:escapedURL];
	
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [[NSURL alloc] initWithString:urlRequest]]; 
	
	NSURLResponse *response = [[NSURLResponse alloc] init];
	
	NSData *serverData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:serverData];
	
	ParserDelegate *parserDelegate = [[ParserDelegate alloc] init];
	
    [parser setDelegate: parserDelegate]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; //
    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
	
	[parser parse]; // Parse that data..

	newString = [[parserDelegate shortUrl] value];
    
	[urlMigreMe release];
	[escapedURL release];
	[urlRequest release];
	[request release];
	[response release];
	[serverData release];
	[parser release];	
	[parserDelegate release];
	
    if (!newString) {
        *error = NSLocalizedString(@"Error: Couldn't shorten url %@.",
								   nil);
        return;
    }
	
    /* We now return the capitalized string... */
    types = [NSArray arrayWithObject:NSStringPboardType];
    [pboard declareTypes:types owner:nil];
    [pboard setString:newString forType:NSStringPboardType];
	
    return;
}
@end
