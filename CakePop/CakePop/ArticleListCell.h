//
//  ArticleListCell.h
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleListCell : UITableViewCell

@property(nonatomic, strong) UILabel* title;
@property(nonatomic, strong) NSString* backgroundImage;

- (void)setTitleText:(NSString *)titleText;

@end
