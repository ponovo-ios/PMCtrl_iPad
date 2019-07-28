#include "myXmlrpcServer.h"
using namespace XmlRpc;
using namespace std;

myXmlRpcServer::myXmlRpcServer()
{
    //call register methods
    pm_registerMethods();

    //set port bind and listen
    int port = 8085;
    pm_xmlRpcServer.bindAndListen(port);

    
}

void myXmlRpcServer::pm_registerMethods()
{
    pm_serverMethods.push_back(new ManualTest(&pm_xmlRpcServer));//手动／谐波
    pm_serverMethods.push_back(new StateSequence(&pm_xmlRpcServer));//状态序列
    pm_serverMethods.push_back(new DifferResult(&pm_xmlRpcServer));//差动
    pm_serverMethods.push_back(new ReadGPSMethod(&pm_xmlRpcServer));//获取gps时间
    pm_serverMethods.push_back(new ReadDeviceinfoMethod(&pm_xmlRpcServer)); //读取设备信息
}

void myXmlRpcServer::run()
{
    pm_xmlRpcServer.work(-1);
}
