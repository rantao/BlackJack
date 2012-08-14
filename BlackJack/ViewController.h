//
//  ViewController.h
//  BlackJack
//
//  Created by Ran Tao & Eddie Kim on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UILabel *playersHandText;
//@property (weak, nonatomic) IBOutlet UITextView *playersHandText;
@property (weak, nonatomic) IBOutlet UILabel *dealersHandText;
@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *stayButton;
//@property (weak, nonatomic) IBOutlet UITextView *dealersHandText;
@property (weak, nonatomic) IBOutlet UILabel *numWins;
@property (weak, nonatomic) IBOutlet UIButton *doubleDownButton;
@property (weak, nonatomic) IBOutlet UIButton *splitButton;
@property (weak, nonatomic) IBOutlet UILabel *numLosses;
- (IBAction)dealPressed;
- (IBAction)playerHitorStay:(UIButton *)sender;
- (IBAction)doubleDownPressed:(UIButton *)sender;
- (IBAction)splitPressed:(UIButton *)sender;

@end
