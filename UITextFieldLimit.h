//
//  UITextFieldLimit.h
//  UITextFieldLimit
//
//  NO LICENCE! WOHOOO! It's developed by Jonathan Gurebo! and it means that you can do whatever you like to do.
//  Sell it, modify it, distribute it, copy it, resell it, patent it. Do what-ever you like. But you can give me credit if you like to ;) OPTIONAL
//
//  Created by Jonathan Gurebo on 2014-04-12.
//  Copyright (c) 2014 Jonathan Gurebo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITextFieldLimit;

@protocol UITextFieldLimitDelegate<UITextFieldDelegate>

@optional
-(void)textFieldLimit:(UITextFieldLimit *)textFieldLimit didWentOverLimitWithDisallowedText:(NSString *)text inDisallowedRange:(NSRange)range;
-(void)textFieldLimit:(UITextFieldLimit *)textFieldLimit didReachLimitWithLastEnteredText:(NSString *)text inRange:(NSRange)range;
@end

@interface UITextFieldLimit : UITextField<UITextFieldDelegate> {
    long limit;
    UILabel *limitLabel;
}
@property (nonatomic, assign) id<UITextFieldLimitDelegate> delegate;

@property (readwrite, nonatomic) long limit;
@property (retain, nonatomic) UILabel *limitLabel;

@end
