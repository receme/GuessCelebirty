//
//  PrepareString.m
//  GuessCelebrity
//
//  Created by Muzahid on 1/4/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//

#import "PrepareString.h"
#define k_CharSet @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define k_Total_Length 12


@implementation PrepareString

-(id)init{
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

-(NSString *)makeResultStingFromString:(NSString *)inputString{
    
   // NSString *str1 = [self removeRepeatation:inputString];
    int expectedLength = k_Total_Length-(int)[inputString length];
    NSMutableString *newString = [self randomStringWithLength:k_CharSet sting:inputString ofLength:expectedLength];
    [newString appendString:inputString];
    NSMutableString *resultString = [NSMutableString stringWithCapacity: newString.length];
    resultString = (NSMutableString *)[self shuffleString:newString];
    return resultString;
}

-(NSMutableString *) randomStringWithLength:(NSString*)letters sting:(NSString*)newString ofLength:(int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    while (randomString.length<len){
        NSString* randoomCharString =[NSString stringWithFormat:@"%c",[letters characterAtIndex:arc4random_uniform((u_int32_t)[letters length])]];
        
        if ([newString rangeOfString:randoomCharString].location == NSNotFound){
            [randomString appendString:randoomCharString];
        }
      //  randomString = (NSMutableString*)[self removeRepeatation:randomString];
    }
    
    return randomString;
}

-(NSString *)shuffleString:(NSString *)finalLettersString{
    
    int length = (int)[finalLettersString length];
    
    if (!length) return @""; // nothing to shuffle
    
    unichar *buffer = calloc(length, sizeof (unichar));
    
    [finalLettersString getCharacters:buffer range:NSMakeRange(0, length)];
    
    for(int i = length - 1; i >= 0; i--){
        
        int j = arc4random() % (i + 1);
        unichar c = buffer[i];
        buffer[i] = buffer[j];
        buffer[j] = c;
    }
    
    NSString *result = [NSString stringWithCharacters:buffer length:length];
    free(buffer);
    
    finalLettersString = result;
    return finalLettersString;
}

-(NSString*)removeRepeatation:(NSString *)input{
    
    NSMutableSet *seenCharacters = [NSMutableSet set];
    NSMutableString *result = [NSMutableString string];
    [input enumerateSubstringsInRange:NSMakeRange(0, input.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (![seenCharacters containsObject:substring]) {
            [seenCharacters addObject:substring];
            [result appendString:substring];
        }
    }];
    return result;
    
}

@end
