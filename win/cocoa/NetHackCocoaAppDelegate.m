//
//  NetHackCocoaAppDelegate.m
//  NetHackCocoa
//
//  Created by Dirk Zimmermann on 2/15/10.
//  Copyright 2010 Dirk Zimmermann. All rights reserved.
//

/*
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation, version 2
 of the License.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#import "NetHackCocoaAppDelegate.h"
#import "wincocoa.h"

#include <sys/stat.h>

extern int unixmain(int argc, char **argv);

@implementation NetHackCocoaAppDelegate
@synthesize window;

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	netHackThread = [[NSThread alloc] initWithTarget:self selector:@selector(netHackMainLoop:) object:nil];
	netHackThread.name = @"NetHack Thread";
	[netHackThread start];
}

-(BOOL)netHackThreadRunning
{
	return netHackThread != nil && netHackThread.executing;
}

-(void)lockNethackCore
{
	[nethackCoreLock lock];
}
-(void)unlockNethackCore
{
	[nethackCoreLock unlock];
}

- (void) netHackMainLoop:(id)arg {
	extern int g_argc;
	extern char ** g_argv;
	
	@autoreleasepool {
		NSFileManager *fm = [[NSFileManager alloc] init];
		nethackCoreLock = [[NSRecursiveLock alloc] init];
		[self lockNethackCore];
		
		// create necessary directories
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString *baseDirectory = paths[0];
		baseDirectory = [baseDirectory stringByAppendingPathComponent:@"NetHackCocoa"];
		if (![fm fileExistsAtPath:baseDirectory]) {
			[fm createDirectoryAtPath:baseDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
		}
		NSLog(@"baseDir %@", baseDirectory);
		setenv("NETHACKDIR", baseDirectory.fileSystemRepresentation, 1);
		NSString *saveDirectory = [baseDirectory stringByAppendingPathComponent:@"save"];
		if (![fm fileExistsAtPath:saveDirectory]) {
			[fm createDirectoryAtPath:saveDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
		}
		@autoreleasepool{
			NSString *sysCFStr = @(SYSCF_FILE);
			NSString *ourPlace = [baseDirectory stringByAppendingPathComponent:sysCFStr];
			NSString *bundPlace = [[NSBundle mainBundle] pathForResource:sysCFStr ofType:nil];
			if (![fm fileExistsAtPath:ourPlace]) {
				[fm copyItemAtPath:bundPlace toPath:ourPlace error:NULL];
			}

			NSData *blankData = [[NSData alloc] init];
			for (NSString *addlPatch in @[@"perm", @"logfile", @"xlogfile"]) {
				NSString *aStr = [baseDirectory stringByAppendingPathComponent:addlPatch];
				if (![fm fileExistsAtPath:aStr]) {
					[blankData writeToFile:aStr atomically:NO];
				}
			}
		}
		
		// set plname (very important for save files and getlock)
		[NSUserName().capitalizedString getCString:plname maxLength:PL_NSIZ encoding:NSASCIIStringEncoding];
		
		// call NetHack
		unixmain(g_argc, g_argv);
		
		[self unlockNethackCore];
		
		// clean up thread pool
	}
}

@end
