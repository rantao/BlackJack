//
//  ViewController.m
//  BlackJack
//
//  Created by Ran Tao & Eddie Kim on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "Hand.h"

@interface ViewController ()
@property (nonatomic, strong) Deck* deck;
@property (nonatomic, strong) Hand* dealersHand;
//@property (nonatomic, strong) Hand* playersHand;
@property (nonatomic, strong) NSMutableArray* playerHands;
@property (nonatomic) int currentHandIndex;
@property (nonatomic) int wins;
@property (nonatomic) int losses;
@property (nonatomic) bool gameStarted;
@end

@implementation ViewController
@synthesize gameStarted = _gameStarted;
@synthesize playerHands = _playerHands;
@synthesize dealButton = _dealButton;
@synthesize playersHandText = _playersHandText;
@synthesize hitButton = _hitButton;
@synthesize stayButton = _stayButton;
@synthesize dealersHandText = _dealersHandText;
@synthesize numWins = _numWins;
@synthesize doubleDownButton = _doubleDownButton;
@synthesize splitButton = _splitButton;
@synthesize numLosses = _numLosses;
@synthesize dealersHand = _dealersHand;
//@synthesize playersHand = _playersHand;
@synthesize currentHandIndex = _currentHandIndex;
@synthesize deck = _deck;
@synthesize wins = _wins;
@synthesize losses = _losses;

-(void) showAlert:(NSString*)title withMessage:(NSString*)msg withButton:(NSString*)btn {
    UIAlertView* alert = [[UIAlertView alloc]
                          initWithTitle:title message:msg delegate:nil cancelButtonTitle:btn otherButtonTitles:nil];
    [alert show];
}

-(NSMutableArray *) playerHands {
    if (!_playerHands) {
        _playerHands = [NSMutableArray new];
    }
    return _playerHands;
}

-(void) nextHand {
    self.currentHandIndex++;
    [self updateHands];
    if (self.currentHandIndex >= [self.playerHands count]) {
        [self hidePlayerButtons:YES];
        [self dealersTurn];
        return;
    }
    Hand* currHand = [self.playerHands objectAtIndex:self.currentHandIndex];
    if ([currHand isBlackJack]){
        [self nextHand];
        return;
    }
}

-(void) playerWins:(NSString*) msg {
    [self showAlert:@"You win!!" withMessage:msg withButton:@"Deal another hand!!!"];
    self.numWins.text = [NSString stringWithFormat:@"%d",++self.wins];
}

-(void) playerLoses:(NSString*) msg {
    [self showAlert:@"You lose!!" withMessage:msg withButton:@"Continue"];
    self.numLosses.text = [NSString stringWithFormat:@"%d",++self.losses];
}

-(void) playerTies:(NSString*) msg{
    [self showAlert:@"You tied!!" withMessage:msg withButton:@"Deal another hand!!!"];
}

-(void) playerBusted:(NSString*) msg {
    Hand* currHand = [self.playerHands objectAtIndex:self.currentHandIndex];
    currHand.isBusted = YES;
    [self showAlert:@"You busted!!" withMessage:msg withButton:@"Continue"];
}

-(void) hidePlayerButtons:(bool)val {
    [self.hitButton setHidden:val];
    [self.stayButton setHidden:val];
    [self.dealButton setHidden:!val];
    [self.doubleDownButton setHidden:val];
}

- (bool) needNewDeck {
    if (!self.deck){
        return YES;
    }
    return [self.deck isShuffleNeeded];
}

-(void) checkIfNewDeckNeeded {
    if ([self needNewDeck]) {
        self.deck = [Deck new];
        [self.deck newDeck];
        if (self.gameStarted) {
            [self showAlert:@"Shuffling new deck!!" withMessage:@"guess you have to start your count over huh?" withButton:@"let's play!!!"];
        }
    }
}

- (void) dealFirstTwoCards {
    self.dealersHand = [Hand new];
    self.dealersHand.isDealersHand = YES;
    Hand* playersHand = [Hand new];
    [playersHand.cards addObject:[self.deck dealCard]];
    [self.dealersHand.cards addObject:[self.deck dealCard]];
    [playersHand.cards addObject:[self.deck dealCard]];
    [self.dealersHand.cards addObject:[self.deck dealCard]];
    [self.playerHands addObject:playersHand];
    
    Card* firstCard = [[playersHand cards] objectAtIndex:0];
    Card* secondCard = [[playersHand cards] lastObject];
    if (firstCard.value == secondCard.value) {
        [self.splitButton setHidden:NO];
    }
}

-(void) updateHands {
    self.dealersHandText.text = [NSString stringWithFormat:@"%@",self.dealersHand];
    
    //self.playersHandText.text = [NSString stringWithFormat:@"%@",self.playersHand];
    NSMutableString* handsString = [NSMutableString new];
    for (int i=0; i < [self.playerHands count]; i++) {
        if (self.currentHandIndex ==i && [self.playerHands count]>1) {
            [handsString appendString:@"====>"];
        }
        Hand * handAtIndex = [self.playerHands objectAtIndex:i];
        [handsString appendFormat:@"%@\n\n",handAtIndex];
    }
    self.playersHandText.text = handsString;
}

-(bool) checkForBlackJack {
    Hand* playersHand = [self.playerHands objectAtIndex:0];
    if ( [self.dealersHand isBlackJack] && [playersHand isBlackJack] ) {
        [self playerTies:@"Both player and dealer have blackjack!"];
        return YES;
    } else if ( [self.dealersHand isBlackJack] ) {
        [self playerLoses:@"=("];
        return YES;
    } else if ( [playersHand isBlackJack] ) {
        [self playerWins:@"=)"];
        return YES;
    }
    return NO;
}

