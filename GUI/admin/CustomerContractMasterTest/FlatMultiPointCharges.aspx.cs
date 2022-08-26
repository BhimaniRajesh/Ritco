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

public partial class GUI_admin_CustomerContractMater_FlatMultiPointCharges : System.Web.UI.Page
{
    static protected DataTable dt_ftls, dtftltype;
    SqlConnection con;
    string custcode = "", contractid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["contractid"].ToString();

        MyFunctions fn = new MyFunctions();
        lblcontractid.Text = contractid;
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);
        try
        {
            con = new SqlConnection(Convert.ToString(Session["SqlProvider"]).Trim());
            con.Open();
        }
        catch (Exception ex)
        {
            string strex = ex.Message.ToString().Replace('\n', '_');
            Response.Redirect("../../Operation/DocketEntry/ErrorPage.aspx?heading=Session Expired&detail1=" + strex);
            return;
        }

        string sqlstr = "";
        SqlCommand cmd;
        SqlDataAdapter da;

        if (!IsPostBack)
        {
            sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y' ORDER BY codedesc";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);
            dtftltype = new DataTable();
            da.Fill(dtftltype);


            dt_ftls = new DataTable();
            dt_ftls.Columns.Add("srno", typeof(string));
            dt_ftls.Columns.Add("codeid", typeof(string));
            dt_ftls.Columns.Add("ftltype", typeof(string));
            dt_ftls.Columns.Add("pickup", typeof(string));
            dt_ftls.Columns.Add("delivery", typeof(string));


            /// CHECKING FOR MASTER INPUTS - STARTS
            int cnt = 0;

            sqlstr = "SELECT * FROM webx_custcontract_flatmultipoint WHERE contractid = '" + contractid + "' ORDER BY ftltype";
            cmd = new SqlCommand(sqlstr, con);
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);
            da.Fill(dt_ftls);
            if (dt_ftls.Rows.Count <= 0)
                dt_ftls.Rows.Add();

            grvftls.DataSource = dt_ftls;
            grvftls.DataBind();





        }
    }

    protected void grvftls_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DropDownList cmbftltype = (DropDownList)e.Row.FindControl("cmbftltype");
            DropDownList cmbratetype = (DropDownList)e.Row.FindControl("cmbratetype");
            cmbftltype.DataSource = dtftltype;
            cmbftltype.DataBind();

            try
            {
                cmbftltype.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ftltype"));
                cmbratetype.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ratetype"));

            }
            catch (Exception ex) { }
        }
    }

    protected void btnaddrows_Click(object sender, EventArgs e)
    {
        int len = Convert.ToInt16(txtnorows.Text);
        for (int i = 0; i < len; i++)
        {
            dt_ftls.Rows.Add();
        }
        grvftls.DataSource = dt_ftls;
        grvftls.DataBind();
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlCommand cmd;
        string sqlstr = "";

        SqlTransaction trn;
        trn = con.BeginTransaction();
        try
        {
            sqlstr = "DELETE FROM webx_custcontract_flatmultipoint WHERE contractid = '" + contractid + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            foreach (GridViewRow grv in grvftls.Rows)
            {
                DropDownList cmbftltype = (DropDownList)grv.FindControl("cmbftltype");
                DropDownList cmbratetype = (DropDownList)grv.FindControl("cmbratetype");
                TextBox txtpickup = (TextBox)grv.FindControl("txtpickup");
                TextBox txtdelivery = (TextBox)grv.FindControl("txtdelivery");

                sqlstr = "INSERT INTO webx_custcontract_flatmultipoint(custcode,contractid,service_class,ftltype,ratetype,pickup,delivery)";
                sqlstr = sqlstr + "VALUES ('" + custcode + "',";
                sqlstr = sqlstr + "'" + contractid + "','2',";
                sqlstr = sqlstr + "'" + cmbftltype.SelectedValue + "',";
                sqlstr = sqlstr + "'" + cmbratetype.SelectedValue + "',";
                sqlstr = sqlstr + "" + txtpickup.Text.Trim() + ",";
                sqlstr = sqlstr + txtdelivery.Text.Trim() + ")";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            string strex = ex.Message.ToString().Replace('\n', '_');
            Response.Redirect("../../Operation/DocketEntry/ErrorPage.aspx?heading=Database Entry Failed&detail1=" + strex);
            return;
        }

        trn.Commit();
        Response.Redirect("CCM_DisplayResult.aspx?contractid=" + contractid + "&custcode=" + custcode);

    }
}
