//
//  AppDelegate.m
//  nosmoking
//
//  Created by Niklas Schröder on 14.09.2014.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    // Setup the date format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // Defaults
    float dailySaving = 6.0;
    // Added one to offset the evening. Last smoke was 14.09.2014 @ 21.00
    NSDate *startDate = [dateFormatter dateFromString:@"2014-09-15"];
    
    // Modify defaults if passed in as arguments
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    if(arguments.count > 1) {
        startDate = [dateFormatter dateFromString:arguments[1]];
    }
    if(arguments.count > 2) {
        dailySaving = [arguments[2] floatValue];
    }
    
    // Calculate days without smoking and money savings
    NSTimeInterval secondsSince = [startDate timeIntervalSinceNow];
    int daysWithout = floor(-secondsSince / (60 * 60 * 24));
    float moneySaved = daysWithout * dailySaving;
    
    // Fetch the user's notification center and display the notification
    NSUserNotificationCenter* notificationCenter = [NSUserNotificationCenter defaultUserNotificationCenter];
    [notificationCenter setDelegate:self];
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"You're awesome!";
    notification.informativeText = [NSString stringWithFormat:@"You've been %d days smoke free! You already saved %.2f€!", daysWithout, moneySaved];
    notification.soundName = NSUserNotificationDefaultSoundName;
    notification.hasActionButton = NO;
    [notificationCenter deliverNotification:notification];
    
    
    // And we are done
    [[NSApplication sharedApplication] terminate: nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
