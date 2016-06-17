//
//  SecondViewController.m
//  01-PickerViewDemo
//
//  Created by qingyun on 16/5/24.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation SecondViewController

-(NSArray *)datas{
    if (_datas == nil){
        _datas = @[@"张三",@"李四",@"王五",@"赵六",@"田七",@"宋八"];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _label.text = self.datas.firstObject;
    
    //设置数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    // Do any additional setup after loading the view.
}

#pragma mark -UIPickerViewDataSource
//Components
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//Components中rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.datas.count;
}

#pragma mark  -UIPickerViewDelegate

//title
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row != 0) {
        return self.datas[row];
    }
    return nil;
}
//attributedTitle
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row == 0) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.datas[row] attributes:@{NSUnderlineStyleAttributeName:@1,NSForegroundColorAttributeName:[UIColor redColor]}];
        return attributedString;
    }
    return nil;
}

//rowHeight
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 60;
}

//didSelectedRow
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _label.text = self.datas[row];
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
