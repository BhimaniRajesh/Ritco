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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_finance_voucher_ContraVoucher : System.Web.UI.Page
{
    public DataSet_Templates _dataSet = new DataSet_Templates();
    string connStr, strEmpid="";
    int _lastEditedPage;
    MyFunctions myFunc;
    SqlDataReader dtr;
    protected void Page_Load(object sender, EventArgs e)
    {
        string pagetitle = System.Configuration.ConfigurationManager.AppSettings["PageTitle"];
        
        connStr = Session["SqlProvider"].ToString().Trim();
        //AccountTrans trans = new AccountTrans();
        //string vchrno = trans.genVoucherNo("HQTR");

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        //LinkButton1.Attributes.Add("onClick", "javascript:window.open('../../../GUI/Admin/commonPopUp.aspx?ctrCodeName=" + txtManualNo.ClientID + "&ctrDescName=" + txtManualNo.ClientID + "',null,'height=250, width=250,status= no, resizable= yes, scrollbars=no, toolbar=no,location=no,menubar=no ');");

        if (!IsPostBack)
        {
            ///////////////////////////////Need To Change Start//////////////////////////////////////////////////////
            DateFunction DAccess = new DateFunction();
            string FieldCode, FieldName, FieldLengthMin, FieldLengthMax, PrefixAlphaChars, IsPrefixConstant, PrefixConstant;
            FieldCode = "";
            FieldName = "";
            FieldLengthMin = "";
            FieldLengthMax = "";
            PrefixAlphaChars = "";
            IsPrefixConstant = "";
            PrefixConstant = "";
            string str = "select * from WebX_Setup_Fields";
            dtr = DAccess.getreader(str);
            while (dtr.Read())
            {
                FieldCode = dtr["FieldCode"].ToString().Trim();
                FieldName = dtr["FieldName"].ToString().Trim();
                FieldLengthMin = dtr["FieldLengthMin"].ToString().Trim();
                FieldLengthMax = dtr["FieldLengthMax"].ToString().Trim();
                PrefixAlphaChars = dtr["PrefixAlphaChars"].ToString().Trim();
                IsPrefixConstant = dtr["IsPrefixConstant"].ToString().Trim();
                PrefixConstant = dtr["PrefixConstant"].ToString().Trim();
            }
            dtr.Close();
            //txtPrepareFor.MaxLength = Convert.ToInt16(FieldLengthMax);
            string codename = "";
            //(pbov_code + ':' + pbov_name) as pbov_name
            string str_empname = "select (EmpId + ':' + Name) as Name from webx_master_users with (NOLOCK) where UserId='" + Session["empcd"].ToString() + "' and Status='100'";
            dtr = DAccess.getreader(str_empname);
            while (dtr.Read())
            {
                codename = dtr["name"].ToString().Trim();
            }
            dtr.Close();
            lblPrepareBy.Text = codename;
            ///////////////////////////////Need To Change End//////////////////////////////////////////////////////

            Initialised();
            BindGrid();
            lblPrepareAt.Text = Session["brcd"].ToString();
            //lblPrepareBy.Text = Session["empcd"].ToString();
            
            myFunc = new MyFunctions();
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
            txtVoucherDate.Text = maxValue.ToString();
          //  txtVoucherDate.Attributes.Add("onblur","javascript:" + myFunc.getDateValidateString(txtVoucherDate,minValue ,maxValue));
            string jsValidateAcct = "" +
            "<script language=javascript>  function fValidateAcct() " +
            "{" +
            "        var acccode1;" +
            "        totalrows=2; var totaldebit,totalcredit;" +
            "        totaldebit=0;totalcredit=0;" +
            "        totaldebit=0;totalcredit=0;" +
            "        totaldebit=0;totalcredit=0;" +
            "        totaldebit=0;totalcredit=0;" +
            "        totaldebit=0;totalcredit=0;";
            
            TextBox txtDebit1, txtCredit1,txtChqDate1,txtChqNo1;
            string acccode1="", acccode2="";
            int i=0;
            DropDownList dlst1, dlst2;
            //double totaldebit=0,totalcredit=0;
            

            
	        foreach(GridViewRow gr in dgGeneral.Rows)
            {
                
                if (i == 0)
                {
                    
                    dlst1 = (DropDownList)gr.FindControl("dlst_acccode");
                    acccode1 = dlst1.ClientID;
                    jsValidateAcct = jsValidateAcct + "if(document.getElementById('" + dlst1.ClientID + "').value=='')" +
                        "{   alert('Please Select Account!!!');" +
                        "    return false;}";
                    txtDebit1 =(TextBox)gr.FindControl("txtDebit");
                    txtCredit1 = (TextBox)gr.FindControl("txtCredit");

                    jsValidateAcct = jsValidateAcct + " totaldebit=totaldebit+parseFloat(document.getElementById('" + txtDebit1.ClientID + "').value);";
                    jsValidateAcct = jsValidateAcct + " totalcredit=totalcredit+parseFloat(document.getElementById('" + txtCredit1.ClientID + "').value);";
                   
                   
                   // jsValidateAcct = jsValidateAcct + "if((parseInt(document.getElementById('" + txtDebit1.ClientID + "').value)==0)&&(parseInt(document.getElementById('" + txtCredit1.ClientID + "').value)==0))" +
                    //"{"+
			        //"alert('Please enter either credit or debit!!!');"+
			        //"document.getElementById('" + txtDebit1.ClientID + "').focus();"+
			        //"return false;}";

                    txtChqNo1 = (TextBox)gr.FindControl("txtChqNo");
                    txtChqDate1 = (TextBox)gr.FindControl("txtChqDt");


                    jsValidateAcct = jsValidateAcct + " if(document.getElementById('" + txtChqNo1.ClientID + "').value!='')" +
                    "{" +
                    "if(document.getElementById('" + txtChqDate1.ClientID + "').value=='')" +
                    "{ alert('Please enter Cheque Date!!!');" +
                    "document.getElementById('" + txtChqDate1.ClientID + "').focus();" +
                    "return false;}}";

                    jsValidateAcct = jsValidateAcct + " if(document.getElementById('" + txtChqDate1.ClientID + "').value!='')" +
                    "{" +
                    "if(document.getElementById('" + txtChqNo1.ClientID + "').value=='')" +
                    "{ alert('Please enter Cheque No!!!');" +
                    "document.getElementById('" + txtChqNo1.ClientID + "').focus();" +
                    "return false;}}";

		        }
                else
                {
                    dlst2 = (DropDownList)gr.FindControl("dlst_acccode"); 
                    acccode2 = dlst2.ClientID;
                    jsValidateAcct = jsValidateAcct + " if(document.getElementById('" + dlst2.ClientID + "').value=='')" +
                        "{   alert('Please Select Account!!!');" +
                        "    return false;}";
                    txtDebit1 = (TextBox)gr.FindControl("txtDebit");
                    txtCredit1 = (TextBox)gr.FindControl("txtCredit");

                    jsValidateAcct = jsValidateAcct + " totaldebit=totaldebit+parseFloat(document.getElementById('" + txtDebit1.ClientID + "').value);";
                    jsValidateAcct = jsValidateAcct + " totalcredit=totalcredit+parseFloat(document.getElementById('" + txtCredit1.ClientID + "').value);";
                   

                    //jsValidateAcct = jsValidateAcct + "if((parseInt(document.getElementById('" + txtDebit1.ClientID + "').value)==0)&&(parseInt(document.getElementById('" + txtCredit1.ClientID + "').value)==0))" +
                    // "{" +
                    //"alert('Please enter either credit or debit!!!');" +
                    //"document.getElementById('" + txtDebit1.ClientID + "').focus();" +
                    //"return false;}";

                    txtChqNo1 = (TextBox)gr.FindControl("txtChqNo");
                    txtChqDate1 = (TextBox)gr.FindControl("txtChqDt");


                    jsValidateAcct = jsValidateAcct + " if(document.getElementById('" + txtChqNo1.ClientID + "').value!='')" +
                    "{" +
                    "if(document.getElementById('" + txtChqDate1.ClientID + "').value=='')" +
                    "{ alert('Please enter Cheque Date!!!');" +
                    "document.getElementById('" + txtChqDate1.ClientID + "').focus();" +
                    "return false;}}";

                    jsValidateAcct = jsValidateAcct + " if(document.getElementById('" + txtChqDate1.ClientID + "').value!='')" +
                    "{" +
                    "if(document.getElementById('" + txtChqNo1.ClientID + "').value=='')" +
                    "{ alert('Please enter Cheque No!!!');" +
                    "document.getElementById('" + txtChqNo1.ClientID + "').focus();" +
                    "return false;}} ";

                    
                }
                i += 1;
            }

            jsValidateAcct = jsValidateAcct + " if(document.getElementById('" + acccode1 + "').value == document.getElementById('" + acccode2 + "').value) {" +
                                            " alert('Duplicate Account,Please verify Account!!!');" +
                                            "document.getElementById('" + acccode1 + "').focus();" +
                                            "return false;}"+
                                            " if(parseFloat(totaldebit)!=parseFloat(totalcredit)) { alert('Total Debit Does not match with total credit');return false;}" +
                                            "return true; }</script>";
            ///jsValidateAcct = jsValidateAcct + "}</script>";
            Page.RegisterClientScriptBlock("ValidateAcct",jsValidateAcct);
            cmdSubmit.Attributes.Add("onclick", "javascript:return fsubmit();");
                        
          
        }
    }
    private void Initialised()
    {
        _dataSet.Contra.AddContraRow("Select", "0", "0", "", "", "");
        _dataSet.Contra.AddContraRow("Select", "0", "0", "", "", "");
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
    
    private void BindGrid()
    {
        dgGeneral.DataSource = _dataSet.Contra;
        dgGeneral.DataBind();
    }

    protected void dg_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //BindGrid();
    }

    protected void dg_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string sql = "";
            if (Session["HeadOfficeCode"].ToString() == Session["brcd"].ToString())
                sql = "select acccode  ,accdesc from webx_acctinfo where  ( acccategory='CASH' OR  acccategory='BANK' ) order by accdesc asc";
            else
                sql = "select acccode ,accdesc from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like '%" + Session["brcd"].ToString() + "%' or bkloccode='ALL') AND acccategory='BANK')) order by accdesc asc";

            DataSet ds = SqlHelper.ExecuteDataset(connStr, CommandType.Text, sql);
            DropDownList dlst = (DropDownList)e.Row.FindControl("dlst_acccode");
            dlst.DataSource = ds.Tables[0].DefaultView;
            dlst.DataTextField = "accdesc";// +" : " + "acccode";
            dlst.DataValueField = "acccode" ;//+ "~" + "acccategory";
            dlst.DataBind();
            //dlst.Items.Insert(0, new ListItem("Select", ""));
            //dlst.SelectedIndex = 0;
            dlst.Items.Insert(0, "Select");
            dlst.Items[0].Value = "";
            dlst.Items[0].Selected = true;

            TextBox txtDebit = (TextBox)e.Row.FindControl("txtDebit");
            TextBox txtCredit = (TextBox)e.Row.FindControl("txtCredit");
            txtCredit.Attributes.Add("onblur","javascript:if((parseInt(document.getElementById('" + txtDebit.ClientID +"').value)>0)&&(parseInt(document.getElementById('" + txtCredit.ClientID +"').value)>0)) { alert('Either Debit or Credit  should be greater than zero!!!') ;document.getElementById('" + txtCredit.ClientID +"').focus();return;}");

           // rdr.Close();
        }
    }

    
    protected void cmdSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            bool success = false;
            string docNo = "";
            try
            {
                myFunc = new MyFunctions();
                AccountTrans AcctTrans = new AccountTrans();
                

                string Finyear = Session["FinYear"].ToString();
                string CloseYear = Convert.ToString((Convert.ToInt16(Session["FinYear"].ToString()) + 1));
                if (CloseYear.Length == 1)
                    CloseYear = "0" + CloseYear;
                string yearSuffix = Session["FinYear"].ToString() + "_" + CloseYear;
                AcctTrans.DocNo = txtRefNo.Text.ToString();
                AcctTrans.Autoentry = "N";
                AcctTrans.Billdt = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Billduedt = Convert.ToDateTime("01 Jan 1900");
                AcctTrans.Billno = "";
                AcctTrans.Brcd = Session["brcd"].ToString();
                AcctTrans.Dockno = "";
                AcctTrans.Docksf = "";
                AcctTrans.DocNo = "";
                AcctTrans.Docsf = "";
                AcctTrans.Entryby = Session["empcd"].ToString();
                AcctTrans.Finyear = Finyear;
                AcctTrans.Opertitle = "Manual Contra Voucher";
                AcctTrans.Panno = "";
                AcctTrans.Payto = "";
                AcctTrans.PBOV_TYP = "";
                AcctTrans.PBOV_CODE = "";
                AcctTrans.PBOV_NAME = "";

               

                AcctTrans.ServicetaxNo = "";
                AcctTrans.Transdate = Convert.ToDateTime(myFunc.Mydate1(txtVoucherDate.Text));
                AcctTrans.TransNo = 0;
                AcctTrans.Transtype = "Contra";
                AcctTrans.UpdateBy = Session["empcd"].ToString();
                AcctTrans.Voucher_Cancel = "N";
                AcctTrans.Voucher_status = "Submitted";
                AcctTrans.Voucherno = AcctTrans.genVoucherNo(Session["brcd"].ToString());
                docNo = AcctTrans.Voucherno;
                AcctTrans.Bookcode = "";
                AcctTrans.YearSuffix = yearSuffix;
                AcctTrans.Entryfor = Session["empcd"].ToString();
                AcctTrans.PrepareByLoc = Session["brcd"].ToString();


                AcctTrans.Oppacccode = "";
                AcctTrans.Oppaccount = "";
                int i = 0;
                string mainAcccode = "", mainAccdesc = "";
                string chqdt = "";
                foreach (GridViewRow gridrow in dgGeneral.Rows)
                {
                    if (i == 0)
                    {
                        mainAcccode = ((DropDownList)gridrow.FindControl("dlst_acccode")).SelectedValue.ToString();
                        //' string mainAcccode_arr = mainAcccode.Split("~");
                        AcctTrans.Acccode = mainAcccode;
                        mainAccdesc = AcctTrans.getAccountDesc(mainAcccode);

                        
                        AcctTrans.Credit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtCredit")).Text);
                        AcctTrans.Debit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtDebit")).Text);
                        AcctTrans.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                        
                        AcctTrans.Chqno = ((TextBox)gridrow.FindControl("txtChqNo")).Text;
                        
                        chqdt = ((TextBox)gridrow.FindControl("txtChqDt")).Text;

                        if (chqdt == "")
                            chqdt = "01 Jan 1900";
                        else
                        {
                            chqdt = myFunc.Mydate1(chqdt);
                            
                            ChequeDet chqTrans = new ChequeDet();
                            
                            chqTrans.Chqno = AcctTrans.Chqno;
                            chqTrans.Acccode = mainAcccode;
                            
                            if (AcctTrans.Credit>0)
                                chqTrans.Adjustamt=(float)AcctTrans.Credit;
                            else
                                chqTrans.Adjustamt = (float)AcctTrans.Debit;
                            
                            chqTrans.Bankbrn = "";
                            chqTrans.Banknm = "";
                            chqTrans.Brcd = Session["brcd"].ToString();
                            chqTrans.Chq_bounce_dt = Convert.ToDateTime("01 Jan 1900");
                            chqTrans.Chq_bounceamt = 0;
                            chqTrans.Chq_clear = "N";
                            chqTrans.Chq_depattempt = 0;
                            chqTrans.Chq_flag = "";
                            chqTrans.Chq_reoffer_dt = Convert.ToDateTime("01 Jan 1900");
                            chqTrans.Chq_status = "SUBMITTED";
                            chqTrans.Chq_trf = "N";
                            chqTrans.Chqamt = chqTrans.Adjustamt;
                            chqTrans.Chqdt = Convert.ToDateTime(chqdt);
                            chqTrans.Comments = "";
                            chqTrans.Depoflag = "Y";
                            chqTrans.Empcd = Session["empcd"].ToString();
                            chqTrans.OwnCust = "O";
                            chqTrans.Ptmsptcd = "";
                            chqTrans.Ptmsptnm = "";
                            chqTrans.Recdbrcd = "";
                            chqTrans.Transdate = Convert.ToDateTime("01 Jan 1900");
                            chqTrans.Voucherno = docNo;
                            chqTrans.Depoloccode = Session["brcd"].ToString();
                            
                            chqTrans.InsertData();
                            chqTrans = null;

                        }

                        AcctTrans.Chqdate = Convert.ToDateTime(chqdt);

                    }
                    else
                    {
                        if (i == 1)
                        {
                            AcctTrans.Oppacccode = ((DropDownList)gridrow.FindControl("dlst_acccode")).SelectedValue.ToString();
                            AcctTrans.Oppaccount = AcctTrans.getAccountDesc(AcctTrans.Oppacccode);
                            AcctTrans.InsertData();

                            AcctTrans.Acccode = ((DropDownList)gridrow.FindControl("dlst_acccode")).SelectedValue.ToString();
                            
                            AcctTrans.Chqno = ((TextBox)gridrow.FindControl("txtChqNo")).Text;

                            chqdt = ((TextBox)gridrow.FindControl("txtChqDt")).Text;

                            if (chqdt == "")
                                chqdt = "01 Jan 1900";
                            else
                            {
                                        chqdt = myFunc.Mydate1(chqdt);
                                        ChequeDet chqTrans = new ChequeDet();

                                        chqTrans.Chqno = AcctTrans.Chqno;
                                        chqTrans.Acccode = mainAcccode;

                                        if (AcctTrans.Credit > 0)
                                            chqTrans.Adjustamt = (float)AcctTrans.Credit;
                                        else
                                            chqTrans.Adjustamt = (float)AcctTrans.Debit;

                                        chqTrans.Bankbrn = "";
                                        chqTrans.Banknm = "";
                                        chqTrans.Brcd = Session["brcd"].ToString();
                                        chqTrans.Chq_bounce_dt = Convert.ToDateTime("01 Jan 1900");
                                        chqTrans.Chq_bounceamt = 0;
                                        chqTrans.Chq_clear = "N";
                                        chqTrans.Chq_depattempt = 0;
                                        chqTrans.Chq_flag = "";
                                        chqTrans.Chq_reoffer_dt = Convert.ToDateTime("01 Jan 1900");
                                        chqTrans.Chq_status = "SUBMITTED";
                                        chqTrans.Chq_trf = "N";
                                        chqTrans.Chqamt = chqTrans.Adjustamt;
                                        chqTrans.Chqdt = Convert.ToDateTime(chqdt);
                                        chqTrans.Comments = "";
                                        chqTrans.Depoflag = "Y";
                                        chqTrans.Empcd = Session["empcd"].ToString();
                                        chqTrans.OwnCust = "O";
                                        chqTrans.Ptmsptcd = "";
                                        chqTrans.Ptmsptnm = "";
                                        chqTrans.Recdbrcd = "";
                                        chqTrans.Transdate = Convert.ToDateTime("01 Jan 1900");
                                        chqTrans.Voucherno = docNo;

                                        chqTrans.InsertData();
                                        chqTrans = null;
                            }
                            AcctTrans.Chqdate = Convert.ToDateTime(chqdt);

                            AcctTrans.Oppacccode = mainAcccode;
                            AcctTrans.Oppaccount = mainAccdesc;

                            AcctTrans.Credit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtCredit")).Text);
                            AcctTrans.Debit = Convert.ToDouble(((TextBox)gridrow.FindControl("txtDebit")).Text);
                            AcctTrans.Narration = ((TextBox)gridrow.FindControl("txtNarration")).Text.Replace("'", "''");
                            AcctTrans.InsertData();
                        }
                    }
                    i += 1;
                }
                success = true;
                AcctTrans = null;
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
                Response.Redirect("./voucher_Done.aspx?VoucherType=Contra&VoucherNo=" + docNo, true);
        }
    }
    protected void dgGeneral_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
