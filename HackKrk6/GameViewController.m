//
//  GameViewController.m
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "Networking.h"
#import "UserAuthentication.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize iamgeView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[Networking sharedNetworking] sendListOfRiddleRequestWithPageNumber:[NSNumber numberWithInt:2] itemsPerPage:[NSNumber numberWithInt:2] token:[UserAuthentication sharedAuthentication].token withCallBack:^(BOOL result, NSError *error, id JSON){
        NSLog(@"%@",JSON);
    }];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setIamgeView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
