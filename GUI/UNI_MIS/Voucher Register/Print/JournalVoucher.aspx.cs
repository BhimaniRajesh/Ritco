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

public partial class GUI_Finance_DebitCredit_JournalVoucher : System.Web.UI.Page
{
    SqlConnection con;
    
    // CONSTANT DECLARATIONS
    string YEAR_SUFFIX = "",TBL_NAME="";

    string voucherno = "",transtype="",autoentry="",printyn="";
    protected void Page_Load(object sender, EventArgs e)
    {

        NumberToText ntt = new NumberToText();

        string branch="";
        MyFunctions fn = new MyFunctions();
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        voucherno=Request.QueryString["voucherno"].ToString();
        printyn =Request.QueryString["printyn"].ToString();
        lblvoucherno.Text = voucherno;

        // YEAR_SUFFIX IS CONSTANT DESCRIBING CURRENT FINANCIAL YEAR
        string YEAR_SUFFIX = "";
        if (DateTime.Now.Month < 4)
            YEAR_SUFFIX = Convert.ToString((DateTime.Now.Year - 1)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year)).Substring(2, 2);
        else
            YEAR_SUFFIX = Convert.ToString((DateTime.Now.Year)).Substring(2, 2) + "_" + Convert.ToString((DateTime.Now.Year + 1)).Substring(2, 2);

        YEAR_SUFFIX = "07_08";


        // QUERY FOR FINDING TRANSTYPE BECAUSE IT IS NOT AVAILABE BY FORE-END
        string sql = "SELECT * FROM webx_acctrans_" + YEAR_SUFFIX + " WHERE voucherno='" + voucherno + "'";
        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataReader dr=cmd.ExecuteReader();
        while (dr.Read())
        {
            transtype = dr["transtype"].ToString();
        }
        dr.Close();




        // TABLE SELECTION DEPENDING transtype
        if (transtype.ToUpper().CompareTo("NORMAL") == 0)
            TBL_NAME = "webx_vouchertrans";
        else
            TBL_NAME = "webx_acctrans_" + YEAR_SUFFIX;






        // QUERY FOR DATA FILLING
        if (transtype.ToUpper().CompareTo("JOURNAL") != 0 && transtype.ToUpper().CompareTo("CONTRA") != 0)
            sql = "SELECT * FROM " + TBL_NAME + " WHERE voucherno='" + voucherno + "'";
        else
            sql = "SELECT convert(varchar,transdate,6) AS transdate,* FROM " + TBL_NAME + " WHERE voucherno='" + voucherno + "' AND transtype='" + transtype + "'";

       



        // TO GET AUTO ENTRY AND TRANSTYPE FUTHER  --  I DON'T UNDERSTAND WHY WE GET transtype TWICE
        cmd = new SqlCommand(sql,con);
        dr = cmd.ExecuteReader();
        
        // THIS LABEL WE ARE GOING TO PRINT NARRATION AFTER PRINTING ALL DEBIT-CREDIT
        Label lbl = new Label();

        while(dr.Read())
        {
            transtype = dr["transtype"].ToString();
            autoentry = dr["autoentry"].ToString();
            lblvoucherdate.Text = dr["transdate"].ToString();
            lblbranchcode.Text = dr["brcd"].ToString();
            branch = dr["brcd"].ToString();
            lblbranchname.Text = fn.GetLocation(dr["brcd"].ToString());
            lbl.Text = dr["narration"].ToString();
        }
        dr.Close();


        // UpdatePrintFolder FUNCTION WAS NOT FOUNDED
        string n = "";
        if (autoentry.ToUpper().CompareTo("N") == 0)
        { 
            //n=UpdatePrintFolder("VS",voucherno);
            if (n.ToUpper().CompareTo("FRESH") == 0)
                lbljnvoucher.Text = "";
            else
                lbljnvoucher.Text = "[ Automatic - Not For Payment ]";
        }

        if (autoentry.ToUpper().CompareTo("N") == 0)
        {
            lbljnvoucher.Text = "[ Not For Payment ]";
        }
        else
            lbljnvoucher.Text = "[ Not For Payment ]";

        
///////////////////////////////////////////////DEBIT FILLER//////////////////////////////////////////////////




        // I DON'T UNDERSTAND FLOW I AM DOING SAME AS ASP
        
