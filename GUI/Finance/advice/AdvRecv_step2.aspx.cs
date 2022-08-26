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

public partial class GUI_finance_advice_AdvRecv_step2 : System.Web.UI.Page
{
    MyFunctions myFunc;
    string connStr;

    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        connStr = Session["SqlProvider"].ToString().Trim();
        //AccountTrans trans = new AccountTrans();
        //string vchrno = trans.genVoucherNo("HQTR");

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            myFunc = new MyFunctions();
            //myFunc.getAccountDesc()
            string adviceNo = Request.QueryString["AdviceNo"];
            string dateFrom = myFunc.Mydate1(Request.QueryString["DateFrom"]);
            string dateTo = myFunc.Mydate1(Request.QueryString["DateTo"]);
            Advice adv = new Advice();
            DataSet ds = adv.getAdvAckList(adviceNo, dateFrom, dateTo);
            
            dgGeneral.DataSource = ds.Tables[0].DefaultView;
            dgGeneral.DataBind();
            
        }

    }
    protected void dgGeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string sql = "";
            string transType = e.Row.Cells[3].Text;

            if (transType == "CASH")
                sql = "select acccode,accdesc from webx_acctinfo where acccategory='CASH' order by accdesc asc";
            else
                sql = "select acccode,accdesc from webx_acctinfo where ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL' ) AND  acccategory='BANK') order by accdesc asc";

            DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, sql);
            DropDownList dlst = (DropDownList)e.Row.FindControl("dlstAcccode");
            dlst.DataSource = ds.Tables[0].DefaultView;
            dlst.DataTextField = "accdesc";// +" : " + "acccode";
            dlst.DataValueField = "acccode";//+ "~" + "acccategory";
            dlst.DataBind();
            //dlst.Items.Insert(0, new ListItem("Select", ""));
            //dlst.SelectedIndex = 0;
            dlst.Items.Insert(0, "Select");
            dlst.Items[0].Value = "";
            dlst.Items[0].Selected = true;

            TextBox advdate = (TextBox)e.Row.FindControl("txtAccDate");

            string maxValue, minValue;
            maxValue = DateTime.Now.ToString("dd MMM yyyy");
            if (Convert.ToDateTime(Session["FinYearEnd"].ToString()) <= Convert.ToDateTime(maxValue))
            {
                maxValue = myFunc.DatadateDDMMYYYY(Session["FinYearEnd"].ToString());
                minValue = myFunc.DatadateDDMMYYYY(Session["FinYearStart"].ToString());
            }
            else
            {
                maxValue = DateTime.Now.ToString("dd/MM/yyyy");
                minValue = myFunc.DatadateDDMMYYYY(Session["FinYearStart"].ToString());
            }
            
            advdate.Text = maxValue.ToString();
            advdate.Attributes.Add("onblur", "javascript:" + myFunc.getDateValidateString(advdate, minValue, maxValue));
            
            CheckBox  chk1 = (CheckBox)e.Row.FindControl("chkAdvice");
            DropDownList acccode1=(DropDownList)e.Row.FindControl("dlstAcccode");
            TextBox accdate1 = (TextBox)e.Row.FindControl("txtAccDate");
            RequiredFieldValidator RequiredFieldValid1 = (RequiredFieldValidator)e.Row.FindControl("RequiredFieldValidator1");

            string strjs = " javascript : if(document.getElementById('" + chk1.ClientID + "').checked)" +
                  " { " +
                  "     if(document.getElementById('" + acccode1.ClientID + "').value=='')" +
                  "     {   alert('Please Select Account!!!'); " +
                  "         document.getElementById('" + acccode1.ClientID + "').focus(); " +
                  "         return false; " +
                  "     } " +
                   "     if(document.getElementById('" + accdate1.ClientID + "').value=='')" +
                  "     {   alert('Please Enter Receipt Date!!!'); " +
                  "         document.getElementById('" + accdate1.ClientID + "').focus(); " +
                  "         return false; " +
                  "     } " +
                  " } ";
            
            string strjs1 = " javascript : if(document.getElementById('" + chk1.ClientID + "').checked)" +
                  " {   document.getElementById('" + acccode1.ClientID + "').disabled=false; " +
                  "     document.getElementById('" + accdate1.ClientID + "').disabled=false; " +
                  "     document.getElementById('" + acccode1.ClientID + "').focus(); " +
                  " } " +
                  "else " +
                  "{    document.getElementById('" + acccode1.ClientID + "').disabled=true; " +
                  "     document.getElementById('" + accdate1.ClientID + "').disabled=true; " +
                  "} ";

            string strjs2 = " javascript : if(document.getElementById('" + chk1.ClientID + "').checked)" +
                  " {   if(document.getElementById('" + acccode1.ClientID + "').value=='') { " +
                  "     alert('Please Select Account!!!'); document.getElementById('" + acccode1.ClientID + "').focus();return;} " +
                  " } ";
                  

        
            accdate1.Attributes.Add("onblur", strjs);
            chk1.Attributes.Add("onclick", strjs1);
            acccode1.Attributes.Add("onblur", strjs2);
            

         }
    }
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        string docNo = "";
        bool success = false;
        if (Page.IsValid)
        {
            try
            {
              
            Advice adv=new Advice();
            myFunc = new MyFunctions();
            foreach (GridViewRow gr in dgGeneral.Rows)
            {
                CheckBox  chk1 = (CheckBox)gr.FindControl("chkAdvice");
                DropDownList acccode1=(DropDownList)gr.FindControl("dlstAcccode");
                TextBox accdate1 = (TextBox)gr.FindControl("txtAccDate");

                if (chk1.Checked)
                {
                    if (docNo == "")
                        docNo = gr.Cells[1].Text;
                    else
                        docNo = docNo + "," + gr.Cells[1].Text;

                    adv.AcceptAdvice(gr.Cells[1].Text,acccode1.SelectedValue,Convert.ToDateTime(myFunc.Mydate1(accdate1.Text)));
                }
            }
            adv=null;
            success = true;

        }
        catch (Exception e1)
        {
            Response.Write("Error" + e1.Message);
            Response.End();
        }
        finally
        {

        }
        if (success)
            Server.Transfer("./advRecv_Done.aspx?AdviceNo=" + docNo , false);
            
        }
    }
}
