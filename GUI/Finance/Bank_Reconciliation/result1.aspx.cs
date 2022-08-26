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

public partial class GUI_Finance_Bank_Reconciliation_result1 : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    DataAccess DAccess = new DataAccess();
    DateFunction DFun = new DateFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        string branText = Request.QueryString["branText"].ToString().Trim();
        string branch = Request.QueryString["branch"].ToString().Trim();
        string rad = Request.QueryString["strdlstTranType"].ToString().Trim();
        string mTodt = Request.QueryString["dateFrom"].ToString().Trim();
        string mClosedt = Request.QueryString["dateTo"].ToString().Trim();
        string acccode = Request.QueryString["strdlstSalesAmount"].ToString().Trim();
        string strstrSalesAccountText = Request.QueryString["strSalesAccountText"].ToString().Trim();
        string AcctTransTable = "webx_acctrans_" + Session["YearVal"].ToString();
        string mAcctTable = "webx_acctinfo";
        string mGroupTable = "webx_groups";
        string mAcctOpenTable = "webx_acctopening_" + Session["YearVal"].ToString();

        lblBran.Text = branText;
        lblDate_Range.Text = mTodt + " To : " + mClosedt;
        lblAccount.Text = strstrSalesAccountText;
        string locstr = "", accstr = "";
        
        locstr = "and brcd = '" + branch + "' ";
        
        accstr = "and Acccode = '" + acccode + "'";
        
			
        string wheredtrange = "";
        wheredtrange=" (convert(varchar,transdate,106)  ";
        wheredtrange = wheredtrange + "  between convert(datetime,'" + mTodt + "',106) and convert(datetime,'" + mClosedt + "',106))";
        string sql = "";
        if (rad == "reconciled")
        {
            sql = "select srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit,  case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + locstr + accstr + " and ( (transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1) or  (transtype like '%Bank Payment%' and credit >= 1) Or  (transtype like '%Bank Receipt%'and debit >= 1)) and chqcleardate is not null order by transdate,voucherno ";
        }
        else if (rad == "notreconciled")
        {
            sql = "select srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit, case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + locstr + accstr + " and ((transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1) or (transtype like '%Bank Payment%' and credit >= 1)  Or  (transtype like '%Bank Receipt%'and debit >= 1)) and chqcleardate is null order by transdate,voucherno ";
        }
        else if (rad == "all")
        {
            sql = "select srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit, case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + locstr + accstr + " and ((transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1)  or (transtype like '%Bank Payment%' and credit >= 1) Or  (transtype like '%Bank Receipt%'and debit >= 1)) order by transdate,voucherno ";
        }
        ds = DAccess.getdataset(sql);
        MyGrid.DataSource = ds;
        
        MyGrid.DataBind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string sql="";
        DropDownList dlstYearVal = (DropDownList)Master.FindControl("dlstFinYear");
        string yearVal = "";
        if (dlstYearVal != null)
            yearVal = dlstYearVal.SelectedItem.Value;
        string AcctTransTable = "webx_acctrans_" + yearVal;
        //Session["YearVal"].ToString();
        foreach (DataGridItem gridrow in MyGrid.Items)
        {
            CheckBox check = (CheckBox)gridrow.FindControl("chkSelect");
            string chk = check.Checked.ToString();
            if (chk == "true")
            {

                string SrNo = MyGrid.DataKeys[gridrow.ItemIndex].ToString();
                string my_Date = (String)((WebUserControl)gridrow.FindControl("txtDateTo")).getValue();//.SetClientID();
                if (my_Date != "")
                {
                    string new_date = DFun.return_date(my_Date);
                    
                    Hashtable MyHT = new Hashtable();
                    MyHT.Add("AcctTransTable", AcctTransTable);
                    MyHT.Add("fromdt", new_date);
                    MyHT.Add("SrNo", SrNo);
                    string r_val = DAccess.insertQuary_New("usp_update_BR", MyHT);
                    if (r_val != "0")
                    {
                        Server.Transfer("../Error/ErrorPage.aspx?PageHead='Bank Reconcilation'&ErrorMsg=" + r_val, true);
                    }
                    else
                    {
                        Response.Redirect("prestart.aspx");
                    }
                }
            }
        }
    }
}
