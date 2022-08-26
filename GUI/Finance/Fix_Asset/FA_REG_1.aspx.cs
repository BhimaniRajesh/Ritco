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

public partial class GUI_Finance_Fix_Asset_aaaaa : System.Web.UI.Page
{
      public byte byteRadButtonSelection;
      protected void Page_Load(object sender, EventArgs e)
    {

     

        if (!IsPostBack)
        {
  
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            popgrp();
             
        }
        
    
    }

    

    public void daterange(object source, ServerValidateEventArgs value)
    {

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

        System.TimeSpan diffResult = dt2.Subtract(dt1);
        //if (diffResult.Days > 31)
        //{
        //    value.IsValid = false;
        //}

          if (dt1 > dt2)
        {
            value.IsValid = false;
            CustomValidator1.ErrorMessage = "From Date Can not Be Greter Than To Date.";
        }
        else
        {
            value.IsValid = true;

        }
    }


    public void popgrp()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        string sql = "select top 1 '' as c1,'--Select--' as c2 from webx_acctinfo union select Acccode as c2,Accdesc as c1 from webx_acctinfo where acccategory='Fixed Assets'";
        //"select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";


        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        ddastclass.DataSource = ds;
        ddastclass.DataTextField = "c2";
        ddastclass.DataValueField = "c1";
        ddastclass.DataBind();

    }




    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {

            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

            string strFinalQS = "?strDateRange=" + strDate;
             strFinalQS = strFinalQS + "&loc=" + txtloc.Text;
             strFinalQS = strFinalQS + "&grp=" + ddastclass.SelectedValue.ToString();
             strFinalQS = strFinalQS + "&grossval=" + txtastval.Text;




            Response.Redirect("FA_REG_2.aspx" + strFinalQS);


        }


    }
}
