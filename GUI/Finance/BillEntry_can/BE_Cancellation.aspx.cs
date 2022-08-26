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
using System.Web.SessionState;

public partial class octroi_octCustBillStep1 : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public byte byteRadButtonSelection;
    protected void Page_Load(object sender, EventArgs e)
    {
        Button1.Attributes.Add("onclick", "javascript:return Check_Submit()");
      //  submit2.Attributes.Add("onclick", "javascript:return chk2(" + txtadv.ClientID + ")");
        if (!IsPostBack)
        {
            txtDateFrom.Text=System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }
    protected void submit1_Click(object sender, EventArgs e)
    {
         
        if (Page.IsValid == true)
        {

            string FromDtae= fn.Mydate1(txtDateFrom.Text.ToString()) ;
            string ToDtae = fn.Mydate1(txtDateTo.Text.ToString());

            string final = "?FromDtae=" + FromDtae;
            final += "&ToDtae=" + ToDtae;
            final += "&Billtype=" + Billtype.SelectedValue.ToString();
            final += "&Billno=" + txtadv.Text;
            Response.Redirect("BE_Cancellation_2.aspx" + final);
        }

    }

    //protected void submit2_Click(object sender, EventArgs e)
    //{

    //    string para;
    //    para = "m";
    //    Response.Redirect("BE_Cancellation_2.aspx?stradvno=" + txtadv.Text + "&para1=" + para);

    //}

    protected void submit3_Click(object sender, EventArgs e)
    {
        string para;
        para = "d";
       // Response.Redirect("MR_Cancellation_2.aspx?docno=" + txtdoc.Text + "&para1=" + para);

    }
    protected void Billto_SelectedIndexChanged(object sender, EventArgs e)
    {

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
