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

public partial class Octroi_Octroi_MR_Query : System.Web.UI.Page
{
    public DataSet1 _dataSet = new DataSet1();
    public DataSet1.WorkExperianceDataRow datarow;
    int _lastEditedPage;
    int nullvalue = 0;
    string scriptStr;
    public string ptnm, ptcd, myflag;
    string res = "ok";
    public static string Financial_Year = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        foreach (DataGridItem gridrow in DataGrid1.Items)
        {
            TextBox txtrcptno = ((TextBox)gridrow.FindControl("txtrcptno"));
            txtrcptno.Attributes.Add("onblur", "javascript:tupper(this)");
        }
        if (!IsPostBack)
        {
            txtmrdt.Text= System.DateTime.Today.ToString("dd/MM/yyyy");
            Inetialized();
            BindGrid();

        }
        else
        {
            ReverseBind();
        }
        Session["mrno2"] = "";
        svctax_yn.Attributes.Add("onclick", "javascript:Svctax_enable_disable()");
        LinkButton1.Attributes.Add("onclick", "javascript:return ValidateData()");
        LinkButton2.Attributes.Add("onclick", "javascript:return ValidateData()");
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
    private void ReverseBind()
    {
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

    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        DataGrid1.DataSource = null;
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        }
        BindGrid();
    }

    protected void OnDocketNOChange(object sender, EventArgs e)
    {
       
    }



    protected void fun1(object sender, EventArgs e)
    {
        myflag = "1";



        LinkButton1_Click();

    }
    protected void fun2(object sender, EventArgs e)
    {
        myflag = "2";

        LinkButton1_Click();
    }



    protected void LinkButton1_Click()
    {

        string From = "";
        string Oct_MR = "";
        string mrn="";


        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trn;
        trn = conn.BeginTransaction();

        try
        {

            foreach (DataGridItem gridrow in DataGrid1.Items)
            {


                string DockNo = ((TextBox)gridrow.FindControl("txtdockno")).Text;
             
                 if (DockNo != "")
                { 
                
                string OctAmt = ((TextBox)gridrow.FindControl("txtoctamt")).Text;
                string OctPer = ((TextBox)gridrow.FindControl("txtoctper")).Text;
                string Clear_Chrg = ((TextBox)gridrow.FindControl("txtclearchrg")).Text;
                string declval = ((TextBox)gridrow.FindControl("txtdeclval")).Text;
                string Proce_per = ((TextBox)gridrow.FindControl("txtprochrg_per")).Text;
                string Proc_Chrg = ((TextBox)gridrow.FindControl("txtprochrg")).Text;
                string Oth_Chrg = ((TextBox)gridrow.FindControl("txtotchg")).Text;
                string Total = ((TextBox)gridrow.FindControl("txttotalamt")).Text;
                string RecNo = ((TextBox)gridrow.FindControl("txtrcptno")).Text;
                string RecDt = ((TextBox)gridrow.FindControl("txtrcptdate")).Text;

                string stax = ((TextBox)gridrow.FindControl("txtstax")).Text;
                string cess = ((TextBox)gridrow.FindControl("txtcess")).Text;
                string hcess = ((TextBox)gridrow.FindControl("txthcess")).Text;

                if (Total == "")
                {
                    Total = "0";
                }



                string RecptDate = ((TextBox)gridrow.FindControl("txtrcptdate")).Text;

                TextBox txtrcptno = ((TextBox)gridrow.FindControl("txtrcptno"));
                //  txtrcptno.Attributes.Add("onblur", "javascript:tupper(this)");

                if (RecptDate == "")
                {

                    //string[] strArrDtFrom1 = RecptDate.Split('/');
                    //From = strArrDtFrom1[1] + "/" + strArrDtFrom1[0] + "/" + strArrDtFrom1[2];

                }
                else
                {
                    string[] strArrDtFrom1 = RecptDate.Split('/');
                    From = strArrDtFrom1[1] + "/" + strArrDtFrom1[0] + "/" + strArrDtFrom1[2];

                }

                

                    
                    string sql_chg_stax = "Select * from WEBX_CHARGEMST";
                    SqlCommand cmd_chg = new SqlCommand(sql_chg_stax, conn,trn);
                    SqlDataReader dr_oth_charges = null;
                    dr_oth_charges = cmd_chg.ExecuteReader();
                    string ServiceTax = "", OtherTax = "", H_OtherTax = "";
                    while (dr_oth_charges.Read())
                    {
                        ServiceTax = Convert.ToString(dr_oth_charges["ServiceTax"].ToString());
                        OtherTax = Convert.ToString(dr_oth_charges["EDU_CESS_RATE"].ToString());

                        H_OtherTax = Convert.ToString(dr_oth_charges["HEDU_CESS_RATE"].ToString());
                    }
                    dr_oth_charges.Close();

                    string svctax_str = ",svctax_rate=" + ServiceTax + ",cess_rate  =" + OtherTax + ",H_cess_rate=" + H_OtherTax + "";

                    string s1 = "select top 1 * from vw_docket_net  where DOCKNO ='" + DockNo + "'";
                    SqlCommand cmd11 = new SqlCommand(s1, conn, trn);
                    SqlDataReader d1 = cmd11.ExecuteReader();
                    string trn_mod = "";
                    if (myflag == "1")
                    {
                        while (d1.Read())
                        {

                            ptcd = d1["CSGECD"].ToString();
                            ptnm = d1["CSGENM"].ToString();
                            ptnm = ptnm.Replace("'", " ").ToString();
                            trn_mod = d1["trn_mod"].ToString();

                        }
                    }
                    else
                    {
                        while (d1.Read())
                        {

                            ptcd = d1["CSGNCD"].ToString();
                            ptnm = d1["CSGNNM"].ToString();
                            ptnm = ptnm.Replace("'", " ").ToString();
                            trn_mod = d1["trn_mod"].ToString();
                        }
                    }

                    if (trn_mod.ToString() == "2")
                    {
                        ServiceTax = "3";
                    } 
                    d1.Close();
                    
                    string MRSNO = getVovno();

                    mrn += MRSNO + ",";


                   // Session["mrno2"] += MRSNO + ",";
 
                    string sql = "insert into webx_mr_det (dockno,declval,octamt,oct_percentage,clearance_chrg,processing_per,process_chrg,otchg,tot,recptno,recptdt,DOCKSF,MRSNO,MRSSF,bill_mr_dt,oct_cess,oct_high_cess,oct_svctax) values ('" + DockNo + "','" + declval + "','" + OctAmt + "','" + OctPer + "','" + Clear_Chrg + "','" + Proce_per + "','" + Proc_Chrg + "','" + Oth_Chrg + "','" + Total + "','" + RecNo + "','" + From + "','.','" + MRSNO + "','.','" + Convert.ToDateTime(txtmrdt.Text, dtfi) + "','" + cess + "','" + hcess + "','" + stax + "')";
                    SqlCommand cmd = new SqlCommand(sql, conn, trn);
                    cmd.ExecuteNonQuery();

                    string sql1 = "insert into webx_MR_HDR WITH(ROWLOCK)(ENTRYBY,ENTRYDT,MRSTYPE,mrsbr,MRSNO,MRSSF,MRSDT,DOCKNO,MRS_CLOSED,PTCD,PTNAME,MRSAMT,NETAMT,mrcollbrcd) values('" + Session["empcd"] + "','" + System.DateTime.Now + "','4','" + Session["brcd"] + "','" + MRSNO + "','.','" + Convert.ToDateTime(txtmrdt.Text, dtfi) + "','" + DockNo + "','N','" + ptcd + "','" + ptnm + "','" + Total + "','" + Total + "','" + Session["brcd"] + "')";
                    SqlCommand cmd1 = new SqlCommand(sql1, conn, trn);
                    cmd1.ExecuteNonQuery();

                    string sql2 = "";


                    string res1 = docket_EXIST(DockNo);

                    if (res1 == "NOT EXIST")
                    {
                        sql2 = "insert into webx_oct_det(MRSNO,bill_mr_dt,MR_PAIDBY,customer_paidby,customer_paidat,customer_paiddt,process_chrg,declval,oct_percentage,clearance_chrg,OTCHG,processing_per,dockno,docksf) values ('" + MRSNO + "','" + Convert.ToDateTime(txtmrdt.Text, dtfi) + "','CSGECD','" + Session["empcd"] + "','" + Session["brcd"] + "',getdate(),'" + Proc_Chrg + "','" + declval + "','" + OctPer + "','" + Clear_Chrg + "','" + Oth_Chrg + "','" + Proce_per + "','" + DockNo + "','.')";
                    }
                    else
                    {
                        sql2 = "update webx_oct_det set MRSNO='" + MRSNO + "',bill_mr_dt='" + Convert.ToDateTime(txtmrdt.Text, dtfi) + "',MR_PAIDBY='CSGECD',customer_paidby='" + Session["empcd"] + "',customer_paidat='" + Session["brcd"] + "',customer_paiddt=getdate(),process_chrg='" + Proc_Chrg + "',declval='" + declval + "',oct_percentage='" + OctPer + "',clearance_chrg='" + Clear_Chrg + "',OTCHG='" + Oth_Chrg + "',processing_per='" + Proce_per + "' where dockno='" + DockNo + "' and docksf='.'";
                    }
                    SqlCommand cmd2 = new SqlCommand(sql2, conn, trn);
                    cmd2.ExecuteNonQuery();
                    //conn.Close();

                     

                   // conn.Open();
                     
                    string sql3 = "Update webx_trans_docket_status set OctroiMr='Y'  where DOCKNO='" + DockNo + "'";
                    SqlCommand cmd3 = new SqlCommand(sql3, conn, trn);
                    cmd3.ExecuteNonQuery();
                    if (svctax_str != "")
                    {
                        sql3 = "Update webx_mr_hdr set MRSNO='" + MRSNO + "' " + svctax_str + "where MRSNO='" + MRSNO + "'";
                        cmd3 = new SqlCommand(sql3, conn, trn);
                        cmd3.ExecuteNonQuery();
                    }
                    //********************************* For Accounting ********************************
                    string acctrans = "exec usp_OctroiMRTransaction 1,'" + MRSNO + "','" + Financial_Year + "','" + Session["empcd"].ToString() + "',''";
                    cmd3 = new SqlCommand(acctrans, conn, trn);
                    cmd3.ExecuteNonQuery();

                    //*************************************************************************************
                    //
                }
            }
            trn.Commit();
            //trn.Rollback();
            Response.Redirect("Manual_MR_2.aspx?mrno=" + mrn);
            conn.Close();
        }
 
       
       catch (Exception e1)
        {
            lblerr.Text += " " + res;
            pnl1.Visible = false;
            plnerr.Visible = true;
             Response.Write("<br><br><br><font class='blackboldfnt' >Error : " + e1.Message + "</font>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trn.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();

        }
       
           
        




       // Response.Redirect("Manual_MR_2.aspx");
    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("query.aspx");
    }
    public string docket_EXIST(string dockno)
    {
        string msg;

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string dno = dockno;
        string sql = "";
        sql = "select dockno from webx_oct_det  where dockno='" + dno + "'";

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
    public string getVovno()
    {
        string vno = "";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;
        conn.Open();
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "sp_get_next_mr_code";

        sqlCommand.Parameters.AddWithValue("@loccode", Session["BRCD"]);
        if (Session["Client"].ToString() == "RLL")
        {
            sqlCommand.Parameters.Add("@finyear", SqlDbType.VarChar).Value = Financial_Year;
        }
        //sqlCommand.Parameters.AddWithValue("@NextVoucherNo", "");

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        da.Fill(ds);
        foreach (DataRow ddd in ds.Tables[0].Rows)
        {
            vno = ddd["NewCode"].ToString();
        }
        return vno;
    }

    protected void DataGrid1_ItemCreated(object sender, DataGridItemEventArgs e)
    {
        if ((e.Item.ItemType != ListItemType.Header) && (e.Item.ItemType != ListItemType.Footer))
        {

            int no = e.Item.ItemIndex + 2;
            String a, b, c, d, f, g, h, t;
            if (no < 10)
            {
                a = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtoctamt'";
                b = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtoctper'";
                c = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtclearchrg'";
                d = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtprochrg_per'";
                f = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtprochrg'";
                g = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtotchg'";
                h = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txtdeclval'";
                t = "'ctl00_MyCPH1_DataGrid1_ctl0" + Convert.ToString(no) + "_txttotalamt'";

            }
            else
            {
                a = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtoctamt'";
                b = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtoctper'";
                c = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtclearchrg'";
                d = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtprochrg_per'";
                f = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtprochrg'";
                g = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtotchg'";
                h = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txtdeclval'";
                t = "'ctl00_MyCPH1_DataGrid1_ctl" + Convert.ToString(no) + "_txttotalamt'";
            }

            ((TextBox)(e.Item.FindControl("txtoctamt"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
            ((TextBox)(e.Item.FindControl("txtoctper"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
            ((TextBox)(e.Item.FindControl("txtclearchrg"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
            ((TextBox)(e.Item.FindControl("txtprochrg_per"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
            ((TextBox)(e.Item.FindControl("txtprochrg"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
            ((TextBox)(e.Item.FindControl("txtotchg"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
            ((TextBox)(e.Item.FindControl("txtdeclval"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
            ((TextBox)(e.Item.FindControl("txttotalamt"))).Attributes.Add("onblur", "return AddRowNo(" + a + "," + b + "," + c + "," + d + "," + f + "," + g + "," + h + "," + t + ")");
        }
    }

    protected void UpperCase(object sender, EventArgs e)
    {

        //((TextBox)DataGrid1.SelectedItem.FindControl("txtrcptno")).Text = ((TextBox)(DataGrid1.SelectedItem.FindControl("txtrcptno"))).Text.ToUpper();
    }



}
