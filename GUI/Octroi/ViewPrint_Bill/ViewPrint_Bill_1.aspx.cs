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

public partial class GUI_Finance_MR_cancel_MR_Cancellation_1 : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtbill.Attributes.Add("onblur", "return billBlur('"+ txtbill.ClientID.ToString() +"')");
        txtcust.Attributes.Add("onblur", "return CustBlur('" + txtcust.ClientID.ToString() + "')");
        submit2.Attributes.Add("onclick", "return Check()");

    }
    protected void submit2_Click(object sender, EventArgs e)
    {
        string para;
        para = "b";
        Response.Redirect("ViewPrint_Bill_2.aspx?strbillno=" + txtbill.Text + "&para1=" + para);

    }
    protected void submit3_Click(object sender, EventArgs e)
    {
        //string para;
        //para = "d";
        //Response.Redirect("ViewPrint_Bill_2.aspx?docno=" + txtdoc.Text + "&para1=" + para);
    }
    protected void submit1_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            //DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            //DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[2] + "/" + strArrDtFrom[1] + "/" + strArrDtFrom[0]);
            DateTime dtTo = Convert.ToDateTime(strArrDtTo[2] + "/" + strArrDtTo[1] + "/" + strArrDtTo[0]);

            string strdt = Convert.ToDateTime(strArrDtFrom[2] + "/" + strArrDtFrom[1] + "/" + strArrDtFrom[0]).ToString("yyyy/MM/dd") + " - " + Convert.ToDateTime(strArrDtTo[2] + "/" + strArrDtTo[1] + "/" + strArrDtTo[0]).ToString("yyyy/MM/dd");
            string para;
            para = "a";

            Response.Redirect("ViewPrint_Bill_2.aspx?strcust=" + txtcust.Text + "&strmrtype=" + ddlmrtype.SelectedValue.ToString() + "&strdt=" + strdt + "&para1=" + para);
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
            calfrom.Visible = true;
            calTo.Visible = true;
            txtDateFrom.Text = "";
            txtDateTo.Text = "";
            
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            calfrom.Visible = false;
            calTo.Visible = false;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            calfrom.Visible = false;
            calTo.Visible = false;
           
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            calfrom.Visible = false;
            calTo.Visible = false;
        }
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            calfrom.Visible = false;
            calTo.Visible = false;
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




        //if (diffResult.Days > 31)
        //{
        //    value.IsValid = false;
        //}
        //else
        //{
        //    value.IsValid = true;
        //}
    }
}
