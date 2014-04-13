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
@synthesize limit,limitLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        limit=10;// -- Default limit
        [self initializeLimitLabel];
        self.delegate=self;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)inCoder {
    if (self = [super initWithCoder:inCoder]) {
        limit=10;// -- Default limit
        [self initializeLimitLabel];
        self.delegate = self;
    }
    return self;
}

-(id)init {
    limit=10;// -- Default limit
    [self initializeLimitLabel];
    self.delegate=self;
    return self;
}

-(long)limit {
    return limit;
}

-(void)initializeLimitLabel {
    [self initializeLimitLabelWithFont:[UIFont fontWithName:@"AppleSDGothicNeo-Light" size:14.0] andTextColor:[UIColor blackColor]];// <-- Customize the label font and color. BUT! By customizing the size and, you will have to change the bounds
}

-(void)setLimit:(long)theLimit {
    limit=theLimit;
    [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];
}

-(void)initializeLimitLabelWithFont:(UIFont *)font andTextColor:(UIColor *)textColor {
    limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-([[NSNumber numberWithFloat:font.pointSize] doubleValue]*(2.285714)), 8, 30, self.bounds.size.height)];
    
    if (!_defaultTextSize) {
        _defaultTextSize = 14.0;
    }
    
    if (_countTextColor) {
        [limitLabel setTextColor:_countTextColor];
    }else{
        [limitLabel setTextColor:textColor];
    }
    
    if (_countFont) {
        [limitLabel setFont:_countFont];
    } else {
        [limitLabel setFont:font];
    }
    
    [limitLabel setBackgroundColor:[UIColor clearColor]];
    [limitLabel setAdjustsFontSizeToFitWidth:_fitCountTextSize];
    [limitLabel setTextAlignment:NSTextAlignmentLeft];
    [limitLabel setNumberOfLines:1];
    [limitLabel setText:@""];
    [self setRightView:limitLabel];
    [self setRightViewMode:UITextFieldViewModeWhileEditing];
    [self textField:self shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@""];
    
    limitLabel.hidden=YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    long MAXLENGTH=limit;
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(newText.length>MAXLENGTH) {
        [self shakeLabel];
        return NO;
    }
    [limitLabel setText:[NSString stringWithFormat:@"%lu",MAXLENGTH-newText.length]];
    
    return YES;
}

-(long)expectedLabelWidthWithText:(NSString *)text andFont:(UIFont *)font {
    CGRect labelRect = [text
                        boundingRectWithSize:CGSizeMake(200, 0)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{
                                     NSFontAttributeName : limitLabel.font
                                     }
                        context:nil];
    return labelRect.size.width;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    limitLabel.hidden=YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
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

@end
