
//
//  BD_IECConfitDecodManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/3/28.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_IECConfitDecodManager.h"
#import "IECDecodFramework.framework/Headers/cxml.h"
#import "BD_PopListViewManager.h"
#import "BD_SCLFileConfigVC.h"
#import "BD_IEDInfoModel.h"

@implementation BD_IECConfitDecodManager
-(NSMutableArray<BD_IEDInfoModel *> *)decodingSCDFileWithFilePath:(NSString *)filePath{
    
    std::string  fileStr=  [filePath UTF8String];
    CXML mSCDParse;
    if(mSCDParse.loadSCDFile(fileStr) >= 0)
    {
        cout << "open right!!!!";
        //将获取到的解码文件返回
       
        int size = (int)mSCDParse.IEDList.size();
        NSMutableArray *result = [[NSMutableArray alloc]init];
        for (int i = 0; i<size; i++) {
             _IED_INFO iedinfo = mSCDParse.IEDList[i];
            
            BD_IEDInfoModel *resultItem = [[BD_IEDInfoModel alloc]init];
            resultItem.IEDname = [self cstringToNSString:iedinfo.name];
            resultItem.IEDtype = [self cstringToNSString:iedinfo.type];
            resultItem.IEDmanufacture = [self cstringToNSString:iedinfo.manufacturer];
            resultItem.IEDconfigVersion = [self cstringToNSString:iedinfo.configVersion];
            resultItem.IEDDescription = [self cstringToNSString:iedinfo.desc];
            for (int n = 0; n<iedinfo.GSEList.size(); n++) {
                _GSE_INFO gse = iedinfo.GSEList[n];
                BD_GSEInfo *gseinfo = [[BD_GSEInfo alloc]init];
                gseinfo.apName = [self cstringToNSString:gse.apName];
                gseinfo.apDesc = [self cstringToNSString:gse.apDesc];
                gseinfo.cbName = [self cstringToNSString:gse.cbName];
                gseinfo.ldInst = [self cstringToNSString:gse.ldInst];
                gseinfo.desc = [self cstringToNSString:gse.desc];
                gseinfo.MAC_Adress = [self cstringToNSString:gse.MAC_Adress];
                gseinfo.VLAN_ID = [self cstringToNSString:gse.VLAN_ID];
                gseinfo.VLAN_PRIORITY = [self cstringToNSString:gse.VLAN_PRIORITY];
                gseinfo.APPID = [self cstringToNSString:gse.APPID];
                gseinfo.MinTime = [self intToNSInteger:gse.MinTime];
                gseinfo.MaxTime = [self intToNSInteger:gse.MaxTime];
                gseinfo.datSet = [self cstringToNSString:gse.datSet];
                gseinfo.confRev = [self cstringToNSString:gse.confRev];
                gseinfo.appID = [self cstringToNSString:gse.appID];
                gseinfo.recNum = [self intToNSInteger:gse.recNum];
                gseinfo.DataSetDesc = [self cstringToNSString:gse.DataSetDesc];
                
                for (int j = 0; j<gse.pubList.size(); j++) {
                    _PUB_REC_INFO pubrec = gse.pubList[j];
                    BD_PublishRECInfo *pubRecInfo = [[BD_PublishRECInfo alloc]init];
                    pubRecInfo.ref = [self cstringToNSString:pubrec.ref];
                    pubRecInfo.desc = [self cstringToNSString:pubrec.desc];
                    pubRecInfo.bType = [self cstringToNSString:pubrec.bType];
                    
                    for (int x = 0; x<pubrec.recPubList.size(); x++) {
                        _CONNECT_PUB_INFO pub = pubrec.recPubList[x];
                        BD_ConnectPubInfo *pubInfo = [[BD_ConnectPubInfo alloc]init];
                        pubInfo.index_IED = [self intToNSInteger:pub.index_IED];
                        pubInfo.index_Rec = [self intToNSInteger:pub.index_Rec];
                        [pubRecInfo.recPubList addObject:pubInfo];
                    }
                    [gseinfo.pubList addObject:pubRecInfo];
                }
                [resultItem.GSEList addObject:gseinfo];
            }
            
            for (int n = 0; n<iedinfo.SMVList.size(); n++) {
                _SMV_INFO smv = iedinfo.SMVList[n];
                BD_SMVInfo *smvInfo = [[BD_SMVInfo alloc]init];
                smvInfo.apName = [self cstringToNSString:smv.apName];
                smvInfo.apDesc = [self cstringToNSString:smv.apDesc];
                smvInfo.cbName = [self cstringToNSString:smv.cbName];
                smvInfo.ldInst = [self cstringToNSString:smv.ldInst];
                smvInfo.desc = [self cstringToNSString:smv.desc];
                smvInfo.MAC_Adress = [self cstringToNSString:smv.MAC_Adress];
                smvInfo.VLAN_ID = [self cstringToNSString:smv.VLAN_ID];
                smvInfo.APPID = [self cstringToNSString:smv.APPID];
                smvInfo.VLAN_PRIORITY = [self cstringToNSString:smv.VLAN_PRIORITY];
                smvInfo.datSet = [self cstringToNSString:smv.datSet];
                smvInfo.confRev = [self cstringToNSString:smv.confRev];
                smvInfo.SmvID = [self cstringToNSString:smv.SmvID];
                smvInfo.smpRate = [self intToNSInteger:smv.smpRate];
                smvInfo.nofASDU = [self intToNSInteger:smv.nofASDU];
                smvInfo.refreshTime = smv.refreshTime;
                smvInfo.sampleSynchronized = smv.sampleSynchronized;
                smvInfo.sampleRate = smv.sampleRate;
                smvInfo.security = smv.security;
                smvInfo.dataRef = smv.dataRef;
                smvInfo.recNum = [self intToNSInteger:smv.recNum];
                smvInfo.DataSetDesc = [self cstringToNSString:smv.DataSetDesc];
                for (int j = 0; j<smv.pubList.size(); j++) {
                    _PUB_REC_INFO pubrec = smv.pubList[j];
                    BD_PublishRECInfo *pubrecInfo = [[BD_PublishRECInfo alloc]init];
                    pubrecInfo.ref = [self cstringToNSString:pubrec.ref];
                    pubrecInfo.desc = [self cstringToNSString:pubrec.desc];
                    pubrecInfo.bType = [self cstringToNSString:pubrec.bType];
                    
                    for (int y = 0; y<pubrec.recPubList.size(); y++) {
                        _CONNECT_PUB_INFO pub = pubrec.recPubList[y];
                        BD_ConnectPubInfo *pubInfo = [[BD_ConnectPubInfo alloc]init];
                        pubInfo.index_IED = [self intToNSInteger:pub.index_IED];
                        pubInfo.index_Rec = [self intToNSInteger:pub.index_Rec];
                        [pubrecInfo.recPubList addObject:pubInfo];
                    }
                    
                    [smvInfo.pubList addObject:pubrecInfo];
                }
                [resultItem.SMVList addObject:smvInfo];
                
                
            }
            
            for (int n = 0; n<iedinfo.GOSubList.size();n++) {
                _SUB_REC_INFO subrec = iedinfo.GOSubList[n];
                BD_SubRECInfo *subRecInfo = [[BD_SubRECInfo alloc]init];
                subRecInfo.ref = [self cstringToNSString:subrec.ref];
                subRecInfo.desc = [self cstringToNSString:subrec.desc];
                subRecInfo.sub_IED_name = [self cstringToNSString:subrec.sub_IED_name];
                subRecInfo.sub_ldInst = [self cstringToNSString:subrec.sub_ldInst];
                subRecInfo.sub_ref = [self cstringToNSString:subrec.sub_ref];
                subRecInfo.index_IED = [self intToNSInteger:subrec.index_IED];
                subRecInfo.index_GSE_SMV = [self intToNSInteger:subrec.index_GSE_SMV];
                subRecInfo.index_Rec = [self intToNSInteger:subrec.index_Rec];
                [resultItem.GOSubList addObject:subRecInfo];
            }
            
            for (int n = 0; n<iedinfo.SVSubList.size();n++) {
                _SUB_REC_INFO subrec = iedinfo.SVSubList[n];
                BD_SubRECInfo *subRecInfo = [[BD_SubRECInfo alloc]init];
                subRecInfo.ref = [self cstringToNSString:subrec.ref];
                subRecInfo.desc = [self cstringToNSString:subrec.desc];
                subRecInfo.sub_IED_name = [self cstringToNSString:subrec.sub_IED_name];
                subRecInfo.sub_ldInst = [self cstringToNSString:subrec.sub_ldInst];
                subRecInfo.sub_ref = [self cstringToNSString:subrec.sub_ref];
                subRecInfo.index_IED = [self intToNSInteger:subrec.index_IED];
                subRecInfo.index_GSE_SMV = [self intToNSInteger:subrec.index_GSE_SMV];
                subRecInfo.index_Rec = [self intToNSInteger:subrec.index_Rec];
                [resultItem.SVSubList addObject:subRecInfo];
            }
            
            
            [result addObject:resultItem];
        }

        return result;
    }
    else
    {
        cout<<"open FAILED!";
        
    }
    return nil;
 
}
-(void)showIECViewInVC:(UIViewController *)VC sourceView:(UIView *)sourceView{
    //最初版IEC配置页是手动测试模块的一个子项目，后修改独立成为一个单独的模块，所以，UI设计也进行了调整，独立跳转到一个新页面
    WeakSelf;
    //判断SCDFiles文件夹中是否
    [self showTemplateFileListView:sourceView complete:^(NSString *name) {
        if ([name hasSuffix:@".scd"]) {
            NSString *document = [[[FileUtil documentsPath] stringByAppendingString:@"/"] stringByAppendingString:name];
            NSMutableArray *iedInfoArr = [weakself decodingSCDFileWithFilePath:document];
            [self presentSCLConfitViewWithVC:VC datasource:iedInfoArr];
        } else {
              [BD_PopListViewManager showRemindAlertView:VC title:@"提醒" message:@"请选择正确的SCD文件"];
        }
        
    } vc:VC];
    
  
    
    
    
}