- (IBAction)dealPressed {
    [self checkIfNewDeckNeeded];
    self.playerHands = nil;
    self.currentHandIndex = -1;
    [self dealFirstTwoCards];
    [self updateHands];
    self.gameStarted = YES;
    if ([self checkForBlackJack]) {
        self.dealersHand.isDealersHand = NO;
        [self updateHands];
        return;
    }
    [self hidePlayerButtons:NO];
    [self nextHand];
}

- (bool) areAllPlayerHandsBusted {
    for (int i = 0; i < [self.playerHands count]; i++) {
        Hand* currHand = [self.playerHands objectAtIndex:i];
        if (!currHand.isBusted) {
            return NO;
        }
    }
    return YES;
}

- (IBAction)doubleDownPressed:(UIButton *)sender {
    [self hidePlayerButtons:YES];
    self.doubleDownButton.hidden = YES;
      Hand* playersHand = [self.playerHands objectAtIndex:self.currentHandIndex];
    [playersHand.cards addObject:[self.deck dealCard]];
    [self updateHands];
    if (playersHand.value > 21) {
        [self playerBusted:@"=("];
        [self dealersTurn];
        return;
    }
    [self nextHand];
}

- (IBAction)splitPressed:(UIButton *)sender {
    Hand* currHand = [self.playerHands objectAtIndex:self.currentHandIndex];
    Card* firstCard = [currHand.cards objectAtIndex:0];
    Card* secondCard = [currHand.cards lastObject];
    
    Hand* firstHand = [Hand new];
    Hand* secondHand = [Hand new];
    [firstHand.cards addObject:firstCard];
    [firstHand.cards addObject:[self.deck dealCard]];
    [secondHand.cards addObject:secondCard];
    [secondHand.cards addObject:[self.deck dealCard]];
    
    [self.playerHands removeObjectAtIndex:self.currentHandIndex];
    [self.playerHands addObject:firstHand];
    [self.playerHands addObject:secondHand];
    
    [self updateHands];
    [self.doubleDownButton setHidden:YES];
    [self.splitButton setHidden:YES];
}


-(void) determineWinner {

    NSMutableString* result = [NSMutableString new];
    if (self.dealersHand.isBusted) {
        [result appendFormat:@"Dealer busted with %d!\n", self.dealersHand.value];
        for (int i = 0; i < [self.playerHands count]; i++) {
            Hand * currentHand = [self.playerHands objectAtIndex:i];
            if(!currentHand.isBusted) {
                [result appendFormat:@"Hand %d won with %d!\n", i+1, currentHand.value];
                self.numWins.text = [NSString stringWithFormat:@"%d",++self.wins];
            }
            else {
                [result appendFormat:@"Hand %d busted as well...\n", i+1];
            }
        }
    } else {
        [result appendFormat:@"Dealer has %d\n", self.dealersHand.value];
        for (int i=0; i< [self.playerHands count]; i++) {
            Hand *currentHand = [self.playerHands objectAtIndex:i];
            if (currentHand.isBusted) {
                [result appendFormat:@"Hand %d busted with %d...\n",i+1, currentHand.value];
                self.numLosses.text = [NSString stringWithFormat:@"%d",++self.losses];
            } else {
                if (currentHand.value > self.dealersHand.value) {
                    [result appendFormat:@"Hand %d won with %d!\n", i+1, currentHand.value];
                    self.numWins.text = [NSString stringWithFormat:@"%d",++self.wins];
                } else if (currentHand.value < self.dealersHand.value) {
                    [result appendFormat:@"Hand %d lost with %d :(\n", i+1, currentHand.value];
                    self.numLosses.text = [NSString stringWithFormat:@"%d",++self.losses];
                } else {
                    [result appendFormat:@"Hand %d pushed with %d\n", i+1, currentHand.value];
                }
            }
        }
    }
    
    [self showAlert:@"Results" withMessage:result withButton:@"Play again!"];
    
}

-(void) dealersTurn {
    self.dealersHand.isDealersHand = NO;
    if ([self areAllPlayerHandsBusted]) {
        [self updateHands];
        [self determineWinner];
        return;
    }
    while (self.dealersHand.value<17) {
        [self.dealersHand.cards addObject:[self.deck dealCard]];
    }
    if (self.dealersHand.value > 21) {
        self.dealersHand.isBusted = YES;
    }
    [self updateHands];
    [self determineWinner];
}

- (IBAction)playerHitorStay:(UIButton *)sender {
  Hand* playersHand = [self.playerHands objectAtIndex:self.currentHandIndex];
    if ([sender.titleLabel.text isEqualToString:@"Hit"]) {
        [playersHand.cards addObject:[self.deck dealCard]];
        [self updateHands];
        
        if (playersHand.value > 21) {
            [self playerBusted:@"=("];
            [self nextHand];
        }
    } else if ([sender.titleLabel.text isEqualToString:@"Stay"]) {
        [self nextHand];
    }
    [self.doubleDownButton setHidden:YES];
    [self.splitButton setHidden:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setDealersHand:nil];
    [self setPlayerHands:nil];
    [self setHitButton:nil];
    [self setStayButton:nil];
    [self setNumWins:nil];
    [self setNumLosses:nil];
    [self setDealButton:nil];
    [self setDoubleDownButton:nil];
    [self setSplitButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
