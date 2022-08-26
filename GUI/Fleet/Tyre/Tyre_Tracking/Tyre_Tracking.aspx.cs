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

public partial class GUI_Fleet_Tyre_Tyre_Tracking_Tyre_Tracking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtTyreNo.Attributes.Add("OnBlur", "javascript:checkTyreNo(this)");
        txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo(this)");
       
        if (!IsPostBack)
        {
            btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../../GUI/Fleet/Tyre/Tyre_Tracking/VehicleNo.aspx?VehNo=" + txtVehNo.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            btnPopupTyreNo.Attributes.Add("OnClick", "window.open('../../../../GUI/Fleet/Tyre/Tyre_Tracking/popup_TyreNo.aspx?TyreNo=" + txtTyreNo.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        BindGrid();
    }

    protected void gvTyreTracking_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvTyreTracking.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "USP_TyreTracking";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@TYRE_NO", SqlDbType.VarChar).Value = txtTyreNo.Text.ToString().Trim();
        da.SelectCommand.Parameters.Add("@TYRE_VEHNO", SqlDbType.VarChar).Value = txtVehNo.Text.ToString().Trim();

        DataSet ds = new DataSet();
        da.Fill(ds);
        gvTyreTracking.DataSource = ds;
        gvTyreTracking.DataBind();
        conn.Close();
    }
}
