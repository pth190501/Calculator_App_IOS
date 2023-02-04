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
}

-(void)configCellWith:(NSString *)nameFeature {
    if ([nameFeature isEqualToString:@"C"] || [nameFeature isEqualToString:@"%"] || [nameFeature isEqualToString:@"+"] || [nameFeature isEqualToString:@"-"] || [nameFeature isEqualToString:@"x"] || [nameFeature isEqualToString:@":"]) {
        self.lbFeature.textColor = UIColor.blueColor;
    }
    if ([nameFeature isEqualToString:@"="]) {
        self.contentView.backgroundColor = UIColor.blueColor;
        self.lbFeature.textColor = UIColor.whiteColor;
    }
    self.lbFeature.text = nameFeature;
    
}

@end
