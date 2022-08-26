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

public partial class GUI_Octroi_ViewnPrint_DText : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            con.Open();
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=Session Expired&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        if (!IsPostBack)
        {
            string strsql = "";
            SqlCommand cmd;
            SqlDataAdapter da;
            DataTable dt;
            fn.Fill_Acccode_Dataset();

            ddllist_SelectedIndexChanged(sender, e);

        }
    }

    protected void ddllist_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strsql = "";
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;

        strsql = "SELECT *,Acccdesc=(select Accdesc+'~'+Company_Acccode from webx_acctinfo where Acccode=A.acccode)  FROM webx_master_billcharge A WHERE chargetype='BILL' ORDER BY chargename";
        cmd = new SqlCommand(strsql, con);

        da = new SqlDataAdapter(cmd);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count < 10)
            dt = createChargeTable();
        grvcharges.DataSource = dt;
        grvcharges.DataBind();

        if (dt.Rows.Count <= 0)
        {
            trgrid.Style["display"] = "none";
            trsubmit.Style["display"] = "none";
        }
        else
        {
            trgrid.Style["display"] = "marker";
            trsubmit.Style["display"] = "marker";
        }
    }

    protected void grvcharges_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddloperator = (DropDownList)e.Row.FindControl("ddloperator");
            HiddenField hdnactiveflag = (HiddenField)e.Row.FindControl("hdnactiveflag");
            TextBox txtchargename = (TextBox)e.Row.FindControl("txtchargename");
            Label lblchargename = (Label)e.Row.FindControl("lblchargename");
            Label lblfixed = (Label)e.Row.FindControl("lblfixed");
            HiddenField hdnbillcoltime = (HiddenField)e.Row.FindControl("hdnbillcoltime");
            HiddenField hdnchargecode = (HiddenField)e.Row.FindControl("hdnchargecode");
            HiddenField hdndktcoltime = (HiddenField)e.Row.FindControl("hdndktcoltime");
            HiddenField hdnstaxbifur = (HiddenField)e.Row.FindControl("hdnstaxbifur");
            CheckBox chkactiveflag = (CheckBox)e.Row.FindControl("chkactiveflag");
            CheckBox chkbillcoltime = (CheckBox)e.Row.FindControl("chkbillcoltime");
            CheckBox chkdktcoltime = (CheckBox)e.Row.FindControl("chkdktcoltime");
            CheckBox chkstaxbifur = (CheckBox)e.Row.FindControl("chkstaxbifur");

            if (hdnbillcoltime.Value.ToUpper().CompareTo("Y") == 0)
                chkbillcoltime.Checked = true;
            else
                chkbillcoltime.Checked = false;

            if (hdndktcoltime.Value.ToUpper().CompareTo("Y") == 0)
                chkdktcoltime.Checked = true;
            else
                chkdktcoltime.Checked = false;

            if (hdnstaxbifur.Value.ToUpper().CompareTo("Y") == 0)
                chkstaxbifur.Checked = true;
            else
                chkstaxbifur.Checked = false;

            if (hdnactiveflag.Value.ToUpper().CompareTo("Y") == 0)
                chkactiveflag.Checked = true;
            else
                chkactiveflag.Checked = false;

            try
            {
                ddloperator.SelectedValue = (string)DataBinder.Eval(e.Row.DataItem, "operator");
            }
            catch (Exception ex) { }

            lblchargename.Attributes.Add("onclick", "javascript:return alterDisplay('" + txtchargename.ClientID.ToString() + "','" + lblchargename.ClientID.ToString() + "')");
            txtchargename.Attributes.Add("onblur", "javascript:return alterDisplay('" + txtchargename.ClientID.ToString() + "','" + lblchargename.ClientID.ToString() + "')");


        }
    }



    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        SqlCommand cmd;
        SqlTransaction trn;
        string sqlstr = "";

        trn = con.BeginTransaction();
        try
        {
            sqlstr = "INSERT INTO webx_master_billcharge_edit ";
            sqlstr = sqlstr + "SELECT chargetype,chargecode,chargename,narration,acccode,flag_billcol,";
            sqlstr = sqlstr + "flag_dktcol,flag_staxbifur,activeflag,operator,entryby,getdate(),lasteditby,";
            sqlstr = sqlstr + "lasteditdate FROM webx_master_billcharge WHERE chargetype='BILL'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "DELETE FROM webx_master_billcharge WHERE chargetype='BILL'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
            string Acccode = "";
            foreach (GridViewRow grv in grvcharges.Rows)
            {
                TextBox txtchargename = (TextBox)grv.FindControl("txtchargename");
                TextBox txtnarration = (TextBox)grv.FindControl("txtnarration");
                TextBox txtacccode = (TextBox)grv.FindControl("txtacccode");
                HiddenField hdnchargecode = (HiddenField)grv.FindControl("hdnchargecode");
                CheckBox chkbillcoltime = (CheckBox)grv.FindControl("chkbillcoltime");
                CheckBox chkdktcoltime = (CheckBox)grv.FindControl("chkdktcoltime");
                CheckBox chkstaxbifur = (CheckBox)grv.FindControl("chkstaxbifur");
                CheckBox chkactiveflag = (CheckBox)grv.FindControl("chkactiveflag");
                DropDownList ddloperator = (DropDownList)grv.FindControl("ddloperator");
                string[] Arr_Acccode = txtacccode.Text.ToString().Split('~');
                Acccode = "";
                if (txtacccode.Text != "")
                {
                    sqlstr = "select acccode from webx_acctinfo where company_acccode='" + Arr_Acccode[1] + "'";
                    cmd = new SqlCommand(sqlstr, con, trn);
                    Acccode = cmd.ExecuteScalar().ToString();
                }
                sqlstr = "INSERT INTO webx_master_billcharge(chargetype,chargecode,chargename,narration,acccode,flag_billcol,";
                sqlstr = sqlstr + "flag_dktcol,flag_staxbifur,activeflag,operator,entryby,entrydate,lasteditby,lasteditdate)";
                sqlstr = sqlstr + " VALUES ('BILL',";
                sqlstr = sqlstr + "'" + hdnchargecode.Value + "','" + txtchargename.Text + "',";
                sqlstr = sqlstr + "'" + txtnarration.Text + "','" + Acccode.ToString() + "',";
                sqlstr = sqlstr + "'" + (chkbillcoltime.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chkdktcoltime.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chkstaxbifur.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chkactiveflag.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + ddloperator.SelectedValue + "','" + Session["empcd"].ToString() + "'";
                sqlstr = sqlstr + ",getdate(),'" + Session["empcd"].ToString() + "',getdate())";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=DataBase Entry Failed&detail1=" + ex.Message.Replace('\n', '_'));
        }

        trn.Commit();
        Response.Redirect("~/GUI/Default.aspx");
    }

    protected DataTable createChargeTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("chargetype", typeof(string));
        dt.Columns.Add("chargecode", typeof(string));
        dt.Columns.Add("chargename", typeof(string));
        dt.Columns.Add("flag_billcol", typeof(string));
        dt.Columns.Add("flag_dktcol", typeof(string));
        dt.Columns.Add("flag_staxbifur", typeof(string));
        dt.Columns.Add("activeflag", typeof(string));
        dt.Columns.Add("operator", typeof(string));


        for (int i = 1; i < 24; i++)
        {
            string[] param = new string[8];
            param[0] = "BILL";
            param[1] = "SCHG" + i.ToString().PadLeft(2, '0');
            param[2] = "Charge Name " + i.ToString().PadLeft(2, '0');
            param[3] = "N";
            param[4] = "N";
            param[5] = "N";
            param[6] = "N";
            param[7] = "+";

            dt.Rows.Add(param);
        }

        for (int i = 1; i < 11; i++)
        {
            string[] param = new string[8];
            param[0] = "BILL";
            param[1] = "UCHG" + i.ToString().PadLeft(2, '0');
            param[2] = "User Charge Name " + i.ToString().PadLeft(2, '0');
            param[3] = "N";
            param[4] = "N";
            param[5] = "N";
            param[6] = "N";
            param[7] = "+";
            dt.Rows.Add(param);
        }

        return dt;
    }


}
