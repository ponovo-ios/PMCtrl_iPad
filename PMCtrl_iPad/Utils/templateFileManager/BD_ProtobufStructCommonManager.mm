//
//  BD_ProtobufStructCommonManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ProtobufStructCommonManager.h"
#import "BD_TestDataParamModel.h"
@implementation BD_ProtobufStructCommonManager


+(OutPutCommon::para_type )varTypeStringToProbuf:(NSString *)vartype{
    if ([vartype isEqualToString:@"Ua"]) {
        return OutPutCommon::para_type::va1_type;
    }  else if ([vartype isEqualToString:@"Ub"]){
        return OutPutCommon::para_type::vb1_type;
    }  else if ([vartype isEqualToString:@"Uc"]){
        return OutPutCommon::para_type::vc1_type;
    }  else if ([vartype isEqualToString:@"Ua,Ub,Uc"]){
        return OutPutCommon::para_type::vabc1_type;
    }if ([vartype isEqualToString:@"Ua1"]) {
        return OutPutCommon::para_type::va1_type;
    }  else if ([vartype isEqualToString:@"Ub1"]){
        return OutPutCommon::para_type::vb1_type;
    }  else if ([vartype isEqualToString:@"Uc1"]){
        return OutPutCommon::para_type::vc1_type;
    }  else if ([vartype isEqualToString:@"Ua1,Ub1,Uc1"]){
        return OutPutCommon::para_type::vabc1_type;
    } else if ([vartype isEqualToString:@"Ua2"]){
        return OutPutCommon::para_type::va2_type;
    } else if ([vartype isEqualToString:@"Ub2"]){
        return OutPutCommon::para_type::vb2_type;
    } else if ([vartype isEqualToString:@"Uc2"]){
        return OutPutCommon::para_type::vc2_type;
    } else if ([vartype isEqualToString:@"Ua2,Ub2,Uc2"]){
        return OutPutCommon::para_type::vabc2_type;
    } else if ([vartype isEqualToString:@"Ia"]){
        return OutPutCommon::para_type::ia1_type;
    } else if ([vartype isEqualToString:@"Ib"]){
        return OutPutCommon::para_type::ib1_type;
    } else if ([vartype isEqualToString:@"Ic"]){
        return OutPutCommon::para_type::ic1_type;
    } else if ([vartype isEqualToString:@"Ia,Ib,Ic"]){
        return OutPutCommon::para_type::iabc1_type;
    } else if ([vartype isEqualToString:@"Ia1"]){
        return OutPutCommon::para_type::ia1_type;
    } else if ([vartype isEqualToString:@"Ib1"]){
        return OutPutCommon::para_type::ib1_type;
    } else if ([vartype isEqualToString:@"Ic1"]){
        return OutPutCommon::para_type::ic1_type;
    }else if ([vartype isEqualToString:@"Ia1,Ib1,Ic1"]){
        return OutPutCommon::para_type::iabc1_type;
    }if ([vartype isEqualToString:@"Ia2"]){
        return OutPutCommon::para_type::ia2_type;
    } else if ([vartype isEqualToString:@"Ib2"]){
        return OutPutCommon::para_type::ib2_type;
    } else if ([vartype isEqualToString:@"Ic2"]){
        return OutPutCommon::para_type::ic2_type;
    }else if ([vartype isEqualToString:@"Ia2,Ib2,Ic2"]){
        return OutPutCommon::para_type::iabc2_type;
    }     else if ([vartype isEqualToString:@"Ia1,Ib1,Ic1,Ia2,Ib2,Ic2"]){
        return OutPutCommon::para_type::iall_type;
    } else if ([vartype isEqualToString:@"Ua1,Ub1,Uc1,Ua2,Ub2,Uc2"]){
        return OutPutCommon::para_type::vall_type;
    }else if ([vartype isEqualToString:@"Uz"]){
        return OutPutCommon::para_type::vz_type;
    } else if ([vartype isEqualToString:@"Ua,Ub,Uc,Uz"]){
        return OutPutCommon::para_type::vall_type;
    }else if ([vartype isEqualToString:@"Ua1,Ub1,Uc1,Ua2,Ub2,Uc2"]){
        return OutPutCommon::para_type::vall_type;
    }else if ([vartype isEqualToString:@"Uz"]){
        return OutPutCommon::para_type::vz_type;
    } else if ([vartype isEqualToString:@"Ua,Ub,Uc,Uz"]){
        return OutPutCommon::para_type::vall_type;
    } else if ([vartype isEqualToString:@"Ua,Ub"]){
        return OutPutCommon::para_type::vab1_type;
    }else if ([vartype isEqualToString:@"Ua,Uc"]){
        return OutPutCommon::para_type::vca1_type;
    } else if ([vartype isEqualToString:@"Ub,Uc"]){
        return OutPutCommon::para_type::vbc1_type;
    }if ([vartype isEqualToString:@"Ia,Ib"]){
        return OutPutCommon::para_type::iab1_type;
    }else if ([vartype isEqualToString:@"Ib,Ic"]){
        return OutPutCommon::para_type::ibc1_type;
    } else if ([vartype isEqualToString:@"Ia,Ic"]){
        return OutPutCommon::para_type::ica1_type;
    } else if ([vartype isEqualToString:@"Ua1,Ub1"]){
        return OutPutCommon::para_type::vab1_type;
    }else if ([vartype isEqualToString:@"Ua1,Uc1"]){
        return OutPutCommon::para_type::vca1_type;
    } else if ([vartype isEqualToString:@"Ub1,Uc1"]){
        return OutPutCommon::para_type::vbc1_type;
    }if ([vartype isEqualToString:@"Ia1,Ib1"]){
        return OutPutCommon::para_type::iab1_type;
    }else if ([vartype isEqualToString:@"Ib1,Ic1"]){
        return OutPutCommon::para_type::ibc1_type;
    }else if ([vartype isEqualToString:@"Ia1,Ic1"]){
        return OutPutCommon::para_type::ica1_type;
    }else {
        return OutPutCommon::para_type::vall_type;
    }
}

