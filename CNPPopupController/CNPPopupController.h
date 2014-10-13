//
//  CNPPopupController.h
//  CNPPopupController
//
//  Created by Carson Perrotti on 2014-09-28.
//  Copyright (c) 2014 Carson Perrotti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNPPopupTheme.h"

@protocol CNPPopupControllerDelegate;

typedef void (^CNPPopupActionBlock)(NSUInteger selectedIndex);

@interface CNPPopupController : UIView

@property (nonatomic, strong) NSAttributedString *popupTitle;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, strong) NSArray *buttonBlocks;
@property (nonatomic, strong) NSAttributedString *destructiveButtonTitle;
@property (nonatomic, copy) CNPPopupActionBlock destructiveButtonBlock;

@property (nonatomic, strong) CNPPopupTheme *theme;

@property (nonatomic, weak) id <CNPPopupControllerDelegate> delegate;

- (instancetype)initWithTitle:(NSAttributedString *)popupTitle
                     contents:(NSArray *)contents
                  buttonTitles:(NSArray *)buttonTitles
       destructiveButtonTitle:(NSAttributedString *)destructiveButtonTitle;

- (instancetype)initWithTitle:(NSAttributedString *)popupTitle
                     contents:(NSArray *)contents
                 buttonTitles:(NSArray *)buttonTitles
                 buttonBlocks:(NSArray *)buttonBlocks // Array of CNPPopupActionBlock's
       destructiveButtonTitle:(NSAttributedString *)destructiveButtonTitle
       destructiveButtonBlock:(CNPPopupActionBlock)destructiveButtonBlock;

- (void)presentPopupControllerAnimated:(BOOL)flag;
- (void)dismissPopupControllerAnimated:(BOOL)flag;

@end

@protocol CNPPopupControllerDelegate <NSObject>

@optional
- (void)popupControllerWillPresent:(CNPPopupController *)controller;
- (void)popupControllerDidPresent:(CNPPopupController *)controller;
- (void)popupController:(CNPPopupController *)controller willDismissWithButtonTitle:(NSString *)title;
- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title;

@end
