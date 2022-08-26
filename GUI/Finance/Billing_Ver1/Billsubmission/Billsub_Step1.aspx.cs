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

public partial class Finance_Billing_Billsubmission_Billsub_Step1 : System.Web.UI.Page
{

   //// SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    //SqlConnection conn1 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
    string Party_code;
    string orgncd;
    string fincmplbr;
    string billno;
    string fromdt;
    string Todt;
    string PAYBAS, manualbillno="";

    string TRN_MOD;
    string sqlmain;
    MyFunctions fn = new MyFunctions();
    public int intTotalRecords;
    public static string Fromdate = "", Todate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Button1.Attributes.Add("onclick", "javascript:return CheckDocketSelection(" + txtbsbdt.ClientID + "," + txtsubto.ClientID + "," + txtsubcontactno.ClientID + "," + txtdocketlist.ClientID + "," + txtdocketlist_count.ClientID + ")");
        //txtbsbdt.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'03','../../../images/Date_Control_Rule_Check.aspx')");
        Party_code = Request.QueryString.Get("Party_code");
        billno = Request.QueryString.Get("billno");
        manualbillno = Request.QueryString.Get("manualbillno");
            orgncd = "All";
            fincmplbr = Session["brcd"].ToString();
            fromdt = Request.QueryString.Get("fromtdate");
            Fromdate = Request.QueryString.Get("fromtdate");
            Todt = Request.QueryString.Get("todate");
            Todate = Request.QueryString.Get("todate");
            PAYBAS = Request.QueryString.Get("paybas");
           if (fromdt=="")
            {
                fromdt = System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            if (Todt=="")
            {
                Todt=System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            

        if (billno == "")
        {
            lbldaterange.Text = fromdt.Trim() + "-" + Todt.Trim();
            lblparty.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
            lblpaybas.Text = fn.Getpaybas(PAYBAS);
            lblbillno.Text = "";
        }
        else
        {
            lbldaterange.Text = "-";
            lblparty.Text = Party_code.ToString() + ":" + fn.Getcustomer(Party_code);
            lblpaybas.Text = fn.Getpaybas(PAYBAS);
            lblbillno.Text = billno.Trim();
        }
        if (!IsPostBack)
        {
            BindGrid();
        }
    }
    public void BindGrid()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "exec webx_BillSubmission '" + billno.Trim() + "','" + Party_code.Trim() + "','" + PAYBAS.Trim() + "','" + fromdt.Trim() + "','" + Todt.Trim() + "','" + fincmplbr.Trim() + "','" + manualbillno.Trim() + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        myAdapter.Fill(ds, "billdata");
        intTotalRecords = ds.Tables[0].Rows.Count;
        dockdata.DataSource = ds;
        dockdata.DataBind();
        conn.Close();
    }
    protected void pgChange(object sender, GridViewPageEventArgs e)
    {

        BindGrid();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        
        string BSUBEMPCD = Session["empcd"].ToString().ToUpper();
        string BILLSUBTO = txtsubto.Text.ToString().ToUpper();
        string SUBTOTEL = txtsubcontactno.Text.ToString().ToUpper();
        string bsbdt = "";
        bsbdt = fn.Mydate1(txtbsbdt.Text.ToString());
        SqlCommand cmd = new SqlCommand();
        string Xml_Bill_Submission = "<root>";
        string Due_DT = "";
		
		//if (Convert.ToDateTime(bsbdt).ToShortDateString() != System.DateTime.Now.ToShortDateString()) {
        //    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Bill Submission Date" + "&ErrorMsg=Bill Submission Date Can not be Future Date and Back Date !!", false);
        //    return;
        // }
		
		if (Convert.ToDateTime(bsbdt) > Convert.ToDateTime(System.DateTime.Now.ToString("dd MMM yyyy")))
        {
            Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Bill Submission Date" + "&ErrorMsg=Bill Submission Date Can not be Future Date  !!", false);
            return;
        }
		
        foreach (GridViewRow gridrow in dockdata.Rows)
        {
            var billdate = "";
            CheckBox chkDock = (CheckBox)gridrow.FindControl("chkDock");
            HiddenField Hnd_BgnDT = (HiddenField)gridrow.FindControl("Hnd_BgnDT");
            if (chkDock.Checked == true ) {
                billdate = fn.Mydate1(Hnd_BgnDT.Value);

                if (Convert.ToDateTime(bsbdt) < Convert.ToDateTime(billdate))
                {
                    Response.Redirect("~/GUI/ErrorPage.aspx?PageHead=" + "Bill Submission Date" + "&ErrorMsg=Bill Submission Date Can not be less then BillDate :"+ billdate + " !!", false);
                    return;
                }
            }
        }

            

       /* if (Convert.ToInt16(Txt_DueDays.Text) > 0)
        {
            Due_DT = fn.Mydate1(Txt_Due_Date.Text.ToString());
        }*/
        foreach (GridViewRow gridrow in dockdata.Rows)
        {
            CheckBox chkDock = (CheckBox)gridrow.FindControl("chkDock");
            Label billno = (Label)gridrow.FindControl("billno");
            Label LBL_DUE_DT = (Label)gridrow.FindControl("LBL_DUE_DT");
            
            //HiddenField billno = (Label)gridrow.FindControl("billno");
            //Label LBL_DUE_DT = (Label)gridrow.FindControl("LBL_DUE_DT");
             HiddenField Hnd_DUEDT = (HiddenField)gridrow.FindControl("Hnd_DUEDT");
            //HiddenField Hnd_DUEDT_Old = (HiddenField)gridrow.FindControl("Hnd_DUEDT_Old");
           // Due_DT = Hnd_DUEDT_Old.Value.ToString();
           // if (Convert.ToInt16(Txt_DueDays.Text) > 0)
           // {
           //     Due_DT = Hnd_DUEDT.Value.ToString();
           // }
            if (chkDock.Checked)
            {
                Xml_Bill_Submission = Xml_Bill_Submission + "<Submission>";
                Xml_Bill_Submission = Xml_Bill_Submission + "<billno>" + billno.Text.Trim() + "</billno>";
                Xml_Bill_Submission = Xml_Bill_Submission + "<DueDt>" + LBL_DUE_DT.Text.Trim() + "</DueDt>";
                Xml_Bill_Submission = Xml_Bill_Submission + "</Submission> ";
            }
        }
        Xml_Bill_Submission = Xml_Bill_Submission + "</root> ";
        string SQL = "usp_XML_Bill_Submission";
        SqlCommand sqlCmd = new SqlCommand(SQL, conn);
        sqlCmd.CommandType = CommandType.StoredProcedure;
        sqlCmd.Parameters.Add("@BSUBEMPCD", SqlDbType.VarChar).Value = BSUBEMPCD.Trim();
        sqlCmd.Parameters.Add("@Xml_Bill_Submission", SqlDbType.Text).Value = Xml_Bill_Submission.Replace("&", "&amp").Trim();//xmlTHC.Trim();
        sqlCmd.Parameters.Add("@BILLSUBTO", SqlDbType.VarChar).Value = BILLSUBTO.Trim();
        sqlCmd.Parameters.Add("@SUBTOTEL", SqlDbType.VarChar).Value = SUBTOTEL.Trim();
        sqlCmd.Parameters.Add("@bsbdt", SqlDbType.VarChar).Value = bsbdt.Trim();
        //sqlCmd.Parameters.Add("@DueDays", SqlDbType.VarChar).Value = "";// Txt_DueDays.Text.ToString().Trim();
        //sqlCmd.Parameters.Add("@DueDate", SqlDbType.VarChar).Value = "";// Due_DT.ToString().Trim();
 

        SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        da.Dispose();
        string TranXaction = ds.Tables[0].Rows[0]["TranXaction"].ToString();
        Response.Redirect("Billsub_Step2.aspx?billnos=" + TranXaction);
  
    }
    protected void dockdata_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
