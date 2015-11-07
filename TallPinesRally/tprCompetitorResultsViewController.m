//
//  tprCompetitorResultsViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-12.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import "tprCompetitorResultsViewController.h"

@interface tprCompetitorResultsViewController ()

@end

@implementation tprCompetitorResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.top = self.navigationController.navigationBar.bounds.size.height +
        [UIApplication sharedApplication].statusBarFrame.size.height;
        self.tableView.contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets; 
        
    }
    tprCompetitor *competitor = (tprCompetitor *) self.detailItem;
    self.penatlties = competitor.getPenalties;
    self.results = competitor.getResults;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger numberOfRows = 0;
    
    if (section == 0)
    {
        numberOfRows = [self.penatlties count];
    }
     else if (section == 1)
     {
         numberOfRows =  [self.results count];
     }
    
    return numberOfRows;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
        if (section == 0)
        {
            return @"Penalties";
        } else if (section == 1)
        {
            return @"Results Per Stage";
        } else {
            return @"";
        }
            
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"penaltiesCell" forIndexPath:indexPath];
        tprPenalty *penalty = [self.penatlties objectAtIndex:indexPath.row];
        
        UILabel *controlLabel =  (UILabel *)[cell viewWithTag:100];
        controlLabel.text = penalty.control;
        
        UILabel *remarkLabel = (UILabel *)[cell viewWithTag:101];
        remarkLabel.text = penalty.remark;
        
        UILabel *penaltyLabel = (UILabel *)[cell viewWithTag:102];
        penaltyLabel.text = [penalty getPenaltyFormated];
        
        return cell;
        
    }
    else if (indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stageResultsCell" forIndexPath:indexPath];
        tprStageResults *stageResult = [self.results objectAtIndex:indexPath.row];
        
        UILabel *stageIDLabel =  (UILabel *)[cell viewWithTag:100];
        stageIDLabel.text = stageResult.stageId;
        
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:101];
        nameLabel.text = stageResult.stageName;
        
        UILabel *timeLabel = (UILabel *)[cell viewWithTag:102];
        timeLabel.text = [stageResult getFormattedStageTime];
        
        UILabel *lengthLabel = (UILabel *)[cell viewWithTag:104];
        lengthLabel.text = stageResult.stageLength;
        
        return cell;
    } else {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return 64;
    } else {
        return 44;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
