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
using System.IO;
using Microsoft.ApplicationBlocks.Data;
using System.Xml;


using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_ContractScanCopyUpload : System.Web.UI.Page
{
    #region Variable[s]
    private static string ErrorMsg = string.Empty;
    #endregion

    #region Form Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {      
        
        try
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["ContractID"] != null)
                {
                    cstheader.ContractID = Convert.ToString(Request.QueryString["ContractID"]);
                    hdnContractID.Value = Convert.ToString(Request.QueryString["ContractID"]);
                }

                if (Request.QueryString["CustCode"] != null)
                {
                    cstheader.CustCode = Convert.ToString(Request.QueryString["CustCode"]);
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
                    string str ="select * from Webx_Contract_ScanCopy where ContractId='"+hdnContractID.Value+"'";
                    ScanCopyDetailsDatatable= SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString,CommandType.Text,str).Tables[0];
                      
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
   protected void btnUploadFile_Click(object sender, EventArgs e)
    {

        
        try
        {
            Validation();

            if (string.IsNullOrEmpty(ErrorMsg))
            {
                string Timedate = Convert.ToString(DateTime.Today.Day) + Convert.ToString(DateTime.Today.Month) + Convert.ToString(DateTime.Today.Year) + Convert.ToString(DateTime.Now.Hour) + Convert.ToString(DateTime.Now.Minute) + Convert.ToString(DateTime.Now.Minute) + Convert.ToString(DateTime.Now.Second);
                string strBaseLocation = Server.MapPath("~/UploadedImages/");// +"//"; //+hdnContractID.Value + "//";
                string FilePath = strBaseLocation + hdnContractID.Value +"_" +Timedate + Path.GetExtension(uplTheFile.PostedFile.FileName);
                string Filename= hdnContractID.Value +"_" +Timedate + Path.GetExtension(uplTheFile.PostedFile.FileName);
                try
                {
                    if (!Directory.Exists(strBaseLocation))
                    {
                        Directory.CreateDirectory(strBaseLocation);
                        //CCMController.UpdateScanCopyName(hdnContractID.Value + Path.GetExtension(uplTheFile.PostedFile.FileName));
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error to create directory.&detail1=" + ex.Message.Replace('\n', '_'), false);
                }

                if (null != uplTheFile.PostedFile)
                {

                    //uplTheFile.PostedFile.FileName 
                   
                    //string[] FileNames = Directory.GetFiles(strBaseLocation);

                    //if (FileNames.Length > 0)
                    //{
                    //    for (int i = 0; i < FileNames.Length; i++)
                    //    {

                    //        if (FileNames[i].Substring(strBaseLocation.Length + 1) == uplTheFile.PostedFile.FileName)
                    //      {
                    //      ViewState["Flag"]="False";
                    //      }
                       
                        
                    //    }

                    //}

                    //if (ViewState["Flag"].ToString() != "False")
                    //{


                    string str = "insert into Webx_Contract_ScanCopy values('" + hdnContractID.Value + "','" + System.DateTime.Now + "','" + Filename + "')";

                    SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString,CommandType.Text,str);
            
                    uplTheFile.PostedFile.SaveAs(FilePath);
                    //}
                    //else
                    //{ 
                    
                    
                    //}
                }
                Response.Write("<script language='javascript'> { window.close();}</script>");
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);
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
            LinkButton lnkDeleteFile = (LinkButton)e.Row.FindControl("lnkDeleteFile");
            Label lblFileName = (Label)e.Row.FindControl("lblFileName");
            lnkviewFile.Text = "View";// e.Row.DataItem.ToString();
            lnkDeleteFile.Text = "Delete";
           // lnkviewFile.Text = lnkviewFile.Text.Substring(0, e.Row.DataItem.ToString().LastIndexOf(".") );
          // lnkviewFile.Text = e.Row.DataItem.ToString();

                  lnkviewFile.Attributes.Add("onclick", "javascript:return topWindow('" + lblFileName.Text +"')");
         
            
        }

       
    }

   protected void grvFileName_OnRowCommand(object sender, GridViewCommandEventArgs e)
   {
       try
       {
           string str ="delete  Webx_Contract_ScanCopy where FileName='" +e.CommandArgument.ToString()+"'";
           
          SqlHelper.ExecuteNonQuery(SessionUtilities.ConnectionString ,CommandType.Text,str);

          FileInfo F = new FileInfo(Server.MapPath("~/UploadedImages/") + e.CommandArgument.ToString());
           F.Delete();

          
       }
       catch(Exception ex){
       
       }
       Response.Redirect("ContractScanCopyUpload.aspx?contractID=" + Convert.ToString(Request.QueryString["ContractID"]) + "&CustCode=" + Convert.ToString(Request.QueryString["CustCode"]));
   }

  
    
    #endregion

    #region Private Function[s]
    private void Validation()
    {
        try
        {
            if (string.IsNullOrEmpty(uplTheFile.PostedFile.FileName))
            {
                ErrorMsg = "Please browse file to upload.";
                return;
            }
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    #endregion
}