        string acccoded = ""; // TO USE IN FOLLOWING QUERY AS NOT IN 
        sql = "SELECT acccode,SUM(debit) AS debit FROM " + TBL_NAME + " WHERE voucherno='" + voucherno + "' AND transtype='" + transtype + "' AND brcd='" + Session["brcd"].ToString() + "' AND debit>0 GROUP BY acccode HAVING COUNT(acccode)>1";
        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            acccoded = dr["acccode"].ToString();
        }
        dr.Close();



        // SAME QUERY FROM ASP THAT GENERATE DEBIT LIST IN TABLE
        string s = "SELECT accdesc=(select accdesc from webx_acctinfo where acccode=a.acccode),* FROM webx_acctrans_" + YEAR_SUFFIX + " a WHERE a.voucherno='" + voucherno + "' AND a.transtype='" + transtype + "' AND a.debit>0 AND a.acccode NOT IN('" + acccoded + "')";
        cmd = new SqlCommand(s, con);
        dr = cmd.ExecuteReader();
        double totdebit = 0, totcredit = 0;

       while (dr.Read())
        {
            TableRow tr = new TableRow();

            TableCell tc1 = new TableCell();
            TableCell tc2 = new TableCell();
            TableCell tc3 = new TableCell();
            TableCell tc4 = new TableCell();

            Label lblacccode = new Label();
            Label lblaccname = new Label();
            Label lbldebit = new Label();

            lblacccode.CssClass = "blackfnt";
            lblaccname.CssClass = "blackfnt";
            lbldebit.CssClass = "blackfnt";

            lblacccode.Text = dr["acccode"].ToString(); // dr["acccode"].ToString();
            lblaccname.Text=dr["accdesc"].ToString();
            lbldebit.Text = Convert.ToDouble( dr["debit"].ToString()).ToString("F2");

            tc1.Controls.Add(lblacccode);
            tc2.Controls.Add(lblaccname);
            tc3.CssClass = "blackfnt";
            tc3.Text = "DR";
            
            tc4.Controls.Add(lbldebit);

            tc1.HorizontalAlign = HorizontalAlign.Left;
            tc2.HorizontalAlign = HorizontalAlign.Left;
            tc3.HorizontalAlign = HorizontalAlign.Left;
            tc4.HorizontalAlign = HorizontalAlign.Right;

            tr.Cells.Add(tc1);
            tr.Cells.Add(tc2);
            tr.Cells.Add(tc3);
            tr.Cells.Add(tc4);

            tr.BackColor = System.Drawing.Color.White;
            tblacclist.Rows.Add(tr);
            totdebit = totdebit + Convert.ToDouble(dr["debit"].ToString());
        }
        dr.Close();

        TableRow trtot = new TableRow();

        TableCell tctot1 = new TableCell();
        TableCell tctot2 = new TableCell();
        TableCell tctot3 = new TableCell();
        TableCell tctot4 = new TableCell();

        tctot3.Text = "TOTAL :";
        tctot3.HorizontalAlign = HorizontalAlign.Right;
        tctot3.CssClass = "blackfnt";
        tctot3.Style["font-weight"] = "bold";


        tctot4.HorizontalAlign = HorizontalAlign.Right;
        tctot4.Text = totdebit.ToString("F2");
        tctot4.CssClass = "blackfnt";
        tctot4.Style["font-weight"] = "bold";

        trtot.Cells.Add(tctot1);
        trtot.Cells.Add(tctot2);
        trtot.Cells.Add(tctot3);
        trtot.Cells.Add(tctot4);

        trtot.BackColor = System.Drawing.Color.White;
        tblacclist.Rows.Add(trtot);




