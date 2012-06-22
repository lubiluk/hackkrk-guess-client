//
//  RidleCameraViewController.h
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RidleCameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iamgeView;
@property (weak, nonatomic) IBOutlet UITextField *question;
@property (weak, nonatomic) IBOutlet UITextField *answer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
