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

public partial class GUI_Finance_Fix_Asset_aaaaa : System.Web.UI.Page
{
    public static string straccd, p,err="";

    public DataTable dt_san = new DataTable();
    public double OtherAmt = 0.00, TDSDeduction = 0.00, ServiceTax = 0.00, CessAmount = 0.00, AdvancePaid = 0.00, NetAmount = 0.00, NetAmount1 = 0.00, PaymentAmt = 0.00;
    protected void Page_Load(object sender, EventArgs e)
    {

        p = Request.QueryString["pa"].ToString();


        if (!IsPostBack)
        {
            getstring();
            creategrid();
            txtpodt.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtqdt.Text = txtpodt.Text;

        }

    }

    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "select distinct vendorcode from webx_vendor_hdr";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["vendorcode"] + "'"));
        }
        dr_Location.Close();
    }


    public void creategrid()
    {
        dt_san.Clear();
        Int32 i;
        DataRow drow;


        for (i = 0; i < 10; i++)
        {
            drow = dt_san.NewRow();
            dt_san.Rows.Add(drow);

        }


        GV_D.DataSource = dt_san;
        GV_D.DataBind();

    }

    protected void GV_D_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TextBox txtacccode = (TextBox)(e.Row.FindControl("txtassetcd"));

            TextBox txtastnm = ((TextBox)(e.Row.FindControl("txtastnm")));

            ((Button)(e.Row.FindControl("btncodepopup"))).Attributes.Add("onclick", "javascript:return nwOpen2('" + txtacccode.ClientID.ToString() + "','" + txtastnm.ClientID.ToString() + "')");


        }


    }


    public string getnewcd()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        string sql = "exec sp_get_next_FAPO_code '" + Session["BRCD"].ToString() + "','07'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        string cd1 = (string)sqlcmd.ExecuteScalar();

        //  string cd = Convert.ToString(cd1);

        return cd1;


    }

    protected void btn_submit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string sql = "";


        string[] strArrDtFrom = txtpodt.Text.Split('/');

        string podate = strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2];



        string[] strArrDtFrom1 = txtqdt.Text.Split('/');


        string qdate = strArrDtFrom1[1] + "/" + strArrDtFrom1[0] + "/" + strArrDtFrom1[2];


        string[] strArrDtFrom2 = txtqdt.Text.Split('/');


        string rdate = strArrDtFrom2[1] + "/" + strArrDtFrom2[0] + "/" + strArrDtFrom2[2];

        string chdate = "";

        if (txtChequeDate.Text != "")
        {
            string[] strArrDtFrom3 = txtChequeDate.Text.Split('/');


            chdate = strArrDtFrom3[1] + "/" + strArrDtFrom3[0] + "/" + strArrDtFrom3[2];

        }



        string pocd = getnewcd();

        if (cboModeOfTransaction.SelectedValue.ToString() == "Cheque")
        {
            sql = "Insert into webx_POASSET_HDR(pocode,podate,VENDORCD,qutno,qutdate,reqno,reqdt,totalqty,totalamt,attn,ENTRYBY,ENTRYON,POSTATUS,Pendamt,po_loccode,chqdate,PayMode,acccode,accdesc,Chqno,paidamt,terms_condition)" +
                "values('" + pocd + "','" + txtpodt.Text + "','" + txtven.Text + "','" + txtqno.Text + "'," + qdate + ",'" + txtreqno.Text + "'," + rdate + "," + hh1.Value + ",100,'" + txtkind.Text + "','" + Session["EMPCD"].ToString() + "',getdate(),'P'," + txtbalamt.Text + ",'" + Session["BRCD"].ToString() + "'," + chdate + ",'" + cboModeOfTransaction.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedItem.ToString() + "','" + txtChequeNo.Text + "'," + txtPaymentAmt.Text + ",'" + txtterm.Text + "')";
        }
        else
        {
            sql = "Insert into webx_POASSET_HDR(pocode,podate,VENDORCD,qutno,qutdate,reqno,reqdt,totalqty,totalamt,attn,ENTRYBY,ENTRYON,POSTATUS,Pendamt,po_loccode,PayMode,acccode,accdesc,paidamt,terms_condition)" +
                "values('" + pocd + "','" + podate + "','" + txtven.Text + "','" + txtqno.Text + "'," + qdate + ",'" + txtreqno.Text + "'," + rdate + "," + hh1.Value + ",100,'" + txtkind.Text + "','" + Session["EMPCD"].ToString() + "',getdate(),'P'," + txtbalamt.Text + ",'" + Session["BRCD"].ToString() + "','" + cboModeOfTransaction.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedItem.ToString() + "','" + txtCashAmount.Text + "','" + txtterm.Text + "')";

        }


        // sql = "Insert into webx_POASSET_HDR(pocode,podate,VENDORCD,qutno,qutdate,reqno,reqdt,totalqty,totalamt,attn,ENTRYBY,ENTRYON,POSTATUS)" +
        //"values('" + pocd + "','" + txtpodt.Text + "','" + txtven.Text + "','" + txtqno.Text + "'," + txtqdt.Text + ",'','',15," + txtbalamt.Text + ",'" + txtkind.Text + "','" + Session["empcd"].ToString() + "',getdate(),'P')";



        //+txtbalamt.Text + ",'" + Session["brcd"].ToString() + "'," + txtChequeDate.Text + ",'" + cboModeOfTransaction.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedValue.ToString() + "','" + cboPaymentAccount.SelectedItem.ToString() + "'," + txtChequeNo.Text + "," + txtCashAmount.Text + ",'term and cndt','tax_type ')";



        try
        {
            SqlCommand sqlcmd = new SqlCommand(sql, conn);

            sqlcmd.ExecuteNonQuery();
           // btn_submit.Text = "ok";
            err = "";
        }
        catch (Exception e1)
        {
          err = e1.Message;
        }



        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            CheckBox c = (CheckBox)gridrow.FindControl("chksrno");

            if (c.Checked == true)
            {

                TextBox txtassetcd = (TextBox)gridrow.FindControl("txtassetcd");
                TextBox txtastnm = (TextBox)gridrow.FindControl("txtastnm");
                TextBox txtdesc = (TextBox)gridrow.FindControl("txtdesc");
                TextBox txtqty = (TextBox)gridrow.FindControl("txtqty");
                TextBox txtperct = (TextBox)gridrow.FindControl("txtperct");
                TextBox txtrate = (TextBox)gridrow.FindControl("txtrate");
                TextBox txttot = (TextBox)gridrow.FindControl("txttot");
                TextBox txttot2 = (TextBox)gridrow.FindControl("txttottot");





                string dkno, rno, dt, amt;


                //dkno = txtdockno.Text;
                string sqldet = "";




                try
                {
                    sqldet = "Insert into webx_POASSET_det(pocode,podate,assetcd,qty,rate,total,entryby,entrydt,balanceqty,location,narration,tax_per,tax_type,activeflag)" +
                   "values('" + pocd + "',getdate(),'" + txtassetcd.Text + "'," + txtqty.Text + "," + txtrate.Text + "," + txttot.Text + ",'" + Session["empcd"].ToString() + "',getdate()," + txtqty.Text + ",'" + Session["BRCD"].ToString() + "','" + txtdesc.Text + "'," + txtperct.Text + ",'','N')";
                    SqlCommand sqlcmd1 = new SqlCommand(sqldet, conn);

                    sqlcmd1.ExecuteNonQuery();

                 //   Response.Redirect("fa.aspx");

                }
                catch (Exception e1)
                {
                   err += e1.Message;
                }



            }



        }

        //  string sqlcq = "insert into WEBX_chq_det(Chqno, chqdt, chqamt,banknm, ptmsptcd,ptmsptnm,comments,bacd,banm,empcd,empnm,brcd,brnm,staffcd,staffnm,chq_trf,OwnCust,BANKBRN,adjustamt) values"+
        //    "(" +txtChequeNo.Text+"," +txtChequeDate.Text+ "," +txtCashAmount.Text+ "," +cboPaymentAccount.SelectedItem.ToString()+ "," &  ptmsptcd & "," & ptmsptnm & "," & comments & "," & bacd & "," & banm & ",'" & empcd & "'," & empnm & ",'" & brcd & "','" & brnm & "'," & staffcd & "," & staffnm & ",null,'O','" & BANKBRN & "'," & adjustamt & ")";


        //SqlCommand sqlcmd1 = new SqlCommand(sqlcq, conn);

        //sqlcmd1.ExecuteNonQuery();




        if (err == "")
        {
            Response.Redirect("po2.aspx?pono=" + pocd + "&ven=" + txtven.Text);
        }
        else
        {
            lblerr.Text = err;
            pnl1.Visible = false;
            plnerr.Visible = true;

        }








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

                sql = "select acccode,accdesc from webx_acctinfo where  (((bkloccode like 'All' or bkloccode like '" + Session["brcd"].ToString() + "%') AND acccategory='BANK')) order by accdesc asc";
                txtChequeDate.ReadOnly = false;
                txtChequeNo.ReadOnly = false;

            }
            else
            {
                txtCashAmount.Text = txtadv.Text;
                sql = "select  acccode,accdesc from webx_acctinfo where  acccategory='CASH' order by accdesc asc";
                txtChequeDate.ReadOnly = true;
                txtChequeNo.ReadOnly = true;
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

    protected void cboPaymentAccount_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("fa.aspx");
    }

}
