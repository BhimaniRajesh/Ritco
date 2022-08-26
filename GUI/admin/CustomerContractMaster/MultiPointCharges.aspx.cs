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

public partial class GUI_admin_CustomerContractMaster_MultiPointCharges : System.Web.UI.Page
{
    SqlConnection con;
    static DataTable dt;
    static DataTable dtftls;
    static string custcode = "", contractid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        string sqlstr = "";
        SqlCommand cmd;
        SqlDataAdapter da;
        MyFunctions fn = new MyFunctions();
        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["contractid"].ToString();
        lblcontractid.Text = contractid;
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);

        if (!IsPostBack)
        {
            dt = new DataTable();
            dtftls = new DataTable();

            sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y'";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);
            da.Fill(dtftls);

            dt.Columns.Add("custcode", typeof(string));
            dt.Columns.Add("ftltype", typeof(string));
            dt.Columns.Add("ratetype", typeof(string));
            dt.Columns.Add("from_loc", typeof(string));
            dt.Columns.Add("to_loc", typeof(string));
            dt.Columns.Add("pickup_chrg", typeof(string));
            dt.Columns.Add("delivery_chrg", typeof(string));

            sqlstr = "SELECT * FROM webx_custcontract_multipointcharges WHERE contractid='" + contractid + "'";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);

            da.Fill(dt);
            if (dt.Rows.Count <= 0)
                dt.Rows.Add();

            grvmultipoint.DataSource = dt;
            grvmultipoint.DataBind();


        }
    }

    protected void grvmultipoint_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList cmbftltype = (DropDownList)e.Row.FindControl("cmbftltype");
            DropDownList cmbratetype = (DropDownList)e.Row.FindControl("cmbratetype");

            TextBox txtfrom = (TextBox)(e.Row.FindControl("txtfrom"));
            ((HtmlInputButton)e.Row.FindControl("btnfrom")).Attributes.Add("onclick", "popuplist('branch','" + txtfrom.ClientID.ToString() + "','none')");

            TextBox txtto = (TextBox)(e.Row.FindControl("txtto"));
            ((HtmlInputButton)e.Row.FindControl("btnto")).Attributes.Add("onclick", "popuplist('branch','" + txtto.ClientID.ToString() + "','none')");

            cmbftltype.DataSource = dtftls;
            cmbftltype.DataBind();

            CheckBox chk = (CheckBox)(e.Row.FindControl("chkyes"));
            chk.Checked = true;

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
            dt.Rows.Add();
        }

        grvmultipoint.DataSource = dt;
        grvmultipoint.DataBind();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        SqlTransaction trn;
        trn = con.BeginTransaction();

        try
        {
            string sqlstr = "";
            SqlCommand cmd;
            sqlstr = "DELETE FROM webx_custcontract_multipointcharges WHERE contractid='" + contractid + "'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            foreach (GridViewRow grv in grvmultipoint.Rows)
            {

                TextBox txtfrom = (TextBox)grv.FindControl("txtfrom");
                TextBox txtto = (TextBox)grv.FindControl("txtto");
                TextBox txtpickup = (TextBox)grv.FindControl("txtpickup");
                TextBox txtdelivery = (TextBox)grv.FindControl("txtdelivery");
                CheckBox chkyes = (CheckBox)grv.FindControl("chkyes");
                DropDownList cmbftltype = (DropDownList)grv.FindControl("cmbftltype");
                DropDownList cmbratetype = (DropDownList)grv.FindControl("cmbratetype");

                if (chkyes.Checked == true)
                {
                    if (txtfrom.Text.CompareTo("") == 0)
                    {
                        //redirect
                        return;
                    }

                    if (txtfrom.Text.CompareTo("") == 0)
                    {
                        //redirect
                        return;
                    }

                    if (txtpickup.Text.CompareTo("") == 0)
                    {
                        txtpickup.Text = "0.00";
                        return;
                    }

                    if (txtdelivery.Text.CompareTo("") == 0)
                    {
                        txtdelivery.Text = "0.00";
                        return;
                    }

                    sqlstr = "INSERT INTO webx_custcontract_multipointcharges(custcode,contractid,from_loc,to_loc,";
                    sqlstr = sqlstr + "ftltype,ratetype,pickup_chrg,delivery_chrg) VALUES('" + custcode + "',";
                    sqlstr = sqlstr + "'" + contractid + "','" + txtfrom.Text + "','" + txtto.Text + "',";
                    sqlstr = sqlstr + "'" + cmbftltype.SelectedValue + "',";
                    sqlstr = sqlstr + "'" + cmbratetype.SelectedValue + "',";
                    sqlstr = sqlstr + txtpickup.Text.Trim() + "," + txtdelivery.Text + ")";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    cmd.ExecuteNonQuery();
                }

            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../../Operation/DocketEntry/ErrorPage.aspx?heading=Database Entry Failed&detail1=" + strex);
            return;
        }
        trn.Commit();

        Response.Redirect("CCM_DisplayResult.aspx?custcode=" + custcode + "&contractid=" + contractid);
    }
    // Inner Function convert string to double,(incase string is NULL or blank it handles) and  keep Code clear
    protected double returnDouble(string num)
    {
        if (num.ToString().CompareTo("") == 0 || num is DBNull)
        {
            num = "0";
        }

        try
        {
            return Convert.ToDouble(num);
        }
        catch (Exception e)
        {
            return 0.00;
        }
    }
}
