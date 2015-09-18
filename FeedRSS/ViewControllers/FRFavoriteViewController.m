//
//  FRFavoriteViewController.m
//  FeedRSS
//
//  Created by KinhNM1 on 9/16/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRFavoriteViewController.h"
#import "ArticleTableViewCell.h"
#import "FRDetailViewController.h"
#import "FRPost.h"
#import "FRFavoriteBusinessController.h"

@interface FRFavoriteViewController ()
{
    FRFavoriteBusinessController *favBusinessController;
}

@property (weak, nonatomic) IBOutlet UITableView *tblFavorite;

@end

@implementation FRFavoriteViewController

@synthesize posts;
@synthesize table;
@synthesize postDAO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postDAO = [FRPostDAO sharedInstance];
    self.posts = [self.postDAO listAllFavorite];
    
    if(self.posts.count == 0) {
        [self.postDAO populateWithDummies];
        self.posts = [self.postDAO listAllFavorite];
    }
    
//   [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([SimpleTableCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SimpleTableCell class])];
    
    favBusinessController = [[FRFavoriteBusinessController alloc] init];
    self.tblFavorite.dataSource = favBusinessController.dataSource;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak __typeof(self)weakSelf = self;
    [favBusinessController loadAllFavorites:^{
        [weakSelf.tblFavorite reloadData];
    } failure:^(NSString *errorMessage) {
        //Alert
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**LIST VIEW*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 100;
    return self.posts.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        ArticleTableViewCell * cell = nil;
        
        static NSString *cellIndentifier = @"ArticleTableViewCell";
        cell = (ArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
       
       [cell configCellWithData:nil];
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
       [self performSegueWithIdentifier:@"ViewFavoriteAction" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        if([self.postDAO removeFavorite:[self.posts objectAtIndex:indexPath.row]]) {
            
            // Remove device from table view
            [self.posts removeObjectAtIndex:indexPath.row];
            [self.table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 78;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue");
    
    if ([segue.identifier isEqualToString:@"ViewFavoriteAction"]) {
        
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        
        FRDetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.Url = @"http://www.dantri.com.vn";
        
    }

}

@end