///////////////////////////////////////////////CREDIT FILLER//////////////////////////////////////////////////



        // I DON'T UNDERSTAND FLOW I AM DOING SAME AS ASP

        acccoded = ""; // TO USE IN FOLLOWING QUERY AS NOT IN 
        sql = "SELECT acccode,SUM(credit) AS credit FROM " + TBL_NAME + " WHERE voucherno='" + voucherno + "' AND transtype='" + transtype + "' AND brcd='" + Session["brcd"].ToString() + "' AND credit>0 GROUP BY acccode HAVING COUNT(acccode)>1";
        cmd = new SqlCommand(sql, con);
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            acccoded = dr["acccode"].ToString();
        }
        dr.Close();



        // SAME QUERY FROM ASP THAT GENERATE DEBIT LIST IN TABLE
        s = "SELECT accdesc=(select accdesc from webx_acctinfo where acccode=a.acccode),* FROM webx_acctrans_" + YEAR_SUFFIX + " a WHERE a.voucherno='" + voucherno + "' AND a.transtype='" + transtype + "' AND a.credit>0 AND a.acccode NOT IN('" + acccoded + "')";
        cmd = new SqlCommand(s, con);
        dr = cmd.ExecuteReader();
        totdebit = 0; totcredit = 0;

        while (dr.Read())
        {
            TableRow tr = new TableRow();

            TableCell tc1 = new TableCell();
            TableCell tc2 = new TableCell();
            TableCell tc3 = new TableCell();
            TableCell tc4 = new TableCell();

            Label lblacccode = new Label();
            Label lblaccname = new Label();
            Label lbldebit = new Label();

            lblacccode.CssClass = "blackfnt";
            lblaccname.CssClass = "blackfnt";
            lbldebit.CssClass = "blackfnt";

            lblacccode.Text = dr["acccode"].ToString(); // dr["acccode"].ToString();
            lblaccname.Text = dr["accdesc"].ToString();
            lbldebit.Text = dr["credit"].ToString();

            tc1.Controls.Add(lblacccode);
            tc2.Controls.Add(lblaccname);
            tc3.CssClass = "blackfnt";
            tc3.Text = "CR";
            tc4.Controls.Add(lbldebit);

            tc1.HorizontalAlign = HorizontalAlign.Left;
            tc2.HorizontalAlign = HorizontalAlign.Left;
            tc3.HorizontalAlign = HorizontalAlign.Left;
            tc4.HorizontalAlign = HorizontalAlign.Right;

            tr.Cells.Add(tc1);
            tr.Cells.Add(tc2);
            tr.Cells.Add(tc3);
            tr.Cells.Add(tc4);

            tr.BackColor = System.Drawing.Color.White;
            tblacclist.Rows.Add(tr);
            totcredit = totcredit + Convert.ToDouble(dr["credit"].ToString());
        }
        dr.Close();

         trtot = new TableRow();

         tctot1 = new TableCell();
         tctot2 = new TableCell();
         tctot3 = new TableCell();
         tctot4 = new TableCell();

        tctot3.Text = "TOTAL :";
        tctot3.HorizontalAlign = HorizontalAlign.Right;
        tctot3.CssClass = "blackfnt";
        tctot3.Style["font-weight"] = "bold";


        tctot4.HorizontalAlign = HorizontalAlign.Right;
        tctot4.Text = totcredit.ToString("F2");
        tctot4.CssClass = "blackfnt";
        tctot4.Style["font-weight"] = "bold";

        trtot.Cells.Add(tctot1);
        trtot.Cells.Add(tctot2);
        trtot.Cells.Add(tctot3);
        trtot.Cells.Add(tctot4);

        trtot.BackColor = System.Drawing.Color.White;
        tblacclist.Rows.Add(trtot);




        //////////////////////NARRATION AND NUMEBR IN WORDS////////////////////////////////////////
        tctot3 = new TableCell();
        
        tctot3.Controls.Add(lbl);
        tctot3.CssClass = "blackfnt";
        tctot3.ColumnSpan = 3;
        tctot3.HorizontalAlign = HorizontalAlign.Left;

        tctot4 = new TableCell();
        tctot4.Text = "NARRATION ";
        tctot4.CssClass = "blackfnt";
        tctot4.HorizontalAlign = HorizontalAlign.Left;

        trtot = new TableRow();
        trtot.BackColor = System.Drawing.Color.White;

        trtot.Cells.Add(tctot4);
        trtot.Cells.Add(tctot3);

        tblacclist.Rows.Add(trtot);



        tctot3 = new TableCell();
        tctot4 = new TableCell();

        trtot = new TableRow();
        trtot.BackColor = System.Drawing.Color.White;

        tctot4.ColumnSpan = 3;

        tctot3.CssClass = "blackfnt";
        tctot4.CssClass = "blackfnt";

        tctot3.HorizontalAlign = HorizontalAlign.Left;
        tctot4.HorizontalAlign = HorizontalAlign.Left;

        tctot3.Text = "Rupees in Words";
        tctot4.Text = ntt.numberToText(totcredit.ToString("F2"));

        trtot.Cells.Add(tctot3);
        trtot.Cells.Add(tctot4);

        tblacclist.Rows.Add(trtot);

        ////////////////////////LAST LINE PASSED BY AND CERTIFIED BY
        tctot3 = new TableCell();
        tctot4 = new TableCell();

        trtot = new TableRow();
        trtot.BackColor = System.Drawing.Color.White;

        tctot3.ColumnSpan = 2;
        tctot4.ColumnSpan = 2;
        
        tctot3.CssClass = "blackfnt";
        tctot4.CssClass = "blackfnt";

        tctot3.HorizontalAlign = HorizontalAlign.Left;
        tctot4.HorizontalAlign = HorizontalAlign.Left;

        tctot3.Text = "PASSED BY :";
        tctot4.Text = "CERTIFIED BY :";

        trtot.Cells.Add(tctot3);
        trtot.Cells.Add(tctot4);

        tblacclist.Rows.Add(trtot);
    }
}
