using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using ApplicationManager;
using System.Data.SqlClient;

public class Vehicle_KmUpdate : DataAccessLayer
{
    #region Private Declaration
    private string _Connection_String;
    private int _Veh_Internal_No;
    private string _VEHNO;
    private string _CURRENT_KM_READ;
    private string _TMP_CURRENT_KM_READ;
  
    #endregion

    #region Properties
    public int Veh_Internal_No { get { return _Veh_Internal_No; } set { _Veh_Internal_No = value; } }
    public string VEHNO { get { return _VEHNO; } set { _VEHNO = value; } }
    public string CURRENT_KM_READ { get { return _CURRENT_KM_READ; } set { _CURRENT_KM_READ = value; } }
    public string TMP_CURRENT_KM_READ { get { return _TMP_CURRENT_KM_READ; } set { _TMP_CURRENT_KM_READ = value; } }
    #endregion


    public Vehicle_KmUpdate(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}


    //public DataTable BindSKUMap()
    //{
    //    DataTable dt = new DataTable();
    //    DataControlManager dcm = new DataControlManager(_Connection_String);
    //    SqlParameter[] prm = new SqlParameter[3];
        
    //    prm[0] = new SqlParameter("@CODE_ID", CODE_ID);
    //    prm[1] = new SqlParameter("@From_Date", From_Date);
    //    prm[2] = new SqlParameter("@To_Date", To_Date);

    //    dt = ExecuteDataTable(CommandType.StoredProcedure, "usp_Search_SKU_MAP", prm);
    //    return dt;
    //}
    public void UpdateKMRead()
    {
        ExecuteNonQuery(CommandType.Text, "UPDATE WEBX_VEHICLE_HDR SET Tmp_Current_KM_Read=" + TMP_CURRENT_KM_READ + " WHERE  VEH_INTERNAL_NO=" + Veh_Internal_No +"");
    }
    public void BindVehicle(GridView gv)
    {
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dcm.DataBind(gv, CommandType.Text, "SELECT [VEH_INTERNAL_NO], [VEHNO], [Current_KM_Read], [Tmp_Current_KM_Read] FROM [webx_vehicle_hdr] WHERE ACTIVEFLAG='Y' AND VEHNO LIKE '"+ VEHNO +"%'");
    }
}
