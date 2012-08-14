//
//  Deck.h
//  BlackJack
//
//  Created by Ran Tao & Eddie Kim on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(Card*) dealCard;
-(void) newDeck;
-(bool) isShuffleNeeded;

@end
