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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_finance_chqMgt_depositVoucher_step2 : System.Web.UI.Page
{
    MyFunctions myFunc;
    string connStr;
    public DataSet_Templates _dataSet = new DataSet_Templates();
    private  int _lastEditedPage;
    DateFunction Daccess = new DateFunction();
    DateTime transdate;
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
            txtVoucherDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            
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
            txtVoucherDate.Attributes.Add("onblur", "javascript:" + myFunc.getDateValidateString(txtVoucherDate, minValue, maxValue));


            string chqNo = Request.QueryString["chqno"];
            if (chqNo == "")
            {
                chqNo = "All";
            }
            string dateFrom = myFunc.Mydate1(Request.QueryString["DateFrom"]);
            string dateTo = myFunc.Mydate1(Request.QueryString["DateTo"]);
            string sql="";
            //if (Session["HeadOfficeCode"].ToString() == Session["brcd"].ToString())
            //    sql = "select acccode+'~'+acccategory as acccode,accdesc from webx_acctinfo where  ( acccategory='BANK' ) order by accdesc asc";
            //else
            sql = "select acccode +'~'+acccategory as acccode,accdesc from webx_acctinfo where  (( bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL') AND acccategory='BANK') order by accdesc asc";
            DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, sql);
            dlstAcccode.DataSource = ds.Tables[0].DefaultView;
            dlstAcccode.DataTextField = "accdesc";
            dlstAcccode.DataValueField = "acccode";
            dlstAcccode.DataBind();
            dlstAcccode.Items.Insert(0, "Select");
            dlstAcccode.Items[0].Value = "";
            dlstAcccode.Items[0].Selected = true;

            ChequeDet chqTrans = new ChequeDet();
            DataSet ds1 = chqTrans.getChkDepList(chqNo, dateFrom, dateTo);

            for (int i = 0; i <= ds1.Tables[0].Rows.Count - 1; i++)
            {
                _dataSet.chequeDeposit.AddchequeDepositRow("false", ds1.Tables[0].Rows[i].ItemArray[0].ToString().Trim(), ds1.Tables[0].Rows[i].ItemArray[1].ToString().Trim(), ds1.Tables[0].Rows[i].ItemArray[2].ToString().Trim(), ds1.Tables[0].Rows[i].ItemArray[3].ToString().Trim(), ds1.Tables[0].Rows[i].ItemArray[4].ToString().Trim());
            }
            chqTrans = null;
            BindGrid();
        }
        else
        {
            ReverseBind();
        }
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((DataSet_Templates)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }
    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }
    private void ReverseBind()
    {
        DataSet_Templates.chequeDepositRow datarow;
        
        foreach (GridViewRow  gridrow in dgGeneral.Rows)
        {
            datarow = _dataSet.chequeDeposit[(dgGeneral.PageSize*dgGeneral.PageIndex) + gridrow.RowIndex];
            datarow.ChkFlag = ((CheckBox)gridrow.FindControl("chkChqNo")).Checked.ToString();
            datarow.ChqNo = gridrow.Cells[1].Text.ToString();
            datarow.ChqDate = gridrow.Cells[2].Text.ToString();
            datarow.ChqAmt = gridrow.Cells[3].Text.ToString();
            datarow.EntryDt = gridrow.Cells[4].Text.ToString();
            datarow.Party = gridrow.Cells[5].Text.ToString();

            _dataSet.chequeDeposit[(dgGeneral.PageSize * dgGeneral.PageIndex) + gridrow.RowIndex].ItemArray = datarow.ItemArray;
        }
    }
    private void BindGrid()
    {
        dgGeneral.DataSource = _dataSet.chequeDeposit;
        dgGeneral.DataBind();
        _lastEditedPage = dgGeneral.PageIndex;
    }

    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            bool success = false;
            MyFunctions fn=new MyFunctions();
            string mChqno, mChqdt, mChqamt;
            ChequeDet chqdet = new ChequeDet();

            mChqno="";
            mChqdt="";
            mChqamt="";

            try
            {
                string narration = txtNarration.Text.Replace("'","''");
                transdate = Convert.ToDateTime(Daccess.return_date(txtVoucherDate.Text));
                    //Convert.ToDateTime(fn.Mydate1(txtVoucherDate.Text));
                
                string bankloccode = dlstAcccode.SelectedValue.Substring(0,7).ToString();

                DataSet_Templates.chequeDepositRow datarow;
                for (int i = 0; i<=_dataSet.chequeDeposit.Rows.Count  - 1; i++)
                {
                    datarow = _dataSet.chequeDeposit[i];
                    if (datarow.ChkFlag.ToUpper() == "TRUE")
                    {
                        if (mChqno == "")
                            mChqno = datarow.ChqNo;
                        else
                            mChqno = mChqno + "~" + datarow.ChqNo;

                        if (mChqdt == "")
                            mChqdt = datarow.ChqDate;
                        else
                            mChqdt = mChqdt + "~" + datarow.ChqDate;

                        if (mChqamt == "")
                            mChqamt = datarow.ChqAmt;
                        else
                            mChqamt = mChqamt + "~" + datarow.ChqAmt;

                    }
                }
                if (mChqno != "")
                {
                    chqdet.updChequeDeposit(mChqno, mChqdt, mChqamt, transdate, narration, bankloccode);

                    //  Changed by DP (7th Jan 2007)
                    //chqdet = null;
                }
                success = true;
            }
            catch (Exception e1)
            {
                Response.Redirect("../../ErrorPage.aspx?PageHead=Cheque Management : Cheque Deposit Entry&ErrorMsg=" +  e1.Message );
            }
            finally 
            {
                             
            }
            if (success)
            {
                //  Changed by DP (7th Jan 2007)
                //Response.Redirect("depositVoucher_Done.aspx?chqNo=" + mChqno + "&chqDate=" + mChqdt, true);
                //Response.Redirect("depositVoucher_Done.aspx?voucherNo=" + chqdet.Voucherno + "&chqNo=" + mChqno + "&chqDate=" + mChqdt, true);
                Response.Redirect("depositVoucher_Done.aspx?voucherNo=" + chqdet.Voucherno, true);
            }
        }
    }

    protected void dgGeneral_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataSet_Templates.chequeDepositRow datarow;
            datarow = _dataSet.chequeDeposit[(dgGeneral.PageSize * dgGeneral.PageIndex) + e.Row.RowIndex];

            CheckBox chk1 = (CheckBox)e.Row.FindControl("chkChqNo");
            if (datarow.ChkFlag=="True")
                chk1.Checked =true;
            else
                chk1.Checked = false;
        }
    }

    protected void dgGeneral_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dgGeneral.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void CalDepositAmt(object sender, EventArgs e)
    {
        double totamt=0;
        totamt = Convert.ToDouble(txtAmount.Text);
        for (int i = 0; i<=dgGeneral.Rows.Count  - 1; i++)
        {
            
            CheckBox chk1 = (CheckBox)dgGeneral.Rows[i].FindControl("chkChqNo");
            if ((((CheckBox)(sender)).ClientID == chk1.ClientID))
            {
                if (chk1.Checked)
                    totamt = totamt + Convert.ToDouble(dgGeneral.Rows[i].Cells[3].Text);
                else
                {
                    if (totamt > 0)
                        totamt = totamt - Convert.ToDouble(dgGeneral.Rows[i].Cells[3].Text);
                }
            }
        }

        txtAmount.Text = string.Format("{0:0.00}", totamt).ToString();
        //txtAmount.Text = totamt.ToString();//String.Format("0.00",); 
    }
}
