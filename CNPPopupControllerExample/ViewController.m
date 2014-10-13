//
//  ViewController.m
//  CNPPopupControllerExample
//
//  Created by Carson Perrotti on 2014-09-28.
//  Copyright (c) 2014 Carson Perrotti. All rights reserved.
//

#import "ViewController.h"

#import "CNPPopupController.h"

#define CNP_USE_BLOCKS 1

@interface ViewController () <CNPPopupControllerDelegate>

@end

@implementation ViewController


-(void)showPopupCentered:(id)sender {
    [self showPopupWithStyle:CNPPopupStyleCentered];
}

- (void)showPopupFormSheet:(id)sender {
    [self showPopupWithStyle:CNPPopupStyleActionSheet];
}

- (void)showPopupFullscreen:(id)sender {
    [self showPopupWithStyle:CNPPopupStyleFullscreen];
}

- (void)showPopupWithStyle:(CNPPopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"It's A Popup!" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:@"You can add text and images" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    UIImage *icon = [UIImage imageNamed:@"icon"];
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"With style, using NSAttributedString" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSAttributedString *buttonTitle = [[NSAttributedString alloc] initWithString:@"Close me" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor], NSParagraphStyleAttributeName : paragraphStyle}];
    CNPPopupActionBlock actionBlock = ^(NSUInteger selectedIndex){
        NSLog(@"Dismissed with button index: %lu", (unsigned long)selectedIndex);
    };

    CNPPopupController *popupController;

    if (CNP_USE_BLOCKS) {
         popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne, icon, lineTwo] buttonTitles:@[buttonTitle] buttonBlocks:@[actionBlock] destructiveButtonTitle:nil destructiveButtonBlock:nil];
    } else {
        popupController = [[CNPPopupController alloc] initWithTitle:title contents:@[lineOne, icon, lineTwo] buttonTitles:@[buttonTitle] destructiveButtonTitle:nil];
    }

    popupController.theme = [CNPPopupTheme defaultTheme];
    popupController.theme.popupStyle = popupStyle;
    popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromTop;
    popupController.theme.dismissesOppositeDirection = YES;
    popupController.delegate = self;
    [popupController presentPopupControllerAnimated:YES];
}

#pragma mark - CNPPopupController Delegate 

- (void)popupController:(CNPPopupController *)controller didDismissWithButtonTitle:(NSString *)title {
    NSLog(@"Dismissed with button title: %@", title);
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller {
    NSLog(@"Popup controller presented.");
}

@end
