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
using Microsoft.ApplicationBlocks.Data;
using WebX.Controllers;

public partial class GUI_Fleet_TyreIssueModule_TyreRemovalMaster : System.Web.UI.Page
{
    int CountRows = 0, checkedCount = 0, EncheckedCount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);
        if (!IsPostBack)
        {
            //txtVehNo.Attributes.Add("onblur", " BindGrid");
            trSubmit.Visible = false;
            tblGrid.Visible = false;
            // txtActualTyre.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtActualTyre.ClientID.ToString() + "').focus();");
            //txtPendingTyre.Attributes.Add("OnFocus", "javascript:document.getElementById('" + txtPendingTyre.ClientID.ToString() + "').focus();");
        }
        //foreach (GridViewRow r in GV_TyreDetails.Rows)
        //{
        //    TextBox txtRemovalKM = (TextBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("txtRemovalKM");
        //    txtRemovalKM.Attributes.Add("OnBlur", "javascript:CheckKM();");
        //}
    }

    /// <summary>
    /// bind grid according to selection of vehicle no.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void BindGrid(object sender, EventArgs e)
    {
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(SessionUtilities.ConnectionString.ToString().Trim());
        CTIM.VEH_NO = txtVehNo.Text.ToString().Trim();

        CTIM.CheckValidVehicle();

        if (CTIM.IsRecordFound)
        {
            ////trTyreDtls.Visible = true;
            //GV_TyreDetails.Visible = true;
            //tblGrid.Visible = true;
            CTIM.BindGetTyreDetails(GV_TyreDetails);
            lblError.Text = "";
            // lblError.Visible = false;
            CountRows = GV_TyreDetails.Rows.Count;
            hdfPendingTyre.Value = Convert.ToString(CountRows);
            // txtActualTyre.Text = hdfPendingTyre.Value;
            CTIM.GetVehicleDtls();
            txtAxel.Text = Convert.ToString(CTIM.Tyre_Attached);
            txtActualTyre.Text = Convert.ToString(Convert.ToInt32(hdfPendingTyre.Value));
            txtPendingTyre.Text = Convert.ToString(Convert.ToInt32(txtActualTyre.Text) - Convert.ToInt32(txtAxel.Text));

            if (GV_TyreDetails.Rows.Count > 0)
            {
                tblGrid.Visible = true;
                trSubmit.Visible = true;
            }
            else
            {
                tblGrid.Visible = true;
                trSubmit.Visible = false;
            }
        }
        else
        {
            lblError.Text = "Invalid Vehicle No.";
            txtVehNo.Text = "";
            txtVehNo.Focus();
            //GV_TyreDetails.Visible = false;
            ////trTyreDtls.Visible = false;
            tblGrid.Visible = false;
            trSubmit.Visible = false;
        }
    }
    /// <summary>
    /// function to  calculate pending tyre
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CalculatePendingTyre(object sender, EventArgs e)
    {
        foreach (GridViewRow gridrow in GV_TyreDetails.Rows)
        {
            CheckBox chkSelected = (CheckBox)gridrow.FindControl("chkSelected");
            TextBox txtDistanceCovered = (TextBox)gridrow.FindControl("txtDistanceCovered");
            TextBox txtRemovalKM = (TextBox)gridrow.FindControl("txtRemovalKM");
            TextBox txtPerKMCost = (TextBox)gridrow.FindControl("txtPerKMCost");

            if (chkSelected.Checked)
            {
                checkedCount = checkedCount + 1;
                int Pending = Convert.ToInt32(hdfPendingTyre.Value) - checkedCount;
                txtPendingTyre.Text = Convert.ToString(Pending);
            }

            //else
            //{
            //    //if (checkedCount != 0)
            //    //{
            //    //    checkedCount = checkedCount - 1;
            //    //}
            //    //else
            //    //{
            //    //    checkedCount = 0;
            //    //}
            //    //txtPendingTyre.Text = Convert.ToString(CountRows - checkedCount);
            //}
            ////else
            ////{

            ////    txtPerKMCost.Text = "0.00";
            ////    txtDistanceCovered.Text = "0.00";

            ////    checkedCount = checkedCount - 1;
            ////    int Pending = Convert.ToInt32(hdfPendingTyre.Value) - checkedCount;
            ////    txtPendingTyre.Text = Convert.ToString(Pending);
            ////}
        }

    }
    /// <summary>
    /// function to Calculate Distance
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    ////protected void CalculateDistance(object sender, EventArgs e)
    ////{
    ////    Double RemovalKM = 0.0, FitmentKM = 0.0;
    ////    foreach (GridViewRow gridrow in GV_TyreDetails.Rows)
    ////    {
    ////        CheckBox chkSelected = (CheckBox)gridrow.FindControl("chkSelected");
    ////        TextBox txtDistanceCovered = (TextBox)gridrow.FindControl("txtDistanceCovered");
    ////        TextBox txtRemovalKM = (TextBox)gridrow.FindControl("txtRemovalKM");
    ////        TextBox txtPerKMCost = (TextBox)gridrow.FindControl("txtPerKMCost");
    ////        Label lblFitmentKM = (Label)gridrow.FindControl("lblFitmentKM");
    ////        HiddenField hdfFitmentKM = (HiddenField)gridrow.FindControl("hdfFitmentKM");
    ////        HiddenField hdfGRNAmount = (HiddenField)gridrow.FindControl("hdfGRNAmount");

    ////        Double GRNAmount = Convert.ToDouble(hdfGRNAmount.Value);

    ////        FitmentKM = Convert.ToDouble(hdfFitmentKM.Value);
    ////        if (chkSelected.Checked)
    ////        {
    ////            RemovalKM = Convert.ToDouble(txtRemovalKM.Text);

    ////            if (RemovalKM != 0.0 && RemovalKM > FitmentKM)
    ////            {
    ////                txtDistanceCovered.Text = Convert.ToString(RemovalKM - FitmentKM);

    ////                Double DistanceCovered = Convert.ToDouble(txtDistanceCovered.Text);
    ////                txtPerKMCost.Text = Convert.ToString(GRNAmount / DistanceCovered);
    ////            }
    ////        }
    ////    }
    ////}

    protected void GV_TyreDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)//|| e.Row.RowType == DataControlRowType.EmptyDataRow
        {
            CheckBox chkSelected = (CheckBox)e.Row.FindControl("chkSelected");
            TextBox txtRemovalKM = (TextBox)e.Row.FindControl("txtRemovalKM");
            TextBox txtDistanceCovered = (TextBox)e.Row.FindControl("txtDistanceCovered");
            TextBox txtPerKMCost = (TextBox)e.Row.FindControl("txtPerKMCost");

            HiddenField hdfFitmentKM = (HiddenField)e.Row.FindControl("hdfFitmentKM");
            Label lblFitmentKM = (Label)e.Row.FindControl("lblFitmentKM");
            HiddenField hdfGRNAmount = (HiddenField)e.Row.FindControl("hdfGRNAmount");

            txtRemovalKM.Attributes.Add("OnBlur", "javascript:return CalculateDistance(this," + txtDistanceCovered.ClientID + "," + txtPerKMCost.ClientID + "," + hdfFitmentKM.ClientID + "," + hdfGRNAmount.ClientID + ");");
        }
    }
    /// <summary>
    /// remove tyre from vehicle
    /// save records into table & redirect to result page
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Boolean IsCommit = false;
        Double PerKMCost = 0.00, REMOVAL_KM = 0.00;

        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd/MM/yyyy";
        dtfi.DateSeparator = "/";
        //dtfi.ShortTimePattern = "hh:mm tt";

        //DateTime Date = Convert.ToDateTime(txtDate.Text.Trim(), dtfi);

        DateTime DT = Convert.ToDateTime(txtDate.Text.Trim() + " 00:00:00.000", dtfi);

        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());

        CTIM.REMOVAL_DATE = DT;
        CTIM.VEH_NO = txtVehNo.Text.Trim();
        CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.ToString().Trim();

        //try
        //{
        if (lblError.Text == "")
        {
            foreach (GridViewRow r in GV_TyreDetails.Rows)
            {
                CheckBox chkSelected = (CheckBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("chkSelected");
                HiddenField hdfTyreNo = (HiddenField)GV_TyreDetails.Rows[r.RowIndex].FindControl("hdfTyreNo");
                Label lblFitmentDate = (Label)GV_TyreDetails.Rows[r.RowIndex].FindControl("lblFitmentDate");
                TextBox txtRemovalKM = (TextBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("txtRemovalKM");
                TextBox txtDistanceCovered = (TextBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("txtDistanceCovered");
                TextBox txtPerKMCost = (TextBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("txtPerKMCost");

                if (chkSelected.Checked)
                {
                    if (txtRemovalKM.Text != "")
                    {
                        REMOVAL_KM = Convert.ToDouble(txtRemovalKM.Text.Trim());
                        CTIM.RemovalKM = Convert.ToDouble(txtRemovalKM.Text.Trim());
                    }
                    else
                    {

                        CTIM.RemovalKM = 0.00;
                    }

                    if (txtDistanceCovered.Text != "")
                    {
                        CTIM.Dist_Covered = Convert.ToDouble(txtDistanceCovered.Text.Trim());
                    }
                    else
                    {
                        CTIM.Dist_Covered = 0.00;
                    }


                    if (txtPerKMCost.Text != "")
                    {
                        PerKMCost = Convert.ToDouble(txtPerKMCost.Text);
                        CTIM.CostPerKM = Math.Round(PerKMCost, 2);

                    }
                    else
                    {

                        CTIM.CostPerKM = 0.00;
                    }

                    //Math.Round(txtPerKMCost.Text, 2, MidpointRounding.AwayFromZero);
                    //Convert.ToDouble(txtPerKMCost.Text.Trim());
                    //Convert.ToString(Math.Round(Amt, 2, MidpointRounding.AwayFromZero));

                    CTIM.TYRE_LOC = SessionUtilities.CurrentBranchCode.ToString().Trim();
                    //CTIM.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();
                    CTIM.TYRE_ID = hdfTyreNo.Value;


                    CTIM.UpdateRemovalTyreDtl();
                    // lblMsg.ForeColor = System.Drawing.Color.Green;
                    // lblMsg.Text = "Tyre Removed successfully. !!!!";
                    IsCommit = true;
                    btnSubmit.Enabled = false;
                }
            }
        }

        //catch (Exception ex)
        //{
        //    lblMsg.ForeColor = System.Drawing.Color.Red;
        //    lblMsg.Text = ex.Message.ToString();
        //}
        //finally
        //{
        //    btnSubmit.Enabled = false;
        //}
        if (IsCommit == true)
        {
            Response.Redirect("TyreRemovalMsg.aspx?Flag=R");
        }
    }
}