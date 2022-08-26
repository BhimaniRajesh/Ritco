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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Accounts_Advice_Cancellation : System.Web.UI.Page
{
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        btnrows.Attributes.Add("onclick", "javascript:return addRows()");
        btnsubmit.Attributes.Add("onclick", "javascript:return validateBoxes()");
        if (!IsPostBack)
        {
            for (int i = 0; i < 5; i++)
            {
                dt.Rows.Add();
            }

            grvcontrols.DataSource = dt;
            grvcontrols.DataBind();
        }
       

    }
    protected void grvcontrols_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            ((TextBox)e.Row.FindControl("txtraisedon")).Attributes.Add("onblur", "locBlur('" + ((TextBox)e.Row.FindControl("txtraisedon")).ClientID.ToString() + "')");
            ((TextBox)e.Row.FindControl("txtadviceno")).Attributes.Add("onblur", "AdviceBlur('" + ((TextBox)e.Row.FindControl("txtadviceno")).ClientID.ToString() + "')");
            ((CheckBox)e.Row.FindControl("chkcancel")).Attributes.Add("onclick", "checkboxclick('" + ((CheckBox)e.Row.FindControl("chkcancel")).ClientID.ToString() + "')");
            ((CheckBox)e.Row.FindControl("chkboxsrno")).Attributes.Add("onclick", "return checkboxclick('" + ((CheckBox)e.Row.FindControl("chkboxsrno")).ClientID.ToString() + "')");
            
            ((HtmlInputButton)e.Row.FindControl("btnraisedon")).Attributes.Add("onclick", "popuplist('location','" + ((TextBox)e.Row.FindControl("txtraisedon")).ClientID.ToString() + "','none')");

            string s = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("txtcanceldt")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("linkdtbtn")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("linkdtbtn")).Attributes.Add("onclick", s);
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
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
        SqlCommand cmd = new SqlCommand();
        SqlTransaction trn;
        trn = con.BeginTransaction();
        try
        {
            for (int i = 0; i < grvcontrols.Rows.Count; i++)
            {
                TextBox txtadviceno = (TextBox)grvcontrols.Rows[i].FindControl("txtadviceno");
                TextBox txtcanceldt = (TextBox)grvcontrols.Rows[i].FindControl("txtcanceldt");
                TextBox txtraisedon = (TextBox)grvcontrols.Rows[i].FindControl("txtraisedon");
                CheckBox chkboxsrno = (CheckBox)grvcontrols.Rows[i].FindControl("chkboxsrno");
                CheckBox chkcancel = (CheckBox)grvcontrols.Rows[i].FindControl("chkcancel");
                TextBox txtcancelreason = (TextBox)grvcontrols.Rows[i].FindControl("txtcancelreason");
                string sql = "";
                if (chkboxsrno.Checked == true)
                {
                    if (chkcancel.Checked == true)
                    {
                        sql = "SELECT COUNT(*) FROM WEBX_ADVICE_HDR WHERE ADVICENO='" + txtadviceno.Text + "' AND isnull(ADVICE_CANCEL,'N')='N'";
                        double Cnt = Convert.ToDouble(SqlHelper.ExecuteScalar(trn, CommandType.Text, sql));

                        if (Cnt == 1)
                        {
                            sql = "UPDATE WEBX_ADVICE_HDR SET ADVICESTATUS='CANCELLED',Advice_Cancel='Y',cancelby='" + Session["empcd"] + "',cancel_date='" + fn.Mydate1(txtcanceldt.Text) + "',Cancel_Reason='" + txtcancelreason.Text + "' where adviceno='" + txtadviceno.Text + "'";
                            Response.Write(sql);
                            cmd = new SqlCommand(sql, con, trn);
                            cmd.ExecuteNonQuery();

                            sql = "exec usp_Advice_Cancel_Transaction 1,'" + txtadviceno.Text + "','" + Session["finyear"].ToString().Substring(2, 2) + "'";
                            cmd = new SqlCommand(sql, con, trn);
                            cmd.ExecuteNonQuery();
                        }

                    }
                    else
                    {
                        sql = "UPDATE WEBX_ADVICE_HDR SET RaisedOn='" + txtraisedon.Text + "' where adviceno='" + txtadviceno.Text + "'";
                        cmd = new SqlCommand(sql, con, trn);
                        cmd.ExecuteNonQuery();
                    }
                    
                }

            }

            trn.Commit();

        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            Response.End();
            Response.Redirect("Message.aspx?message='" + msg);
            con.Close();
        }

        Response.Redirect("Updatedone.aspx");
    }
}
