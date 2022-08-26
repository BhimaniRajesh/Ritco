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
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    string custcd, octroipaid_by;
    string custcls = "";
    MyFunctions fn = new MyFunctions();
    public DataSet1.WorkExperianceDataRow datarow;
    public string custcdstr, custis;
    public static string custcode;
    string res = "ok";

    protected void Page_Load(object sender, EventArgs e)
    {
        //  getstring();

        string billdate;
        billdate = System.DateTime.Now.ToString("dd/MM/yyyy");

        txtbgndt.Text = billdate.ToString(); //System.DateTime.Now.ToShortDateString();
        DateTime dt = DateTime.Today.AddDays(15);
        txtduedate.Text = dt.ToString("dd/MM/yyyy");
        custcode = Request.QueryString.Get("Party_detail");
        custcdstr = Request.QueryString.Get("Party_detail");
        custis = Request.QueryString.Get("custis");

        string[] custcd_arr;

        custcd_arr = custcdstr.Split('-');
        custcd = custcd_arr[0].ToString();
        if (custis == "CSGN")
        {
            custcls = "and csgncd='" + custcd + "'";
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
            octroipaid_by = "Billing Party";
        }

        Label1.Text = custcd.Trim() + ":" + fn.Getcustomer(custcd);
        LblPTMSCD.Text = custcd.Trim() + ":" + fn.Getcustomer(custcd);

        //  txtbillamt = 0;
        if (!IsPostBack)
        {
            txtbillsubloc.Text = Session["brcd"].ToString();
            txtbillcolloc.Text = Session["brcd"].ToString();
            Inetialized();

            BindGrid();
        }
        else
        {
            ReverseBind();
        }


    }
    //private void getstring()
    //{
    //    //holidaystr = "";
    //    SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    cn.Open();
    //    string sql = "select dockno from webx_master_docket";
    //    SqlCommand sqlCommand = new SqlCommand(sql, cn);
    //    SqlDataReader dr_Location;
    //    dr_Location = sqlCommand.ExecuteReader();
    //    while (dr_Location.Read())
    //    {
    //        Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["dockno"] + "'"));
    //    }
    //    dr_Location.Close();
    //}
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
        DataGrid1.Columns[1].HeaderText = Session["DocketCalledAs"].ToString() + " No.";
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
            datarow.DECLVAL = ((TextBox)gridrow.FindControl("txtdeclval")).Text;
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
            ((TextBox)e.Item.FindControl("txtdeclval")).Text = datarow.DECLVAL;
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
        _dataSet.WorkExperianceData.Clear();
        //_dataSet.WorkExperianceData.RemoveWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        DataGrid1.DataSource = null;
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");

        }
        BindGrid();
    }
    protected void BindGrid1()
    {
        DataView dv = _dataSet.WorkExperianceData.DefaultView;
        DataGrid1.DataSource = dv;
        DataGrid1.DataBind();
    }
  
    
    //protected void OnDocketNOChange(object sender, EventArgs e)
    //{       
    //    foreach (DataGridItem gridrow in DataGrid1.Items)
    //    {
    //        if (gridrow.ItemIndex != -1)
    //        {
    //            Inetialized();

    //            TextBox txtdockno = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtdockno");
    //            TextBox txtdeclval = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtdeclval");
    //            TextBox txtoctper = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtoctper");
    //            TextBox txtoctamt = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtoctamt");
    //            TextBox txtrcptno = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtrcptno");
    //            TextBox txtrcptdate = (TextBox)DataGrid1.Items[gridrow.ItemIndex].FindControl("txtrcptdate");

    //            datarow = _dataSet.WorkExperianceData[gridrow.ItemIndex];

    //            datarow = GetDataRow(gridrow.ItemIndex);

    //            if (txtdockno.ClientID == ((TextBox)sender).ClientID)
    //            {
    //                datarow.DOCKNO = txtdockno.Text;

    //                string docket_valid = docket_validcheck(txtdockno.Text, custcls.ToString());
    //                if (docket_valid == "OK")
    //                {
    //                    string octroi_detail = Octroi_date_field(txtdockno.Text);
    //                    string[] octroi_detail_arr;
    //                    DateTime rcptdate1;

    //                    octroi_detail_arr = octroi_detail.Split('~');

    //                    txtdeclval.Text = octroi_detail_arr[0].ToString();
    //                    txtoctamt.Text = octroi_detail_arr[1].ToString();
    //                    txtrcptno.Text = octroi_detail_arr[2].ToString();
    //                    if (octroi_detail_arr[3].ToString() != "")
    //                    {
    //                        rcptdate1 = Convert.ToDateTime(octroi_detail_arr[3].ToString());
    //                        txtrcptdate.Text = rcptdate1.ToString("dd/MM/yyyy");
    //                    }
    //                    else
    //                    {
    //                        txtrcptdate.Text = "";
    //                    }

    //                    if (txtdeclval.Text == "")
    //                    {
    //                        txtdockno.Text = "";
    //                        txtdeclval.Text = "Invalid Dockno";

    //                    }
    //                    else
    //                    {
    //                        decimal declval, octamt, octper;
    //                        declval = Convert.ToDecimal(txtdeclval.Text.ToString());
    //                        if (txtoctamt.Text.ToString() != "")
    //                        {
    //                            octamt = Convert.ToDecimal(txtoctamt.Text.ToString());
    //                        }
    //                        else
    //                        {
    //                            octamt = 0;
    //                        }

    //                        if (declval > 0 && octamt > 0)
    //                        {
    //                            octper = (octamt / declval) * 100;
    //                            octper = octper;
    //                            txtoctper.Text = octper.ToString();
    //                        }
    //                        txtoctamt.Focus();
    //                    }
    //                }
    //                else
    //                {
    //                    txtdockno.Text = "";
    //                    txtdeclval.Text = docket_valid.Trim();
    //                }
    //            }

    //            _dataSet.WorkExperianceData[gridrow.ItemIndex].ItemArray = datarow.ItemArray;
    //        }

    //    }
    //    //BindGrid1();
    //}



    private DataSet1.WorkExperianceDataRow GetDataRow(int rowIndex)
    {

        // foreach (DataGridItem gridrow in DataGrid1.Items)
        //{

        DataSet1.WorkExperianceDataRow datarow;
        datarow = _dataSet.WorkExperianceData[rowIndex];
        datarow.DOCKNO = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtdockno")).Text;
        datarow.DECLVAL = ((TextBox)DataGrid1.Items[rowIndex].FindControl("txtdeclval")).Text;
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

    public string Octroi_date_field(string dockno)
    {
        string declval = "";
        string octamt = "";
        string rcptno = "";
        string rcptdate = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

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

    //public string docket_validcheck(string dockno, string custcls)
    //{
    //    string msg;
    //    //SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    string dno = dockno;

    //    string sql = "select dockno from webx_docket where dockno='" + dno + "' and octroibill='N' and party_code='" + custcode + "'";

    //    SqlCommand cmd = new SqlCommand(sql, conn);

    //    string dno2;
    //    conn.Open();

    //    //dno2= cmd.ExecuteScalar().ToString();
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);

    //    DataSet ds = new DataSet();

    //    da.Fill(ds);

    //    if (ds.Tables[0].Rows.Count == 0)
    //    {
    //        msg = "Invalid Docket No.";
    //    }
    //    else
    //    {
    //        msg = "OK";
    //    }

    //    return msg;
    //}
    //**********************************************************
    public string OCBIllno(string loccode)
    {
        string NewCode = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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

        if (NewCode == null && NewCode == "")
        {

        }
        return NewCode;
    }
    protected void Button11_Click(object sender, EventArgs e)
    {
        string BillNo = getBillno();

        try
        {
           
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
            dtfi.ShortDatePattern = "dd/MM/yyyy";
            dtfi.DateSeparator = "/";

            DateTime dtFrom = new DateTime();
            DateTime dtTo = new DateTime();
            DateTime RecDate = new DateTime();

            dtFrom = Convert.ToDateTime(txtbgndt.Text, dtfi);
            dtTo = Convert.ToDateTime(txtduedate.Text, dtfi);
      
            foreach (DataGridItem gridrow in DataGrid1.Items)
            {


                string DocNo = ((TextBox)gridrow.FindControl("txtdockno")).Text;
                string OctAmt = ((TextBox)gridrow.FindControl("txtoctamt")).Text;
                string OctPer = ((TextBox)gridrow.FindControl("txtoctper")).Text;
                string Clear_Chrg = ((TextBox)gridrow.FindControl("txtclearchrg")).Text;
                string Proce_per = ((TextBox)gridrow.FindControl("txtprochrg_per")).Text;
                string Proc_Chrg = ((TextBox)gridrow.FindControl("txtprochrg")).Text;
                string Oth_Chrg = ((TextBox)gridrow.FindControl("txtotchg")).Text;
                string total = ((TextBox)gridrow.FindControl("txttotalamt")).Text;
                string RecNo = ((TextBox)gridrow.FindControl("txtrcptno")).Text;
                string RecDt = ((TextBox)gridrow.FindControl("txtrcptdate")).Text;

                string stax = ((TextBox)gridrow.FindControl("txtstax")).Text;
                string cess = ((TextBox)gridrow.FindControl("txtcess")).Text;
                string hcess = ((TextBox)gridrow.FindControl("txthcess")).Text;




                if (DocNo != "")
                {
                    txtbillamt.Enabled = true;

                    string dval = ((TextBox)gridrow.FindControl("txtdeclval")).Text;


                    string[] strArrDtFrom1 = RecDt.Split('/');
                    string RecDt_f = strArrDtFrom1[1] + "/" + strArrDtFrom1[0] + "/" + strArrDtFrom1[2];



                    /*
                     -----------------  Retrive Info from vw_docket_net-----------------------*/

                    string sq = "select top 10 DKTTOT as dktamt,SVCTAX,DKTTOT,Schg01 as dktchg,Schg11 as FOVCHG,SCHG14 as demchg,*from vw_docket_net where dockno='" + DocNo + "'";
                    SqlCommand cm = new SqlCommand(sq, conn);
                    SqlDataReader dr;
                    dr = cm.ExecuteReader();
                    string reasdestcd = "";
                    string dockdt = "";
                    string cdeldt = "";
                    string chrgwt = "";
                    string dkttot = "";

                    string dktamt = "";
                    string demchg = "";
                    string fovchg = "";
                    string dktchg = "";
                    string svctax = "";

                    while (dr.Read())
                    {
                        reasdestcd = dr["reassign_destcd"].ToString();
                        dockdt = dr["dockdt"].ToString();
                        cdeldt = dr["cdeldt"].ToString();
                        chrgwt = dr["chrgwt"].ToString();
                        dkttot = dr["dkttot"].ToString();

                        dktamt = dr["dktamt"].ToString();
                        demchg = dr["demchg"].ToString();
                        fovchg = dr["fovchg"].ToString();
                        dktchg = dr["dktchg"].ToString();
                        svctax = dr["svctax"].ToString();

                    }
                    dr.Close();


                    /*  -------------------------------------------------------------------------- */


                    string sql_bill = "INSERT INTO webx_BILLDET (BILLNO, DOCKNO, DOCKSF,OCT_AMT,process_chrg,TOTAMT,declval,oct_percentage,clearance_chrg,OTCHG,OCT_RECEIPTNO,processing_per,recptdt,oct_svctax,oct_cess,Oct_High_cess,reassign_destcd,dockdt,cdeldt,chrgwt,dkttot,svrcamt,dktamt,dktchg,fovchg,demchgs)VALUES ('" + BillNo + "','" + DocNo + "','.','" + OctAmt + "','" + Proc_Chrg + "','" + total + "','" + dval + "','" + OctPer + "','" + Clear_Chrg + "','" + Oth_Chrg + "','" + RecNo + "','" + Proce_per + "','" + RecDt_f + "','" + stax + "','" + cess + "','" + hcess + "','" + reasdestcd + "','" + dockdt + "','" + cdeldt + "','" + chrgwt + "','" + dkttot + "','" + svctax + "','" + dktamt + "','" + dktchg + "','" + fovchg + "','" + demchg + "')";
                    SqlCommand cmd4 = new SqlCommand(sql_bill, conn);
                    cmd4.ExecuteNonQuery();



                    string res1 = docket_EXIST(DocNo);

                    string sql = "";
                    if (res1 == "All Ready EXIST")
                    {
                        sql = "UPDATE webx_oct_det SET billno='" + BillNo + "',DOCKNO='" + DocNo + "',octamt='" + OctAmt + "',recptno='" + RecNo + "',docksf='" + "." + "',recptdt=convert(varchar,'" + RecDt_f + "',106),process_chrg='" + Proc_Chrg + "',declval='" + dval + "',oct_percentage='" + OctPer + "',clearance_chrg='" + Clear_Chrg + "',OTCHG='" + Oth_Chrg + "',processing_per='" + Proce_per + "',bill_mr_dt='" + System.DateTime.Now + "',octroipaid_by='" + custis + "',oct_Custcd='" + custcd + "',customer_paidby='" + Session["EMPCD"].ToString() + "',customer_paidat='" + Session["BRCD"].ToString() + "',customer_paiddt='" + System.DateTime.Now + "'  where DOCKNO='" + DocNo + "'";
                    }
                    else
                    {


                        sql = "insert into webx_oct_det (billno,DOCKNO,octamt,recptno,docksf,recptdt,process_chrg,declval,oct_percentage,clearance_chrg,OTCHG,processing_per,bill_mr_dt,octroipaid_by,oct_Custcd,customer_paidby,customer_paidat,customer_paiddt) values('" + BillNo + "','" + DocNo + "','" + OctAmt + "','" + RecNo + "','" + "." + "',convert(varchar,'" + RecDt_f + "',106),'" + Proc_Chrg + "','" + dval + "','" + OctPer + "','" + Clear_Chrg + "','" + Oth_Chrg + "','" + Proce_per + "','" + System.DateTime.Now + "','" + custis + "','" + custcd + "','" + Session["EMPCD"].ToString() + "','" + Session["BRCD"].ToString() + "','" + System.DateTime.Now + "')";
                    }
                    //  + "','" + OctPer + "','" + Clear_Chrg + "','" + Oth_Chrg + "','" + Proce_per + "')";


                    //'" + "" + "','" + "" + "','" + "" + "','" + "" + "','" + "" + "','" + "" + "',convert(varchar,getdate(),106))";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.ExecuteNonQuery();


                    string sql2 = "update webx_trans_docket_status set octroibill='Y' where DOCKNO='" + DocNo + "'";
                    SqlCommand cmd2 = new SqlCommand(sql2, conn);
                    cmd2.ExecuteNonQuery();

                }

            }

            string sql3 = "insert into webx_billmst(billno,billstatus,bbrcd,paybas,ptmscd,bgndt,billsubbrcd,billcolbrcd,bduedt,billamt,remark) values('" + BillNo + "','Bill Generated','" + Session["BRCD"].ToString() + "','6','" + custcdstr.ToString() + "','" + dtFrom + "','" + txtbillsubloc.Text + "','" + txtbillcolloc.Text + "','" + dtTo + "','" + h11.Value + "','" + txtRemark.Text + "')";
            SqlCommand cmd3 = new SqlCommand(sql3, conn);
            cmd3.ExecuteNonQuery();
        }

        catch (Exception e123)
        {
            res = e123.Message;
        
        }
       
        if (res == "ok")
        {
            Response.Redirect("OctCustBillStep3.aspx?billno=" + BillNo);
        }
        else
        {
            lblerr.Text += " " + res;
            pnl1.Visible = false;
            plnerr.Visible = true;
        }

        
 
    }

    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("OctCustBillStep1.aspx");

    }

    public string docket_EXIST(string dockno)
    {
        string msg;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string dno = dockno;
        string sql = "";
        sql = "select dockno from webx_oct_det where dockno='" + dno + "'";

        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2;
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        da.Fill(ds);

        if (ds.Tables[0].Rows.Count == 0)
        {
            msg = "NOT EXIST";
        }
        else
        {
            msg = "All Ready EXIST";
        }

        return msg;



    }

    //public string Getdeclval(string dockno)
    //{
    //    string declval = "";
    //    SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
    //    //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    //    conn.Open();
    //    string sql = "usp_oct_detail";
    //    SqlCommand cmd = new SqlCommand(sql, conn);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.Add("@dockno", SqlDbType.VarChar).Value = dockno.Trim();

    //    SqlDataReader dr = null;
    //    dr = cmd.ExecuteReader();

    //    while (dr.Read())
    //    {
    //        declval = Convert.ToString(dr["declval"]);
    //    }

    //    if (declval == null) declval = "";
    //    return declval;
    //}


    public string getBillno()
    {
        string bno = "";
        try
        {

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = conn;
            conn.Open();
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "sp_get_next_octbill_code";
            string loc = Session["BRCD"].ToString();
            sqlCommand.Parameters.AddWithValue("@loccode", loc);
            //sqlCommand.Parameters.AddWithValue("@finyear", "07");

            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
            da.Fill(ds);
            foreach (DataRow ddd in ds.Tables[0].Rows)
            {
                bno = ddd["NewCode"].ToString();
            }
        }
        catch (Exception e1234)
        {
            res = e1234.Message;

        }
        return bno;
    }
    //protected void DataGrid1_ItemCreated(object sender, DataGridItemEventArgs e)
    //{

    //    if ((e.Item.ItemType != ListItemType.Header) && (e.Item.ItemType != ListItemType.Footer))
    //    {

    //        int no = e.Item.ItemIndex + 2;
    //        String a, b, c, d, f, g, h, t;
    //        if (no < 10)
    //        {
    //            a = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtoctamt'";
    //            b = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtoctper'";
    //            c = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtclearchrg'";
    //            d = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtprochrg_per'";
    //            f = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtprochrg'";
    //            g = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtotchg'";
    //            h = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtdeclval'";
    //            t = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txttotalamt'";

    //        }
    //        else
    //        {
    //            a = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtoctamt'";
    //            b = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtoctper'";
    //            c = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtclearchrg'";
    //            d = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtprochrg_per'";
    //            f = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtprochrg'";
    //            g = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtotchg'";
    //            h = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtdeclval'";
    //            t = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txttotalamt'";
    //        }



    //        //((TextBox)(e.Item.FindControl("txtoctamt"))).Attributes.Add("onblur", "javascript:Nagative_Chk_wDecimal(this)");
    //        //((TextBox)(e.Item.FindControl("txtoctamt"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");

    //        ((TextBox)(e.Item.FindControl("txtrcptno"))).Attributes.Add("onblur", "javascript:tupper(this)");
    //        ((TextBox)(e.Item.FindControl("txtoctper"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
    //        ((TextBox)(e.Item.FindControl("txtprochrg_per"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
    //        ((TextBox)(e.Item.FindControl("txtprochrg"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
    //        ((TextBox)(e.Item.FindControl("txtotchg"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
    //        ((TextBox)(e.Item.FindControl("txtdeclval"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
    //        ((TextBox)(e.Item.FindControl("txttotalamt"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
    //    }
    //}


    protected void txtbillsubloc_TextChanged(object sender, EventArgs e)
    {
        txtbillsubloc.Text = txtbillsubloc.Text.ToUpper();

        if (txtbillsubloc.Text == "")
        {
            lblErrorLocation.Visible = false;
            return;
        }

        String strSQL = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "SELECT LocCode FROM webx_location WHERE LocCode = '" + txtbillsubloc.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        lblErrorLocation.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? false : true);

        if (dsLocation.Tables[0].Rows.Count > 0)
        {
            txtbillsubloc.Focus();
        }
        sqlConn.Close();
    }
    protected void txtbillcolloc_TextChanged(object sender, EventArgs e)
    {
        txtbillcolloc.Text = txtbillcolloc.Text.ToUpper();

        if (txtbillcolloc.Text == "")
        {
            lblErrorLocation1.Visible = false;
            return;
        }

        String strSQL = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "SELECT LocCode FROM webx_location WHERE LocCode = '" + txtbillcolloc.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        lblErrorLocation1.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? false : true);

        if (dsLocation.Tables[0].Rows.Count > 0)
        {
            txtbillcolloc.Focus();
        }
        sqlConn.Close();
    }
}
