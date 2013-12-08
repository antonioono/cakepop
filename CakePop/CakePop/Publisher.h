//
//  Publisher.h
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Publisher : NSObject

@property (nonatomic, strong) NSString* headerLogoImage;
@property (nonatomic, strong) NSString* imageNameUnread;
@property (nonatomic, strong) NSString* imageNameRead;
@property (nonatomic, assign) BOOL isRead;

- (id)initWithImageNameUnread:(NSString *)imageNameUnread imageNameRead:(NSString *)imageNameRead;
- (id)initWithImageNameUnread:(NSString *)imageNameUnread imageNameRead:(NSString *)imageNameRead headerLogoImage:(NSString *)headerLogoImage;
- (void)setIsRead:(BOOL)isRead;

@end
