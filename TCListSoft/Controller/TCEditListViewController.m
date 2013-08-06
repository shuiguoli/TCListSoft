//
//  TCEditListViewController.m
//  TCListSoft
//
//  Created by 谷 on 13-8-6.
//  Copyright (c) 2013年 徐 哲. All rights reserved.
//

#import "TCEditListViewController.h"
#import "TCItemsViewController.h"
#import "TCList.h"
#import "TCListCategory.h"
#import "TCItem.h"
#import "Tools.h"
#import "TCDataStore.h"
@interface TCEditListViewController ()
{
    NSArray *allListCategorys;
}
@end


@implementation TCEditListViewController

@synthesize list;
@synthesize textView;
//@synthesize datePickerView,myPickerView,currentPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStyleDone target:nil action:nil];
        
        allListCategorys = [[TCDataStore sharedStore] allListCategorys];
        
        [n setRightBarButtonItem:bbi];
        
    }
    return self;
}

//设置备注textView

-(void)setuptextView

{
    self.textView =[[UITextView alloc]initWithFrame:CGRectMake(20, 220, 280,280)];
    self.textView.textColor = [UIColor blackColor];
	self.textView.font = [UIFont fontWithName:@"Arial" size:18.0];
    
    textView.delegate = self;
    self.textView.backgroundColor = [UIColor greenColor];
    
    self.textView.text = @"备注：";
    
    self.textView.returnKeyType = UIReturnKeyDefault;
    
    self.textView.keyboardType = UIKeyboardTypeDefault;
    
    self.textView.scrollEnabled = YES;
    
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview: self.textView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    createdListTimeLabel.text = [Tools stringFromDate:[list valueForKey:@"createdDate"]];
    
    NSDate *now = [NSDate date];
    [self.datePicker setDate:now animated:NO];
    
    self.datePicker.hidden = YES;
    [self setuptextView];
}

-(void)viewDidUnload

{
    [self setDatePicker:nil];
    [super viewDidUnload];
    self.textView = nil;
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated

{
    
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)keyboardWillShow:(NSNotification *)aNotification

{
    
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = self.view.frame;
    
    frame.size.height -= keyboardRect.size.height;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = frame;
    
    [UIView commitAnimations];
    
    }



-(void)keyboardWillHide:(NSNotification *)aNotification

{
    
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect frame = self.view.frame;
    
    frame.size.height += keyboardRect.size.height;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = frame;
    
    [UIView commitAnimations];
    
}



#pragma mark -

#pragma mark UItextViewDelegate



- (void)textViewDidBeginEditing:(UITextView *)textView

{
    
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                                                                              action:@selector(saveAction:)];
    
    self.navigationItem.rightBarButtonItem = saveItem;
    
}

- (void)saveAction:(id)sender

{
    
    [self.textView resignFirstResponder];
    
    self.navigationItem.rightBarButtonItem = nil;
    
}



//更改提醒时间

- (IBAction)changeNotifDate:(id)sender
{
   //
    textView.hidden = YES;
    self.datePicker.hidden = NO;
    
    NSDate *selected = [_datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    
    NSString *message = [[NSString alloc] initWithFormat:
                         @"%@", destDateString];
    
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提醒时间" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil ];
    [alter show];

    notificationListDateLabel.text =[[NSString alloc]initWithFormat:@"%@",destDateString];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    NSString *msg = [[NSString alloc] initWithFormat:@"您点击的是第%d个按钮!",buttonIndex];
    
    NSLog(@"msg:%@",msg);
    
    if (buttonIndex == 0) {
        
        return;
        
    }else if(buttonIndex == 1){
        
        NSDate *selected = [_datePicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *destDateString = [dateFormatter stringFromDate:selected];
        
        notificationListDateLabel.text =[[NSString alloc]initWithFormat:@"%@",destDateString];
        
    }
    
}

-(void)animationFinished
{
    NSLog(@"动画结束!");
}

// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
                                   screenRect.size.height - 42.0 - size.height,
                                   size.width,
                                   size.height);
	return pickerRect;
}


//添加子任务
-(IBAction)addSubList:(id)sender
{
    
    TCItemsViewController *newIsVC = [[TCItemsViewController alloc] initWithNibName:nil bundle:nil];
    [[self navigationController] pushViewController:newIsVC animated:YES];
}

@end
