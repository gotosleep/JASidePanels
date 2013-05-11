//
//  MenuViewController.m
//
//  Created by Brian McIntyre on 2013-05-10.
//

#import "MenuViewController.h"
#import "JASidePanel.h"

@interface MenuViewController()  <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

@end

@implementation MenuViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		
	}
	return self;
}

- (void) viewDidLoad
{
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
	self.tableView.tableFooterView = footer;
			
	self.items = @[@[@"option1",@"Option1"],
				@[@"option2",@"Option2"]];
	
}

-(void) viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
	[super viewWillAppear:animated];
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if ( [segue isKindOfClass: [JASidePanelViewSegue class]] )
    {
        JASidePanelViewSegue* rvcs = (JASidePanelViewSegue*) segue;
        
        rvcs.performBlock = ^(JASidePanelViewSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
			
			UINavigationController *navigationController = (id)self.sidePanelController.centerPanel;
			
			NSArray *controllers = [NSArray arrayWithObject:dvc];
			navigationController.viewControllers = controllers;
			[self.sidePanelController toggleLeftPanel:sender];
        };
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [[self.items objectAtIndex:indexPath.row] objectAtIndex:0];
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell.textLabel.text = [[self.items objectAtIndex:indexPath.row] objectAtIndex:1];
	
	[cell setNeedsDisplay];
    return cell;
}

@end
