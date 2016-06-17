//
//  FourthViewController.m
//  01-PickerViewDemo
//
//  Created by qingyun on 16/5/24.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *leftArray;
@property (nonatomic, strong) NSArray *rightArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@end

@implementation FourthViewController
//提取数据
-(void)loadDictFromFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"statedictionary" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    _leftArray = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    _rightArray = _dict[_leftArray.firstObject];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDictFromFile];
    // Do any additional setup after loading the view.
}

- (IBAction)selectedContent:(UIButton *)sender {
    //获取左右两列中选中的行
    NSInteger leftRow = [_pickerView selectedRowInComponent:0];
    NSInteger rightRow = [_pickerView selectedRowInComponent:1];
    //获取两列的标题
    NSString *leftString = _leftArray[leftRow];
    NSString *rightString = _rightArray[rightRow];
    NSString *message = [NSString stringWithFormat:@"%@中%@",leftString,rightString];
    //弹出视图(显示选择内容)
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您选中的是:" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark  -UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _leftArray.count;
    }
    return _rightArray.count;
}

#pragma mark  -UIPickerViewDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return _leftArray[row];
    }
    return _rightArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        //获取左边列选中的行内容
        NSString *key = _leftArray[row];
        //获取对应的右列中的数组
        _rightArray = _dict[key];
        
        //刷新右列
        [pickerView reloadComponent:1];
        //强制选中右列第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
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

@end
