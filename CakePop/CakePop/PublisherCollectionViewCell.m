//
//  PublisherCollectionViewCell.m
//  CakePop
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "PublisherCollectionViewCell.h"

@implementation PublisherCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat borderWidth = 3.0f;
        CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
        UIView* myContentView = [[UIView alloc]initWithFrame:myContentRect];
        myContentView.backgroundColor = [UIColor whiteColor];
        myContentView.layer.borderColor = [UIColor blackColor].CGColor;
        myContentView.layer.borderWidth = borderWidth;
        [self.contentView addSubview:myContentView];
        
        [self setNumber:0];
    }
    return self;
}

- (void)setNumber:(NSInteger)number
{
    self.cellNumber = number;
}

- (void)setImage:(NSString*)imageName isRead:(BOOL)isRead
{
    NSLog(@"Item number is: %d, imageName is: %@", self.cellNumber, imageName);
    self.imageName = imageName;
    UIImage* image = [UIImage imageNamed:imageName];
    
    if (!isRead) {
        [self.imageView setImage:image];
    } else {
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *inputImage = [[CIImage alloc] initWithImage:image]; //your input image
        
        CIFilter *filter= [CIFilter filterWithName:@"CIColorControls"];
        [filter setValue:inputImage forKey:@"inputImage"];
        [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputBrightness"];
        
        // Your output image
        UIImage *darkenedImage = [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
        [self.imageView setImage:darkenedImage];
    }
    
}




- (void)prepareForReuse {
    [super prepareForReuse];
    [self setNeedsDisplay];
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