+(NSString *)protobufTypeToStrvarType:(OutPutCommon::para_type)vartype{
    if (vartype == OutPutCommon::para_type::va1_type) {
        return @"Ua";
    }  else if (vartype==OutPutCommon::para_type::vb1_type){
        return @"Ub";
    }  else if (vartype == OutPutCommon::para_type::vc1_type){
        return @"Uc";
    }  else if (vartype==OutPutCommon::para_type::vabc1_type){
        return @"Ua,Ub,Uc";
    }if (vartype==OutPutCommon::para_type::va1_type) {
        return @"Ua1";
    }  else if (vartype==OutPutCommon::para_type::vb1_type){
        return @"Ub1";
    }  else if (vartype==OutPutCommon::para_type::vc1_type){
        return @"Uc1";
    }  else if (vartype==OutPutCommon::para_type::vabc1_type){
        return @"Ua1,Ub1,Uc1";
    } else if (vartype==OutPutCommon::para_type::va2_type){
        return @"Ua2";
    } else if (vartype==OutPutCommon::para_type::vb2_type){
        return  @"Ub2";
    } else if (vartype==OutPutCommon::para_type::vc2_type){
        return @"Uc2";
    } else if (vartype==OutPutCommon::para_type::vabc2_type){
        return @"Ua2,Ub2,Uc2";
    } else if (vartype==OutPutCommon::para_type::ia1_type){
        return @"Ia";
    } else if (vartype==OutPutCommon::para_type::ib1_type){
        return @"Ib";
    } else if (vartype==OutPutCommon::para_type::ic1_type){
        return @"Ic";
    } else if (vartype==OutPutCommon::para_type::iabc1_type){
        return @"Ia,Ib,Ic";
    } else if (vartype==OutPutCommon::para_type::ia1_type){
        return @"Ia1";
    } else if (vartype==OutPutCommon::para_type::ib1_type){
        return @"Ib1";
    } else if (vartype==OutPutCommon::para_type::ic1_type){
        return @"Ic1";
    }else if (vartype==OutPutCommon::para_type::iabc1_type){
        return @"Ia1,Ib1,Ic1";
    } else if (vartype==OutPutCommon::para_type::ia2_type){
        return @"Ia2";
    } else if (vartype==OutPutCommon::para_type::ib2_type){
        return @"Ib2";
    } else if (vartype==OutPutCommon::para_type::ic2_type){
        return @"Ic2";
    }else if (vartype==OutPutCommon::para_type::iabc2_type){
        return @"Ia2,Ib2,Ic2";
    }     else if (vartype==OutPutCommon::para_type::iall_type){
        return @"Ia1,Ib1,Ic1,Ia2,Ib2,Ic2";
    } else if (vartype==OutPutCommon::para_type::vall_type){
        return @"Ua1,Ub1,Uc1,Ua2,Ub2,Uc2";
    }else if (vartype==OutPutCommon::para_type::vz_type){
        return @"Uz";
    } else if (vartype==OutPutCommon::para_type::vall_type){
        return @"Ua,Ub,Uc,Uz";
    }if (vartype==OutPutCommon::para_type::vall_type){
        return @"Ua1,Ub1,Uc1,Ua2,Ub2,Uc2";
    }else if (vartype==OutPutCommon::para_type::vz_type){
        return @"Uz";
    } else if (vartype==OutPutCommon::para_type::vall_type){
        return @"Ua,Ub,Uc,Uz";
    } else if (vartype==OutPutCommon::para_type::vab1_type){
        return @"Ua,Ub";
    }else if (vartype==OutPutCommon::para_type::vca1_type){
        return @"Ua,Uc";
    } else if (vartype==OutPutCommon::para_type::vbc1_type){
        return @"Ub,Uc";
    }if (vartype==OutPutCommon::para_type::iab1_type){
        return @"Ia,Ib";
    }else if (vartype==OutPutCommon::para_type::ibc1_type){
        return @"Ib,Ic";
    } else if (vartype==OutPutCommon::para_type::ica1_type){
        return @"Ia,Ic";
    } else if (vartype==OutPutCommon::para_type::vab1_type){
        return @"Ua1,Ub1";
    }else if (vartype==OutPutCommon::para_type::vca1_type){
        return @"Ua1,Uc1";
    } else if (vartype==OutPutCommon::para_type::vbc1_type){
        return @"Ub1,Uc1";
    }if (vartype==OutPutCommon::para_type::iab1_type){
        return @"Ia1,Ib1";
    }else if (vartype==OutPutCommon::para_type::ibc1_type){
        return @"Ib1,Ic1";
    }else if (vartype==OutPutCommon::para_type::ica1_type){
        return @"Ia1,Ic1";
    }else {
        return @"";
    }
}


