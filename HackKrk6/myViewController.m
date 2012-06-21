//
//  myViewController.m
//  View
//
//  Created by Natalia Terlecka on 6/21/12.
//  Copyright (c) 2012 AGH. All rights reserved.
//

#import "myViewController.h"
#import "Networking.h"

@interface myViewController()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) Networking *model;

@end

@implementation myViewController
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize model = _model;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (IBAction)tryToLogIn:(id)sender 
{
    [[Networking sharedNetworking] sendRegisterRequestWithUsername:self.userName.text password:self.password.text withCallBack:^(BOOL result, NSError *error, id JSON) {
        if (!result) {
        UIAlertView *mistake = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Something went wrong, please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [mistake show];
        }
        else {
            [self performSegueWithIdentifier:@"logInAttempt" sender:self];
        }
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
