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

public partial class EditCCMStep3FreightSundry : System.Web.UI.Page
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
            HidContractID.Value = Request.QueryString["ContractID"].ToString();

            PopulateHiddenVars();
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
            Response.Redirect("EditCCMStep3ASSC.aspx?Random=" + HidRandomNo.Value + "&Slab=S" + "&FTL=" + HidFTL.Value + "&ODA=" + HidODA.Value);
        }
        else
        {
            Response.Redirect("EditCCMStep3BMSC.aspx?Random=" + HidRandomNo.Value + "&Slab=M" + "&FTL=" + HidFTL.Value + "&ODA=" + HidODA.Value);
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

    private void PopulateHiddenVars()
    {
        //HidContractID.Value = "";

        //string strSQL = "select ContractId from Webx_CCM_Step1 where Temp_Sr_No = " + HidRandomNo.Value;

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        //SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        //SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        //DataSet dsCCMStep1Data = new DataSet();

        //sqlDA.Fill(dsCCMStep1Data);

        //if (dsCCMStep1Data.Tables[0].Rows.Count > 0)
        //{
        //    HidContractID.Value = dsCCMStep1Data.Tables[0].Rows[0]["ContractId"].ToString();

            string strSQL = "select ISNULL(single_slab_yn, 'N') AS SingleSlab, ISNULL(multiple_slab_yn, 'N') AS MultipleSlab from WEBX_CUSTCONTRACT_HDR where contractid = '" + HidContractID.Value + "'";

            SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
            SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

            DataSet dsCCMStep1Data = new DataSet();

            //sqlCommand = null;
            //sqlDA = null;
            //dsCCMStep1Data = null;

            sqlCommand = new SqlCommand(strSQL, sqlConn);
            sqlDA = new SqlDataAdapter(sqlCommand);

            dsCCMStep1Data = new DataSet();

            sqlDA.Fill(dsCCMStep1Data);

            if (dsCCMStep1Data.Tables[0].Rows.Count > 0)
            {
                if (dsCCMStep1Data.Tables[0].Rows[0]["SingleSlab"].ToString() == "Y")
                {
                    radSingle.Checked = true;
                }
                else if (dsCCMStep1Data.Tables[0].Rows[0]["MultipleSlab"].ToString() == "Y")
                {
                    radMultiple.Checked = true;
                }
            }
        //}
    }
}
