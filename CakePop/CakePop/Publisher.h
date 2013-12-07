//
//  Publisher.h
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Publisher : NSObject

@property (nonatomic, strong) NSString* imageName;
@property (nonatomic, assign) BOOL read;

- (id)initWithImageName:(NSString *)imageName;
- (void)setIsRead:(BOOL)isRead;

@end
