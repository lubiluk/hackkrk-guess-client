//
//  questionViewController.h
//  HackKrk6
//
//  Created by Grzegorz Krukiewicz-Gacek on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networking.h"

@interface questionViewController : UIViewController {
    
    NSString *_answerString;
    NSString *_questionString;
    NSInteger _riddleID;
    NSDictionary *_riddle;
    
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UITextField *answerField;
@property (nonatomic, retain) IBOutlet UIButton *submitButton;

@property (nonatomic, retain) NSString *_answerString;
@property (nonatomic, retain) NSString *_questrionString;
@property (nonatomic, readwrite) NSInteger _riddleID;
@property (nonatomic, retain) NSDictionary *_riddle;

-(IBAction)submit:(id)sender;

@end
