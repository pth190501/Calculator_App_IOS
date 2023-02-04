//
//  ButtonCollectionViewCell.m
//  CalculatorIOS
//
//  Created by Phạm Thanh Hải on 02/02/2023.
//

#import "ButtonCollectionViewCell.h"

@implementation ButtonCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.contentView.layer.borderWidth = 1.0f;
    self.lbFeature.font = [UIFont boldSystemFontOfSize:50];
}

-(void)configCellWith:(NSString *)nameFeature {
    if ([nameFeature isEqualToString:@"C"] || [nameFeature isEqualToString:@"%"] || [nameFeature isEqualToString:@"+"] || [nameFeature isEqualToString:@"-"] || [nameFeature isEqualToString:@"x"] || [nameFeature isEqualToString:@"÷"]) {
        self.lbFeature.textColor = UIColor.cyanColor;
    }
    if ([nameFeature isEqualToString:@"="]) {
        self.contentView.backgroundColor = UIColor.cyanColor;
        self.lbFeature.textColor = UIColor.whiteColor;
    }
    if ([nameFeature isEqualToString:@"Rotate"] || [nameFeature isEqualToString:@"Del"]){
        NSString *imgName = @"";
        if ([nameFeature isEqualToString:@"Rotate"]){
            imgName = @"rotate-smartphone";
        }
        else {
            imgName = @"delete";
        }
        self.imgIcon.hidden = NO;
        self.lbFeature.hidden = YES;
        self.imgIcon.image = [UIImage imageNamed:imgName];
        self.imgIcon.contentMode = UIViewContentModeScaleToFill;
    }
    else {
        self.imgIcon.hidden = YES;
    }
    
    self.lbFeature.text = nameFeature;
    
}

@end
