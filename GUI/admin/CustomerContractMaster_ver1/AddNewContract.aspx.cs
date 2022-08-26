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

public partial class GUI_admin_CustomerContractMaster_AddNewContract : System.Web.UI.Page
{
    SqlConnection con;
    MyFunctions fn;
    protected void Page_Load(object sender, EventArgs e)
    {
        fn = new MyFunctions();
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        hdncustcode.Value = Request.QueryString["custcode"].ToString();
        lblcustcodename.Text = Request.QueryString["custcode"].ToString() + " : " + fn.Getcustomer(Request.QueryString["custcode"].ToString());
    }



    protected void btnsubmit_Click(object sender, EventArgs e)
    {


        if (cmbpaybas.SelectedValue.CompareTo("") == 0 || cmbpaybas.SelectedValue.CompareTo("0") == 0)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=Payment Basis is not Selected");
            return;
        }

        if (txtstartdate.Text.CompareTo("") == 0 || txtenddate.Text.CompareTo("") == 0)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=Date Range is not Properly Entered.");
            return;
        }

        DateTime dtst, dted;
        try
        {
            string[] arrst = new string[3];
            string[] arred = new string[3];

            arrst = txtstartdate.Text.Split('/');
            arred = txtenddate.Text.Split('/');

            dtst = new DateTime(Convert.ToInt16(arrst[2]), Convert.ToInt16(arrst[1]), Convert.ToInt16(arrst[0]));
            dted = new DateTime(Convert.ToInt16(arred[2]), Convert.ToInt16(arred[1]), Convert.ToInt16(arred[0]));
        }
        catch (Exception ex)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=InValid Date Range Entered.&detail1=" + ex.Message.Replace('\n', '_') + "&detail2=Invalid User Entry for Date");
            return;
        }
        if (dtst >= dted)
        {
            Response.Redirect("../../ErrorPage.aspx?heading=Contract Start Date is Greater than Contract End Date.&detail1=User Entered Wrong Dates&detail2=Invalid User Entry for Date");
            return;
        }


        string sqlstr = "SELECT count(custcode) FROM webx_custcontract_hdr WHERE custcode='" + hdncustcode.Value + "'";
        sqlstr = sqlstr + " AND contract_type='" + cmbpaybas.SelectedValue + "'";
        sqlstr = sqlstr + " AND ((contract_stdate BETWEEN '" + fn.Mydate1(txtstartdate.Text.Trim()) + "' AND '" + fn.Mydate1(txtenddate.Text.Trim()) + "')";
        sqlstr = sqlstr + " OR (contract_eddate BETWEEN '" + fn.Mydate1(txtstartdate.Text.Trim()) + "' AND '" + fn.Mydate1(txtenddate.Text.Trim()) + "'))";
        SqlCommand cmd = new SqlCommand(sqlstr, con);
        // IT WILL RETURN 1 IF CONTRACT PRESENT 0 IF NOT PRESENT
        int cnt = Convert.ToInt16(cmd.ExecuteScalar());
        if (cnt >= 1)
        {
            lblerror.Text = "Contract is Already Present. Please select different Criteria.";
            lblerror.Style["display"] = "block";
        }
        else
        {
            string url = "custcode=" + hdncustcode.Value + "&paybas=" + cmbpaybas.SelectedValue + "&startdate=";
            url = url + txtstartdate.Text.Trim() + "&enddate=" + txtenddate.Text.Trim();
            Response.Redirect("CopyContract.aspx?" + url);
        }

    }
}
