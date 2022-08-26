using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using ApplicationManager;
using System.Data.SqlClient;
using WebControls;

/// <summary>
/// Summary description for cls_vendor_Service_Mapping
/// </summary>
public class cls_vendor_Service_Mapping : DataAccessLayer
{
    private string _Connection_String;
    private string _VENDORCODE, _VENDORNAME, _AccCode;
    protected bool _Is_Record_Found;

    public bool IsRecordFound { get { return _Is_Record_Found; } set { _Is_Record_Found = value; } }
    public string VENDORCODE { get { return _VENDORCODE; } set { _VENDORCODE = value; } }
    public string VENDORNAME { get { return _VENDORNAME; } set { _VENDORNAME = value; } }
    public string AccCode { get { return _AccCode; } set { _AccCode = value; } }

    public cls_vendor_Service_Mapping(string ConnectionString)
        : base(ConnectionString)
	{
        _Connection_String = ConnectionString;
	}

    public void VendorService(DataList dl, string VENDORCODE, string VENDORNAME)
    {
        WebControlsBinder wcb = new WebControlsBinder(_Connection_String);
        SqlParameter[] prm = new SqlParameter[2];

        prm[0] = new SqlParameter("@VENDORCODE", VENDORCODE);
        prm[1] = new SqlParameter("@VENDORNAME", VENDORNAME);

        wcb.DataBind(dl, CommandType.StoredProcedure, "usp_Fleet_Vendor_Servie_Mapping", prm);
    }

    public void CheckAccCode()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@AccCode", AccCode);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Check_AccCode", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

        }
        else
        {
            IsRecordFound = false;
        }
    }

    public void CheckVendorCode()
    {
        DataTable dt = new DataTable();
        SqlParameter[] prm = new SqlParameter[1];

        prm[0] = new SqlParameter("@VENDORNAME", VENDORNAME);

        dt = ExecuteDataTable(CommandType.StoredProcedure, "USP_Check_VendorCode", prm);

        if (dt.Rows.Count > 0)
        {
            IsRecordFound = true;

            VENDORNAME = dt.Rows[0]["VENDORNAME"].ToString();
            VENDORCODE = dt.Rows[0]["VENDORCODE"].ToString();
        }
        else
        {
            IsRecordFound = false;
        }
    }


    public DataTable GetVendorServiceData(string mCode)
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dt = ExecuteDataTable(CommandType.Text, "select * from Webx_Vendor_Service_Mapping_master where vendor_service_code = '" + mCode + "'");
        return dt;
    }

    public DataTable GetVendorData(string mCode)
    {
        DataTable dt = new DataTable();
        DataControlManager dcm = new DataControlManager(_Connection_String);
        dt = ExecuteDataTable(CommandType.Text, "select * from Webx_Vendor_Service_Mapping_master where vendorcode = '" + mCode + "'");
        return dt;
    }
}
