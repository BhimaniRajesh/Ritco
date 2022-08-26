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
    static protected DataTable dt_ftls, dtftltype, dt_sundry;
    SqlConnection con;
    string custcode = "", contractid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["contractid"].ToString();

        cstheader.CustCode = Request.QueryString["custcode"].ToString();
        cstheader.ContractID = Request.QueryString["contractid"].ToString();

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
            sqlstr = "SELECT * FROM webx_custcontract_flatloading WHERE custcode='" + custcode + "' AND service_class='2' ORDER BY ftltype";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);
            dt_ftls = new DataTable();
            da.Fill(dt_ftls);
            if (dt_ftls.Rows.Count <= 0)
                dt_ftls.Rows.Add();

            grvloadingftl.DataSource = dt_ftls;
            grvloadingftl.DataBind();




            dt_sundry = new DataTable();
            sqlstr = "SELECT * FROM webx_custcontract_flatloading WHERE custcode='" + custcode + "' AND service_class='1' ORDER BY custcode";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);
            dt_sundry = new DataTable();
            da.Fill(dt_sundry);
            if (dt_sundry.Rows.Count <= 0)
                dt_sundry.Rows.Add();

            grvloadingsundry.DataSource = dt_sundry;
            grvloadingsundry.DataBind();


        }
    }

    protected void grvloadingftl_RowDataBound(object sender, GridViewRowEventArgs e)
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


    protected void grvloadingsundry_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList cmbratetype = (DropDownList)e.Row.FindControl("cmbratetype");

            try
            {
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
        grvloadingftl.DataSource = dt_ftls;
        grvloadingftl.DataBind();
    }

    protected void btnaddrowssundry_Click(object sender, EventArgs e)
    {
        int len = Convert.ToInt16(txtnorowssundry.Text);
        for (int i = 0; i < len; i++)
        {
            dt_sundry.Rows.Add();
        }
        grvloadingsundry.DataSource = dt_sundry;
        grvloadingsundry.DataBind();
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlCommand cmd;
        string sqlstr = "";

        SqlTransaction trn;
        trn = con.BeginTransaction();
        try
        {
            sqlstr = "DELETE FROM webx_custcontract_flatloading WHERE contractid='" + contractid + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            foreach (GridViewRow grv in grvloadingftl.Rows)
            {
                DropDownList cmbftltype = (DropDownList)grv.FindControl("cmbftltype");
                DropDownList cmbratetype = (DropDownList)grv.FindControl("cmbratetype");
                TextBox txtrate = (TextBox)grv.FindControl("txtrate");

                sqlstr = "INSERT INTO webx_custcontract_flatloading(custcode,contractid,service_class,ftltype,ratetype,rate)";
                sqlstr = sqlstr + "VALUES ('" + custcode + "',";
                sqlstr = sqlstr + "'" + contractid + "','2',";
                sqlstr = sqlstr + "'" + cmbftltype.SelectedValue + "',";
                sqlstr = sqlstr + "'" + cmbratetype.SelectedValue + "',";
                sqlstr = sqlstr + "" + txtrate.Text.Trim() + ")";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();
            }

            foreach (GridViewRow grv in grvloadingsundry.Rows)
            {
                DropDownList cmbratetype = (DropDownList)grv.FindControl("cmbratetype");
                TextBox txtrate = (TextBox)grv.FindControl("txtrate");

                sqlstr = "INSERT INTO webx_custcontract_flatloading(custcode,contractid,service_class,ftltype,ratetype,rate)";
                sqlstr = sqlstr + "VALUES ('" + custcode + "',";
                sqlstr = sqlstr + "'" + contractid + "','1',";
                sqlstr = sqlstr + "'0',";
                sqlstr = sqlstr + "'" + cmbratetype.SelectedValue + "',";
                sqlstr = sqlstr + "" + txtrate.Text.Trim() + ")";
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
        Response.Redirect("CCM_DisplayResult.aspx?custcode=" + custcode + "&contractid=" + contractid);

    }
}
