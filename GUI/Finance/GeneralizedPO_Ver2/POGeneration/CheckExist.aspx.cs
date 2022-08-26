using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class GUI_Finance_GeneralizedPO_POGeneration_CheckExist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string mode = Request.QueryString["mode"].ToString();
        string code = Request.QueryString["code"].ToString();
        string desc = "";
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string qry = "";
        if (mode.CompareTo("SKU") == 0)
            qry = "SELECT Cnt=Count(*) FROM Webx_PO_SKU_Master Where SKU_ID='" + code + "'";
        else if (mode.CompareTo("Spare") == 0)
            qry = "SELECT Cnt=Count(*) FROM Webx_PO_SKU_Master Where SKU_ID='" + code + "'";
        else if (mode.CompareTo("Vendor") == 0)
            qry = "SELECT Count(*) FROM Webx_Vendor_hdr Where VENDORCODE='" + code + "'";
        else if (mode.CompareTo("TyreModel") == 0)
            qry = "SELECT COUNT(*) FROM WEBX_FLEET_TYREMODELMST WHERE TYRE_MODEL_ID ='" + code + "' OR MODEL_NO ='" + code + "'";
        else if (mode.CompareTo("TyreMFG") == 0)
            qry = "SELECT COUNT(*) FROM WEBX_FLEET_TYREMFG WHERE MFG_ID='" + code + "'";
        else if (mode.CompareTo("TyreSize") == 0)
            qry = "SELECT Count(*) FROM WEBX_FLEET_TYRESIZEMST Where Tyre_sizeID='" + code + "'";
		else if (mode.CompareTo("ManualPONo") == 0)
            qry = "Select COUNT(*) FROM webx_GENERAL_POASSET_HDR Where Manual_PO_No='" + code + "'";
        else if (mode.CompareTo("FixAsset") == 0)
            qry = "Select COUNT(*) FROM webx_ASSETMASTER Where ASSETCD='" + code + "'";

        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;
        mwhile (dr.Read())
        {
            if (Convert.ToInt16(dr[0]) != 0)
            {
                i = 1;
                break;
            }
        }
        dr.Close();
        if (mode.CompareTo("ManualPONo") == 0)
        {
            if (i == 0)
                Response.Write("true|");
            else if (i == 1)
                Response.Write("false|" + desc + "|");
        }
        else
        {
            if (i == 0)
                Response.Write("false|");
            else if (i == 1)
                Response.Write("true|" + desc + "|");
        }

        con.Close();
    }
}
