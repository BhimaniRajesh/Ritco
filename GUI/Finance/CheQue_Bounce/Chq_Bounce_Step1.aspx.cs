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
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Finance_Accounts_Debit_Voucher_DebitVoucher : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataReader dr;
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    DateFunction DAccess = new DateFunction();
    public static string  opertitle = "MANUAL DEBIT VOUCHER", Defaultdate="";
    public string cnt = "0";
    public static int Total_Count = 0;
    string Chqdate = "", Chqno = "";
    string Financial_Year = "", fin_year = "", TableName = "";
    double fin_year_next = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        MsgBox.Hide();
        Financial_Year = Session["FinYear"].ToString().Substring(2, 2);
        fin_year = Session["FinYear"].ToString();
        fin_year_next = Convert.ToDouble(Financial_Year) + 1;
        fin_year = Financial_Year + "_" + fin_year_next.ToString().PadLeft(2, '0');
        TableName = "Webx_acctrans_" + fin_year;
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
     //   SHR();
        con.Close();

        Button1.Attributes.Add("onclick", "javascript:return Chq_Submit()");

        TxtChqNo.Attributes.Add("onblur", "javascript:Chq_valid_YN()");
        TxtChqdt.Attributes.Add("onblur", "javascript:Chq_valid_YN()");
        btnSubmit.Attributes.Add("onclick", "javascript:return Chq_Bounce_Validate()");
         
        TxtBounceDate.CssClass = "blackfnt";
        TxtChqNo.CssClass = "blackfnt";
        TxtChqdt.CssClass = "blackfnt";
        

    }
    public void SHR()
    {
        string sql = "USP_Chq_Bounce_SHOW_Document";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataAdapter myAdapter = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;
        Chqdate = fn.Mydate1(TxtChqdt.Text.ToString());
        Chqno = TxtChqNo.Text.ToString();
        myAdapter.SelectCommand.Parameters.Add("@Chqno", SqlDbType.VarChar).Value = Chqno;//"004302"; //
        myAdapter.SelectCommand.Parameters.Add("@Chqdt", SqlDbType.VarChar).Value = Chqdate;// "23 APr 08";//
        DataSet ds = new DataSet();
        myAdapter.Fill(ds, "billdata");
        Total_Count = ds.Tables[0].Rows.Count;
        //hnd_Count.Value = ds.Tables[0].Rows.Count.ToString();
        dockdata.DataSource = ds;
        dockdata.DataBind();

        sql = "USP_Chq_Details";
        cmd = new SqlCommand(sql, con);
        SqlDataAdapter myAdapter2 = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;
        //string Chqdate = fn.Mydate1(TxtChqdt.Text.ToString()), Chqno = TxtChqNo.Text.ToString();
        myAdapter2.SelectCommand.Parameters.Add("@Chqno", SqlDbType.VarChar).Value = Chqno;//"004302"; //
        myAdapter2.SelectCommand.Parameters.Add("@Chqdt", SqlDbType.VarChar).Value = Chqdate;// "23 APr 08";//
        DataSet ds2 = new DataSet();
        myAdapter2.Fill(ds2, "billdata2");
        // Total_Count = ds1.Tables[0].Rows.Count;
        //hnd_Count.Value = ds2.Tables[0].Rows.Count.ToString();
        GR_Chq_details.DataSource = ds2;
        GR_Chq_details.DataBind();
        if (Total_Count > 0)
        {
            sql = "USP_Chq_Deposit_Details";
            cmd = new SqlCommand(sql, con);
            SqlDataAdapter myAdapter1 = new SqlDataAdapter(cmd);
            cmd.CommandType = CommandType.StoredProcedure;
            //string Chqdate = fn.Mydate1(TxtChqdt.Text.ToString()), Chqno = TxtChqNo.Text.ToString();
            myAdapter1.SelectCommand.Parameters.Add("@Chqno", SqlDbType.VarChar).Value = Chqno;//"004302"; //
            myAdapter1.SelectCommand.Parameters.Add("@Chqdt", SqlDbType.VarChar).Value = Chqdate;// "23 APr 08";//
            myAdapter1.SelectCommand.Parameters.Add("@TableName", SqlDbType.VarChar).Value = TableName;// "23 APr 08";//
            DataSet ds1 = new DataSet();
            myAdapter1.Fill(ds1, "billdata1");
            // Total_Count = ds1.Tables[0].Rows.Count;
            hnd_Count.Value = ds1.Tables[0].Rows.Count.ToString();
            GR_DepoDetail.DataSource = ds1;
            GR_DepoDetail.DataBind();
        }
       


        Grid_row0.Visible = true;
        Grid_row1.Visible = true;
        Grid_row3.Visible = true;
        Grid_row5.Visible = true;
        Grid_row6.Visible = true;
        Grid_row7.Visible = true;
        if (Total_Count > 0)
        {
            BounceDate_Row.Visible = true;
            TxtBounceDate.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            Grid_row2.Visible = true;
            TxtChqdt.Enabled = false;
            TxtChqNo.Enabled = false;
            Button1.Enabled = false;
        }
    }
    protected void ShowResult(object sender, EventArgs e)
    {
        
        

        con.Open();
        SHR();
        con.Close();


       
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();
         
         TableName = "Webx_acctrans_" + fin_year;
         SqlTransaction trans;
         trans = con.BeginTransaction();
         string Sql_insert = "";
         string Bouncedtae = fn.Mydate1(TxtBounceDate.Text);
         Chqdate = fn.Mydate1(TxtChqdt.Text.ToString());
         Chqno = TxtChqNo.Text.ToString();
         try
         {
             string Flag = Check_Cheque_Bounce(Chqno, Chqdate);
             if (Flag == "Y")
             {
                 string ErrorMsg = "This Cheque Already Bounced";
                 throw new Exception(ErrorMsg);
             }
             Sql_insert = "Exec USP_Chq_Bounce_Updation 1,'" + Chqno + "','" + Chqdate + "','" + Bouncedtae + "','" + Session["empcd"].ToString() + "','" + Session["finyear"].ToString() + "'";
             SqlCommand cmd = new SqlCommand(Sql_insert, con, trans);
             cmd.ExecuteNonQuery();

             Sql_insert = "Exec USP_Chq_Bounce_Updation 2,'" + Chqno + "','" + Chqdate + "','" + Bouncedtae + "','" + Session["empcd"].ToString() + "','" + Session["finyear"].ToString() + "'";
             cmd = new SqlCommand(Sql_insert, con, trans);
             cmd.ExecuteNonQuery();

             Sql_insert = "Exec USP_Chq_Bounce_Reverese_Accounting 1,'" + Chqno + "','" + Chqdate + "','" + TableName + "','" + Session["empcd"].ToString() + "','" + Session["finyear"].ToString() + "'";
             cmd = new SqlCommand(Sql_insert, con, trans);
             cmd.ExecuteNonQuery();
             //SqlDataReader dr_mr_type;
             //dr_mr_type = cmd.ExecuteReader();


             //while (dr_mr_type.Read())
             //{
             //   string Mrstype = dr_mr_type.GetValue(0).ToString();
             //}
             //dr_mr_type.Close(); 
             


             Sql_insert = "Exec USP_Chq_Bounce_Reverese_Accounting 2,'" + Chqno + "','" + Chqdate + "','" + TableName + "','" + Session["empcd"].ToString() + "','" + Session["finyear"].ToString() + "'";
             cmd = new SqlCommand(Sql_insert, con, trans);
             cmd.ExecuteNonQuery();

             Sql_insert = "Exec USP_Chq_Bounce_Updation 3,'" + Chqno + "','" + Chqdate + "','" + Bouncedtae + "','" + Session["empcd"].ToString() + "','" + Session["finyear"].ToString() + "'";
             cmd = new SqlCommand(Sql_insert, con, trans);
             cmd.ExecuteNonQuery();
             //  trans.Rollback();
            trans.Commit();
            con.Close();
            Response.Redirect("./BOUNCE_Done.aspx?Chqno=" + Chqno + "&ChqDate=" + Chqdate, false);

         }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            MsgBox.Show(msg);
            trans.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }

    }
    public static string Check_Cheque_Bounce(string ChqNo,string ChqDate)
    {
        string Cnt = "";
        string Sql = "EXEC Usp_Check_Cheque_Bounce '" + ChqNo + "','" + ChqDate + "'";
        //DataSet ds = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        object Obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Sql);
        if (Obj != null)
            Cnt = Obj.ToString();
        return Cnt;
    }
}
