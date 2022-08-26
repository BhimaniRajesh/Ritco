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

public partial class GUI_Finance_Bill_MR_Cancellation_Bill_MR_Cancellation_step_1 : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    MyFunctions fn = new MyFunctions();
    public byte byteRadButtonSelection;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con.Open();

        Button1.Attributes.Add("onclick", "javascript:return Check_Submit()");
        if (!IsPostBack)
        {
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            showBillMrtype();
            lblbillmrno.Text = "Enter Bill No. :";
            lblbillmrtype.Text = "Bill Type :";
        }
    }
    protected void submit1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            string FromDtae = fn.Mydate1(txtDateFrom.Text.ToString());
            string ToDtae = fn.Mydate1(txtDateTo.Text.ToString());
            string final = "";
            if (radbillselection.Checked == true)
            {
                final = "?FromDtae=" + FromDtae;
                final += "&ToDtae=" + ToDtae;
                final += "&Billtype=" + ddrbillmrtype.SelectedValue.ToString();
                final += "&BillNO=" + txtBillMrNo.Text;
                Response.Redirect("Bill_Cancellation_step_2.aspx" + final);
            }
            if (radmrselection.Checked == true)
            {
                final = "?FromDtae=" + FromDtae;
                final += "&ToDtae=" + ToDtae;
                final += "&MRStype=" + ddrbillmrtype.SelectedValue.ToString();
                final += "&MRSNO=" + txtBillMrNo.Text;
                Response.Redirect("Mr_Cancellation_step_2.aspx" + final);
            }
        }
    }
    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
        }

    }
    public void daterange(object source, ServerValidateEventArgs value)
    {

        if (txtDateFrom.Text == "")
        {
            value.IsValid = false;
            return;
        }
        if (txtDateTo.Text == "")
        {
            value.IsValid = false;
            return;
        }

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));
        System.TimeSpan diffResult = dt2.Subtract(dt1);


        if (dt1 > dt2)
        {
            CustomValidator1.ErrorMessage = "From Date can not be Less then To date";
            value.IsValid = false;
            return;

        }
    }
    protected void showDetails(object sender, EventArgs e)
    {
        showBillMrtype();
    }
    protected void showBillMrtype()
    {
        string sql = "";
        txtBillMrNo.Text = "";
        if (radbillselection.Checked == true)
        {
            lblbillmrno.Text = "Enter Bill No. :";
            lblbillmrtype.Text = "Bill Type :";
            sql = "select '' as Codeid,'Select' as CodeDesc union select Codeid,CodeDesc from webx_master_general where codetype='billtyp' and statuscode='Y' and Codeid in('2','6','7')";
        }
        else if(radmrselection.Checked == true)
        {
            lblbillmrno.Text = "Enter MR No. :";
            lblbillmrtype.Text = "MR Type :";
            sql = "select '' as Codeid,'Select' as CodeDesc union select Codeid,CodeDesc from webx_master_general where codetype='mrstype' and statuscode='Y' and Codeid in('4')";
        }

        cmd = new SqlCommand(sql, con);
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        ddrbillmrtype.Items.Clear();
        while (dr.Read())
        {
            ddrbillmrtype.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
        }
        dr.Close();
    }
    protected void showtype(object sender, EventArgs e)
    {
        showBillMrtype();
    }
}
