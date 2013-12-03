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
#import "ArticleListCell.h"
#import "ArticleViewController.h"

#import "ArticleListViewController.h"

#define NUM_SECTIONS 1
#define CELL_HEIGHT 150


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
    return [source count];
}

/*
 * Create Cell for the given index
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";

   ArticleListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ArticleListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell
    Article* article = [source objectAtIndex:indexPath.row];
    [cell setTitleText:article.titleText];
    
    if (![article.imageName isEqualToString:@""]) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:article.imageName]];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

/*
 * Called when a row in the table is selected
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected row at %d", indexPath.row);

    Article* article = [source objectAtIndex:indexPath.row];
    
    /*
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
*/
    
    ArticleViewController* articleViewController = [[ArticleViewController alloc] initWithArticle:article];
    //articleViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentModalViewController:articleViewController animated:YES];
    
    //[self.navigationController pushViewController:articleViewController animated:YES];
}

/*
 * Create array that contains all of the Article data objects used to make the cells later on
 */
- (void)initializeSourceArray
{
    NSString* article1TitleText = @"Article one title";
    NSString* article1BodyText = @"Article one body text: Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! END OF TEXT";
    NSString* article1ImageName = @"Dismemberment Plan.png";
    NSString* article1AuthorName = @"Author1 name";
    NSString* article1URI = @"www.article1.com";
    Article* article1 = [[Article alloc] initWithTitleText:article1TitleText bodyText:article1BodyText imageName:article1ImageName authorName:article1AuthorName uri:article1URI];
    
    NSString* article2TitleText = @"Article two title";
    NSString* article2BodyText = @"Article two body text yay";
    NSString* article2ImageName = @"";
    NSString* article2AuthorName = @"Author2 name";
    NSString* article2URI = @"www.article2.com";
    Article* article2 = [[Article alloc] initWithTitleText:article2TitleText bodyText:article2BodyText imageName:article2ImageName authorName:article2AuthorName uri:article2URI];
    
    NSString* article3TitleText = @"Article three title";
    NSString* article3BodyText = @"Article three body text yay";
    NSString* article3ImageName = @"";
    NSString* article3AuthorName = @"Author3 name";
    NSString* article3URI = @"www.article3.com";
    Article* article3 = [[Article alloc] initWithTitleText:article3TitleText bodyText:article3BodyText imageName:article3ImageName authorName:article3AuthorName uri:article3URI];
    
    NSString* article4TitleText = @"Article four title";
    NSString* article4BodyText = @"Article one body text yay";
    NSString* article4ImageName = @"";
    NSString* article4AuthorName = @"Author4 name";
    NSString* article4URI = @"www.article4.com";
    Article* article4 = [[Article alloc] initWithTitleText:article4TitleText bodyText:article4BodyText imageName:article4ImageName authorName:article4AuthorName uri:article4URI];
    
    NSString* article5TitleText = @"Article five title";
    NSString* article5BodyText = @"Article five body text yay";
    NSString* article5ImageName = @"";
    NSString* article5AuthorName = @"Author5 name";
    NSString* article5URI = @"www.article5.com";
    Article* article5 = [[Article alloc] initWithTitleText:article5TitleText bodyText:article5BodyText imageName:article5ImageName authorName:article5AuthorName uri:article5URI];
    
    [source addObject:article1];
    [source addObject:article2];
    [source addObject:article3];
    [source addObject:article4];
    [source addObject:article5];
}

@end
