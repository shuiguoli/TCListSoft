//
//  TCTableViewController.m
//  TCListSoft
//
//  Created by 徐 哲 on 13-8-7.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCTableViewController.h"
#import "TCCell.h"
#import "TCAppDelegate.h"
@interface TCTableViewController ()

@end

@implementation TCTableViewController

@synthesize tableView = _tableView;
@synthesize managedObject = _managedObject;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize noContentView = _noContentView;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - UIViewController

- (id)initWithStyle:(UITableViewStyle)style
{
	if ((self = [super init])) {
        self.managedObjectContext = [(TCAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
		_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_tableView.dataSource = self;
		_tableView.delegate = self;
	}
	return self;
    
}

- (id)init
{
    self = [self initWithStyle:UITableViewStylePlain];
	return self;
}

- (void)dealloc
{
	_tableView.dataSource = nil;
	_tableView.delegate = nil;
}

- (void)loadView
{
	[super loadView];

	_tableView.frame = self.view.bounds;
    UIView *view = [[UIView alloc] initWithFrame:_tableView.bounds];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"arches"]];
    _tableView.backgroundView = view;
	[self.view addSubview:_tableView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    [_tableView reloadData];

    [_tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	[self.tableView setEditing:editing animated:animated];
}

- (NSManagedObjectContext*)managedObjectContext
{
    if(_managedObjectContext == nil)
        NSLog(@"重要信息：managedObjectContext == nil");
    return _managedObjectContext;
}

- (NSFetchedResultsController *)fetchedResultsController
{
	if (!_fetchedResultsController)
    {
		_fetchedResultsController =
        [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                            managedObjectContext:self.managedObjectContext
                                              sectionNameKeyPath:self.sectionNameKeyPath
                                                       cacheName:self.cacheName];
		_fetchedResultsController.delegate = self;
		[_fetchedResultsController performFetch:nil];
	}
	return _fetchedResultsController;
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
	_fetchedResultsController.delegate = nil;
	_fetchedResultsController = fetchedResultsController;
}


- (NSFetchRequest *)fetchRequest {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [self entity];
	fetchRequest.sortDescriptors = [self sortDescriptors];
	fetchRequest.predicate = self.predicate;
	return fetchRequest;
}

#warning entityClass
- (NSEntityDescription*)entity
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([_managedObject class]) inManagedObjectContext:_managedObjectContext];
	return entity;
}

#warning sortDescriptors
- (NSArray *)sortDescriptors
{
    NSLog(@"没有实现sortDescriptors");
	return nil;
}

#warning predicate
- (NSPredicate *)predicate
{
	return nil;
}


#warning sectionNameKeyPath
- (NSString *)sectionNameKeyPath
{
	return nil;
}


- (NSString *)cacheName
{
	return nil;
}

- (void)save
{
	[self.managedObjectContext save:nil];
}

- (void)deleteObject:(NSManagedObject*)aObject
{
	[self.managedObjectContext deleteObject:aObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// TODO: 子类覆盖
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - NSFetched Results Controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
        {
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
		}
			
        case NSFetchedResultsChangeDelete:
        {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
		}
    }
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
        {
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            break;
		}
			
        case NSFetchedResultsChangeDelete:
        {
            [tableView deleteRowsAtIndexPaths:@[indexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            break;
		}
			
        case NSFetchedResultsChangeUpdate:
        {
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
		}
			
        case NSFetchedResultsChangeMove:
        {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            break;
		}
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
//    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}
@end
