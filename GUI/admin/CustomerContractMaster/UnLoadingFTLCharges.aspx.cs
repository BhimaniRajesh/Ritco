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

public partial class GUI_admin_CustomerContractMaster_UnLoadingFTL : System.Web.UI.Page
{
    static DataTable dtbranch, dtcity;
    SqlConnection con;
    static DataTable dtftltypes;
    string custcode,contractid;
    SqlTransaction trn;
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        custcode = Request.QueryString["custcode"].ToString();
        contractid = Request.QueryString["contractid"].ToString();
        fn = new MyFunctions();

        lblcontractid.Text = contractid;
        lblcustcodename.Text = custcode + " : " + fn.Getcustomer(custcode);

        if (!IsPostBack)
        {
            dtbranch = new DataTable();
            dtcity = new DataTable();

            try
            {
                hdnclient.Value = Session["client"].ToString().ToUpper();
            }
            catch (Exception ex)
            {
                Response.Redirect("../../Operation/docketentry/ErrorPage.aspx?heading=Session Expired d&detail1=Logon Again");
                return;
            }

            string sqlstr = "";
            SqlCommand cmd;
            SqlDataAdapter da;

            dtftltypes = new DataTable();
            sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='FTLTYP' AND statuscode='Y'";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);
            da.Fill(dtftltypes);


            sqlstr = "SELECT * FROM webx_custcontract_unloadingcharges WHERE contractid='" + contractid + "' AND loctype='L' AND service_class='2'";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);
            da.Fill(dtbranch);

            if (dtbranch.Rows.Count <= 0)
                dtbranch.Rows.Add();
            grvbranch.DataSource = dtbranch;
            grvbranch.DataBind();

            sqlstr = "SELECT * FROM webx_custcontract_unloadingcharges WHERE contractid='" + contractid + "' AND loctype='C' AND service_class='2'";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);

            da.Fill(dtcity);

            if (dtcity.Rows.Count <= 0)
                dtcity.Rows.Add();
            grvcity.DataSource = dtcity;
            grvcity.DataBind();
        }
        // ENDS OF IsPostBack
    }

    protected void grvbranch_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        bindGrid(e,"branch");
    }

    protected void btnbranchnorows_Click(object sender, EventArgs e)
    {
        if (txtbranchnorows.Text.CompareTo("") == 0)
            txtbranchnorows.Text = "0";

        int norows = Convert.ToInt16(txtbranchnorows.Text);
        for (int i = 0; i < norows; i++)
        {
            dtbranch.Rows.Add();
        }

        grvbranch.DataSource = dtbranch;
        grvbranch.DataBind();
    }

    protected void grvcity_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        bindGrid(e,"city");
    }

    protected void btncitynorows_Click(object sender, EventArgs e)
    {
        if (txtcitynorows.Text.CompareTo("") == 0)
            txtcitynorows.Text = "0";

        int norows = Convert.ToInt16(txtcitynorows.Text);
        for (int i = 0; i < norows; i++)
        {
            dtcity.Rows.Add();
        }

        grvcity.DataSource = dtcity;
        grvcity.DataBind();
    }




    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string sqlstr = "";
        SqlCommand cmd;
        try
        {
            trn = con.BeginTransaction();

            sqlstr = "DELETE FROM webx_custcontract_unloadingcharges WHERE contractid='" + contractid + "' AND service_class='2'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            saveGrid(grvbranch, "L");
            saveGrid(grvcity, "C");
        }
        catch (Exception ex)
        {
            trn.Rollback();
            string strex = ex.Message.Replace('\n', '_');
            Response.Redirect("../../Operation/docketentry/ErrorPage.aspx?heading=DataBase Entry Failed&detail1" + strex);
            return;
        }

        trn.Commit();
        Response.Redirect("CCM_DisplayResult.aspx?custcode=" + custcode + "&contractid=" + contractid);
    }

    protected void bindGrid(GridViewRowEventArgs e,string loctype)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtlocation = (TextBox)(e.Row.FindControl("txtlocation"));
            ((HtmlInputButton)e.Row.FindControl("btnlocation")).Attributes.Add("onclick", "popuplist('" + loctype + "','" + txtlocation.ClientID.ToString() + "','none')");

            if (hdnclient.Value.CompareTo("AGILITY") == 0)
            {
                TextBox txtrate = (TextBox)(e.Row.FindControl("txtrate"));
               

                txtrate.Attributes.Add("onblur", "javascript:return this.value=roundNumber(this.value,3)");
                
            }

            DropDownList cmbratetype = (DropDownList)(e.Row.FindControl("cmbratetype"));
            cmbratetype.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ratetype"));

            DropDownList cmbftltype = (DropDownList)(e.Row.FindControl("cmbftltype"));
            cmbftltype.DataSource = dtftltypes;
            cmbftltype.DataBind();

            cmbratetype.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ftltype"));

            CheckBox chk = (CheckBox)(e.Row.FindControl("chkyes"));
            if (txtlocation.Text.CompareTo("") != 0)
                chk.Checked = true;
        }
    }

    protected void saveGrid(GridView grid, string loctype)
    {
        string sqlstr = "";
        SqlCommand cmd;
        foreach (GridViewRow grv in grid.Rows)
        {
            TextBox txtlocation = (TextBox)grv.FindControl("txtlocation");
            DropDownList cmbratetype = (DropDownList)grv.FindControl("cmbratetype");
            DropDownList cmbftltype = (DropDownList)grv.FindControl("cmbftltype");
            TextBox txtrate = (TextBox)grv.FindControl("txtrate");
            CheckBox chkyes = (CheckBox)grv.FindControl("chkyes");

            if (chkyes.Checked)
            {
                sqlstr = "INSERT INTO webx_custcontract_unloadingcharges ";
                sqlstr = sqlstr + "(custcode,contractid,loctype,service_class,ftltype,location,ratetype,airrate,roadrate,trainrate,expressrate) ";
                sqlstr = sqlstr + " VALUES('" + custcode + "','" + contractid + "','" + loctype + "','2','" + cmbftltype.SelectedValue + "',";
                sqlstr = sqlstr + "'" + txtlocation.Text + "','" + cmbratetype.SelectedValue + "',";
                sqlstr = sqlstr + txtrate.Text + ",0,0,0)";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();
            }
        }
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
