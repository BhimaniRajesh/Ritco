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
using WebX.Controllers;

public partial class GUI_admin_CustomerContractMaster_CopyContract : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn;

    protected void Page_Load(object sender, EventArgs e)
    {
        fn = new MyFunctions();
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString());
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=Session Expired. LogOn Again&reason1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        con.Open();

        if (!IsPostBack)
        {
            imgtick.Style["display"] = "none";
            hdnpaybas.Value = Request.QueryString["paybas"].ToString().ToUpper();

            hdnstartdate.Value = Request.QueryString["startdate"].ToString();
            hdnenddate.Value = Request.QueryString["enddate"].ToString();

            string strpaybasname = "";
            switch (hdnpaybas.Value)
            {
                case "P01":
                    strpaybasname = "PAID";
                    break;
                case "P02":
                    strpaybasname = "TBB";
                    break;
                case "P03":
                    strpaybasname = "TOPAY";
                    break;
            }

            lblcontractid.Text = getContractID();
            lblcustname.Text = Request.QueryString["custcode"].ToString() + "  :  " + fn.Getcustomer(Request.QueryString["custcode"].ToString());
            lblcustname.Text = lblcustname.Text + "  :  " + strpaybasname;
        }

    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        btnsubmit.Style["display"] = "none";


        if (txtcontractid.Text.CompareTo("") == 0)
        {
            if (addContract())
            {
                Response.Redirect("CCM_DisplayResult.aspx?contractid=" + lblcontractid.Text.Trim() + "&custcode=" + Request.QueryString["custcode"].ToString() + "&CCMMode=E");
                return;
            }
        }
        else
        {
            if (copyContract())
            {
                Response.Redirect("CCM_DisplayResult.aspx?contractid=" + lblcontractid.Text.Trim() + "&custcode=" + Request.QueryString["custcode"].ToString() + "&CCMMode=E");
                return;
            }
            else
            {
                //  Response.Redirect("ErrorPage.aspx?heading=Updation Error in Copy Contract.");
                return;
            }
        }


        txtcontractid.Enabled = false;
        btnpopup.Style["display"] = "none";
        lblmessage.Style["display"] = "block";
    }



    private string getContractID()
    {
        string sql = "SELECT contractid FROM webx_custcontract_hdr";
        SqlCommand cmd = new SqlCommand(sql, con);
        SqlDataReader dr = cmd.ExecuteReader();
        string oldcnid = "";
        Int64 ab = 0;
        Int64 greatno = 0;
        while (dr.Read())
        {
            oldcnid = dr["contractid"].ToString();
            if (oldcnid.Length <= 3)
                continue;
            oldcnid = oldcnid.Substring(2, oldcnid.Length - 2);

            ab = Convert.ToInt64(oldcnid);
            if (greatno < ab)
            {
                greatno = ab;
            }

        }
        dr.Close();

        greatno = greatno + 1;
        string newcnid = "CN" + greatno.ToString().PadLeft(10, '0');

        return newcnid;
    }


    protected bool addContract()
    {
        SqlTransaction trn = con.BeginTransaction();
        string sqlstr = "";
        try
        {
            SqlCommand cmd;
            sqlstr = "INSERT INTO webx_custcontract_hdr";
            sqlstr = sqlstr + "(contractid,custcode,contract_type,";
            sqlstr = sqlstr + "Contract_Stdate,Contract_Effectdate,Contract_Eddate,activeflag)";
            sqlstr = sqlstr + " VALUES('" + lblcontractid.Text.Trim() + "','" + Request.QueryString["custcode"].ToString() + "',";
            sqlstr = sqlstr + "'" + hdnpaybas.Value + "','" + fn.Mydate1(hdnstartdate.Value) + "',";
            sqlstr = sqlstr + "'" + fn.Mydate1(hdnstartdate.Value) + "',";
            sqlstr = sqlstr + "'" + fn.Mydate1(hdnenddate.Value) + "','Y')";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            trn.Rollback();
            lblmessage.Text = ex.Message + "\n-->" + sqlstr;
            return false;
        }

        trn.Commit();
        return true;

    }


    protected bool copyContract()
    {
        string sqlstr = "";
        sqlstr = "SELECT contractid FROM webx_custcontract_hdr WHERE contractid='" + txtcontractid.Text + "'";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        string contractid = Convert.ToString(cmd.ExecuteScalar());
        if (contractid.CompareTo("") == 0)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=Contract Doesn't Exist.Improper Contract Selection.");
            return false;
        }


        SqlTransaction trn = con.BeginTransaction();

        try
        {

            DateTime dtstart = new DateTime();
            DateTime dtend = new DateTime();
            string[] start = new string[3];
            string[] end = new string[3];
            start = hdnstartdate.Value.Split('/');
            end = hdnenddate.Value.Split('/');
            dtstart = new DateTime(Convert.ToInt32(start[2]), Convert.ToInt32(start[1]), Convert.ToInt32(start[0]));
            dtend = new DateTime(Convert.ToInt32(end[2]), Convert.ToInt32(end[1]), Convert.ToInt32(end[0]));
            CustContractController.CopyContract(txtcontractid.Text, lblcontractid.Text, Request.QueryString["custcode"].ToString(), hdnpaybas.Value, dtstart, dtend, trn);
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("ErrorPage.aspx?heading=DataBase Updation Error.&detail1=" + ex.Message.Replace('\n', '_') + "&detail2=" + sqlstr);
            return false;
        }

        trn.Commit();
        return true;
    }



}
