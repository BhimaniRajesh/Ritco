using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using Microsoft.ApplicationBlocks.Data;
public partial class GUI_admin_CustomerContractMaster_ContractScanCopyView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["ContractID"] != null)
                {
                   // cstheader.ContractID = Convert.ToString(Request.QueryString["ContractID"]);
                    hdnContractID.Value = Convert.ToString(Request.QueryString["ContractID"]);
                }

                if (Request.QueryString["CustCode"] != null)
                {
                   // cstheader.CustCode = Convert.ToString(Request.QueryString["CustCode"]);
                }
                string strBaseLocation = Server.MapPath("~/UploadedImages/");// +SessionUtilities.Client;

                try
                {
                    strBaseLocation = Server.MapPath("~/UploadedImages/");// +hdnContractID.Value;// +"//";
                    //string[] FileNames = Directory.GetFiles(strBaseLocation);
                    // ListItem lstFileNames = FileNames.t

                    //if (FileNames.Length > 0)
                    //{

                    //  DataTable dt = new DataTable();
                    //  dt.Columns.Add("Filename", System.Type.GetType("System.String"));
                    //  for (int i = 0; i < FileNames.Length; i++)
                    // {
                    //   FileNames[i] = FileNames[i].Substring(strBaseLocation.Length);

                    // ListItem lstFileNames
                    // dt.Rows.Add( FileNames[i]);
                    //}

                    //System.Collections.Generic.List<string> lstFileNames = new System.Collections.Generic.List<string>(FileNames);


                    DataTable ScanCopyDetailsDatatable = new DataTable();
                    string str = "select * from Webx_Contract_ScanCopy where ContractId='" + hdnContractID.Value + "'";
                    ScanCopyDetailsDatatable = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, str).Tables[0];

                    grvFileName.DataSource = ScanCopyDetailsDatatable;
                    grvFileName.DataBind();
                    //}
                }
                catch (Exception Exc)
                { }
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in record Insert/Update.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }


    protected void grvFileName_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        string strBaseLocation = Server.MapPath("~/UploadedImages/");// +SessionUtilities.Client;
        //string[] FileNames = Directory.GetFiles(strBaseLocation);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnkviewFile = (LinkButton)e.Row.FindControl("lnkviewFile");
            //LinkButton lnkDeleteFile = (LinkButton)e.Row.FindControl("lnkDeleteFile");
            Label lblFileName = (Label)e.Row.FindControl("lblFileName");
            lnkviewFile.Text = "View";// e.Row.DataItem.ToString();
            //lnkDeleteFile.Text = "Delete";
            // lnkviewFile.Text = lnkviewFile.Text.Substring(0, e.Row.DataItem.ToString().LastIndexOf(".") );
            // lnkviewFile.Text = e.Row.DataItem.ToString();

            lnkviewFile.Attributes.Add("onclick", "javascript:return topWindow('" + lblFileName.Text + "')");


        }


    }

    //protected void grvFileName_OnRowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //        string str = "delete  Webx_Contract_ScanCopy where FileName='" + e.CommandArgument.ToString() + "'";

    //        SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString, CommandType.Text, str);

    //        FileInfo F = new FileInfo(Server.MapPath("~/UploadedImages/") + e.CommandArgument.ToString());
    //        F.Delete();


    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //    Response.Redirect("ContractScanCopyView.aspx?contractID=" + Convert.ToString(Request.QueryString["ContractID"]) + "&CustCode=" + Convert.ToString(Request.QueryString["CustCode"]));
    //}
   



}
