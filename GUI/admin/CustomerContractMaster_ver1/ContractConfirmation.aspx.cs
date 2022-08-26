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

public partial class GUI_admin_CustomerContractMaster_ContractConfirmation : System.Web.UI.Page
{
    string action = "";
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        fn = new MyFunctions();
        hdncontractid.Value = Request.QueryString["contractid"].ToUpper();
        hdncustcode.Value = Request.QueryString["custcode"].ToUpper();
        lblcustcodename.Text = hdncustcode.Value + " : " + fn.Getcustomer(hdncustcode.Value);
        action = Request.QueryString["action"].ToUpper();


        if (!IsPostBack)
        {

            trtxtdates.Style["display"] = "none";
            trlbldates.Style["display"] = "none";
            trlbldateerror.Style["display"] = "none";
            trstep1.Style["display"] = "none";

            if (action.CompareTo("DEACTIVATE") == 0)
            {
                lbldesc.Text = "Are You sure you want to Deactivate Contract ?";
                optyesno.Items[1].Selected = true;
            }
            else if (action.CompareTo("ACTIVATE") == 0)
            {
                lbldesc.Text = "Are You sure you want to Activate Contract ?";
                optyesno.Items[1].Selected = true;
            }
            else if (action.CompareTo("DELETE") == 0)
            {
                lbldesc.Text = "Are You sure you want to Delete Contract ?";
                optyesno.Items[1].Selected = true;
            }

            lblcontractid.Text = hdncontractid.Value;
        }
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (optyesno.SelectedIndex == 0)
        {
            if (action.CompareTo("DEACTIVATE") == 0)
            {
                SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString());
                con.Open();

                SqlCommand cmd;
                string sqlstr = "UPDATE webx_custcontract_hdr SET activeflag='N' WHERE contractid='" + hdncontractid.Value + "'";
                cmd = new SqlCommand(sqlstr, con);
                cmd.ExecuteNonQuery();
                con.Close();

                divmain.Style["display"] = "none";
                divcomplete.Style["display"] = "block";

                lblfeedback.Text = "Contract DeActivated Successfully !!!";
                Response.Redirect("ContractEditList.aspx?custcode=" + hdncustcode.Value);
            }
            else if (action.CompareTo("ACTIVATE") == 0)
            {
                if (!activateContract())
                    return;

                divmain.Style["display"] = "none";
                divcomplete.Style["display"] = "block";

                lblfeedback.Text = "Contract Activated Successfully !!!";
                Response.Redirect("ContractEditList.aspx?custcode=" + hdncustcode.Value);
            }
            else if (action.CompareTo("DELETE") == 0)
            {

                Response.Redirect("ContractEditList.aspx?custcode=" + hdncustcode.Value);
            }
        }
        else
        {
            Response.Redirect("MainCustomerContractMaster.aspx");
            return;
        }
    }

    protected void btnstep1_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        SqlCommand cmd;
        string sqlstr = "";

        try
        {
            System.Globalization.CultureInfo enGB = new System.Globalization.CultureInfo("en-GB");
            DateTime dtfrom = Convert.ToDateTime(txtfrom.Text, enGB);
            DateTime dtto = Convert.ToDateTime(txtto.Text, enGB);
        }
        catch (Exception ex)
        {
            Response.Redirect("ErrorPage.aspx?heading=Date Range is not properly Entered. Further Enter Dates&reson1="+ ex.Message.Replace('\n','_'));
            return;
        }
        

        // GETTING CONTRACT TYPE
        sqlstr = "UPDATE webx_custcontract_hdr SET ";
        sqlstr = sqlstr + "contract_effectdate='" + fn.Mydate1(txtfrom.Text) + "',";
        sqlstr = sqlstr + "contract_eddate='" + fn.Mydate1(txtto.Text) + "'";
        sqlstr = sqlstr + " WHERE contractid='" + hdncontractid.Value + "' AND custcode='" + hdncustcode.Value + "'";
        cmd = new SqlCommand(sqlstr, con);
        cmd.ExecuteNonQuery();

        Response.Redirect("ContractConfirmation.aspx?action=ACTIVATE&contractid=" + hdncontractid.Value + "&custcode=" + hdncustcode.Value);
    }

    protected bool activateContract()
    {
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        SqlCommand cmd;
        string sqlstr = "", contracttype = "", fromdate = "", todate = "";

        //// GETTING CONTRACT TYPE
        //sqlstr = "SELECT contract_type,CONVERT(VARCHAR,contract_effectdate,103) AS fromdate,";
        //sqlstr = sqlstr + "CONVERT(VARCHAR,contract_eddate,103) AS todate FROM webx_custcontract_hdr WHERE contractid='" + hdncontractid.Value + "' AND custcode='" + hdncustcode.Value + "'";
        //cmd = new SqlCommand(sqlstr, con);
        //SqlDataReader dr = cmd.ExecuteReader();
        //while (dr.Read())
        //{
        //    contracttype = Convert.ToString(dr["contract_type"]);
        //    fromdate = Convert.ToString(dr["fromdate"]);
        //    todate = Convert.ToString(dr["todate"]);
        //}
        //dr.Close();

        //txtfrom.Text = fromdate;
        //txtto.Text = todate;

        //sqlstr = "SELECT contractid FROM webx_custcontract_hdr WHERE (getdate() BETWEEN contract_effectdate AND contract_eddate) AND contractid='" + hdncontractid.Value + "' AND custcode='" + hdncustcode.Value + "'";
        //cmd = new SqlCommand(sqlstr, con);
        //string flag = Convert.ToString(cmd.ExecuteScalar());
        //if (flag.CompareTo("") == 0)
        //{
        //    trtxtdates.Style["display"] = "block";
        //    trlbldates.Style["display"] = "block";
        //    trlblconfirm.Style["display"] = "none";
        //    troptconfirm.Style["display"] = "none";
        //    lbldateerror.Text = "Contract has not valid Date Range. Change Date Range to Contine.... ";
        //    trlbldateerror.Style["display"] = "block";
        //    trstep1.Style["display"] = "block";
        //    trsubmit.Style["display"] = "none";
        //    return false;
        //}

        //sqlstr = "SELECT contractid FROM webx_custcontract_hdr WHERE (getdate() BETWEEN contract_effectdate AND contract_eddate) AND contractid<>'" + hdncontractid.Value + "' AND custcode='" + hdncustcode.Value + "' AND contract_type='" + contracttype + "' AND activeflag='Y'";
        //cmd = new SqlCommand(sqlstr, con);
        //string dupl_contract = Convert.ToString(cmd.ExecuteScalar());
        //if (dupl_contract.CompareTo("") != 0)
        //{
        //    trtxtdates.Style["display"] = "block";
        //    trlbldates.Style["display"] = "block";
        //    trlblconfirm.Style["display"] = "none";
        //    troptconfirm.Style["display"] = "none";
        //    trsubmit.Style["display"] = "none";
        //    lbldateerror.Text = "Another Contract <font class='redfnt'>" + dupl_contract + "</font> has same Date Range and Paybas.<br /> Change Date Range to Contine.... ";
        //    trlbldateerror.Style["display"] = "block";
        //    trstep1.Style["display"] = "block";
        //    return false;
        //}

        sqlstr = "UPDATE webx_custcontract_hdr SET activeflag='Y' WHERE contractid='" + hdncontractid.Value + "' AND custcode='" + hdncustcode.Value + "'";
        cmd = new SqlCommand(sqlstr, con);
        cmd.ExecuteNonQuery();

        con.Close();

        return true;
    }
}
