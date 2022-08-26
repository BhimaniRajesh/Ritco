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

public partial class GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Result_Trailbalance : System.Web.UI.Page
{

    SqlConnection conn;
    double totOpndeb = 0, totopnCre = 0, totCurrdeb = 0, totCurrCre = 0, totClosedeb = 0, totCloseCre = 0;
    public static string strDateRange,abc, strCust, strro, ledgerof, strindividual,mFromdt, acccode,partyList, strflow, RPT_flag, mAcctTransTable, yearSuffix, YearString;
    protected void Page_Load(object sender, EventArgs e)
    {
        

        if (!IsPostBack)
        {
            String Year = Session["FinYear"].ToString();

             abc = Year.Substring(2, 2);
            //Response.Write("<br>Year " + Year);
            //Response.Write("<br>Year " + abc);
            // Response.End();
            string CloseYear = Convert.ToString((Convert.ToInt16(abc) + 1));
            if (CloseYear.Length == 1)
            {
                CloseYear = "0" + CloseYear;
            }
            YearString = Convert.ToString(abc) + "_" + Convert.ToString(CloseYear);
            yearSuffix = YearString;
            string finyearstart = "01 APR " + abc;

            mAcctTransTable = "webx_acctrans_" + yearSuffix;


            strDateRange = Request.QueryString["DOCDate"].ToString();
            lblseldet.Text = strDateRange;
            strro = Request.QueryString["RO"].ToString();
            lblro.Text = strro;
            strCust = Request.QueryString["Cust"];
            lblcust.Text = strCust;

            if (strCust == "")
            {
                strCust = "";
                lblcust.Text = "All";



                lblcustRow.Visible = true;
            }

            RPT_flag = Request.QueryString["RPT_flag"].ToString();
            strflow = Request.QueryString["strflowtype"].ToString();

            if (RPT_flag == "C")
            {
                ledgerof = "C";
                acccode = "CDA0001";
                partyList = strCust.ToString();
                //lblloc.Text = acccode;
            }

            if (RPT_flag == "V")
            {
                ledgerof = "V";
                acccode = Request.QueryString["AcctCd_v"].ToString();
                partyList = strCust.ToString();
                //lblloc.Text = acccode;
            }

            if (RPT_flag == "E")
            {
                ledgerof = "E";
                acccode = Request.QueryString["AcctCd_v"].ToString();
                partyList = strCust.ToString();
                //lblloc.Text = acccode;
            }

            
            if (strflow.ToString() == "0")
            {
                strindividual = "Y";
            }
            else
            {
                strindividual = "N";
            }

            
        }


        DisplayDocFlow();
        
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        
                GridView1.PageIndex = e.NewPageIndex;
           
           

        DisplayDocFlow();


    }

    private void DisplayDocFlow()
    {

        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        String SQL_ACC = "select Accdesc from webx_acctinfo where Acccode='" + acccode + "'";
        SqlCommand cmd1 = new SqlCommand(SQL_ACC, conn);
        SqlDataReader dread = cmd1.ExecuteReader();
        {

            while (dread.Read())
            {
                String Accdesc = dread.GetValue(0).ToString();
                lblloc.Text = acccode + " : " + Accdesc;
            }

        }
        dread.Close();



        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = conn;
        sqlCommand.CommandType = CommandType.StoredProcedure;
        mFromdt = "01 APR " + abc;

        sqlCommand.CommandText = "usp_trialbalance_subsidiary_new_ver1";
        //sqlCommand.CommandText = "usp_trialbalance_subsidiary_new";

        string[] strArrDtFromTo = strDateRange.Split('-');
        sqlCommand.Parameters.AddWithValue("@mTableName_Trans", mAcctTransTable);
        sqlCommand.Parameters.AddWithValue("@brcd", strro);
        sqlCommand.Parameters.AddWithValue("@datefrom", mFromdt);
        sqlCommand.Parameters.AddWithValue("@dateto", strArrDtFromTo[0]);
        sqlCommand.Parameters.AddWithValue("@closedt", strArrDtFromTo[1]);
        sqlCommand.Parameters.AddWithValue("@individual", strindividual);
        sqlCommand.Parameters.AddWithValue("@acccode", acccode);
        sqlCommand.Parameters.AddWithValue("@yearSuffix", yearSuffix);
        sqlCommand.Parameters.AddWithValue("@partytype", ledgerof);
        sqlCommand.Parameters.AddWithValue("@partyList", partyList);
               


        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();

        sqlDA.Fill(ds);

        GridView1.DataSource = ds;
        GridView1.DataBind();


        GridView1.Visible = true;

        conn.Close();

    }


    protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblopndb = (Label)e.Row.FindControl("lblopendebit");
            Label lblopncr = (Label)e.Row.FindControl("lblopencredit");
            Label lblcurrdb = (Label)e.Row.FindControl("lbltransdebit");
            Label lblcurrcr = (Label)e.Row.FindControl("lbltranscredit");
            Label lblclosedb = (Label)e.Row.FindControl("lblcloseDebit");
            Label lblclosecr = (Label)e.Row.FindControl("lblcloseCredit");
            
            totOpndeb = totOpndeb + Convert.ToDouble(lblopndb.Text.ToString());
            totopnCre = totopnCre + Convert.ToDouble(lblopncr.Text.ToString());
            totCurrdeb = totCurrdeb + Convert.ToDouble(lblcurrdb.Text.ToString());
            totCurrCre = totCurrCre + Convert.ToDouble(lblcurrcr.Text.ToString());
            totClosedeb = totClosedeb + Convert.ToDouble(lblclosedb.Text.ToString());
            totCloseCre = totCloseCre + Convert.ToDouble(lblclosecr.Text.ToString());
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lbltotopndb = (Label)e.Row.FindControl("lblTOTopendebit");
            Label lbltotopncr = (Label)e.Row.FindControl("lblTOTopencredit");
            Label lbltotcurrdb = (Label)e.Row.FindControl("lblTOTtransdebit");
            Label lbltotcurrcr = (Label)e.Row.FindControl("lblTOTtranscredit");
            Label lbltotclosedb = (Label)e.Row.FindControl("lblTOTcloseDebit");
            Label lbltotclosecr = (Label)e.Row.FindControl("lblTOTcloseCredit");
            
            lbltotopndb.Text = totOpndeb.ToString("F2");
            lbltotopncr.Text = totopnCre.ToString("F2");
            lbltotcurrdb.Text = totCurrdeb.ToString("F2");
            lbltotcurrcr.Text = totCurrCre.ToString("F2");
            lbltotclosedb.Text = totClosedeb.ToString("F2");
            lbltotclosecr.Text = totCloseCre.ToString("F2");

             totOpndeb = 0;
            totopnCre = 0;
            totCurrdeb =0;
            totCurrCre = 0;
            totClosedeb =0;
            totCloseCre = 0;
        }

       
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        int ind = 0;
        int a = 0;
        try
        {

            GridView1.AllowPaging = false;
            GridView1.BorderWidth = 1;
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment;Filename=TrailBalance_PartyWise.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            DisplayDocFlow();
            GridView1.RenderControl(hw);


            Response.Write(tw.ToString());
            Response.End();

        }
        catch (Exception ex1)
        {
            throw ex1;
            // lblloc.Text = ex1.Message;
        }

    }
}
