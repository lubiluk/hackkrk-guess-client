//
//  questionViewController.h
//  HackKrk6
//
//  Created by Grzegorz Krukiewicz-Gacek on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface questionViewController : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITextField *answerField;
@property (nonatomic, retain) IBOutlet UIButton *submitButton;

-(IBAction)submit:(id)sender;

@end
