//
//  BD_DifferentialTemplateFileManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferentialTemplateFileManager.h"
#import "BD_DifferentialTestItemModel.h"
#import "BD_DifferGeneralSetDataModel.h"
#import "BD_DifferSetDataModel.h"
#import "BD_TestBinarySwitchSetModel.h"
#import "Differential.pb.h"
@implementation BD_DifferentialTemplateFileManager
-(bool)saveTemplateFileWithGeneralParam:(BD_DifferGeneralSetDataModel * _Nonnull)generalParam setParam:(BD_DifferSetDataModel * _Nonnull)setParam binarySwitch:(BD_TestBinarySwitchSetModel * _Nonnull)binarySwitch testItem:(NSArray * _Nonnull)testItem outputType:(BDDeviceType)outputType fileName:(NSString *_Nonnull)fileName{
    Differential::Items oitems;
    //通用参数
    Differential::CommonPara *oComm = oitems.mutable_ocomm();
    
    oComm->set_ed_v([generalParam.ED_V floatValue]);  //额定线电压
    oComm->set_ed_i([generalParam.ED_I floatValue]);  //额定电流
    oComm->set_ed_hz([generalParam.ED_Hz floatValue]); //额定频率
    oComm->set_pretime([generalParam.PreTime floatValue]); //准备时间
    oComm->set_prefaulttime([generalParam.PrefaultTime floatValue]); //故障前时间
    oComm->set_faulttime([generalParam.FaultTime floatValue]);  //故障时间
    oComm->set_balanceparacacutype([generalParam.BalanceParaCacuType intValue]);//各侧平衡系数0或1
    oComm->set_sn([generalParam.SN floatValue]);       //变压器额定容量
    oComm->set_uh([generalParam.Uh floatValue]);       //高压侧额定电压
    oComm->set_um([generalParam.Um floatValue]);       //中压侧额定电压
    oComm->set_ul([generalParam.Ul floatValue]);       //低压侧额定电压
    oComm->set_ctph([generalParam.CTPh floatValue]);   //高压侧CT一次值
    oComm->set_ctpm([generalParam.CTPm floatValue]);   //中压侧CT一次值
    oComm->set_ctpl([generalParam.CTPl floatValue]);   //低压侧CT一次值
    oComm->set_ctsh([generalParam.CTSh floatValue]);   //高压侧CT二次值
    oComm->set_ctsm([generalParam.CTSm floatValue]);   //高压侧CT二次值
    oComm->set_ctsl([generalParam.CTSl floatValue]);   //高压侧CT二次值
    oComm->set_kph([generalParam.Kph floatValue]);      //高压侧差动平衡系数
    oComm->set_kpm([generalParam.Kpm floatValue]);      //中压侧差动平衡系数
    oComm->set_kpl([generalParam.Kpl floatValue]);      //低压侧差动平衡系数
    //高压侧绕组接线型式
    switch ([generalParam.WindH intValue]) {
        case 0:
            oComm->set_windh(Differential::Connection_Type::StarType);
            break;
        case 1:
            oComm->set_windh(Differential::Connection_Type::TriangleType);
            break;
            
        default:
            break;
    }
    //中压侧绕组接线型式
    switch ([generalParam.WindM intValue]) {
        case 0:
            oComm->set_windm(Differential::Connection_Type::StarType);
            break;
        case 1:
            oComm->set_windm(Differential::Connection_Type::TriangleType);
            break;
        default:
            break;
    }
    //低压侧绕组接线型式
    switch ([generalParam.WindL intValue]) {
        case 0:
            oComm->set_windl(Differential::Connection_Type::StarType);
            break;
        case 1:
            oComm->set_windl(Differential::Connection_Type::TriangleType);
            break;
        default:
            break;
    }
    //校正选择0-2
    switch ([generalParam.AngleMode intValue]) {
        case 0:
            oComm->set_anglemode(Differential::Correct_Type::NONE_TYPE);
            break;
        case 1:
            oComm->set_anglemode(Differential::Correct_Type::Correct_Trigangel_Type);
            break;
        case 2:
            oComm->set_anglemode(Differential::Correct_Type::Correct_Start_Type);
            break;
            
        default:
            break;
    }
    //测试绕组0-2
    switch ([generalParam.WindSide intValue]) {
        case 0:
            oComm->set_windside(Differential::TestWind_Type::TestWind_HightToLow);
            break;
        case 1:
            oComm->set_windside(Differential::TestWind_Type::TestWind_HightToMin);
            break;
        case 2:
            oComm->set_windside(Differential::TestWind_Type::TestWind_MinToLow);
            break;
        default:
            break;
    }
    oComm->set_connmode([generalParam.ConnMode intValue]);//测试绕组之间角差 0 to 11
    oComm->set_jxfactor([generalParam.JXFactor intValue]);//平衡系数计算是否考虑接线形式
    //搜索方法 0-1
    switch ([generalParam.SerachMode intValue]) {
        case 0:
            oComm->set_serachmode(Differential::Search_Type::Search_Type_Search_Type);
            break;
        case 1:
            oComm->set_serachmode(Differential::Search_Type::Search_Type_Single);
            break;
        default:
            break;
    }
    //CT极性0-1
    switch ([generalParam.IdEqu intValue]) {
        case 0:
            oComm->set_idequ(Differential::CTPolar_Type::TwoSide_Type);
            break;
        case 1:
            oComm->set_idequ(Differential::CTPolar_Type::OneSide_type);
            break;
        default:
            break;
    }
    oComm->set_equation([generalParam.Equation intValue]);//制动方程
    oComm->set_k1([generalParam.K1 floatValue]);
    oComm->set_k2([generalParam.K2 floatValue]);
    //测试相0-3
    switch ([generalParam.Phase_Type intValue]) {
        case 0:
            oComm->set_phase_type(Differential::TestPhasor_type::APhase);
            break;
        case 1:
            oComm->set_phase_type(Differential::TestPhasor_type::BPhase);
            break;
        case 2:
            oComm->set_phase_type(Differential::TestPhasor_type::CPhase);
            break;
        case 3:
            oComm->set_phase_type(Differential::TestPhasor_type::ABCPhase);
            break;
            
        default:
            break;
    }
    oComm->set_reso([generalParam.Reso floatValue]);    //测试精度
    oComm->set_ugroup1([generalParam.Ugroup1 floatValue]);        //Uz
    oComm->set_ugroup2([generalParam.Ugroup2 floatValue]);
    
    //整定值
    Differential::ProtectSetting *oProtectSet = oitems.mutable_oprotectset();
    //定值整定方式
    
    switch (setParam.Axis) {
        case 0:
            oProtectSet->set_axis(Differential::SettingType::RealValue_type);
            break;
        case 1:
            oProtectSet->set_axis(Differential::SettingType::MarkValue_Type);
            break;
        default:
            break;
    }
    ////基准电流选择
    switch (setParam.Insel) {
        case 0:
            oProtectSet->set_insel(Differential::BaseCurrentSelect::HighSideSecondaryCurrent);
            break;
        case 1:
            oProtectSet->set_insel(Differential::BaseCurrentSelect::SettingValue);
            break;
        case 2:
            oProtectSet->set_insel(Differential::BaseCurrentSelect::AllSideCurrent);
            break;
        default:
            break;
    }
    oProtectSet->set_inom(setParam.Inom);  //基准电流
    oProtectSet->set_isd(setParam.Isd);   //差动速断电流定值
    oProtectSet->set_icdqd(setParam.Icdqd); //差动动作电流门揽值
    oProtectSet->set_kneepoint((int)setParam.KneePoint); //拐点个数
    oProtectSet->set_ip1(setParam.Ip1);//比率制动特性拐点1电流
    oProtectSet->set_ip2(setParam.Ip2);//比率制动特性拐点1电流
    oProtectSet->set_ip3(setParam.Ip3);//比率制动特性拐点1电流
    oProtectSet->set_kid1(setParam.Kid1);//启动电流斜率
    oProtectSet->set_kid2(setParam.Kid2);//基波比率制动特性斜率1
    oProtectSet->set_kid3(setParam.Kid3);//速断电流斜率
    oProtectSet->set_kid4(setParam.Kid4);//速断电流斜率
    oProtectSet->set_kxb(setParam.Kxb2);//二次谐波制动系数
    oProtectSet->set_kxb3(setParam.Kxb3);//三次谐波制动系数
    oProtectSet->set_kxb5(setParam.Kxb5);//5次谐波制动系数
    
    //开关量参数
    Differential::SwitchPara *oSwitch = oitems.mutable_oswitch();
    oSwitch->set_ika((int)binarySwitch.iKA);
    oSwitch->set_ikb((int)binarySwitch.iKB);
    oSwitch->set_ikc((int)binarySwitch.iKC);
    oSwitch->set_ikd((int)binarySwitch.iKD);
    oSwitch->set_ike((int)binarySwitch.iKE);
    oSwitch->set_ikf((int)binarySwitch.iKF);
    oSwitch->set_ikg((int)binarySwitch.iKG);
    oSwitch->set_ikh((int)binarySwitch.iKH);
    oSwitch->set_iki((int)binarySwitch.iKI);
    oSwitch->set_ikj((int)binarySwitch.iKJ);
    oSwitch->set_ilogic((int)binarySwitch.iLogic);
    oSwitch->set_iout1((int)binarySwitch.iOut1);
    oSwitch->set_iout2((int)binarySwitch.iOut2);
    oSwitch->set_iout3((int)binarySwitch.iOut3);
    oSwitch->set_iout4((int)binarySwitch.iOut4);
    oSwitch->set_iout5((int)binarySwitch.iOut5);
    oSwitch->set_iout6((int)binarySwitch.iOut6);
    oSwitch->set_iout7((int)binarySwitch.iOut7);
    oSwitch->set_iout8((int)binarySwitch.iOut8);
    
    for (int i = 0; i<testItem.count; i++) {
        BD_DifferentialTestItemModel *item = (BD_DifferentialTestItemModel *)testItem[i];
     
        if (item.itemSelect) {//只有在选中的时候才下发数据到接口
        
            if (item.testItemParam.itemType == DifferTestItemType_QDCurrent) {
                Differential::testItem *QDCurrentItem = oitems.add_oitems();
                QDCurrentItem->set_itemtype(Differential::TestItem_type::QDCurrent);
                QDCurrentItem->mutable_oqdcurrent()->set_itemtype(Differential::TestItem_type::QDCurrent);
                QDCurrentItem->mutable_oqdcurrent()->set_iindex([item.testItemParam.iIndex intValue]);
                QDCurrentItem->mutable_oqdcurrent()->set_ir([item.testItemParam.Ir floatValue]);
                QDCurrentItem->mutable_oqdcurrent()->set_fup([item.testItemParam.fUp floatValue]);
                QDCurrentItem->mutable_oqdcurrent()->set_fdown([item.testItemParam.fDown floatValue]);
            }else if (item.testItemParam.itemType == DifferTestItemType_SDCurrent){
                Differential::testItem *SDCurrentItem = oitems.add_oitems();
                SDCurrentItem->set_itemtype(Differential::TestItem_type::SDCurrent);
                SDCurrentItem->mutable_oqdcurrent()->set_itemtype(Differential::TestItem_type::SDCurrent);
                SDCurrentItem->mutable_oqdcurrent()->set_iindex([item.testItemParam.iIndex intValue]);
                SDCurrentItem->mutable_oqdcurrent()->set_ir([item.testItemParam.Ir floatValue]);
                SDCurrentItem->mutable_oqdcurrent()->set_fup([item.testItemParam.fUp floatValue]);
                SDCurrentItem->mutable_oqdcurrent()->set_fdown([item.testItemParam.fDown floatValue]);
            } else if (item.testItemParam.itemType == DifferTestItemType_ZDRatio) {
                Differential::testItem *ZDRatioItem = oitems.add_oitems();
                ZDRatioItem->set_itemtype(Differential::TestItem_type::ZDRatio);
                ZDRatioItem->mutable_ozdratio()->set_itemtype(Differential::TestItem_type::ZDRatio);
                ZDRatioItem->mutable_ozdratio()->set_itypeindex([item.testItemParam.iTypeIndex intValue]);
                ZDRatioItem->mutable_ozdratio()->set_iindex([item.testItemParam.iIndex intValue]);
                ZDRatioItem->mutable_ozdratio()->set_ir([item.testItemParam.Ir floatValue]);
                ZDRatioItem->mutable_ozdratio()->set_fup([item.testItemParam.fUp floatValue]);
                ZDRatioItem->mutable_ozdratio()->set_fdown([item.testItemParam.fDown floatValue]);
                
            } else if (item.testItemParam.itemType == DifferTestItemType_HarmonicRation){
                Differential::testItem *harmItem = oitems.add_oitems();
                harmItem->set_itemtype(Differential::TestItem_type::HarmonicRation);
                harmItem->mutable_oharmnonicratio()->set_itemtype(Differential::TestItem_type::HarmonicRation);
                harmItem->mutable_oharmnonicratio()->set_iindex([item.testItemParam.iIndex intValue]);
                harmItem->mutable_oharmnonicratio()->set_id([item.testItemParam.Id floatValue]);
                harmItem->mutable_oharmnonicratio()->set_nham([item.testItemParam.nHarm intValue]);
                
            } else if (item.testItemParam.itemType == DifferTestItemType_ActionTime ) {
                Differential::testItem *actionTimeItem = oitems.add_oitems();
                actionTimeItem->set_itemtype(Differential::TestItem_type::ActionTime);
                actionTimeItem->mutable_oactiontime()->set_itemtype(Differential::TestItem_type::ActionTime);
                actionTimeItem->mutable_oactiontime()->set_iindex([item.testItemParam.iIndex intValue]);
                actionTimeItem->mutable_oactiontime()->set_id([item.testItemParam.Id floatValue]);
                actionTimeItem->mutable_oactiontime()->set_ir([item.testItemParam.Ir floatValue]);
            } else {
                
            }

        } else{
            DLog(@"未选中%@",item);
        }
        
    }
    //转字节流
    //计算对象大小
    int size = oitems.ByteSize();
    
    //开辟内存空间
    char *pchar = (char *)malloc(sizeof(char)*size);
    
    //序列化到内存中
    oitems.SerializePartialToArray(pchar, size);
    
    NSData *pdata = [NSData dataWithBytes:pchar length:size];
    
    if ([FileUtil writeDataToFileName:[fileName stringByAppendingString:@".properties"] data:pdata]) {
        free(pchar);
        return true;
    } else {
        free(pchar);
        return  false;
    }
}
-(NSMutableArray * _Nullable)readTemplateFileWithfileName:(NSString *_Nullable)fileName{
    NSData *result = [FileUtil readDataToFileName:fileName];
    //proto结构
    Differential::Items oitems;
    bool bRet = oitems.ParsePartialFromArray([result bytes],(int)[result length]);//将读取到的二进制串进行反序列化
    
    //工程模型
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    BD_DifferGeneralSetDataModel *generalParam = [[BD_DifferGeneralSetDataModel alloc]init];
    BD_DifferSetDataModel *setParam = [[BD_DifferSetDataModel alloc]init];
    BD_TestBinarySwitchSetModel *binarySwitch = [[BD_TestBinarySwitchSetModel alloc]init];
    NSMutableArray<BD_DifferentialTestItemModel *> *testItems = [[NSMutableArray alloc]init];
    BDDeviceType deviceType = BDDeviceType_Imitate;
    if (bRet) {
        //将protobuf结构的内容转换为对应试验的模型数组
        //通用参数
        Differential::CommonPara ocomm = oitems.ocomm();
        generalParam.ED_V = kTStrings(ocomm.ed_v());
        generalParam.ED_I = kTStrings(ocomm.ed_i());
        generalParam.ED_Hz = kTStrings(ocomm.ed_hz());
        generalParam.PreTime = kTStrings(ocomm.pretime());
        generalParam.PrefaultTime = kTStrings(ocomm.prefaulttime());
        generalParam.FaultTime = kTStrings(ocomm.faulttime());
        generalParam.BalanceParaCacuType = [NSString stringWithFormat:@"%d",ocomm.balanceparacacutype()];
        generalParam.SN = kTStrings(ocomm.sn());
        generalParam.Uh = kTStrings(ocomm.uh());
        generalParam.Um = kTStrings(ocomm.um());
        generalParam.Ul = kTStrings(ocomm.ul());
        generalParam.CTPh = kTStrings(ocomm.ctph());
        generalParam.CTPm = kTStrings(ocomm.ctpm());
        generalParam.CTPl = kTStrings(ocomm.ctpl());
        generalParam.CTSh = kTStrings(ocomm.ctsh());
        generalParam.CTSm = kTStrings(ocomm.ctsm());
        generalParam.CTSl = kTStrings(ocomm.ctsl());
        generalParam.Kph = kTStrings(ocomm.kph());
        generalParam.Kpm = kTStrings(ocomm.kpm());
        generalParam.Kpl = kTStrings(ocomm.kpl());
        switch (ocomm.windh()) {
            case Differential::Connection_Type::StarType:
                generalParam.WindH = [NSString stringWithFormat:@"%d",0];
                break;
            case Differential::Connection_Type::TriangleType:
                  generalParam.WindH = [NSString stringWithFormat:@"%d",1];
            default:
                break;
        }
        switch (ocomm.windm()) {
            case Differential::Connection_Type::StarType:
                generalParam.WindM = [NSString stringWithFormat:@"%d",0];
                break;
            case Differential::Connection_Type::TriangleType:
                generalParam.WindM = [NSString stringWithFormat:@"%d",1];
                break;
            default:
                break;
        }
        switch (ocomm.windl()) {
            case Differential::Connection_Type::StarType:
                generalParam.WindL = [NSString stringWithFormat:@"%d",0];
                break;
            case Differential::Connection_Type::TriangleType:
                generalParam.WindL = [NSString stringWithFormat:@"%d",1];
                break;
            default:
                break;
        }
        //校正选择0-2
        switch (ocomm.anglemode()) {
            case Differential::Correct_Type::NONE_TYPE:
                generalParam.AngleMode = [NSString stringWithFormat:@"%d",0];
                break;
            case Differential::Correct_Type::Correct_Trigangel_Type:
                generalParam.AngleMode = [NSString stringWithFormat:@"%d",1];
                break;
            case Differential::Correct_Type::Correct_Start_Type:
                generalParam.AngleMode = [NSString stringWithFormat:@"%d",2];
                break;
            default:
                break;
        }
       // 测试绕组0-2
        switch (ocomm.windside()) {
            case Differential::TestWind_Type::TestWind_HightToLow:
                generalParam.WindSide = [NSString stringWithFormat:@"%d",0];
                break;
            case Differential::TestWind_Type::TestWind_HightToMin:
                generalParam.WindSide = [NSString stringWithFormat:@"%d",1];
                break;
            case Differential::TestWind_Type::TestWind_MinToLow:
                generalParam.WindSide = [NSString stringWithFormat:@"%d",2];
                break;
            default:
                break;
        }
        generalParam.ConnMode = [NSString stringWithFormat:@"%d",ocomm.connmode()];//测试绕组之间角差
        generalParam.JXFactor = [NSString stringWithFormat:@"%d",ocomm.jxfactor()];
        //搜索方法
        switch (ocomm.serachmode()) {
            case Differential::Search_Type::Search_Type_Search_Type:
                generalParam.SerachMode = [NSString stringWithFormat:@"%d",0];
                break;
            case Differential::Search_Type::Search_Type_Single:
                generalParam.SerachMode = [NSString stringWithFormat:@"%d",1];
                break;
            default:
                break;
        }
        //CT极性
        switch (ocomm.idequ()) {
            case Differential::CTPolar_Type::TwoSide_Type:
                generalParam.IdEqu = [NSString stringWithFormat:@"%d",0];
                break;
            case Differential::CTPolar_Type::OneSide_type:
                generalParam.IdEqu = [NSString stringWithFormat:@"%d",1];
                break;
            default:
                break;
        }
        generalParam.Equation = [NSString stringWithFormat:@"%d",ocomm.equation()];
        generalParam.K1 = kTStrings(ocomm.k1());
        generalParam.K2 = kTStrings(ocomm.k2());
        //测试项
        switch (ocomm.phase_type()) {
            case Differential::TestPhasor_type::APhase:
                generalParam.Phase_Type = [NSString stringWithFormat:@"%d",0];
                break;
            case Differential::TestPhasor_type::BPhase:
                generalParam.Phase_Type = [NSString stringWithFormat:@"%d",1];
                break;
            case Differential::TestPhasor_type::CPhase:
                generalParam.Phase_Type = [NSString stringWithFormat:@"%d",2];
                break;
            case Differential::TestPhasor_type::ABCPhase:
                generalParam.Phase_Type = [NSString stringWithFormat:@"%d",3];
                break;
            default:
                break;
        }
        generalParam.Reso = kTStrings(ocomm.reso());
        generalParam.Ugroup1 = kTStrings(ocomm.ugroup1());
        generalParam.Ugroup2 = kTStrings(ocomm.ugroup2());
        
        
        generalParam.PrefaultTime = kTStrings(ocomm.prefaulttime());
        generalParam.PrefaultTime = kTStrings(ocomm.prefaulttime());
        generalParam.PrefaultTime = kTStrings(ocomm.prefaulttime());
        generalParam.PrefaultTime = kTStrings(ocomm.prefaulttime());
        generalParam.PrefaultTime = kTStrings(ocomm.prefaulttime());
        generalParam.PrefaultTime = kTStrings(ocomm.prefaulttime());
        
        
        Differential::ProtectSetting oProtecSet = oitems.oprotectset();
        //定值整定值方式
        switch (oProtecSet.axis()) {
            case Differential::SettingType::RealValue_type:
                setParam.Axis = 0;
                break;
            case Differential::SettingType::MarkValue_Type:
                setParam.Axis = 1;
                break;
            default:
                break;
        }
        //基准电流选择
        switch (oProtecSet.insel()) {
            case Differential::BaseCurrentSelect::HighSideSecondaryCurrent:
                setParam.Insel = 0;
                break;
            case Differential::BaseCurrentSelect::SettingValue:
                setParam.Insel = 1;
                break;
            case Differential::BaseCurrentSelect::AllSideCurrent:
                setParam.Insel = 2;
                break;
            default:
                break;
        }
        setParam.Inom = oProtecSet.inom();
        setParam.Isd = oProtecSet.isd();
        setParam.Icdqd = oProtecSet.icdqd();
        setParam.KneePoint = (NSInteger)oProtecSet.kneepoint();
        setParam.Ip1 = oProtecSet.ip1();
        setParam.Ip2 = oProtecSet.ip2();
        setParam.Ip3 = oProtecSet.ip3();
        setParam.Kid1 = oProtecSet.kid1();
        setParam.Kid2 = oProtecSet.kid2();
        setParam.Kid3 = oProtecSet.kid3();
        setParam.Kid4 = oProtecSet.kid4();
        setParam.Kxb2 = oProtecSet.kxb();
        setParam.Kxb3 = oProtecSet.kxb3();
        setParam.Kxb5 = oProtecSet.kxb5();
       
        //开关量参数
        Differential::SwitchPara oSwitch = oitems.oswitch();
        binarySwitch.iKA = (NSInteger)oSwitch.ika();
        binarySwitch.iKB = (NSInteger)oSwitch.ikb();
        binarySwitch.iKC = (NSInteger)oSwitch.ikc();
        binarySwitch.iKD = (NSInteger)oSwitch.ikd();
        binarySwitch.iKE = (NSInteger)oSwitch.ike();
        binarySwitch.iKF = (NSInteger)oSwitch.ikf();
        binarySwitch.iKG = (NSInteger)oSwitch.ikg();
        binarySwitch.iKH = (NSInteger)oSwitch.ikh();
        binarySwitch.iKI = (NSInteger)oSwitch.iki();
        binarySwitch.iKJ = (NSInteger)oSwitch.ikj();
        binarySwitch.iLogic = (NSInteger)oSwitch.ilogic();
        binarySwitch.iOut1 = (NSInteger)oSwitch.iout1();
        binarySwitch.iOut2 = (NSInteger)oSwitch.iout2();
        binarySwitch.iOut3 = (NSInteger)oSwitch.iout3();
        binarySwitch.iOut4 = (NSInteger)oSwitch.iout4();
        binarySwitch.iOut5 = (NSInteger)oSwitch.iout5();
        binarySwitch.iOut6 = (NSInteger)oSwitch.iout6();
        binarySwitch.iOut7 = (NSInteger)oSwitch.iout7();
        binarySwitch.iOut8 = (NSInteger)oSwitch.iout8();
        
        //测试项列表数据
        int size = oitems.oitems_size();//获取模版文件中国年otems中测试项的个数，循环遍历，转化为BD_DifferentialTestItemModel类型的数组，在页面中显示
        for (int i =0; i<size;i++) {
            Differential::testItem oitem = oitems.oitems(i);
            BD_DifferentialTestItemModel *testModel = [[BD_DifferentialTestItemModel alloc]init];
            testModel.itemNum = i+1;
            testModel.itemSelect = YES;
            if (oitem.itemtype() == Differential::TestItem_type::QDCurrent) {
                testModel.itemName = @"启动电流";
                testModel.testItemParam.itemType = DifferTestItemType_QDCurrent;
                testModel.testItemParam.iIndex = [NSString stringWithFormat:@"%d",oitem.oqdcurrent().iindex()];
                testModel.testItemParam.Ir = kTStrings(oitem.oqdcurrent().ir());
                testModel.testItemParam.fUp = kTStrings(oitem.oqdcurrent().fup());
                testModel.testItemParam.fDown = kTStrings(oitem.oqdcurrent().fdown());
                
            } else if (oitem.itemtype() == Differential::TestItem_type::SDCurrent){
                testModel.itemName = @"速断电流";
                testModel.testItemParam.itemType = DifferTestItemType_SDCurrent;
                testModel.testItemParam.iIndex = [NSString stringWithFormat:@"%d",oitem.oqdcurrent().iindex()];
                testModel.testItemParam.Ir = kTStrings(oitem.oqdcurrent().ir());
                testModel.testItemParam.fUp = kTStrings(oitem.oqdcurrent().fup());
                testModel.testItemParam.fDown = kTStrings(oitem.oqdcurrent().fdown());
            } else if (oitem.itemtype() == Differential::TestItem_type::ZDRatio){
                testModel.testItemParam.itemType = DifferTestItemType_ZDRatio;
                testModel.testItemParam.iTypeIndex = [NSString stringWithFormat:@"%d",oitem.ozdratio().itypeindex()];
                testModel.testItemParam.iIndex = [NSString stringWithFormat:@"%d",oitem.ozdratio().iindex()];
                testModel.testItemParam.Ir = kTStrings(oitem.ozdratio().ir());
                testModel.testItemParam.fUp = kTStrings(oitem.ozdratio().fup());
                testModel.testItemParam.fDown = kTStrings(oitem.ozdratio().fdown());
                if ([testModel.testItemParam.iTypeIndex isEqualToString:@"1"]) {
                    testModel.itemName = @"比率制动系数一";
                } else if ([testModel.testItemParam.iTypeIndex isEqualToString:@"2"]) {
                    testModel.itemName = @"比率制动系数二";
                } else {
                    testModel.itemName = @"比率制动系数三";
                }
            } else if (oitem.itemtype() == Differential::TestItem_type::HarmonicRation){
                testModel.testItemParam.itemType = DifferTestItemType_HarmonicRation;
                testModel.testItemParam.iIndex = [NSString stringWithFormat:@"%d",oitem.oharmnonicratio().iindex()];
                testModel.testItemParam.Id = kTStrings(oitem.oharmnonicratio().id());
                testModel.testItemParam.nHarm = [NSString stringWithFormat:@"%d",oitem.oharmnonicratio().nham()];
                testModel.itemName = [NSString stringWithFormat:@"%d次谐波制动系数",oitem.oharmnonicratio().nham()];
                
            } else if (oitem.itemtype() == Differential::TestItem_type::ActionTime){
                testModel.testItemParam.itemType = DifferTestItemType_ActionTime;
                testModel.testItemParam.iIndex = [NSString stringWithFormat:@"%d",oitem.oactiontime().iindex()];
                testModel.testItemParam.Id = kTStrings(oitem.oactiontime().id());
                testModel.testItemParam.Ir = kTStrings(oitem.oactiontime().ir());
                testModel.itemName = @"动作时间";
            } else {
                
            }
           
            [testItems addObject:testModel];
        }
    
        [resultArr addObject:generalParam];
        [resultArr addObject:setParam];
        [resultArr addObject:binarySwitch];
        [resultArr addObject:testItems];

        [BD_PMCtrlSingleton shared].deviceType = deviceType;
        return resultArr;
    } else {
        return nil;
    }
}
@end
