//
//  Deck.m
//  BlackJack
//
//  Created by Ran Tao on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (nonatomic, strong) NSMutableArray* cardDeck;
@property (nonatomic, strong) NSArray* suits;
@property (nonatomic, strong) NSArray* labels;
@end

@implementation Deck

@synthesize cardDeck = _cardDeck;
@synthesize suits = _suits;
@synthesize labels = _labels;

-(NSArray*) suits {
    if (!_suits) {
        _suits = [[NSArray alloc] initWithObjects:@"♥",@"♠",@"♣",@"♦", nil];
    }
    return _suits;
}

-(NSArray*) labels {
    if (!_labels) {
        _labels = [[NSArray alloc] initWithObjects:@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K", nil];
    }
    return _labels;
}

-(NSMutableArray*) cardDeck {
    if (!_cardDeck) {
        _cardDeck = [NSMutableArray new];
    }
    return _cardDeck;
}


-(void) newDeck {
    self.cardDeck = nil;
    for ( NSString* suit in self.suits) {
        for ( int i = 0; i< [self.labels count]; ++i ) {
            int cardValue = (i==0) ? 11 : ((i+1>10)?10:i+1);
            Card* newCard = [[Card alloc] initWithLabel:[[self labels]objectAtIndex:i] withValue:cardValue withSuit:suit];
            [self.cardDeck addObject:newCard];
        }
    }
    NSLog(@"New Deck: %@",self.cardDeck);
}

-(Card*) dealCard {
    int index = arc4random() % [self.cardDeck count];
    Card* ret = [self.cardDeck objectAtIndex:index];
    [self.cardDeck removeObjectAtIndex:index];
    return ret;
}

-(bool) isShuffleNeeded {
    return [self.cardDeck count] < 26;
}

-(NSString*) description {
    return [self.cardDeck componentsJoinedByString:@","]; 
}

@end
