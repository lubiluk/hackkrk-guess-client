//
//  RidleCameraViewController.m
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RidleCameraViewController.h"
#import "Networking.h"
#import "UserAuthentication.h"

@interface RidleCameraViewController ()
@property (nonatomic,strong) UIImagePickerController *camera;
@end

@implementation RidleCameraViewController
@synthesize iamgeView = _iamgeView;
@synthesize question = _question;
@synthesize answer = _answer;
@synthesize scrollView = _scrollView;
@synthesize camera = _camera;

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
    self.scrollView.contentSize = CGSizeMake(320, 640);
    self.scrollView.contentOffset = CGPointMake(0, -200);
	// Do any additional setup after loading the view.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.iamgeView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)catchPhoto:(id)sender 
{
    self.camera = [[UIImagePickerController alloc] init];
    self.camera.delegate = self;
    self.camera.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:self.camera animated:YES];
}

- (IBAction)sendPhoto:(id)sender 
{
    [[Networking sharedNetworking] uploadRiddleWithQuestion:self.question.text answer:self.answer.text token:[UserAuthentication sharedAuthentication].token photo:self.iamgeView.image withCallBack:^(BOOL result, NSError *error, id JSON) {
        NSLog(@"%@",JSON);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [self setIamgeView:nil];
    [self setQuestion:nil];
    [self setAnswer:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