//拼接电压电流通道
+(void)messageData:(NSArray *)sourceArr object:(OutPutCommon::acanalogpara*)para{
    for (int i = 0; i<2; i++) {
        if (i == 0) {
            //电压
            NSArray *modelArr = (NSArray *)sourceArr[i];
            for (int n = 0; n<modelArr.count; n++) {
                BD_TestDataParamModel *model = (BD_TestDataParamModel *)modelArr[n];
                para->add_analogvoltchangelvalue();
                para->mutable_analogvoltchangelvalue(n)->set_famptitude([model.amplitude floatValue]);//幅值
                para->mutable_analogvoltchangelvalue(n)->set_fphase([model.phase floatValue]);//相位
                para->mutable_analogvoltchangelvalue(n)->set_ffre([model.frequency floatValue]);//频率
            }
        } else {
            //电流
            NSArray *modelArr = (NSArray *)sourceArr[i];
            for (int j = 0; j<modelArr.count; j++) {
                BD_TestDataParamModel *model = (BD_TestDataParamModel *)modelArr[j];
                para->add_analogcurrentchanelvalue();
                para->mutable_analogcurrentchanelvalue(j)->set_famptitude([model.amplitude floatValue]);//幅值
                para->mutable_analogcurrentchanelvalue(j)->set_fphase([model.phase floatValue]);//相位
                para->mutable_analogcurrentchanelvalue(j)->set_ffre([model.frequency floatValue]);//频率
            }
        }
    }
}



@end
