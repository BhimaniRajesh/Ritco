using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;

public partial class GUI_Fleet_Tyre_OldTyreStock_TyreCPKM : BasePage
{
    public string clintName = "", path = "UploadedImages";

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            CreateToken();

            clintName = SessionUtilities.Client;
            System.DateTime mServerDt = System.DateTime.Today;
            string mServerCurrDt = mServerDt.ToString("dd/MM/yyyy");
            hf_ServerDt.Value = mServerCurrDt;

            WebXConvert.ToDateTime(txtClaimDT.Text.Trim(), "en-GB").ToString("dd MMM yyyy");

            cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
            string Str = Request.QueryString["Tyre_ID"];
            //string Str = "T0011,T0012,T0013,T0014,T0015,T0018";

            BindDropDown("USP_VendorListCPKM", "Vendor", "vendorcode", ddlVendor);
            CTIM.GetTyres_CPKM(GV_TyreClaim, Str);

            //  btnStep.Attributes.Add("OnClick", "javascript:OnSubmitStep();");
            // btnSubmit.Attributes.Add("OnClick", "javascript:OnSubmit();");
        }
    }

    /// <summary>
    /// Bind Vendor
    /// </summary>
    /// <param name="strProc"></param>
    /// <param name="text"></param>
    /// <param name="value"></param>
    /// <param name="Where"></param>
    /// <param name="d"></param>
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GV_TyreClaim_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtClaim = (TextBox)e.Row.FindControl("txtClaim");
            TextBox txtClaimDT = (TextBox)e.Row.FindControl("txtClaimDT");
            //TextBox txtClaimAmt = (TextBox)e.Row.FindControl("txtClaimAmt");
            //TextBox txtReason = (TextBox)e.Row.FindControl("txtReason");

            //txtClaimAmt.Enabled = false;
            //txtReason.Enabled = false;
            ////txtClaim.Attributes.Add("OnBlur", "javascript:CheckVendor();");
            ////txtClaim.Attributes.Add("OnBlur", "javascript:CheckVendor(" + e.Row.RowIndex + "," + txtClaim.ClientID.ToString() + ");");
            ////txtClaimDT.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'02','../../../images/Fleet_Date_Control_Rule_Check.aspx')");
        }
    }



    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnStep_Click(object sender, EventArgs e)
    {
        btnStep.Enabled = false;
        List<string> list = new List<string>();
        string final = "";
        string[] ARR_vendcd;
        string VendorCD = "", VendorNM = "";
        string mCheck = "CPKM", mDocuementNo = "";
        Boolean IsCommited = false;

        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));

        string Xml_PAY_MST = "<root>";
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (IsTokenValid()) // Genuine Click of Submit Button
        {



            foreach (GridViewRow gridrow in GV_TyreClaim.Rows)
            {
                TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
                TextBox txtTruckNo = gridrow.FindControl("txtTruckNo") as TextBox;
                TextBox txtRate = gridrow.FindControl("txtRate") as TextBox;
                HiddenField hdfTYRE_ID = gridrow.FindControl("hdfTYRE_ID") as HiddenField;

                mDocuementNo = mDocuementNo + "," + hdfTYRE_ID.Value;

                list.Add(hdfTYRE_ID.Value.Trim());


                CTIM.TYRE_ID = hdfTYRE_ID.Value;//txtSysTyreNo.Text.Trim();
                CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.Trim();
                CTIM.VendorCode = ddlVendor.SelectedValue.Trim();
                CTIM.BRANCH = SessionUtilities.CurrentBranchCode.Trim();
                CTIM.Actions = "CPKM";
                CTIM.VEH_NO = txtTruckNo.Text;
                CTIM.CLAIM_AMT = Convert.ToDouble(txtRate.Text);
                CTIM.TotalRate = hdnTotalValue.Value;
                CTIM.FinalRate = hdnFinalRate.Value;
                CTIM.CreditKM = hdnCreditKM.Value;

                string newFName = "";

                if (flUpload.HasFile)
                {
                    string ImgName = flUpload.PostedFile.FileName;
                    int lastIndex = ImgName.LastIndexOf('.');
                    var name = ImgName.Substring(0, lastIndex);
                    var ext = ImgName.Substring(lastIndex + 1);
                    string docno = mDocuementNo.ToString().Trim().Replace("/", "$");
                    newFName = docno + "." + ext;
                    if (CheckDocumentExistance(newFName) == true)
                    {
                        //throw new Exception("Document already exist.");
                    }

                    double dblFileSize = Math.Ceiling(Convert.ToDouble(flUpload.PostedFile.ContentLength) / 1000);
                    double MaxSize = 1024; //1MB
                    if (CheckUploadedImagesDirectory() == false)
                    {
                        throw new Exception("Fail to create directory ");
                    }
                    if (dblFileSize > MaxSize)
                    {

                        throw new Exception("File size can not be more than " + MaxSize.ToString("0") + " KB");
                    }
                    flUpload.SaveAs(Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + clintName + @"\" + newFName);

                }

                CTIM.FileUploadPath = newFName;

                //updated by vidya on 14 Nov 2013

                CTIM.UpdateTyreDtl_CPKM();
                IsCommited = true;

                ConsumeToken();
            }


        }
        if (IsCommited)
        {
            btnStep.Enabled = false;


            Response.Redirect("CPKMMsg.aspx?ID=" + mDocuementNo);
        }
    }
    protected void ddlVendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        int cnt = 0;
        int tyre = 0;
        decimal totalRate = 0;
        foreach (GridViewRow gridrow in GV_TyreClaim.Rows)
        {
            TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
            HiddenField hdnNoofTyre = gridrow.FindControl("hdnNoofTyre") as HiddenField;
            TextBox txtRate = gridrow.FindControl("txtRate") as TextBox;
            cnt++;
            totalRate = totalRate + Convert.ToDecimal(txtRate.Text);
            tyre = Convert.ToInt32(hdnNoofTyre.Value);
        }
       
        var objVendorCPKMBillController = new VendorCPKMBillController();
        var dt = objVendorCPKMBillController.GetrateFromVendorConftract(ddlVendor.SelectedItem.Value);
        txtFinalRate.Text = Convert.ToString(dt.Rows[0]["NetRate"]);
        hdnFinalRate.Value = Convert.ToString(dt.Rows[0]["NetRate"]);
        txtTotalValue.Text = Convert.ToString(totalRate);
        hdnTotalValue.Value = Convert.ToString(totalRate);
        txtNofTyre.Text = Convert.ToString(tyre);
        hdnNofTyre.Value = Convert.ToString(tyre);

        txtCreditKM.Text = Convert.ToString(Decimal.Round(Convert.ToDecimal(Convert.ToDecimal(dt.Rows[0]["NetRate"]) == 0 ? "0" : String.Format("{0:0.0#}", ((totalRate / Convert.ToDecimal(dt.Rows[0]["NetRate"])  )/ (tyre - 1))))));
        hdnCreditKM.Value = Convert.ToString(Decimal.Round(Convert.ToDecimal(Convert.ToDecimal(dt.Rows[0]["NetRate"]) == 0 ? "0" : String.Format("{0:0.0#}", ((totalRate / Convert.ToDecimal(dt.Rows[0]["NetRate"]) ) / (tyre - 1))))));
    }
    private bool CheckDocumentExistance(string FileName)
    {
        try
        {
            return File.Exists(Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + FileName);
        }
        catch (Exception Ex)
        {
            return true;
        }
    }

    private bool CheckUploadedImagesDirectory()
    {
        try
        {
            string strDirectoryName = Server.MapPath("~/GUI/Fleet/Operations/Issue") + @"\" + path + @"\" + clintName + "";
            if (Directory.Exists(strDirectoryName))
            {
                return true;
            }
            else
            {
                Directory.CreateDirectory(strDirectoryName);
                return true;
            }
        }
        catch (Exception Ex)
        {
            return false;
        }
    }
}