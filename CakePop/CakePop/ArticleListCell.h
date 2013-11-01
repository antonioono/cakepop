//
//  ArticleListCell.h
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleListCell : UITableViewCell

@property(nonatomic, retain) UILabel* title;
@property(nonatomic, retain) NSString* backgroundImage;

- (void)setTitleText:(NSString *)titleText;

@end
