using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class AddCCMStep3FreightSundry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblCaption.InnerHtml = "<b>STEP 3: Freight Matrix - " + Request.QueryString["TL"].ToString() + "</b>";
            HidTL.Value = Request.QueryString["TL"].ToString();
            HidFTL.Value = Request.QueryString["FTL"].ToString();
            HidRandomNo.Value = Request.QueryString["Random"].ToString();
            HidODA.Value = Request.QueryString["ODA"].ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //if(radMultiple.Checked == true)
        //{
        //    //updateSlabInfo();
        //}

        if (radSingle.Checked == true)
        {
            Response.Redirect("AddCCMStep3ASSC.aspx?Random=" + HidRandomNo.Value + "&Slab=S" + "&FTL=" + HidFTL.Value + "&ODA=" + HidODA.Value);
        }
        else
        {
            Response.Redirect("AddCCMStep3BMSC.aspx?Random=" + HidRandomNo.Value + "&Slab=M" + "&FTL=" + HidFTL.Value + "&ODA=" + HidODA.Value);
        }
    }

    //private void updateSlabInfo()
    //{
    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    string strSQL = "UPDATE webx_ccm_step1 SET Slab_Multiple_YN = 'Y' WHERE Temp_Sr_No = " + HidRandomNo.Value;

    //    SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
    //    sqlCommand.ExecuteNonQuery();
    //}
}
