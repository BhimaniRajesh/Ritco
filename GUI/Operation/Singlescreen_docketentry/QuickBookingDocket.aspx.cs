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

public partial class GUI_admin_Extra_QuickBookingDocket : System.Web.UI.Page
{

    DataTable dt = new DataTable("table1");
    SqlConnection con;
    MyFunctions fn = new MyFunctions();


    protected static int r = 0;
    protected string tbdocdate = "", anch = "", stranchor = "", ddmmyystr = "", tbclid = "", dktlength = "";
    protected string sdkt_call = "";
    protected string START_YEAR = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        //FINANTIAL_YEAR creation
        DateTime dt1 = new DateTime();
        dt1 = DateTime.Now;

        if (dt1.Month < 4)
            START_YEAR = ((int)(dt1.Year - 1)).ToString();
        else
            START_YEAR = ((int)(dt1.Year)).ToString();

        dktlength = Session["Dktlength"].ToString().Trim();
        sdkt_call = Session["DocketCalledAs"].ToString();
        btnsubmit.Attributes.Add("onclick", "javascript:return validateBoxes()");
        if (!IsPostBack)
        {
            for (int i = 0; i < 10; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
        }
        r = 0;
        int anch_cnt = 0;
        string anch_str = "";
        foreach (GridViewRow dtr in grvcontrols.Rows)
        {
            anch_str = "anchor" + anch_cnt;
            LinkButton imgdate = (LinkButton)(dtr.FindControl("imgdate"));
            TextBox txtdate = (TextBox)(dtr.FindControl("txtdocdate"));
            imgdate.Attributes.Add("onclick", "javascript:cal.select(document.getElementById('" + txtdate.ClientID + "'),'" + imgdate.ClientID + "','dd/MM/yyyy'); return false;");
            anch = "";
            anch_cnt = anch_cnt + 1;
        }
    }


    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((TextBox)(e.Row.FindControl("txtdocdate"))).Attributes.Add("onblur", "javascript:return dateBlur(this.getAttribute('id'))");
            //((TextBox)(e.Row.FindControl("txtdocno"))).Attributes.Add("onblur", "");

            TextBox txtdoc = (TextBox)(e.Row.FindControl("txtdocno"));
            TextBox txtdelloc = (TextBox)(e.Row.FindControl("txtdelloc"));
            TextBox txtdate = (TextBox)(e.Row.FindControl("txtdocdate"));

            txtdoc.Attributes.Add("onblur", "javascript:OnDocketlenghtcheck(this),docBlur(this.getAttribute('id'))");
            txtdelloc.Attributes.Add("onblur", "javascript:delLocBlur(this.getAttribute('id'))");

            r++;
        }
    }


    protected void btnrows_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtnorows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtnorows.Text);
            }
            catch (Exception ex)
            {
                txtnorows.Text = "";
                txtnorows.Focus();
            }
        }

        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();
    }


    protected string getBaCode(string docno)
    {
        string sql = "SELECT docbrcd FROM webx_dcr_entry WHERE '" + docno + "' BETWEEN doc_sr_from AND doc_sr_to ORDER BY updton DESC";
        SqlCommand cmd = new SqlCommand(sql, con);
        return ((string)cmd.ExecuteScalar());
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow dtr in grvcontrols.Rows)
        {
            CheckBox chk = (CheckBox)(dtr.FindControl("chkflag"));
            TextBox txtdocno = (TextBox)(dtr.FindControl("txtdocno"));
            TextBox txtdocdate = (TextBox)(dtr.FindControl("txtdocdate"));
            TextBox txtdelloc = (TextBox)(dtr.FindControl("txtdelloc"));
            TextBox txtpkgs = (TextBox)(dtr.FindControl("txtpkgs"));
            TextBox txtactwt = (TextBox)(dtr.FindControl("txtactwt"));
            TextBox txtchgwt = (TextBox)(dtr.FindControl("txtchgwt"));

            string bacode = getBaCode(txtdocno.Text);
            if (chk.Checked == true)
            {
                string sql_USP = "Exec usp_docket_insert '" + txtdocno.Text;
                sql_USP = sql_USP + "','" + fn.Mydate1(txtdocdate.Text) + "','" + Session["brcd"].ToString() + "','";
                sql_USP = sql_USP + txtdelloc.Text + "'," + txtpkgs.Text + ",";
                sql_USP = sql_USP + txtactwt.Text + "," + txtchgwt.Text + ",'-','" + Session["empcd"].ToString() + "'";

                SqlCommand cmd = new SqlCommand(sql_USP, con);
                cmd.ExecuteNonQuery();
            }
        }

        Response.Redirect("../docket_operation.aspx");
    }

}
