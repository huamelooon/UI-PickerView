//
//  ViewController.m
//  01-PickerViewDemo
//
//  Created by qingyun on 16/5/24.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置dataPicker的日期或时间取值范围
    NSDateComponents *components = [[NSDateComponents alloc] init];
    //设置年/月/日
    components.year = 2016;
    components.month = 5;
    components.day = 24;
    //获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *minDate = [calendar dateFromComponents:components];
    _datePicker.minimumDate = minDate;
    
    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:3 * 24 * 60 * 60];
    _datePicker.maximumDate = maxDate;
    // Do any additional setup after loading the view, typically from a nib.
}
//更改选中的日期或时间的时候触发该方法
- (IBAction)selectedDate:(UIDatePicker *)sender {
    
    [self showDateAndTimeForDatePicker];
}

//显示当前显示的时间
- (IBAction)btnClick:(UIButton *)sender {
    [self showDateAndTimeForDatePicker];
}


-(void)showDateAndTimeForDatePicker{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前选择的日期和时间:" message:[_datePicker.date descriptionWithLocale:_datePicker.locale] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
