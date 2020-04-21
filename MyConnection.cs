using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace NewAppendixLayout
{
    public static class MyConnection
    {
        public static SqlConnection getConnection()
        {
            string conn = "Data Source = (localdb)\\ProjectsV13; Initial Catalog = APPendixDB; Integrated Security = True; Connect Timeout = 30; Encrypt = False; TrustServerCertificate = False; ApplicationIntent = ReadWrite; MultiSubnetFailover = False";
            SqlConnection myConn = new SqlConnection(conn);
            return myConn;
        }
    }
}
