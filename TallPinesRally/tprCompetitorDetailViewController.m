//
//  tprCompetitorDetailViewController.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2014-11-11.
//  Copyright (c) 2014 Derek Vincent. All rights reserved.
//

#import "tprCompetitorDetailViewController.h"

@interface tprCompetitorDetailViewController ()

@end

@implementation tprCompetitorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CompetitorDetailPageViewController"];
    self.pageViewController.dataSource = self;

    self.pageViewControllers = [[NSArray alloc] initWithObjects:@"CompetitorDetailsPage", @"CompetitorResultsPage", nil];
    NSArray *firstPageArray = [[NSArray alloc] initWithObjects:[self viewControllerAtIndex:0], nil];
    
    
    [self.pageViewController setViewControllers:firstPageArray
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
    
    
    [self.pageViewController willMoveToParentViewController:self];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
    

    [self.navigationItem setTitle:@"Competitor"];

    UINavigationController *navController = self.navigationController;
    navController.delegate = self;
    CGSize navBarSize = self.navigationController.navigationBar.bounds.size;
    CGPoint origin = CGPointMake(navBarSize.width/2, navBarSize.height/2);
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(origin.x, origin.y +16, 0, 0)];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.backgroundColor = [UIColor whiteColor];
    [self.pageControl setNumberOfPages:[self.pageViewControllers count]];
    [self.pageControl setTag:100];
    [navController.navigationBar addSubview:self.pageControl];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.pageControl removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //int index = [navigationController.viewControllers indexOfObject:viewController];
    //int index = [self.pageViewControllers indexOfObject:viewController.restorationIdentifier];
    
    //self.pageControl.currentPage = index;
}


-(UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    
    
    if (index == 0)
    {
        tprEntryDetailViewController *competitorDetailsPage = [self.storyboard instantiateViewControllerWithIdentifier:[_pageViewControllers objectAtIndex:index]];
        
        competitorDetailsPage.detailItem = self.detailItem;
        competitorDetailsPage.pageIndex = index;
        return competitorDetailsPage;
    }
    else if ( index == 1)
    {
        tprCompetitorResultsViewController *competitorResultsPage = [self.storyboard instantiateViewControllerWithIdentifier:[_pageViewControllers objectAtIndex:index]];
        competitorResultsPage.detailItem = self.detailItem;
        competitorResultsPage.pageIndex = index;
        return competitorResultsPage;
    } else {
        return nil;
    }
}

#pragma mark - UIPageView Delegation 

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.pageViewControllers indexOfObject:viewController.restorationIdentifier];
    self.pageControl.currentPage = index;
    
    return [self viewControllerAtIndex:index - 1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.pageViewControllers indexOfObject:viewController.restorationIdentifier];
    self.pageControl.currentPage = index;

    return [self viewControllerAtIndex:index + 1];
}
/*
-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageViewControllers count];
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{

    int currentPage = [[pageViewController.viewControllers objectAtIndex:0] pageIndex];
    return currentPage;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
