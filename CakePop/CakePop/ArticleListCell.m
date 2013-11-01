//
//  ArticleListCell.m
//  CakePop
//
//  One cell for the article list tableview
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "ArticleListCell.h"

@implementation ArticleListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_title];
        
    }
    return self;
}

- (void)setTitleText:(NSString *)titleText
{
    _title.text = titleText;
}

- (void)layoutSubviews
{
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    
    //Currently randomly placed frame
    CGRect labelFrame= CGRectMake(boundsX+70 ,5, 200, 25);
    _title.frame = labelFrame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
