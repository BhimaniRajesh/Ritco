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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;




public partial class octroi_OctCustBillStep2 : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
   
  
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    string custcd, octroipaid_by;
    string custcls = "";
    MyFunctions fn = new MyFunctions();
       protected void Page_Load(object sender, EventArgs e)
    {
        
         string billdate;
        billdate = System.DateTime.Now.ToString("dd/MM/yyyy");
      
        txtbgndt.Text = billdate.ToString(); //System.DateTime.Now.ToShortDateString();
        DateTime dt = DateTime.Today.AddDays(15);
        txtduedate.Text = dt.ToString("dd/MM/yyyy");
        string custcdstr = Request.QueryString.Get("Party_detail");
        string custis = Request.QueryString.Get("custis");
       
        
        string[] custcd_arr;
       
        custcd_arr = custcdstr.Split('-');
        custcd = custcd_arr[0].ToString();
        if (custis == "CSGN")
        {
            custcls = "and csgncd='" + custcd +"'";
            octroipaid_by = "Consignor";
        }
        if (custis == "CSGE")
        {
            custcls = "and csgecd='" + custcd + "'";
            octroipaid_by = "consignee";
        }
        if (custis == "BILL")
        {
            custcls = "and party_code='" + custcd + "'";
            octroipaid_by="Billing Party";
        }
        Label1.Text = custcd.Trim() + ":" + fn.Getcustomer(custcd);
        LblPTMSCD.Text = custcd.Trim() + ":" + fn.Getcustomer(custcd);
        txtbillsubloc.Text = Session["brcd"].ToString();
        txtbillcolloc.Text = Session["brcd"].ToString();
      //  txtbillamt = 0;
        if (!IsPostBack)
        {
            Inetialized();
          
            BindGrid();
        }
        else
        {
            ReverseBind();
        }


    }
    protected void BlankRow()
    {

        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow(false, "", "", "", "", "",
        //                                       Convert.ToString(custom_duty_rate), "",
        //                                       Convert.ToString(cvd_rate), "",
        //                                       Convert.ToString(edu_cess_on_cvd_rate), "",
        //                                       Convert.ToString(custom_edu_cess_rate), "",
        ////                                       Convert.ToString(add_import_duty_rate), "",
        //                                       "", "");
    }

    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
    }
    private void BindGrid()
    {
        DataGrid1.DataSource = _dataSet.WorkExperianceData;
        DataGrid1.DataBind();
        _lastEditedPage = DataGrid1.CurrentPageIndex;
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((DataSet1)(this.ViewState["Data"]));
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

    private void DataGrid1_PageIndexChanged(object source, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
    {
        DataGrid1.CurrentPageIndex = e.NewPageIndex;
        BindGrid();
    }
    private void DataGrid1_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
    {
        if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        {
            _dataSet.WorkExperianceData.RemoveWorkExperianceDataRow(_dataSet.WorkExperianceData[e.Item.DataSetIndex]);
            if (((DataGrid1.PageCount - DataGrid1.CurrentPageIndex) == 1 & DataGrid1.Items.Count == 1))
            {
                if ((DataGrid1.PageCount > 1))
                {
                    _lastEditedPage -= 1;
                }
                else
                {
                    _lastEditedPage = 0;
                }
            }
            DataGrid1.CurrentPageIndex = _lastEditedPage;
            BindGrid();
        }
    }
  
   
    private void ReverseBind()
    {
        DataSet1.WorkExperianceDataRow datarow;// = null;

        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            
            datarow = _dataSet.WorkExperianceData[gridrow.DataSetIndex];
            datarow.DOCKNO = ((TextBox)gridrow.FindControl("txtdockno")).Text;
            datarow.DECLVAL = ((Label)gridrow.FindControl("txtdeclval")).Text;
            datarow.OCTAMT = ((TextBox)gridrow.FindControl("txtoctamt")).Text;
            datarow.OCTAMT_PER = ((TextBox)gridrow.FindControl("txtoctper")).Text;
            datarow.CLEAR_CHRG = ((TextBox)gridrow.FindControl("txtclearchrg")).Text;
            datarow.PROCESS_PER = ((TextBox)gridrow.FindControl("txtprochrg_per")).Text;
            datarow.PROCESS_CHRG = ((TextBox)gridrow.FindControl("txtprochrg")).Text;
            datarow.OTCHG = ((TextBox)gridrow.FindControl("txtotchg")).Text;
            datarow.TOTAL = ((TextBox)gridrow.FindControl("txttotalamt")).Text;
            datarow.RCPTNO = ((TextBox)gridrow.FindControl("txtrcptno")).Text;
            datarow.RCPTDATE = ((TextBox)gridrow.FindControl("txtrcptdate")).Text;
            _dataSet.WorkExperianceData[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
        }
    }
    void DataGrid1_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridCommandEventArgs e)
    {
        DataSet1.WorkExperianceDataRow datarow;
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((DataSet1.WorkExperianceDataRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtdockno")).Text = datarow.DOCKNO;
            ((Label)e.Item.FindControl("txtdeclval")).Text = datarow.DECLVAL;
            ((TextBox)e.Item.FindControl("txtoctamt")).Text = datarow.OCTAMT;
            ((TextBox)e.Item.FindControl("txtoctper")).Text = datarow.OCTAMT_PER;
            ((TextBox)e.Item.FindControl("txtclearchrg")).Text = datarow.CLEAR_CHRG;
            ((TextBox)e.Item.FindControl("txtprochrg_per")).Text = datarow.PROCESS_PER;
            ((TextBox)e.Item.FindControl("txtprochrg")).Text = datarow.PROCESS_CHRG;
            ((TextBox)e.Item.FindControl("txtotchg")).Text = datarow.OTCHG;
            ((TextBox)e.Item.FindControl("txttotalamt")).Text = datarow.TOTAL;
            ((TextBox)e.Item.FindControl("txtrcptno")).Text = datarow.RCPTNO;
            ((TextBox)e.Item.FindControl("txtrcptdate")).Text = datarow.RCPTDATE;
        }
    }
    public void btnAdd_Grid(object sender, EventArgs e)
    {
        string rowno;
        rowno = roww.Text;
        //Response.Write("rowno" + rowno);
        //Response.End();
        int i;

        for (i = 0; i < Int16.Parse(roww.Text); i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        }
        BindGrid();
    }
    protected void BindGrid1()
    {

       
        //_lastEditedPage = DataGrid1.CurrentPageIndex;
       // SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
       //// conn.Open();
       // string sql = "usp_oct_detail";
       // SqlCommand cmd = new SqlCommand(sql, conn);
       // cmd.CommandType = CommandType.StoredProcedure;
       // cmd.Parameters.Add("@dockno", SqlDbType.VarChar).Value = "1180788";// txtdockno.Textdockno.Trim();//
       // DataSet ds = new DataSet();
       // SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);

       // myAdapter.Fill(ds, "tblPerson");
       // conn.Open();
       // cmd.ExecuteNonQuery();
       // DataGrid1.DataSource = ds;
       // DataGrid1.DataBind();
       // conn.Close();  

        DataView dv = _dataSet.WorkExperianceData.DefaultView;
        DataGrid1.DataSource = dv;
        DataGrid1.DataBind();
    }
    protected void OnDocketNOChange(object sender, EventArgs e)
    {
        DataSet1.WorkExperianceDataRow datarow;
        
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            if (gridrow.ItemIndex != -1)
            {
                Inetialized();

                TextBox txtdockno = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtdockno");
                Label txtdeclval = (Label)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtdeclval");
                TextBox txtoctper = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtoctper");
                TextBox txtoctamt = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtoctamt");
                TextBox txtrcptno = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtrcptno");
                TextBox txtrcptdate = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtrcptdate");
               
              datarow = _dataSet.WorkExperianceData[gridrow.ItemIndex];
                datarow = GetDataRow(gridrow.ItemIndex);

                if (txtdockno.ClientID == ((TextBox)sender).ClientID)
                {
                    datarow.DOCKNO = txtdockno.Text;

                    string docket_valid = docket_validcheck(txtdockno.Text, custcls.ToString());
                    if (docket_valid == "OK")
                    {
                        string octroi_detail = Octroi_date_field(txtdockno.Text);
                        string[] octroi_detail_arr;
                        DateTime rcptdate1;
                        
                        octroi_detail_arr = octroi_detail.Split('~');

                        txtdeclval.Text = octroi_detail_arr[0].ToString();
                        txtoctamt.Text = octroi_detail_arr[1].ToString();
                        txtrcptno.Text = octroi_detail_arr[2].ToString();
                        if (octroi_detail_arr[3].ToString()!="")
                        {
                        rcptdate1 = Convert.ToDateTime(octroi_detail_arr[3].ToString());
                        txtrcptdate.Text = rcptdate1.ToString("dd/MM/yyyy");
                        }
                        else
                        {
                            txtrcptdate.Text = "";
                        }
                        
                        if (txtdeclval.Text == "")
                        {
                            txtdockno.Text = "";
                            txtdeclval.Text = "Invalid Dockno";

                        }
                        else
                        {
                            decimal declval, octamt, octper;
                            declval = Convert.ToDecimal(txtdeclval.Text.ToString());
                            if (txtoctamt.Text.ToString() != "")
                            {
                                octamt = Convert.ToDecimal(txtoctamt.Text.ToString());
                            }
                            else
                            {
                                octamt = 0;
                            }

                            if (declval > 0 && octamt > 0)
                            {
                                octper = (octamt / declval) * 100;
                                octper = octper;
                                txtoctper.Text = octper.ToString();
                            }

                        }
                    }
                    else
                    {
                        txtdockno.Text = "";
                        txtdeclval.Text = docket_valid.Trim();
                    }
                   
                    //datarow.DECLVAL = Getdeclval(txtdockno.Text);

                 
                    
                }
               
                _dataSet.WorkExperianceData[gridrow.ItemIndex].ItemArray = datarow.ItemArray;
            }
            
        }
        //BindGrid1();
    }
    
    private DataSet1.WorkExperianceDataRow GetDataRow(int rowIndex)
    {

       // foreach (DataGridItem gridrow in DataGrid1.Items)
        //{

            DataSet1.WorkExperianceDataRow datarow;
            datarow = _dataSet.WorkExperianceData[rowIndex];
            datarow.DOCKNO = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtdockno")).Text;
            datarow.DECLVAL = ((Label)DataGrid1.Items[rowIndex].FindControl("txtdeclval")).Text;
            datarow.OCTAMT = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtoctamt")).Text;
            datarow.OCTAMT_PER = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtoctper")).Text;
            datarow.CLEAR_CHRG = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtclearchrg")).Text;
            datarow.PROCESS_PER = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtprochrg_per")).Text;
            datarow.PROCESS_CHRG = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtprochrg")).Text;
            datarow.OTCHG = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtotchg")).Text;
            datarow.TOTAL = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txttotalamt")).Text;
            datarow.RCPTNO = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtrcptno")).Text;
            datarow.RCPTDATE = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtrcptdate")).Text;
           // _dataSet.WorkExperianceData[gridrow.ItemIndex].ItemArray = datarow.ItemArray;

            return datarow;
        //}
    }
    protected string Getdeclval(string dockno)
    {
        string declval = "";
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        conn.Open();
        string sql = "usp_oct_detail";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@dockno", SqlDbType.VarChar).Value = dockno.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            declval = Convert.ToString(dr["declval"]);
        }

        if (declval == null) declval = "";
        return declval;
    }
    public string Octroi_date_field(string dockno)
    {
        string declval = "";
        string octamt = "";
        string rcptno = "";
        string rcptdate = "";
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        conn.Open();
        string sql = "usp_oct_detail";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@dockno", SqlDbType.VarChar).Value = dockno.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {

            declval = Convert.ToString(dr["declval"]);
            octamt = Convert.ToString(dr["octamt"]);
            rcptno = Convert.ToString(dr["rcptno"]);
            rcptdate = Convert.ToString(dr["rcptdate"]);
        }
        string oct_detail;
        oct_detail = declval + "~" + octamt + "~" + rcptno + "~" + rcptdate;
       if (oct_detail == null) declval = "";
       return oct_detail;
    }
    //*****************for docket valid check*******************
    public string docket_validcheck(string dockno,string custcls)
    {
        string OctroiBill = "";
        string octroiMR = "";
        string docket_mode = "";
        string docketno="";
        string result = "";
        string docknocls = "dockno='" + dockno + "'";
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        conn.Open();
        string sql = "usp_oct_docknocheck";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@docknocls", SqlDbType.VarChar).Value = docknocls.Trim();
        cmd.Parameters.Add("@custcls", SqlDbType.VarChar).Value = custcls.Trim();
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            docketno = Convert.ToString(dr["dockno"]);
            OctroiBill = Convert.ToString(dr["OctroiBill"]);
            octroiMR = Convert.ToString(dr["octroiMR"]);
            docket_mode = Convert.ToString(dr["docket_mode"]);
            //break;
        }
        if (docketno != "")
        {
            if (docket_mode != "F")
            {
                result = "Entered Docket is Not Finacial Completed ";
            }
            else
            {
                if (OctroiBill == "Y")
                {
                    result="Octroi Bill already generated for this docket";
                }
                else
                {
                    if (octroiMR == "Y")
                    {
                        result="Octroi MR already generated for this docket";
                    }
                    else
                    {
                        result="OK";
                    }
                }


            }
        }
        else
        {
            result="You have Entered Wrong Docket For this Party code";
        }

        return result;
    }
    //**********************************************************
    public string OCBIllno(string loccode)
    {
        
       
        string NewCode = "";
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        conn.Open();
        string sql = "sp_get_next_OCbill_code";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@loccode", SqlDbType.VarChar).Value = loccode.Trim();

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        while (dr.Read())
        {
                        NewCode = Convert.ToString(dr["NewCode"]);
        }
       
        if (NewCode == null) NewCode = "";
        return NewCode;
    }
    protected void Onoctdatacal(object sender, EventArgs e)
    {
        DataSet1.WorkExperianceDataRow datarow;
        
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            if (gridrow.ItemIndex != -1)
            {
                Inetialized();

                TextBox txtdockno = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtdockno");
                Label  txtdeclval = (Label)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtdeclval");
                TextBox txtoctper = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtoctper");
                TextBox txtoctamt = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtoctamt");
                TextBox txtclearchrg = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtclearchrg");
                TextBox txtprochrg_per = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtprochrg_per");
                TextBox txtprochrg = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtprochrg");
                TextBox txtotchg = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtotchg");
                TextBox txttotalamt = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txttotalamt");
                TextBox txtrcptno = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtrcptno");
                TextBox txtrcptdate = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtrcptdate");

                datarow = _dataSet.WorkExperianceData[gridrow.ItemIndex];
                datarow = GetDataRow(gridrow.ItemIndex);

                if (txtoctamt.ClientID == ((TextBox)sender).ClientID || txtclearchrg.ClientID == ((TextBox)sender).ClientID || txtprochrg_per.ClientID == ((TextBox)sender).ClientID || txtprochrg.ClientID == ((TextBox)sender).ClientID || txtotchg.ClientID == ((TextBox)sender).ClientID)
               {
                    
                       
                    
                    
                        decimal declval, octamt, octper,totamt,otchg,process_chrg,clear_chrg,pocess_per;
                        declval = Convert.ToDecimal(txtdeclval.Text.ToString());
                        if (txtoctamt.Text.ToString() != "")
                        {
                            octamt = Convert.ToDecimal(txtoctamt.Text.ToString());
                        }
                        else
                        {
                            octamt = 0;
                        }
                        
                        if (txtotchg.Text.ToString() != "")
                        {
                            otchg = Convert.ToDecimal(txtotchg.Text.ToString());
                        }
                        else
                        {
                            otchg = 0;
                        }

                        if (txtclearchrg.Text.ToString() != "")
                        {
                            clear_chrg = Convert.ToDecimal(txtclearchrg.Text.ToString());
                        }
                        else
                        {
                            clear_chrg = 0;
                        }
                        if (txtprochrg_per.Text.ToString() != "")
                        {
                            pocess_per = Convert.ToDecimal(txtprochrg_per.Text.ToString());
                        }
                        else
                        {
                            pocess_per = 0;
                        }
                        
                        string octamt123 = txtdeclval.Text.ToString();
                        string octamt1231 = txtoctamt.Text.ToString();
                        if (declval > 0 && octamt > 0)
                        {
                            octper = (octamt / declval) * 100;
                            octper = octper;
                            txtoctper.Text = octper.ToString();
                            if (txtprochrg_per.ClientID == ((TextBox)sender).ClientID)
                            {
                                process_chrg = (octamt * pocess_per) / 100;
                                txtprochrg.Text = process_chrg.ToString();
                            }
                            if (txtprochrg.Text.ToString() != "")
                            {
                                process_chrg = Convert.ToDecimal(txtprochrg.Text.ToString());
                            }
                            else
                            {
                                process_chrg = 0;
                            }
                            totamt = octamt + otchg + clear_chrg + process_chrg ;
                            txttotalamt.Text = totamt.ToString();
                        }
                }

                _dataSet.WorkExperianceData[gridrow.ItemIndex].ItemArray = datarow.ItemArray;
            }
        }
    }

    

    protected void Button11_Click(object sender, EventArgs e)
    {
        //DataSet1.WorkExperianceDataRow datarow;
        //MyFunctions dt = new MyFunctions();
        //string Loccode = Session["brcd"].ToString();
        //string Billno = OCBIllno(Loccode.ToString());

        
        //string custnm = dt.Getcustomer(custcd.Trim());
        //string billsubbrcd = txtbillsubloc.Text.ToString();
        //string bbrcd = Session["brcd"].ToString();
        //string billcolbrcd = txtbillcolloc.Text.ToString();
        //string bgndt = dt.Mydate1(txtbgndt.Text.ToString());
        //string billduedt = dt.Mydate1(txtduedate.Text.ToString());
        //string BCLDT = "NUll";
        //string BCBSDT = "NUll";
        //string Brnm = fn.GetLocation(bbrcd);
        //string Paybas = "6";
        ////**********for party detail**************
        //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
        //conn.Open();
        //string sql = "sp_get_custdetal";
        //SqlCommand cmd = new SqlCommand(sql, conn);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@custcd", SqlDbType.VarChar).Value = custcd.Trim();

        //SqlDataReader dr = null;
        //dr = cmd.ExecuteReader();

        //while (dr.Read())
        //{

        //    string PTMSTEL = Convert.ToString(dr["CUSTTEL"]);
        //    string PTMSEMAIL = Convert.ToString(dr["CUSTEMAIL"]);
        //    string PTMSADDR = Convert.ToString(dr["CUSTADDRESS"]);
              

        //}
        //conn.Close();
        ////****************************************
        //string BILLAMT = txtbillamt.Text.ToString();
        //string PENDAMT = txtbillamt.Text.ToString();
        //string BILLSTATUS = "Bill Generated";
        //string bgenempcd = Session["empcd"].ToString();
       
        //SqlCommand cmd = new SqlCommand("Webx_Insert_Ocbilldata_billmst", conn);
        //cmd.CommandType = CommandType.StoredProcedure;

        //cmd.Parameters.AddWithValue("@billno", Billno);
        //cmd.Parameters.AddWithValue("@BGNDT", bgndt);
        //cmd.Parameters.AddWithValue("@BSBDT", null);
        //cmd.Parameters.AddWithValue("@BDUEDT", billduedt);
        //cmd.Parameters.AddWithValue("@BCLDT", null);
        //cmd.Parameters.AddWithValue("@BCBSDT", null);
        //cmd.Parameters.AddWithValue("@BBRCD", bbrcd);
        //cmd.Parameters.AddWithValue("@BBRNM", Brnm);
        //cmd.Parameters.AddWithValue("@PAYBAS", Paybas);
        //cmd.Parameters.AddWithValue("@PTMSCD", custcd);
        //cmd.Parameters.AddWithValue("@PTMSNM", custnm);
        //cmd.Parameters.AddWithValue("@PTMSTEL", PTMSTEL);
        //cmd.Parameters.AddWithValue("@PTMSEMAIL", PTMSEMAIL);
        //cmd.Parameters.AddWithValue("@PTMSADDR", PTMSADDR);
        //cmd.Parameters.AddWithValue("@REMARK", null);
        //cmd.Parameters.AddWithValue("@BILLAMT", BILLAMT);
        //cmd.Parameters.AddWithValue("@PENDAMT", PENDAMT);
        //cmd.Parameters.AddWithValue("@BILLSTATUS", BILLSTATUS);
        //cmd.Parameters.AddWithValue("@bgenempcd", bgenempcd);
        //cmd.Parameters.AddWithValue("@billsubbrcd", billsubbrcd);
        //cmd.Parameters.AddWithValue("@billcolbrcd", billcolbrcd);
        //conn.Open();
        //cmd.ExecuteNonQuery();
        //conn.Close();
        //conn.Open();
        //foreach (DataGridItem gridrow in DataGrid1.Items)
        //{

        //    SqlCommand cmd_det = new SqlCommand("Webx_Insert_Ocbilldata_billmst", conn);
        //    cmd_det.CommandType = CommandType.StoredProcedure;
        //    cmd_det.Parameters.AddWithValue("@billno", billno);
        //    cmd_det.Parameters.AddWithValue("@dockno", dockno);
        //    cmd_det.Parameters.AddWithValue("@DOCKSF", docksf);
        //    cmd_det.Parameters.AddWithValue("@OCT_AMT ", octamt);
        //    cmd_det.Parameters.AddWithValue("@process_chrg", octamt);
        //    cmd_det.Parameters.AddWithValue("@TOTAMT", docksf);
        //    cmd_det.Parameters.AddWithValue("@declval", rcptno);
        //    cmd_det.Parameters.AddWithValue("@oct_percentage", prochrg);
        //    cmd_det.Parameters.AddWithValue("@clearance_chrg", octamt);
        //    cmd_det.Parameters.AddWithValue("@OTCHG", docksf);
        //    cmd_det.Parameters.AddWithValue("@OCT_RECEIPTNO", rcptno);
        //    cmd_det.Parameters.AddWithValue("@processing_per", prochrg);
        //    cmd_det.Parameters.AddWithValue("@recptdt", recptdt);
            
        //    SqlCommand cmd1 = new SqlCommand("Webx_INSERT_OCT_DET", conn);
        //    cmd1.CommandType = CommandType.StoredProcedure;
        //    string docksf = ".";
        //    datarow = _dataSet.WorkExperianceData[gridrow.DataSetIndex];
        //    string dockno = ((TextBox)gridrow.FindControl("txtdockno")).Text;
        //    string declval = ((TextBox)gridrow.FindControl("txtdeclval")).Text;
        //    string octamt = ((TextBox)gridrow.FindControl("txtoctamt")).Text;
        //    string octper = ((TextBox)gridrow.FindControl("txtoctper")).Text;
        //    string clearchrg = ((TextBox)gridrow.FindControl("txtclearchrg")).Text;
        //    string prochrg_per = ((TextBox)gridrow.FindControl("txtprochrg_per")).Text;
        //    string prochrg = ((TextBox)gridrow.FindControl("txtprochrg")).Text;
        //    string otchg = ((TextBox)gridrow.FindControl("txtotchg")).Text;
        //    string totalamt = ((TextBox)gridrow.FindControl("txttotalamt")).Text;
        //    string rcptno = ((TextBox)gridrow.FindControl("txtrcptno")).Text;
        //    string rcptdate = ((TextBox)gridrow.FindControl("txtrcptdate")).Text;

        //    cmd1.Parameters.AddWithValue("@billno", billno);
        //    cmd1.Parameters.AddWithValue("@dockno", dockno);
        //    cmd1.Parameters.AddWithValue("@octamt", octamt);
        //    cmd1.Parameters.AddWithValue("@recptno", declval);
        //    cmd1.Parameters.AddWithValue("@octamt", octamt);
        //    cmd1.Parameters.AddWithValue("@docksf", docksf);
        //    cmd1.Parameters.AddWithValue("@recptdt", rcptno);
        //    cmd1.Parameters.AddWithValue("@process_chrg", prochrg);
        //    cmd1.Parameters.AddWithValue("@declval", declval);
        //    cmd1.Parameters.AddWithValue("@oct_percentage", octper);
        //    cmd1.Parameters.AddWithValue("@clearance_chrg", clearchrg);
        //    cmd1.Parameters.AddWithValue("@OTCHG", otchg);
        //    cmd1.Parameters.AddWithValue("@processing_per", prochrg_per);
        //    cmd1.Parameters.AddWithValue("@bill_mr_dt", bgndt);
        //    cmd1.Parameters.AddWithValue("@octroipaid_by", octroipaid_by);
        //    cmd1.Parameters.AddWithValue("@oct_Custcd", custcd);
        //    cmd1.Parameters.AddWithValue("@oct_Custnm", custnm);
        //    cmd1.Parameters.AddWithValue("@customer_paidby", Session["empcd"].ToString());
        //    cmd1.Parameters.AddWithValue("@customer_paidat", Session["brcd"].ToString());
        //    cmd1.Parameters.AddWithValue("@customer_paiddt", getdate());
            

        //    _dataSet.WorkExperianceData[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
        //    cmd_det.EndExecuteNonQuery();
        //    cmd1.ExecuteNonQuery();

        //}

        //conn.Close();
        //Response.Redirect("asn_gen.aspx?id=" + maxcode, true);
   }
}
