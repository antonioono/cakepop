//
//  ArticleCollectionViewHeader.h
//  CakePop
//
//  Created by Christina Yoon on 12/7/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Publisher;

@protocol ArticleCollectionViewHeaderDelegate <NSObject>
@required
- (void) backPressed;
@end

@interface ArticleCollectionViewHeader : UICollectionReusableView

@property(nonatomic, strong) id<ArticleCollectionViewHeaderDelegate> delegate;
@property(nonatomic, strong) NSString* headerImageName;

@end
