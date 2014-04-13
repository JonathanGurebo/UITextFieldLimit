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

@interface UITextFieldLimit : UITextField<UITextFieldDelegate> {
    long limit;
    IBOutlet UILabel *limitLabel;
}
@property (readwrite, nonatomic) long limit;
@property (retain, nonatomic) IBOutlet UILabel *limitLabel;

@property (nonatomic, strong) UIColor *countTextColor;
@property (nonatomic, strong) UIColor *countLabelBackgroundColor;
@property (nonatomic, strong) UIFont *countFont;
@property (nonatomic, assign) CGFloat defaultTextSize;
@property (nonatomic, assign) BOOL fitCountTextSize;


@end
