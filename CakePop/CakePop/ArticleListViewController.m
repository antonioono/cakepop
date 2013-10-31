//
//  ArticleListViewController.m
//  CakePop
//
//  ViewController for the ArticleListTableView (View with the list of articles)
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"

#import "ArticleListViewController.h"

@interface ArticleListViewController() {
@private
    NSMutableArray* source;
}
@end

@implementation ArticleListViewController

- (id)init
{
    self = [super init];
    if (self) {
        source = [[NSMutableArray alloc] init];
        [self initializeSourceArray];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
 * Number of rows in the tableview since we only have one section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Num elem is: %d", [source count]);
    return [source count];
}

/*
 * Create Cell for the given index
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell.
    Article* article = [source objectAtIndex:indexPath.row];
    cell.textLabel.text = article.titleText;
    return cell;
}

/*
 * Create array that contains all of the Article data objects used to make the cells later on
 */
- (void)initializeSourceArray
{
    NSString* article1TitleText = @"Article one title";
    NSString* article1BodyText = @"Article one body text yay";
    NSString* article1ImageName = @"";
    Article* article1 = [[Article alloc] initWithTitleText:article1TitleText bodyText:article1BodyText imageName:article1ImageName];
    
    NSString* article2TitleText = @"Article two title";
    NSString* article2BodyText = @"Article two body text yay";
    NSString* article2ImageName = @"";
    Article* article2 = [[Article alloc] initWithTitleText:article2TitleText bodyText:article2BodyText imageName:article2ImageName];
    
    NSString* article3TitleText = @"Article three title";
    NSString* article3BodyText = @"Article three body text yay";
    NSString* article3ImageName = @"";
    Article* article3 = [[Article alloc] initWithTitleText:article3TitleText bodyText:article3BodyText imageName:article3ImageName];
    
    NSString* article4TitleText = @"Article four title";
    NSString* article4BodyText = @"Article one body text yay";
    NSString* article4ImageName = @"";
    Article* article4 = [[Article alloc] initWithTitleText:article4TitleText bodyText:article4BodyText imageName:article4ImageName];
    
    NSString* article5TitleText = @"Article five title";
    NSString* article5BodyText = @"Article five body text yay";
    NSString* article5ImageName = @"";
    Article* article5 = [[Article alloc] initWithTitleText:article5TitleText bodyText:article5BodyText imageName:article5ImageName];
    
    [source addObject:article1];
    [source addObject:article2];
    [source addObject:article3];
    [source addObject:article4];
    [source addObject:article5];
}

@end
