//
//  questionViewController.m
//  HackKrk6
//
//  Created by Grzegorz Krukiewicz-Gacek on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "questionViewController.h"
#import "Networking.h"
#import "UserAuthentication.h"

@implementation questionViewController

@synthesize imageView;
@synthesize questionLabel;
@synthesize answerField;
@synthesize submitButton;

@synthesize _questrionString;
@synthesize _answerString;
@synthesize _riddleID;
@synthesize _riddle;

-(IBAction)submit:(id)sender {
    
    self._questrionString = questionLabel.text;
    
    [[Networking sharedNetworking] postRiddleAnswer:_questionString riddleID:[NSNumber numberWithInt:_riddleID] token:[UserAuthentication sharedAuthentication].token withCallBack:^(BOOL result, NSError *error, id JSON) {
        if (result) {
            UIAlertView *done = [[UIAlertView alloc] initWithTitle:@"Well Done" message:@"Perfect match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [done show];
            [UserAuthentication sharedAuthentication].score += 1;
        }
        else
        {
            UIAlertView *mistake = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"I'm afraid not." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [mistake show];
        }
        
     }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    
    }
    return self;

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[Networking sharedNetworking] sendListOfRiddleRequestWithPageNumber:[NSNumber numberWithInt:1] itemsPerPage:[NSNumber numberWithInt:1] token:[UserAuthentication sharedAuthentication].token withCallBack:^(BOOL result, NSError *error, id JSON) {
        
        NSLog(@"%@",JSON);
        dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
        
        dispatch_async(queue, ^{
            NSArray *array = [JSON objectForKey:@"riddles"];
            
            
            NSDictionary *obj = [array objectAtIndex:1];
            NSString *imageurl = [obj objectForKey:@"photo_url"];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageurl]];
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image; 
            });
            
        });
        
    }];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
