using System;
using System.Data;
using System.Web;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.IO;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;


public partial class GUI_Fleet_Operations_Issue_PODTHCVehicleViewResult : System.Web.UI.Page
{
    public string DateType, fromdt, todt, thctype, vehicleno,status, branch, St_paylist, st_trnlist, st_delist, st_mode, st_status;
    public string ExternalThcNo, dtFrom, dtTo;
    private DateFunction df = new DateFunction();

    protected void Page_Load(object sender, EventArgs e)
    {
        fromdt = Request.QueryString["fromdt"].ToString();
        todt = Request.QueryString["todt"].ToString();
        thctype = Request.QueryString["thctype"].ToString();
        vehicleno = Request.QueryString["vehicleNo"].ToString();
        branch = Request.QueryString["branch"].ToString();
        status = Request.QueryString["status"].ToString();
        BindGrid();
    }

    protected void DownloadFile(object sender, EventArgs e)
    {
        string filePath = (sender as LinkButton).CommandArgument;
        if (filePath.Trim() != "")
        {
            string filePaths = Server.MapPath("~/GUI/Fleet/Operations/Issue/UploadedImages/Ritco" + "//" + filePath);
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filePaths));
            Response.WriteFile(filePaths);
            Response.End();
        }
    }

    public void BindGrid()
    {
        dtFrom = Convert.ToDateTime(df.returnmmddyyyy_format(fromdt)).ToString("dd MMM yy");
        dtTo = Convert.ToDateTime(df.returnmmddyyyy_format(todt)).ToString("dd MMM yy");
        string sql = "USP_Get_Owned_THC_Details_Vehicle_POD";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@FromDt", dtFrom);
        cmd.Parameters.AddWithValue("@ToDt", dtTo);
        cmd.Parameters.AddWithValue("@THCType", thctype);
        cmd.Parameters.AddWithValue("@VehicleNo", vehicleno);
        cmd.Parameters.AddWithValue("@Branch", branch);
        cmd.Parameters.AddWithValue("@Status", status);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        dgExternalThc.DataSource = ds;
        dgExternalThc.DataBind();
        conn.Close();
    }

    protected void pgChange(object sender, GridViewPageEventArgs e)
    {
        dgExternalThc.PageIndex = e.NewPageIndex;
        BindGrid();
    }
   
    protected void dgExternalThc_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandArgument.ToString().ToUpper() != "UPLOADBUTTON")
        {
            return;
        }

        Button btnUpload = e.CommandSource as Button;

        var fUThcDoc = (FileUpload)btnUpload.Parent.FindControl("fldUpload");
        var hdnExternalTHCNo = (HiddenField)btnUpload.Parent.FindControl("hdnExternalTHCNo");
        var hdnTripType = (HiddenField)btnUpload.Parent.FindControl("hdnTripType");

        string newFName = "";
        if (fUThcDoc.HasFile)
        {
            string ImgName = fUThcDoc.PostedFile.FileName;
            int lastIndex = ImgName.LastIndexOf('.');
            var name = ImgName.Substring(0, lastIndex);
            var ext = ImgName.Substring(lastIndex + 1);
            string docno = hdnExternalTHCNo.Value.ToString().Trim().Replace("/", "$");
            newFName = docno + "." + ext;

            double dblFileSize = Math.Ceiling(Convert.ToDouble(fUThcDoc.PostedFile.ContentLength) / 1000);
            double MaxSize = 1024; //1MB

            //if (dblFileSize > MaxSize)
            //{
            //    throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
            //}

            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlCommand cmdUDT = new SqlCommand();
            SqlTransaction trans1;
            conn1.Open();
            trans1 = conn1.BeginTransaction();
            try
            {
                fUThcDoc.SaveAs(Server.MapPath("~/GUI/Fleet/Operations/Issue/UploadedImages/Ritco") + @"\" + newFName);
                string sqlUpdate = "";
                if (hdnTripType.Value == "E")
                {
                    sqlUpdate = " Update WEBX_FLEET_ExternalTHC SET UploadFileName='" + newFName + "' where ExternalTHCNo='" + hdnExternalTHCNo.Value + "' ";
                }
                if (hdnTripType.Value == "E")
                {
                    sqlUpdate = " Update webx_THC_SUMMARY SET TripPOD='" + newFName + "' where thcno='" + hdnExternalTHCNo.Value + "' ";
                }
                cmdUDT = new SqlCommand(sqlUpdate, conn1, trans1);
                cmdUDT.ExecuteNonQuery();
                cmdUDT.Dispose();
                trans1.Commit();
            }
            catch (Exception ex)
            {
                trans1.Rollback();
                throw ex;
            }
            finally
            {
                conn1.Close();
            }
        }
        BindGrid();
    }

    protected void dgExternalThc_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            FileUpload fldUpload = (FileUpload)e.Row.FindControl("fldUpload");
            HiddenField hdnUploadFileName = (HiddenField)e.Row.FindControl("hdnUploadFileName");
            Button btnUpload = (Button)e.Row.FindControl("btnUpload");
            LinkButton lnkDownload = (LinkButton)e.Row.FindControl("lnkDownload");


            if (hdnUploadFileName.Value == "") {
                fldUpload.Visible = true;
                btnUpload.Visible = true;
				 lnkDownload.Visible = false;
				
            }
            else
            {
				fldUpload.Visible = false;
                btnUpload.Visible = false;
                lnkDownload.Visible = true;
            }
        }

    }
}