//
//  SettingsView.m
//  CakePop
//
//  Created by Christina Yoon on 12/8/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "SettingsView.h"

@interface SettingsView() {
@private
    UILabel* settingsLabel;
}
@end

@implementation SettingsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        settingsLabel = [[UILabel alloc] init];
        settingsLabel.text = @"Settings Page";
        settingsLabel.font = [UIFont fontWithName:@"Helvetica" size:35];
        [self addSubview:settingsLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    settingsLabel.frame = CGRectMake(self.frame.size.width / 6, self.frame.size.height / 2, 300, 200);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
