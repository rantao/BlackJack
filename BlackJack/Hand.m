//
//  Hand.m
//  BlackJack
//
//  Created by Ran Tao on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Hand.h"

@implementation Hand

@synthesize cards = _cards;
@synthesize value = _value;
@synthesize isDealersHand;

-(NSMutableArray*) cards {
    if (!_cards) {
        _cards = [NSMutableArray new];
    }
    return _cards;
}

-(bool) isBlackJack {
    if ( [self.cards count] == 2) {
        int hand_values[2];
        Card *firstCard = [self.cards objectAtIndex:0];
        hand_values[0] = [firstCard value];
        Card *secondCard = [self.cards objectAtIndex:1];
        hand_values[1] = [secondCard value];
        if ((hand_values[1] == 11 && hand_values[0] == 10) ||
            (hand_values[0] == 11 && hand_values[1] == 10)) {
            return YES;
        }
        
    }
    return NO;
}

- (IBAction)playerHitorStay:(UIButton *)sender {
    
}

-(int) value {
    _value = 0;
    for (Card* card in self.cards){
        _value += card.value;
    }
    
    //if value >21 check for aces
    if (_value > 21) {
        for (Card* card in self.cards) {
            if (card.value == 11) {
                card.value = 1;
                return [self value];
            }
        }
    }
    
    return _value;
}

-(NSString*) description {
    if (self.isDealersHand && [self.cards count] == 2) {
        return [NSString stringWithFormat:@"[Dealer's first card hidden]\n%@",[self.cards objectAtIndex:1]];
    } else {
        return [NSString stringWithFormat:[self.cards componentsJoinedByString:@"\n"]];
    }
}

@end
