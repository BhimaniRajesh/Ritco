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

       public static SqlConnection conn;
    
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    string custcd, octroipaid_by;
    string custcls = "";
    MyFunctions fn = new MyFunctions();
    public DataSet1.WorkExperianceDataRow datarow;
    public string dockno;
    public string bno = "", billdt = "", agbilldt = "", duedt = "";
    public string BranchCode;
    public string s1, s2, s3;
    SqlTransaction trn ;

    protected void Page_Load(object sender, EventArgs e)
    {
        getstring();

        string billdate;

        BranchCode = Session["brcd"].ToString();

        Label1.Visible = false;
        txtservicetxtchrg.Enabled = false;
        txtservicetxtchrg.Text = "0";
        txtserchgper.Text = "0";
               octamt.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");

        txtagnttax.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtothrchg.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtfrmcharg.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtclearchrg.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtserchgper.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtservicetxtchrg.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtsundry.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtagntbillno.Attributes.Add("onblur", "javascript:tupper(this)");
             conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {

             

            txtbilldt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtagntbilldt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtduedate.Text = System.DateTime.Now.AddDays(15).ToString("dd/MM/yyyy");
            txtagnttax.Text = "0";

            Inetialized();

            BindGrid();
            popAgnt();
            Validation();
            txtbilldt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtagntbilldt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtduedate.Text = System.DateTime.Now.AddDays(15).ToString("dd/MM/yyyy");
        }
        else
        {
            ReverseBind();
        }


    }
    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "select dockno from webx_trans_docket_status where octroi<>'y'";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["dockno"] + "'"));
        }
        dr_Location.Close();
    }
    protected void BlankRow()
    {


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


        //GV_D.HeaderRow.Cells[1].Text = Session["DocketCalledAs"].ToString() + " No.";


    }
    private void BindGrid()
    {
        GV_D.DataSource = _dataSet.WorkExperianceData;
        GV_D.DataBind();
        GV_D.HeaderRow.Cells[1].Text = Session["DocketCalledAs"].ToString() + " No.";
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
        DataSet1.WorkExperianceDataRow datarow;// = null;

        foreach (GridViewRow gridrow in GV_D.Rows)
        {

            datarow = _dataSet.WorkExperianceData[gridrow.DataItemIndex];
            
        }
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

    public void Validation()
    {
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtoctamt = ((TextBox)gridrow.FindControl("txtoctamt"));
            TextBox txtrcpno = ((TextBox)gridrow.FindControl("txtrcpno"));
            txtoctamt.Attributes.Add("onblur", "javascript:check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
            txtoctamt.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(this)");
            txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");

        }
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
        //if (par == "dkt")
        //{
        //    sql = "select dockno from webx_master_docket  where dockno='" + dno + "'";

        //}
        //else 
        if (par == "det")
        {
            sql = "select dockno from webx_oct_det  where dockno='" + dno + "'";

        }
        else
        {

        }


        SqlCommand cmd = new SqlCommand(sql, conn,trn);

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
                GV_D.HeaderRow.Cells[1].Text = Session["DocketCalledAs"].ToString() + " No.";
            }
        }
    }


    public void OnAmtChg(object sender, EventArgs e)
    {

    }

    public string getBillno()
    {
      SqlCommand sqlCommand = new SqlCommand();
        sqlCommand.Connection = conn;

        sqlCommand.Transaction = trn;
     
        sqlCommand.CommandType = CommandType.StoredProcedure;
        sqlCommand.CommandText = "usp_next_vendorbillentry_code";

        sqlCommand.Parameters.AddWithValue("@brcd", Session["BRCD"]);
        sqlCommand.Parameters.AddWithValue("@transdate", System.DateTime.Now);


        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        da.Fill(ds);



        foreach (DataRow ddd in ds.Tables[0].Rows)
        {
            bno = ddd["NewCode"].ToString();
        }

        if (bno == "")
        {

            bno = Session["BRCD"] + "/BE/0000001";

        }




        return bno;
    }

    public void popAgnt()
    {
         

        string sql = "select  distinct m.vendorcode c1,m.vendorname c2  from webx_vendor_hdr m,webx_vendor_det d where m.vendorcode=d.vendorcode and vendor_type=1";

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

        string billno = getBillno();

        Session["billno"] = billno;

        if (billno != "")
        {


            trn = conn.BeginTransaction();

            try
            {

                foreach (GridViewRow gridrow in GV_D.Rows)
                {
                    TextBox txtdockno = (TextBox)gridrow.FindControl("txtdockno");
                    string dkno;
                    dkno = txtdockno.Text;

                    if (dkno.Trim() == "")
                    {}
                    else
                    {

                        TextBox txtrcpno = (TextBox)gridrow.FindControl("txtrcpno");
                        TextBox txtoctamt = (TextBox)gridrow.FindControl("txtoctamt");
                        TextBox txtrcpdt = (TextBox)gridrow.FindControl("txtrcpdt");
                        string rno, dt, amt;

                        rno = txtrcpno.Text;
                        amt = txtoctamt.Text;
                        dt = txtrcpdt.Text;

                        string res1 = docket_validcheck(dkno, "det");


                        string[] dt2 = dt.Split('/');

                        DateTime dt3 = Convert.ToDateTime(dt2[1] + "/" + dt2[0] + "/" + dt2[2]);

                        double amt2 = Convert.ToDouble(amt);
                        string sql = "";
                        string dval = "";
                        //GetDECVAL(dkno);


                        string[] strArrDtFrom1 = txtagntbilldt.Text.Split('/');
                        billdt = strArrDtFrom1[1] + "/" + strArrDtFrom1[0] + "/" + strArrDtFrom1[2];

                        string[] strArrDtFrom2 = txtbilldt.Text.Split('/');
                        agbilldt = strArrDtFrom1[1] + "/" + strArrDtFrom1[0] + "/" + strArrDtFrom1[2];


                        if (res1 != "OK")
                        {

                            sql = "insert into webx_oct_det(ocbillno,dockno,octamt,recptno,recptdt,DOCKSF, DECLVAL,oct_vendorcd,oct_vendornm,vendor_paiddt) values('" + billno + "','" + dkno + "'," + amt2 + ",'" + rno + "','" + dt3 + "','.','" + dval + "','" + ddlagnt.SelectedValue.ToString() + "','" + ddlagnt.SelectedItem.ToString() + "','" + billdt + "')";

                        }
                        else
                        {
                            sql = "Update webx_OCT_DET set ocbillno='" + billno + "', DOCKNO='" + dkno + "',OCTAMT=" + amt2 + ",RECPTNO='" + rno + "',RECPTDT='" + dt3 + "' where DOCKNO='" + dkno + "'";
                        }

                        SqlCommand cmdd = new SqlCommand(sql, conn, trn);

                        cmdd.ExecuteNonQuery();

                        string sql2 = "Update webx_trans_docket_status set OCTROI='Y' where DOCKNO='" + dkno + "'";

                        SqlCommand cmdd2 = new SqlCommand(sql2, conn, trn);

                        cmdd2.ExecuteNonQuery();


                    }

                }

                string ddt = "";
                if (txtduedate.Text != "")
                {
                    string[] strArrDtFrom122 = txtduedate.Text.Split('/');
                    ddt = strArrDtFrom122[1] + "/" + strArrDtFrom122[0] + "/" + strArrDtFrom122[2];
                }
                string agnt = "";
                 
                    agnt = ddlagnt.SelectedItem.ToString();
                

                string sql3 = "INSERT INTO webx_OCT_HDR (OCBILLNO,OCBRCD,OCBILLDT, OCAGCD, OCAGNM, OCAGBILLDT, OCAGOCTAMT, OCAGBILLNO, OCAGOTHCHRG, OCAGSERCHRG,OCTOTALDUE, ENTRYBY, ENTRYDT, REMARK,OCDUEDT,ACTSERCHRG,servchargeper,sundrychrg,formchrg,clearchrg)VALUES "+
                    "('" + billno + "','" + Session["BRCD"].ToString() + "','" + agbilldt + "','" + ddlagnt.SelectedValue.ToString() + "','" + agnt + "','" + billdt + "'," + h1.Value + ",'" + txtagntbillno.Text + "'," + txtothrchg.Text + "," + txtagnttax.Text + "," + h1.Value + ",'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','" + txtremarks.Text + "','" + ddt + "'," + txtservicetxtchrg.Text + "," + txtserchgper.Text + "," + txtsundry.Text + "," + txtfrmcharg.Text + "," + txtclearchrg.Text + ")";



                SqlCommand cmdd3 = new SqlCommand(sql3, conn, trn);

                cmdd3.ExecuteNonQuery();
                string Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
                sql3 = "exec usp_Octroi_Agentbill_Transaction 1,'" + billno + "','" + Financial_Year + "'";
                cmdd3 = new SqlCommand(sql3, conn, trn);

                cmdd3.ExecuteNonQuery();
            }

            catch (Exception ee1)
            {
                trn.Rollback();
                string strex = ee1.Message.Replace('\n', '_');
                Response.Redirect("../ErrorPage.aspx?heading=Billl Generation Error&detail1=Billl Generation Error&detail2=" + strex);
                return;
            }
            trn.Commit(); 
            Response.Redirect("Agent_Bill_2.aspx");

        }
    }

    public void filldata()
    {

        string msg;
        //  SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        


        string dno = dockno;

        string sql = "select * from webx_oct_det where dockno='" + dno + "'";

        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2;
        

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


}
