//
//  Bird.m
//  FlappyBird
//
//  Created by Hai Do Minh on 3/7/14.
//  Copyright (c) 2014 Hai Do Minh. All rights reserved.
//

#import "Bird.h"
#import "CCAnimation.h"
#import "GameConfig.h"

@implementation Bird

@synthesize scene, sprBird, state, type;

-(id) initWithType:(BirdType)pType position:(CGPoint)pPos scene:(CCScene*)pScene {
    self = [super init];
    if (!self) return(nil);
    
    self.scene = pScene;
    self.type = pType;
    self.state = BIRD_STATE_STAND;
    
    NSMutableDictionary* atlasInfo = GameConfig.atlasInfo;
    CCTexture *atlas = GameConfig.atlas;
    
    NSString* birdBaseResource = [NSString stringWithFormat:@"bird%i_", pType];
    // bird animatin
    NSMutableArray* spriteFrames = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        NSString *resource = [NSString stringWithFormat:@"%@%i", birdBaseResource, i];
        NSArray *charInfo = [atlasInfo objectForKey:resource];
        CGSize birdSizeInPixels = CGSizeMake([[charInfo objectAtIndex:1] intValue], [[charInfo objectAtIndex:2] intValue]);
        CGRect birdRectInPixels = {CGPointMake([[charInfo objectAtIndex:3] intValue], [[charInfo objectAtIndex:4] intValue]), birdSizeInPixels};
        CCSpriteFrame* spriteFrame = [CCSpriteFrame frameWithTexture:atlas rectInPixels:birdRectInPixels rotated:NO offset:CGPointZero originalSize:birdSizeInPixels];
        [spriteFrames addObject:spriteFrame];
    }
    self.sprBird = [CCSprite spriteWithSpriteFrame:[spriteFrames objectAtIndex:0]];
    self.sprBird.position = pPos;
    [self.sprBird runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:[CCActionMoveTo actionWithDuration:0.45 position:ccp(pPos.x, pPos.y - 5)], [CCActionMoveTo actionWithDuration:0.45 position:ccp(pPos.x, pPos.y + 20)], nil]]];

    CCAnimation* animation = [CCAnimation animationWithSpriteFrames: spriteFrames delay:0.1];
    CCActionAnimate* actionAnimate = [CCActionAnimate actionWithAnimation:animation];
    [self.sprBird runAction:[CCActionRepeatForever actionWithAction:actionAnimate]];
    [self.scene addChild:self.sprBird];
    
    return self;
}

@end
