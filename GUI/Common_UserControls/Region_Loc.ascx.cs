using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Data.SqlClient;
using System.Web.SessionState;
using System.Security;

public partial class GUI_Common_UserControls_Region_Loc : System.Web.UI.UserControl
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!Page.IsPostBack)
            bindRegion();
    }
    private void bindRegion()
    {
        string sqlstr;
        conn.Open();
        sqlstr = "select CodeId,CodeDesc from webx_master_general a where codetype='Zone'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        dbR.Items.Clear();
        dbR.Items.Add(new ListItem("All", "All"));
        while (dr.Read())
        {
            dbR.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

        }
        dr.Close();
        dbL.Items.Clear();
        dbL.Items.Add(new ListItem("All", "All"));
        conn.Close();

    }
    protected void dbR_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sqlstr;
        conn.Open();
        sqlstr = "select LocCode,LocName from webx_location where locregion='" + dbR.SelectedValue.ToString() + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            dbL.Items.Add(new ListItem(dr.GetValue(0).ToString() + "=" + dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
        }
        dr.Close();
        conn.Close();
    }
}
