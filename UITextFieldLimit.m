//
//  UITextFieldLimit.m
//  UITextFieldLimit
//
//  NO LICENCE! WOHOOO! It's developed by Jonathan Gurebo! and it means that you can do whatever you like to do.
//  Sell it, modify it, distribute it, copy it, resell it, patent it. Do what-ever you like. But you can give me credit if you like to ;) OPTIONAL
//
//  Created by Jonathan Gurebo on 2014-04-12.
//  Copyright (c) 2014 Jonathan Gurebo. All rights reserved.
//

#import "UITextFieldLimit.h"

@implementation UITextFieldLimit
@synthesize limit,limitLabel,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        limit=10;// -- Default limit
        [super setDelegate:(id<UITextFieldLimitDelegate,UITextFieldDelegate>)self];
        [self initializeLimitLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)inCoder {
    self = [super initWithCoder:inCoder];
    if (self) {
        limit=10;// -- Default limit
        [super setDelegate:(id<UITextFieldLimitDelegate,UITextFieldDelegate>)self];
        [self initializeLimitLabel];
    }
    return self;
}

-(long)limit {
    return limit;
}

-(void)initializeLimitLabel {
    [self initializeLimitLabelWithFont:[UIFont fontWithName:@"AppleSDGothicNeo-Light" size:14.0] andTextColor:[UIColor redColor]];// <-- Customize the label font and color. BUT! By customizing the size and, you will have to change the bounds
}

-(void)setLimit:(long)theLimit {
    limit=theLimit;
    [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];
}

-(void)initializeLimitLabelWithFont:(UIFont *)font andTextColor:(UIColor *)textColor {
    limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-([[NSNumber numberWithFloat:font.pointSize] doubleValue]*(2.285714)), 8, 30, self.bounds.size.height)];

    [limitLabel setTextColor:textColor];
    [limitLabel setFont:font];
    
    [limitLabel setBackgroundColor:[UIColor clearColor]];
    [limitLabel setTextAlignment:NSTextAlignmentLeft];
    [limitLabel setNumberOfLines:1];
    [limitLabel setText:@""];
    [self setRightView:limitLabel];
    [self setRightViewMode:UITextFieldViewModeWhileEditing];
    [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];
    
    limitLabel.hidden=YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    long MAXLENGTH=limit;
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(newText.length==MAXLENGTH) {//Did reach limit
        if([self.delegate respondsToSelector:@selector(textFieldLimit:didReachLimitWithLastEnteredText:inRange:)]) {
            [self.delegate textFieldLimit:self didReachLimitWithLastEnteredText:string inRange:NSMakeRange(range.location, string.length)];
        }
    }
    if(newText.length>MAXLENGTH) {
        [self shakeLabel];
        if([self.delegate respondsToSelector:@selector(textFieldLimit:didWentOverLimitWithDisallowedText:inDisallowedRange:)]) {
            [self.delegate textFieldLimit:self didWentOverLimitWithDisallowedText:string inDisallowedRange:NSMakeRange(range.location, string.length)];
        }
        return NO;
    }
    [limitLabel setText:[NSString stringWithFormat:@"%lu",MAXLENGTH-newText.length]];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:self];//UITextFieldDelegate
    }
    limitLabel.hidden=YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];//UITextFieldDelegate
    }
    if(limitLabel.isHidden) {
        limitLabel.hidden=NO;
    }
}

-(void)shakeLabel {
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:2];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:
                         CGPointMake(limitLabel.center.x - 5,limitLabel.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:
                       CGPointMake(limitLabel.center.x + 5, limitLabel.center.y)]];
    [limitLabel.layer addAnimation:shake forKey:@"position"];
}



//UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:self];
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:self];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:self];
    }
    return YES;
}

@end
