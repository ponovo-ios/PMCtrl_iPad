#ifndef MYXMLRPCSERVERMETHOD_H
#define MYXMLRPCSERVERMETHOD_H

#include"../xmlrpc/XmlRpcServerMethod.h"
#include"../xmlrpc/XmlRpcValue.h"
#include"../xmlrpc/XmlRpcServer.h"
using namespace XmlRpc;

class myXmlRpcServerMethod : public XmlRpcServerMethod
{
public:
  myXmlRpcServerMethod
   (const char *name, XmlRpcServer * server):XmlRpcServerMethod(name, server) {}
   virtual void execute(XmlRpcValue & params, XmlRpcValue& result) {}
};

//手动
class ManualTest:public myXmlRpcServerMethod
{
public:
    ManualTest(XmlRpcServer* s);
    virtual void execute(XmlRpcValue & params, XmlRpcValue& result);
};
//状态序列
class StateSequence:public myXmlRpcServerMethod
{
public:
    StateSequence(XmlRpcServer* s);
    virtual void execute(XmlRpcValue & params, XmlRpcValue& result);
};

//差动模块
class DifferResult:public myXmlRpcServerMethod
{
public:
    DifferResult(XmlRpcServer* s);
    virtual void execute(XmlRpcValue & params, XmlRpcValue& result);
};

////谐波模块
//class HarmResult:public myXmlRpcServerMethod
//{
//public:
//    HarmResult(XmlRpcServer* s);
//    virtual void execute(XmlRpcValue & params, XmlRpcValue& result);
//};


//读取gps时间
class ReadGPSMethod:public myXmlRpcServerMethod
{
public:
    ReadGPSMethod(XmlRpcServer* s);
    virtual void execute(XmlRpcValue & params, XmlRpcValue& result);
};

//读取仪器电压--电流信息信号灯信息
class ReadDeviceinfoMethod:public myXmlRpcServerMethod{
public:
    ReadDeviceinfoMethod(XmlRpcServer* s);
    virtual void execute(XmlRpcValue & params, XmlRpcValue& result);
};

//StateSequence

#endif // MYXMLRPCSERVERMETHOD_H
