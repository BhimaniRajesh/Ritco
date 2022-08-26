using System;
using System.Data;
using System.Data.SqlClient;

public static class BLL_Helper
{

    public static DataTable GetDataTable(string _ConnectionString, CommandType CmdType, string CommandText, SqlParameter[] Parameters)
    {
        SqlDataAdapter _Adapter = new SqlDataAdapter(CommandText, _ConnectionString);
        DataTable _DataTable = new DataTable();

        _Adapter.SelectCommand.Parameters.AddRange(Parameters);
        _Adapter.SelectCommand.CommandType = CmdType;
        _Adapter.SelectCommand.CommandTimeout = 0;
        _Adapter.Fill(_DataTable);

        return _DataTable;
    }

}
