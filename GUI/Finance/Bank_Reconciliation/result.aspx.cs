using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


public partial class GUI_Finance_Bank_Reconciliation_result : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    DataAccess DAccess = new DataAccess();
    DateFunction DFun = new DateFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadata();
        }
    }
    private void loadata()
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
        wheredtrange = " (convert(varchar,transdate,106)  ";
        wheredtrange = wheredtrange + "  between convert(datetime,'" + mTodt + "',106) and convert(datetime,'" + mClosedt + "',106))";
        string sql = "";
        if (Session["HeadOfficeCode"] == locstr)
        {
            if (rad == "reconciled")
            {
                sql = "select comment,convert(varchar,chqcleardate,106) as chqcleardate,srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit,  case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + accstr + " and ( (transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1) or  (transtype like '%Bank Payment%' and credit >= 1) Or  (transtype like '%Bank Receipt%'and debit >= 1)) and chqcleardate is not null order by transdate,voucherno ";
            }
            else if (rad == "notreconciled")
            {
                sql = "select comment,convert(varchar,chqcleardate,106) as chqcleardate,srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit, case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + accstr + " and ((transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1) or (transtype like '%Bank Payment%' and credit >= 1)  Or  (transtype like '%Bank Receipt%'and debit >= 1)) and chqcleardate is null order by transdate,voucherno ";
            }
            else if (rad == "all")
            {
                sql = "select comment,convert(varchar,chqcleardate,106) as chqcleardate,srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit, case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + accstr + " and ((transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1)  or (transtype like '%Bank Payment%' and credit >= 1) Or  (transtype like '%Bank Receipt%'and debit >= 1)) order by transdate,voucherno ";
            }
        }
        else
        {
            if (rad == "reconciled")
            {
                sql = "select comment,convert(varchar,chqcleardate,106) as chqcleardate,srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit,  case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + locstr + accstr + " and ( (transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1) or  (transtype like '%Bank Payment%' and credit >= 1) Or  (transtype like '%Bank Receipt%'and debit >= 1)) and chqcleardate is not null order by transdate,voucherno ";
            }
            else if (rad == "notreconciled")
            {
                sql = "select comment,convert(varchar,chqcleardate,106) as chqcleardate,srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit, case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + locstr + accstr + " and ((transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1) or (transtype like '%Bank Payment%' and credit >= 1)  Or  (transtype like '%Bank Receipt%'and debit >= 1)) and chqcleardate is null order by transdate,voucherno ";
            }
            else if (rad == "all")
            {
                sql = "select comment,convert(varchar,chqcleardate,106) as chqcleardate,srno,voucherno,chqno,convert(varchar,chqdate,106) as chqdate,transtype,chqcleardate,Narration,credit,debit, case when transtype = 'Bank Payment' then credit when transtype = 'Cash Payment' then credit when transtype = 'Bank Receipt' then debit when transtype = 'Cash Receipt' then debit when transtype = 'Contra' and credit > 0 then credit when transtype = 'Contra' and debit > 0 then debit else 0 end  as amt from " + AcctTransTable + " where " + wheredtrange + locstr + accstr + " and ((transtype like '%Contra%' and credit >= 1) or (transtype like '%Contra%' and debit >= 1)  or (transtype like '%Bank Payment%' and credit >= 1) Or  (transtype like '%Bank Receipt%'and debit >= 1)) order by transdate,voucherno ";
            }
        }
        ds = DAccess.getdataset(sql);
        MyGrid.DataSource = ds;

        MyGrid.DataBind();
    }
    protected void MyGrid_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            if (DataBinder.Eval(e.Item.DataItem, "chqcleardate") != null)
            {
                ((WebUserControl)e.Item.FindControl("txtDateTo")).CalendarDate = DFun.return_date_fun( DataBinder.Eval(e.Item.DataItem, "chqcleardate").ToString());
                string com = DataBinder.Eval(e.Item.DataItem, "comment").ToString();//DataBinder.Equals(e.Item.DataItem, "comment");
                if (com != "")
                    ((TextBox)e.Item.FindControl("txtNarration")).Text = com;
                else
                    ((TextBox)e.Item.FindControl("txtNarration")).Text = "";
                if (((WebUserControl)e.Item.FindControl("txtDateTo")).CalendarDate != "")
                {
                    ((CheckBox)e.Item.FindControl("chkSelect")).Checked = false;
                    ((CheckBox)e.Item.FindControl("chkSelect")).Enabled = false;
                    ((TextBox)e.Item.FindControl("txtNarration")).Enabled = false;
                }
            }   
        }
    }
    protected void updateData(object sender, EventArgs e)
    {
        string sql = "";
        DropDownList dlstYearVal = (DropDownList)Master.FindControl("dlstFinYear");
        string yearVal = "";
        if (dlstYearVal != null)
            yearVal = dlstYearVal.SelectedItem.Value;
        string AcctTransTable = "webx_acctrans_" + yearVal;
        int count = 0;
        foreach (DataGridItem gridrow in MyGrid.Items)
        {
            if (((CheckBox)gridrow.FindControl("chkSelect")).Checked == true)
            {
                string SrNo = MyGrid.DataKeys[gridrow.ItemIndex].ToString();
                string my_Date = (String)((WebUserControl)gridrow.FindControl("txtDateTo")).CalendarDate;//.SetClientID();
                string comm = ((TextBox)gridrow.FindControl("txtNarration")).Text;
                if (my_Date != "")
                {
                    string new_date = DFun.return_date(my_Date);
                    SqlParameter[] param = new SqlParameter[4];
                    param[0] = new SqlParameter("@AcctTransTable", AcctTransTable);
                    param[1] = new SqlParameter("@fromdt", new_date);
                    param[2] = new SqlParameter("@comment1", comm);
                    param[3] = new SqlParameter("@SrNo", SrNo);
                    DAccess.ExecuteNonQry(CommandType.StoredProcedure, "usp_update_BR" , param);
                    count = count + 1;
                }
            }
        }
        Response.Redirect("Bank_Reconciliation_done.aspx?number=" + Convert.ToString(count));
    }
   
}
