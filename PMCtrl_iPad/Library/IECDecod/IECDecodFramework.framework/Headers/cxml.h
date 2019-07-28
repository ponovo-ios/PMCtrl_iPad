#ifndef CXML_H
#define CXML_H

#include <list>
#include <vector>
#include <string>
#include <map>
//#include "hash_map"

#include <iostream>
//#include ".\pugixml\pugixml.hpp"
#include "pugixml.hpp"
using namespace pugi;
using namespace std;

//通道信息
struct ChanInfor
{
	string iedName;
	string intAddr;
	string prefix;
	string desc;
	string doName;
	string lnInst;
	string lnType;
	string daName;
	string ldInst;
	string lnClass;

	string chankind;//boolean or struct ....
};

//外部Appid描述信息
struct AppIDNameDesEx
{
	string m_ldInst;
	string m_AppID;
	string m_MacSRC;
	string m_IedName;
	string m_cbName;
	string m_Desc;
	string m_datSet;
	string m_confRev;
	string m_VLanID;
	string m_VLanPri;
	std::vector<ChanInfor> m_ChanNameArray;

	//SMV
	string m_smvID;
	string m_smpRate;
	string m_nofASDU;

	//GOOSE
	string m_goID;

	//IN
	string m_ExtIEDName;
	string m_ExtIEDDesc;

};

//外部引用信息
struct IEDExtRefInfor
{
	string m_ExtIEDName;
	std::vector<ChanInfor> m_ExtRefSMVVector;
	std::vector<ChanInfor> m_ExtRefGooseVector;
};

//所有IED信息
struct IEDAllInfor
{

	string m_IedName;
	string m_IedDesc;

	std::vector<AppIDNameDesEx> m_SMVVector;
	std::vector<AppIDNameDesEx> m_GooseVector;

	std::vector<AppIDNameDesEx> m_InputSMVVector;
	std::vector<AppIDNameDesEx> m_InputGooseVector;

	std::vector<IEDExtRefInfor> m_IEDExtRefInforVector;

};


//订阅信息
typedef struct  _SUB_REC_INFO
{
    //内部虚端子信息
    string ref;
    string desc;

    //外部虚端子信息
    string sub_IED_name;
    string sub_ldInst;
    string sub_ref;

    int index_IED;
    int index_GSE_SMV;
    int index_Rec;

}_SUB_REC_INFO;

//发布信息
typedef struct _CONNECT_PUB_INFO
{
    int index_IED;
    int index_Rec;
}_CONNECT_PUB_INFO;

typedef struct  _PUB_REC_INFO
{
    string ref;
    string desc;
    string bType;
    //一条信息发布给多个IED
    vector<_CONNECT_PUB_INFO> recPubList;
}_PUB_REC_INFO;

//GOOSE发送数据块
typedef struct _GSE_INFO
{
    string apName;    //访问点名称
    string apDesc;

    string cbName;    //控制块名称
    string ldInst;    //逻辑设备
    string desc;      //控制块注释
    //Address
    string MAC_Adress;
    string VLAN_ID;
    string VLAN_PRIORITY;
    string APPID;

    int MinTime;
    int MaxTime;

    string datSet;    //数据集名称
    string confRev;    //版本号
    string appID;    //goID

    int recNum;    //数据集通道个数
    string DataSetDesc;    //数据集注释

    //一个控制块，多条记录
    vector<_PUB_REC_INFO> pubList;
}_GSE_INFO;

//SMV发送数据块
typedef struct _SMV_INFO
{
    string apName;
    string apDesc;

    string cbName;
    string ldInst;
    string desc;

    //Address
    string MAC_Adress;
    string VLAN_ID;
    string APPID;
    string VLAN_PRIORITY;

    //SampledValueControl
    string datSet;
    string confRev;
    string SmvID;
	
	//string multicast;    //暂时不用
    int smpRate;
    int nofASDU;

    //SmvOpts
    bool refreshTime;			 //刷新时间
    bool sampleSynchronized;    //同步采样
    bool sampleRate;			 //采样速率
    bool security;				 //完全
    bool dataRef;				 //数据引用

    int recNum;
    string DataSetDesc;

    //一个控制块，多条记录
    vector<_PUB_REC_INFO> pubList;

}_SMV_INFO;

//IED的信息
typedef struct _IED_INFO
{
    string name;
    string type;
    string manufacturer;
    string configVersion;
    string desc;

    vector<_GSE_INFO> GSEList;
    vector<_SMV_INFO> SMVList;

    vector<_SUB_REC_INFO> GOSubList;
    vector<_SUB_REC_INFO> SVSubList;

}_IED_INFO;

class CXML
{
    
public:
    explicit CXML();
	~CXML();

    int loadSCDFile(const string filePath);    //装载SCD文件
    int savePSCDFile(const string filePath);   //保存解析结果

    vector<_IED_INFO> IEDList;				    //解析结果
    int errMsg_counter;

private:
    enum DataFC{DOType,SDOType,DAType,BDAType};
    
	map<string, int> IED_Hash;
	typedef map<string,xml_node> DataTypeHash;
   
	DataTypeHash DOType_Hash;
    DataTypeHash DAType_Hash;

    typedef map<string,DataTypeHash> LNodeTypeHash;
    LNodeTypeHash LNodeType_Hash;

private:
    string getDataFC(const DataFC dataFC,const string id,const string name,const string fc);

    void createLNHash(const xml_node LD_node,DataTypeHash *pLN_hash);
    void createHash(xml_node root);

};

#endif // CXML_H
