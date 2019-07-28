#ifndef MYXMLRPCSERVER_H
#define MYXMLRPCSERVER_H
#include "myXmlrpcServerMethod.h"
#include "../xmlrpc/XmlRpc.h"

class myXmlRpcServer {
public:
        myXmlRpcServer();
        void run();
private:
        void pm_registerMethods();
        XmlRpc::XmlRpcServer pm_xmlRpcServer;
        std::list< myXmlRpcServerMethod* > pm_serverMethods;
};



#endif // MYXMLRPCSERVER_H
