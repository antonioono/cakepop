//
//  PublisherCollectionViewCell.h
//  CakePop
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublisherCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString * imageName;
@property (nonatomic, strong) UILabel* label;

- (void)setNumber:(NSInteger)number;

@end