-(void)showTemplateFileListView:(UIView *)sourceView complete:(void(^)(NSString *))complete vc:(UIViewController*)VC{
    NSArray *files  = [FileUtil getDirectoryFileNames:@""];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [files enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([((NSString *)obj) hasSuffix:@".scd"]) {
            [arr addObject:@(YES)];
        } else {
            [arr addObject:@(NO)];
      
        }
    }];
    if ([arr containsObject:@(YES)]) {
        [BD_PopListViewManager ShowPopViewWithlistDataSource:files textField:sourceView viewController:VC direction:UIPopoverArrowDirectionUp complete:^(NSString *fileName) {
            complete(fileName);
        }];
    } else {
        [BD_PopListViewManager showRemindAlertView:VC title:@"提醒" message:@"请先通过电脑iTunes将scd文件导入APP中。"];
    }
    
}

-(void)presentSCLConfitViewWithVC:(UIViewController *)vc datasource:(NSMutableArray *)dataSource{
    BD_SCLFileConfigVC *sclConfig = [[BD_SCLFileConfigVC alloc]initWithDataSource:dataSource];
    [vc presentViewController:sclConfig animated:YES completion:nil];
}
//C++string转NSString
-(NSString *)cstringToNSString:(string)str{
    return [NSString stringWithUTF8String:str.c_str()];
}
-(NSInteger)intToNSInteger:(int)intvalue{
    return (NSInteger)intvalue;
}
@end
