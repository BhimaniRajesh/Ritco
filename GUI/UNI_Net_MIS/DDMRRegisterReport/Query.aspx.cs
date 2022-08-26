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

public partial class GUI_UNI_Net_MIS_DKT_Profi_Query : System.Web.UI.Page
{
    SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {

        hdnRptId.Value = Request.QueryString["RPTID"].ToString(); // added by Manisha 22/5/2014
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

        string brcd = Session["brcd"].ToString();
        string sqlstr = "select loc_level from webx_location where loccode='" + brcd + "'";        
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        dread.Read();
        int loclevel = Convert.ToInt32(dread.GetValue(0).ToString());
        string loc_level = Convert.ToString(dread.GetValue(0).ToString());       
        dread.Close();
        conn.Close();

        TextBox txtDateFrom = (TextBox)DT.FindControl("txtDateFrom");
        TextBox txtDateTo = (TextBox)DT.FindControl("txtDateTo");

        RadioButtonList radDate = (RadioButtonList)DT.FindControl("radDate");
        string report_mode = "";
        RadioButtonList rb2 = new RadioButtonList();
        rb2 = (RadioButtonList)radDate;
        if ((rb2.Items[0].Selected))        
            report_mode = "Date";       
        if ((rb2.Items[1].Selected))       
            report_mode = "Week";       
        if ((rb2.Items[2].Selected))       
            report_mode = "Today";        

        string strrightnow, strrightnow1;
        System.DateTime righnow = System.DateTime.Today;
        strrightnow = righnow.ToString("dd/MM/yyyy");
        strrightnow1 = righnow.ToString("dd/MM/yyyy");
        if (report_mode == "Date")
        {
            strrightnow = txtDateFrom.Text.ToString();
            strrightnow1 = txtDateTo.Text.ToString(); //Request.QueryString.Get("txtDateTo");
        }
        else if (report_mode == "Week")
        {
            strrightnow = righnow.AddDays(-7).ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        else if (report_mode == "Today")
        {
            strrightnow = righnow.ToString("dd/MM/yyyy");
            strrightnow1 = righnow.ToString("dd/MM/yyyy");

        }
        else if (report_mode == "Tilldate")
        {
            strrightnow = "01/04/1990";
            strrightnow1 = righnow.ToString("dd/MM/yyyy");
        }
        if (strrightnow == "")       
            strrightnow = righnow.ToString("dd/MM/yyyy");
      
        if (strrightnow1 == "")        
            strrightnow1 = righnow.ToString("dd/MM/yyyy");       

        string[] strArrDtFrom = strrightnow.Split('/');
        string[] strArrDtTo = strrightnow1.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        string st_ro = cboRO.SelectedValue.ToString();
        string st_lo = cboLO.SelectedValue.ToString();

        string strDocNo = string.Empty;   

        if (!string.IsNullOrEmpty(txtDocumentNo.Text.Trim()))
        {
            #region strDocNo If Comma Separated
            strDocNo = txtDocumentNo.Text.Trim();
           
            if (strDocNo.IndexOf(',') > 0)
            {
                string[] arrLocCode = strDocNo.Split(',');

                strDocNo = string.Empty;
               
                for (int j = 0; j <= arrLocCode.Length - 1; j++)
                {
                    strDocNo += arrLocCode[j].ToString() + ",";
                }

                if (strDocNo.LastIndexOf(',') > 0)
                    strDocNo = strDocNo.Remove(strDocNo.LastIndexOf(','), 1);              
            }               
            #endregion            
        }

        string final = string.Empty;
        final += "?dtFrom=" + dtFrom;
        final += "&dtTo=" + dtTo;             
        final += "&RO=" + st_ro;
        final += "&LO=" + st_lo;
        final += "&DDMRNO=" + strDocNo;
        final += "&hdnRptId=" + hdnRptId.Value.ToString(); // added by Manisha 22/5/2014


        //Response.Redirect("Result.aspx" + final);
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<");
        sb.Append("script language='javascript'>");
        sb.Append("window.open('./Result.aspx" + final + "', '_blank',");
        sb.Append("'top=0, left=0, width=900, height=700, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');");
        sb.Append("<");
        sb.Append("/script>");

        if (!this.IsStartupScriptRegistered("PopupWindow"))
        {
            this.RegisterStartupScript("PopupWindow", sb.ToString());
        }
    }
}
