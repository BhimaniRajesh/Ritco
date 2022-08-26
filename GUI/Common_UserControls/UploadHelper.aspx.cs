using System;
using System.IO;
using System.Web.UI;
using WebX.Entity;

public partial class GUI_Common_UserControls_UploadHelper : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void fileSave_Click(object sender, EventArgs e)
    {
        if (fileDeclaration.HasFile)
        {
            var FileExtension = Path.GetExtension(fileDeclaration.PostedFile.FileName).Substring(1);

            var stringTimeSlot = DateTime.Now.Ticks.ToString();
            string fileName = Server.MapPath("~\\GUI\\admin\\CustomerMaster\\Files\\");
            if (!System.IO.Directory.Exists(fileName))
            {
                Directory.CreateDirectory(fileName);
            }
            fileDeclaration.SaveAs(fileName + stringTimeSlot + "." + FileExtension);
            if (Request.QueryString["CustomerId"].ToString() != "")
            {
                var dst = new CustomerGSTDetail();
                dst.CUSTCD = Request.QueryString["CustomerId"].ToString();
                dst.DeclarationFile = stringTimeSlot + "." + FileExtension;
                WebX.Controllers.DocketController.GSTCustomerDetailsInsert(dst);
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadControlOnCallBack_LOAD" + stringTimeSlot, "closeWindow('" + stringTimeSlot + "." + FileExtension + "');", true);
        }
        else
        {
            lblInfo.Text = "Please select file and upload.";
        }
    }
}