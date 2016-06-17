//
//  ThirdViewController.m
//  01-PickerViewDemo
//
//  Created by qingyun on 16/5/24.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ThirdViewController.h"

#define QYRGBMaxNum             255
#define QYStepValue             5
#define QYRowNum                QYRGBMaxNum / QYStepValue + 1

@interface ThirdViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@end

@implementation ThirdViewController

-(UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        
        //设置数据源和代理
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        //关闭AutoresizingMask产生的约束,避免与自己添加的约束冲突
        _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.pickerView];
    
    //设置pickerView的约束
    NSDictionary *views = NSDictionaryOfVariableBindings(self.view,_pickerView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_pickerView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[_pickerView(>=200)]" options:0 metrics:nil views:views]];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //代码设置选中的行,以及设置color的颜色
    NSInteger selectedRedRow = arc4random() % QYRowNum;
    [self didSelectedRow:selectedRedRow inComponent:QYRGBComponentTypeRed];
    
    NSInteger selectedGreenRow = arc4random() % QYRowNum;
    [self didSelectedRow:selectedGreenRow inComponent:QYRGBComponentTypeGreen];
    
    NSInteger selectedBlueRow = arc4random() % QYRowNum;
    [self didSelectedRow:selectedBlueRow inComponent:QYRGBComponentTypeBlue];
}

-(void)didSelectedRow:(NSInteger)row inComponent:(NSInteger)component{
    [_pickerView selectRow:row inComponent:component animated:YES];
    [self pickerView:_pickerView didSelectRow:row inComponent:component];
}

#pragma mark - UIPickerViewDataSource

//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

//列中的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return QYRowNum;
}

#pragma mark - UIPickerViewDelegate
//属性标题
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    CGFloat redColorNum = 0;
    CGFloat greenColorNum = 0;
    CGFloat blueColorNum = 0;
    
    switch (component) {
        case QYRGBComponentTypeRed:
            redColorNum = QYStepValue * row / 255.0;
            break;
        case QYRGBComponentTypeGreen:
            greenColorNum = QYStepValue * row / 255.0;
            break;
        case QYRGBComponentTypeBlue:
            blueColorNum = QYStepValue * row / 255.0;
            break;
            
        default:
            break;
    }
    
    UIColor *color = [UIColor colorWithRed:redColorNum green:greenColorNum blue:blueColorNum alpha:1.0];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",QYStepValue * row] attributes:@{NSForegroundColorAttributeName:color}];
    return attributedString;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    //获取每列中选中的行
    NSInteger redSelectedRow = [pickerView selectedRowInComponent:QYRGBComponentTypeRed];
    NSInteger greenSelectedRow = [pickerView selectedRowInComponent:QYRGBComponentTypeGreen];
    NSInteger blueSelectedRow = [pickerView selectedRowInComponent:QYRGBComponentTypeBlue];
    
    //获取选中的行对应的RGB值
    CGFloat redColorNum = redSelectedRow * QYStepValue / 255.0;
    CGFloat greenColorNum = greenSelectedRow * QYStepValue / 255.0;
    CGFloat blueColorNum = blueSelectedRow * QYStepValue / 255.0;
    
    //根据RGB生成颜色
    UIColor *color = [UIColor colorWithRed:redColorNum green:greenColorNum blue:blueColorNum alpha:1.0];
    
    _colorView.backgroundColor = color;
    
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
