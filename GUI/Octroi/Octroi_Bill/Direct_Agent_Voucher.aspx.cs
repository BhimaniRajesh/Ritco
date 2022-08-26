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
    public string dockno, vno;

    public string s1, s2, s3;
    public string vovno, Financial_Year = "";
    string res = "ok";
    public static SqlConnection conn;
    SqlTransaction trn;

    protected void Page_Load(object sender, EventArgs e)
    {
        // getstring();
        t_otheramt.Attributes.Add("onblur", "javascript:check2(" + octamt.ClientID + "," + t_otheramt.ClientID + "," + txtnetpay.ClientID + ")");
        tdsrate.Attributes.Add("onblur", "javascript:check2(" + octamt.ClientID + "," + t_otheramt.ClientID + "," + txtnetpay.ClientID + ")");
        txtchno.Attributes.Add("onblur", "javascript:return Nagative_Chk(" + txtchno.ClientID + ")");
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);


        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "SELECT accdesc,acccode FROM webx_acctinfo WHERE acccode='BL613'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        cboTDSType.Items.Clear();
        while (dr.Read())
        {
            cboTDSType.Items.Add(new ListItem(dr["accdesc"].ToString(), dr["acccode"].ToString()));

        }
        dr.Close();
        if (!IsPostBack)
        {

            string billdate;
            Label1.Visible = false;
            billdate = System.DateTime.Now.ToString("dd/MM/yyyy");

            txtbgndt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");

            roww.Text = "10";
            Inetialized();

            t_otheramt.Text = "0";

            BindGrid();
            popAgnt();
            Validation();

        }
        else
        {
            ReverseBind();
        }
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

    }

    protected void BlankRow()
    {


    }

    public void Validation()
    {

        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtoctamt = ((TextBox)gridrow.FindControl("txtoctamt"));
            txtoctamt.Attributes.Add("onblur", "javascript:check(" + octamt.ClientID + "," + t_otheramt.ClientID + "," + txtnetpay.ClientID + ")");

            txtoctamt.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(" + txtoctamt.ClientID + ")");

        }
    }
    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
    }
    private void BindGrid()
    {
        GV_D.DataSource = _dataSet.WorkExperianceData;
        GV_D.DataBind();
        _lastEditedPage = GV_D.PageIndex;
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

    private void GV_D_PageIndexChanged(object source, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
    {
        GV_D.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    private void GV_D_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
    {
        if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        {
            _dataSet.WorkExperianceData.RemoveWorkExperianceDataRow(_dataSet.WorkExperianceData[e.Item.DataSetIndex]);
            if (((GV_D.PageCount - GV_D.PageIndex) == 1 & GV_D.Rows.Count == 1))
            {
                if ((GV_D.PageCount > 1))
                {
                    _lastEditedPage -= 1;
                }
                else
                {
                    _lastEditedPage = 0;
                }
            }
            GV_D.PageIndex = _lastEditedPage;
            BindGrid();
        }
    }


    private void ReverseBind()
    {
        //DataSet1.WorkExperianceDataRow datarow;// = null;

        //foreach (GridViewRow gridrow in GV_D.Rows)
        //{

        //    datarow = _dataSet.WorkExperianceData[gridrow.DataItemIndex];
        //    //// datarow.DOCKNO = ((TextBox)gridrow.FindControl("txtdockno")).Text;
        //    // //datarow.DECLVAL = ((TextBox)gridrow.FindControl("txtdockno")).Text;
        //    // datarow.OCTAMT = ((TextBox)gridrow.FindControl("txtoctamt")).Text;
        //    // datarow.OCTAMT_PER = ((TextBox)gridrow.FindControl("txtrcpno")).Text;
        //    // datarow.CLEAR_CHRG = ((TextBox)gridrow.FindControl("txtrcpdt")).Text;
        //    // _dataSet.WorkExperianceData[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
        //}
    }
    void GV_D_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridCommandEventArgs e)
    {
        DataSet1.WorkExperianceDataRow datarow;
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((DataSet1.WorkExperianceDataRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtdockno")).Text = datarow.DOCKNO;
            ((TextBox)e.Item.FindControl("txtdockno")).Text = datarow.DECLVAL;
            ((TextBox)e.Item.FindControl("txtoctamt")).Text = datarow.OCTAMT;
            ((TextBox)e.Item.FindControl("txtrcpno")).Text = datarow.OCTAMT_PER;
            ((TextBox)e.Item.FindControl("txtrcpdt")).Text = datarow.CLEAR_CHRG;
        }
    }
    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();

        }
        Validation();
    }


    public void popGrd(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
    }



    public void btnAdd_Grid(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
    }
    protected void BindGrid1()
    {


        DataView dv = _dataSet.WorkExperianceData.DefaultView;
        GV_D.DataSource = dv;
        GV_D.DataBind();
    }
    protected void OnDocketNOChange(object sender, EventArgs e)
    {

        GV_D.SelectedIndex = ((GridViewRow)((TextBox)sender).Parent.Parent).DataItemIndex;

        dockno = ((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).Text;



        string res = docket_validcheck(dockno, "dkt");

        if (res == "OK")
        {
            Label1.Visible = false;
            Button11.Enabled = false;
            filldata();

            ((TextBox)GV_D.SelectedRow.FindControl("txtoctamt")).Text = s1;
            ((TextBox)GV_D.SelectedRow.FindControl("txtrcpno")).Text = s2;
            ((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).ForeColor = System.Drawing.Color.Black;
            if (s3 == null)
            {
                ((TextBox)GV_D.SelectedRow.FindControl("txtrcpdt")).Text = "";
            }
            else
            {



                ((TextBox)GV_D.SelectedRow.FindControl("txtrcpdt")).Text = Convert.ToDateTime(s3).ToString("MM/dd/yyyy");
            }

        }
        else
        {
            ((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).Text = "InValid Docket No.";
            ((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).ForeColor = System.Drawing.Color.Red;

            Label1.Visible = true;
            Label1.ForeColor = System.Drawing.Color.Red; ;
            Label1.Text = "InValid Docket No.";
            Button11.Enabled = false;



        }

        GV_D.FooterRow.CssClass = "blackfnt";
        GV_D.FooterRow.Font.Bold = true;



        GV_D.FooterRow.Cells[1].Text = "Total";
        GV_D.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Center;



    }
    protected void cboModeOfTransaction_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (cboModeOfTransaction.SelectedValue.ToString() != "")
        {

            string sql = "";

            if (cboModeOfTransaction.SelectedValue.ToString() != "Cash")
            {

                sql = "select acccode,accdesc from webx_acctinfo where   (  ((bkloccode like 'All' or PATINDEx ('%" + Session["brcd"].ToString() + "%',bkloccode)>0) AND acccategory='BANK'))  order by accdesc asc";
                //txtchdt.ReadOnly = false;
                //txtchamt.ReadOnly = false;

            }
            else
            {
                // txtCashAmount.Text = txtadv.Text;
                sql = "select  acccode,accdesc from webx_acctinfo where  acccategory='CASH' order by accdesc asc";
                //txtchdt.ReadOnly = true;
                //txtchamt.ReadOnly = true;
            }
            SqlCommand sqlCommand = new SqlCommand(sql, conn);
            DataSet ds = new DataSet();

            SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
            da.Fill(ds, "tab1");

            cboPaymentAccount.DataSource = ds;
            cboPaymentAccount.DataTextField = "accdesc";
            cboPaymentAccount.DataValueField = "acccode";
            cboPaymentAccount.DataBind();
            cboPaymentAccount.CssClass = "blackfnt";
        }
    }

    public void popBank()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string sql = "select acccode,accdesc,acccategory from webx_acctinfo where  ( acccategory='CASH' OR ((bkloccode like 'All' or bkloccode like '%" + Session["brcd"] + "%') AND acccategory='BANK')) order by accdesc asc";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        cboPaymentAccount.DataSource = ds;
        cboPaymentAccount.DataTextField = "accdesc";
        cboPaymentAccount.DataValueField = "acccode";
        cboPaymentAccount.DataBind();
    }

    private DataSet1.WorkExperianceDataRow GetDataRow(int rowIndex)
    {

        // foreach (DataGridItem gridrow in GV_D.Rows)
        //{

        DataSet1.WorkExperianceDataRow datarow;
        datarow = _dataSet.WorkExperianceData[rowIndex];

        return datarow;
        //}
    }


    //*****************for docket valid check*******************
    public string docket_validcheck(string dockno, string par)
    {
        string msg;




        string dno = dockno;
        string sql = "";
        if (par == "dkt")
        {
            sql = "select dockno from webx_docket where dockno='" + dno + "' and octroi='N'";
        }
        else if (par == "det")
        {
            sql = "select dockno from webx_oct_det  where dockno='" + dno + "'";
        }
        else
        {

        }


        SqlCommand cmd = new SqlCommand(sql, conn, trn);

        string dno2;

        //dno2= cmd.ExecuteScalar().ToString();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        da.Fill(ds);



        if (ds.Tables[0].Rows.Count == 0)
        {
            msg = "Invalid Docket No.";
        }
        else
        {
            msg = "OK";
        }

        return msg;



    }



    //**********************************************************

    protected void Onoctdatacal(object sender, EventArgs e)
    {
        DataSet1.WorkExperianceDataRow datarow;

        foreach (DataGridItem gridrow in GV_D.Rows)
        {
            if (gridrow.ItemIndex != -1)
            {
                Inetialized();

                TextBox txtdockno2 = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtdockno2");
                TextBox txtdockno = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtdockno");
                TextBox txtrcpno = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtrcpno");
                TextBox txtoctamt = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtoctamt");
                TextBox txtrcpdt = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtrcpdt");

                datarow = _dataSet.WorkExperianceData[gridrow.ItemIndex];
                datarow = GetDataRow(gridrow.ItemIndex);


                _dataSet.WorkExperianceData[gridrow.ItemIndex].ItemArray = datarow.ItemArray;
            }
        }
    }





    public string getVovNo()
    {


        // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = conn;
        conn.Open();


        sqlCommand.CommandType = CommandType.StoredProcedure;



        sqlCommand.CommandText = "usp_next_VoucherNo_M";
        //System.DateTime.Now.Year.ToString("yy")
        //Input parameter for Billing Party
        sqlCommand.Parameters.AddWithValue("@brcd", Session["BRCD"]);
        sqlCommand.Parameters.AddWithValue("@finyear", Financial_Year);
        sqlCommand.Parameters.AddWithValue("@NextVoucherNo", "");


        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        try
        {
            da.Fill(ds);



            foreach (DataRow ddd in ds.Tables[0].Rows)
            {
                vno = ddd["VNO"].ToString();
            }

        }
        catch (Exception e2)
        {
            lblQry.Text = e2.Message;
        }
        return vno;

    }



    public void OnAmtChg(object sender, EventArgs e)
    {

    }



    public void popAgnt()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        conn.Open();

        string sql = "select m.vendorcode c1,m.vendorcode +' : '+m.vendorname c2,* from webx_vendor_hdr m where vendor_type=1 order by vendorname";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        ddlagnt.DataSource = ds;
        ddlagnt.DataTextField = "c2";
        ddlagnt.DataValueField = "c1";
        ddlagnt.DataBind();

    }



    protected void Button11_Click(object sender, EventArgs e)
    {

        trn = conn.BeginTransaction();
        try
        {

            vovno = getVovNo();
            Session["vvno"] = vovno;
            string[] chdt = null;
            string chdt22 = null;
            string paytype = "Cash Payment";


            foreach (GridViewRow gridrow in GV_D.Rows)
            {


                TextBox txtdockno = (TextBox)gridrow.FindControl("txtdockno");
                TextBox txtrcpno = (TextBox)gridrow.FindControl("txtrcpno");
                TextBox txtoctamt = (TextBox)gridrow.FindControl("txtoctamt");
                TextBox txtrcpdt = (TextBox)gridrow.FindControl("txtrcpdt");

                string dkno, rno, dt, amt;


                dkno = txtdockno.Text;
                rno = txtrcpno.Text;
                amt = txtoctamt.Text;
                dt = txtrcpdt.Text;

                if (dkno == "")
                {

                }
                else
                {

                    string res = docket_validcheck(dkno, "det");
                    if (dt == "")
                    {
                    }
                    else
                    {
                        string[] strArrDtFrom1 = dt.Split('/');
                        dt = strArrDtFrom1[1] + "/" + strArrDtFrom1[0] + "/" + strArrDtFrom1[2];

                    }



                    double amt2 = Convert.ToDouble(amt);
                    // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");



                    string sql = "";


                    if (res == "OK")
                    {

                        sql = "Update webx_OCT_DET set voucherno='" + vovno + "',DOCKNO='" + dkno + "',OCTAMT=" + amt2 + ",RECPTNO='" + rno + "',RECPTDT='" + dt + "' where DOCKNO='" + dkno + "'";

                    }
                    else
                    {
                        sql = "insert into webx_oct_det(voucherno,dockno,octamt,recptno,recptdt) values('" + vovno + "','" + dkno + "'," + amt2 + ",'" + rno + "','" + dt + "')";

                    }




                    SqlCommand cmdd = new SqlCommand(sql, conn, trn);

                    cmdd.ExecuteNonQuery();




                    string sql2 = "Update webx_trans_docket_status set OCTROI='Y' where DOCKNO='" + dkno + "'";

                    SqlCommand cmdd2 = new SqlCommand(sql2, conn, trn);

                    cmdd2.ExecuteNonQuery();




                    if (cboModeOfTransaction.SelectedValue.ToString() == "Cheque")
                    {
                        paytype = "Bank Payment";
                        chdt = txtchdt.Text.Split('/');


                        DateTime chdt2;

                        chdt2 = Convert.ToDateTime(chdt[0] + "/" + chdt[1] + "/" + chdt[2]);
                        chdt22 = chdt2.ToString();

                        string sql3 = "insert into webx_chq_det(voucherno,Chqno, chqdt, chqamt,banknm, ptmsptnm,comments,brcd,BANKBRN,chq_status) values('" + vovno + "','" + txtchno.Text + "','" + chdt22 + "','" + txtchamt.Text + "','" + cboPaymentAccount.SelectedItem.ToString() + "','','" + txtremarks.Text + "','" + Session["BRCD"].ToString() + "','" + cboPaymentAccount.SelectedItem.ToString() + "','SUBMITED')";

                        SqlCommand cmdd3 = new SqlCommand(sql3, conn, trn);

                        cmdd3.ExecuteNonQuery();

                    }





                }

            }


            string sql22 = "insert into webx_vouchertrans_arch(srno,finyear,entrydt,transdate,voucherno,chqno,chqdate,narration,transmode,brcd,oppacccode,Voucher_Cancel,entryby,acccode,debit,credit,payto,voucher_status,netamt,othchrg,octpaid,totalded,transtype,empcdfor,preparefor,totchrg,pbov_code,pbov_name,tdsgrpcode,tdsgrpdesc,tdsfor,tdsacccode,tdsrate,tds) values (1,2008,getdate(),'" + fn.Mydate1(txtbgndt.Text) + "','" + vovno + "','" + txtchno.Text + "','" + chdt22 + "','" + txtremarks.Text + "','" + cboModeOfTransaction.SelectedValue.ToString() + "','" + Session["brcd"].ToString() + "','" + cboPaymentAccount.SelectedValue.ToString() + "','N','" + Session["empcd"].ToString() + "','" + cboPaymentAccount.SelectedValue.ToString() + "',0.00,'" + txtnetpay.Text + "','" + TextBox2.Text + "','Submited','" + txtnetpay.Text + "','" + t_otheramt.Text + "','" + h_tot.Value + "',0,'" + paytype + "','" + Session["empcd"].ToString() + "','" + Session["brcd"].ToString() + "','" + txtnetpay.Text + "','','" + ddlagnt.SelectedValue + "','" + cboTDSType.SelectedValue.ToString() + "','" + cboTDSType.SelectedItem.Text + "','" + cboTDSDeducted.SelectedValue + "','" + cboTDSType.SelectedValue.ToString() + "','" + tdsrate.Text + "','" + Tdsamt.Text + "')";
            SqlCommand cmdd22 = new SqlCommand(sql22, conn, trn);
            cmdd22.ExecuteNonQuery();

            sql22 = "exec usp_Octroi_Payment_Transaction 1,'" + vovno + "','" + Financial_Year + "'";
            cmdd22 = new SqlCommand(sql22, conn, trn);
            cmdd22.ExecuteNonQuery();
        }
        catch (Exception ee1)
        {
            trn.Rollback();
            string strex = ee1.Message.Replace('\n', '_');
            Response.Redirect("../ErrorPage.aspx?heading=Billl Generation Error&detail1=Billl Generation Error&detail2=" + strex);
            return;
        }
        trn.Commit();

        Response.Redirect("Copy of Agent_Bill_2.aspx");

        //if (res == "ok")
        //{
        //    Response.Redirect("Copy of Agent_Bill_2.aspx");
        //}
        //else
        //{
        //    lblerr.Text += " " + res;
        //    pnl1.Visible = false;
        //    plnerr.Visible = true;
        //}




    }

    public void filldata()
    {

        string msg;
        //   SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string dno = dockno;

        string sql = "select * from webx_oct_det where dockno='" + dno + "'";

        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2;
        conn.Open();

        //dno2= cmd.ExecuteScalar().ToString();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        da.Fill(ds);


        foreach (DataRow ddr in ds.Tables[0].Rows)
        {
            s1 = ddr["octamt"].ToString();
            s2 = ddr["recptno"].ToString();
            s3 = ddr["recptdt"].ToString();

        }



    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("Direct_agent_voucher.aspx");
    }


}
