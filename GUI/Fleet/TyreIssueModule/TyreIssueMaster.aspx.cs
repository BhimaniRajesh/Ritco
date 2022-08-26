using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GUI_Fleet_TyreIssueModule_TyreIssueMaster : System.Web.UI.Page
{
    int CountRows = 0, checkedCount = 0, EncheckedCount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            //BindGrid();
            //txtVehNo.Attributes.Add("OnBlur", "javascript:CheckVhNo('" + txtVehNo.ClientID + "');");
            txtVehNo.Attributes.Add("onblur", "javascript:return CheckVhNo();");
            txtKmReading.Attributes.Add("onblur", "javascript:return CheckKMReading();");
            txtDate.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'02','../../../images/Fleet_Date_Control_Rule_Check.aspx')");
            txtRemoveDT.Attributes.Add("onblur", "javascript:MIn_Max_Date_Validation(this,'02','../../../images/Fleet_Date_Control_Rule_Check.aspx')");
            //trRemoval.Visible = false;
            tblGrid.Visible = false;
            trRemove.Visible = false;
            trIssueTyre.Visible = false;
        }

    }


    /// <summary>
    /// bind grid
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GV_TyreDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)//|| e.Row.RowType == DataControlRowType.EmptyDataRow
        {
            TextBox txtRemovalKM = (TextBox)e.Row.FindControl("txtRemovalKM");
            HiddenField hdfFitmentKM = (HiddenField)e.Row.FindControl("hdfFitmentKM");
            // txtRemovalKM.Attributes.Add("OnBlur", "javascript:Check_KM(" + e.Row.RowIndex + "," + txtRemovalKM.ClientID.ToString() + "," + hdfFitmentKM.ClientID.ToString().Trim() + ");");
            txtRemovalKM.Attributes.Add("OnBlur", "javascript:return Check_KM();");
            txtRemovalKM.Text = txtKmReading.Text; //hdfKMReading.Value;
        }
    }
    protected void gwTyreList_PageIndexChanged(object sender, EventArgs e)
    {
    }
    protected void gwTyreList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVTyreDetails.PageIndex = e.NewPageIndex;
        GVTyreDetails.DataBind();
        BindGrid();
    }

    /// <summary>
    /// bind grid 
    /// list of tyres in stock
    /// </summary>
    public void BindGrid()
    {
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        CTIM.TYRE_LOC = SessionUtilities.CurrentBranchCode.ToString().Trim();
        CTIM.BindGridTyreDetails(GVTyreDetails);
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
            CheckBox chkSelected1 = (CheckBox)gridrow.FindControl("chkSelected1");
            TextBox txtDistanceCovered = (TextBox)gridrow.FindControl("txtDistanceCovered");
            TextBox txtRemovalKM = (TextBox)gridrow.FindControl("txtRemovalKM");
            TextBox txtPerKMCost = (TextBox)gridrow.FindControl("txtPerKMCost");

            if (chkSelected1.Checked)
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
    /// function to Calculate Distance & Cost per KM
    /// </summary>
    public void CalDistance_Cost()
    {
        Double RemovalKM = 0.0, FitmentKM = 0.0;
        foreach (GridViewRow gridrow in GV_TyreDetails.Rows)
        {
            CheckBox chkSelected1 = (CheckBox)gridrow.FindControl("chkSelected1");
            TextBox txtDistanceCovered = (TextBox)gridrow.FindControl("txtDistanceCovered");
            TextBox txtRemovalKM = (TextBox)gridrow.FindControl("txtRemovalKM");
            TextBox txtPerKMCost = (TextBox)gridrow.FindControl("txtPerKMCost");
            Label lblFitmentKM = (Label)gridrow.FindControl("lblFitmentKM");
            HiddenField hdfFitmentKM = (HiddenField)gridrow.FindControl("hdfFitmentKM");
            HiddenField hdfGRNAmount = (HiddenField)gridrow.FindControl("hdfGRNAmount");
            Double GRNAmount = Convert.ToDouble(hdfGRNAmount.Value);
            FitmentKM = Convert.ToDouble(hdfFitmentKM.Value);

            if (txtRemovalKM.Text != "")
            {
                RemovalKM = Convert.ToDouble(txtRemovalKM.Text);
            }
            else
            {
                RemovalKM = 0.00;
            }

            if (RemovalKM != 0.00 && RemovalKM > FitmentKM)
            {
                txtDistanceCovered.Text = Convert.ToString(RemovalKM - FitmentKM);
                Double DistanceCovered = Convert.ToDouble(txtDistanceCovered.Text);
                Double cost = (GRNAmount / DistanceCovered);
                //txtPerKMCost.Text = cost.ToString("F2");
                txtPerKMCost.Text = string.Format("{0:n4}", cost);


                Double mNeTPay = Math.Round(GRNAmount / DistanceCovered, 0, MidpointRounding.AwayFromZero);
            }
            //else {
            //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "key", "alert('Removal Amount should be grater than " + FitmentKM + "');", true);
            //    txtRemovalKM.Text = "";
            //}

        }
    }

    /// <summary>
    /// function to Calculate Distance
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CalculateDistance(object sender, EventArgs e)
    {
        Double RemovalKM = 0.0, FitmentKM = 0.0;
        foreach (GridViewRow gridrow in GV_TyreDetails.Rows)
        {
            CheckBox chkSelected1 = (CheckBox)gridrow.FindControl("chkSelected1");
            TextBox txtDistanceCovered = (TextBox)gridrow.FindControl("txtDistanceCovered");
            TextBox txtRemovalKM = (TextBox)gridrow.FindControl("txtRemovalKM");
            TextBox txtPerKMCost = (TextBox)gridrow.FindControl("txtPerKMCost");
            Label lblFitmentKM = (Label)gridrow.FindControl("lblFitmentKM");
            HiddenField hdfFitmentKM = (HiddenField)gridrow.FindControl("hdfFitmentKM");
            HiddenField hdfGRNAmount = (HiddenField)gridrow.FindControl("hdfGRNAmount");
            Double GRNAmount = Convert.ToDouble(hdfGRNAmount.Value);
            FitmentKM = Convert.ToDouble(hdfFitmentKM.Value);

            if (chkSelected1.Checked)
            {
                if (txtRemovalKM.Text != "")
                {
                    RemovalKM = Convert.ToDouble(txtRemovalKM.Text);
                }
                else
                {
                    RemovalKM = 0.00;
                }

                if (RemovalKM != 0.00 && RemovalKM > FitmentKM)
                {
                    txtDistanceCovered.Text = Convert.ToString(RemovalKM - FitmentKM);
                    Double DistanceCovered = Convert.ToDouble(txtDistanceCovered.Text);
                    Double cost = (GRNAmount / DistanceCovered);
                    txtPerKMCost.Text = cost.ToString("F2");

                    Double mNeTPay = Math.Round(GRNAmount / DistanceCovered, 0, MidpointRounding.AwayFromZero);
                }
                //else {
                //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "key", "alert('Removal Amount should be grater than " + FitmentKM + "');", true);
                //    txtRemovalKM.Text = "";
                //}
            }
        }
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

        CTIM.BindGetTyreDetails(GV_TyreDetails);
        CountRows = GV_TyreDetails.Rows.Count;
        hdfPendingTyre.Value = Convert.ToString(CountRows);
        txtActualTyre.Text = hdfPendingTyre.Value;

        CTIM.GetVehicleDtls();
        txtAxel.Text = Convert.ToString(CTIM.Tyre_Attached);
        //trSubmit.Visible = true;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    /// 




    protected void OnVehChange(object sender, EventArgs e)
    {

        //string hvehno = hdfKMReading.Value;
        //if (txtVehNo.Text != "" &&( Convert.ToDouble(txtKmReading.Text) > 0 || txtKmReading.Text!=""))
        //if (txtVehNo.Text != "" && Convert.ToDouble(txtKmReading.Text) > 0 && Convert.ToDouble(txtKmReading.Text)> Convert.ToDouble(hdfKMReading.Value))

        if (txtVehNo.Text != "" && txtKmReading.Text != "")
        {

            cls_TyreIssueMaster objJs = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
            objJs.VEH_NO = txtVehNo.Text;
            objJs.Check_KM();
            hdfKMReading.Value = objJs.KM.ToString();


            //if (hdfKMReading.Value == "")
            //{
            //    hdfKMReading.Value = txtKmReading.Text;
            //}
            if (Convert.ToDouble(txtKmReading.Text) > 0 && Convert.ToDouble(txtKmReading.Text) > Convert.ToDouble(hdfKMReading.Value))
            //if (Convert.ToDouble(txtKmReading.Text) > 0 )
            {
                //hdfKMReading.Value = txtKmReading.Text.Trim();
                cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
                CTIM.TD_ID = "";
                CTIM.VEH_NO = txtVehNo.Text.ToString().Trim();
                trRemove.Visible = true;
                tblGrid.Visible = true;
                tblRemoval.Visible = true;
                txtKmReading.Enabled = false;
                txtVehNo.Enabled = false;
                //Display Removal tyres
                CTIM.BindGetTyreDetails(GV_TyreDetails);

                //Display Tyres for Issue
                trIssueTyre.Visible = true;
                BindGrid();

                CalDistance_Cost();
                //RETURN TYRES AS PER AXEL 
                CTIM.GetVehicleDtls();
                txtAxel.Text = Convert.ToString(CTIM.Tyre_Attached);

                CountRows = GV_TyreDetails.Rows.Count;
                hdfPendingTyre.Value = Convert.ToString(CountRows);
                txtActualTyre.Text = Convert.ToString(Convert.ToInt32(hdfPendingTyre.Value));//+ Convert.ToInt32(txtAxel.Text));
                txtPendingTyre.Text = Convert.ToString(Convert.ToInt32(txtActualTyre.Text) - Convert.ToInt32(txtAxel.Text));

                if (CountRows > 0)
                {
                    //trRemoval.Visible = true;
                    tblGrid.Visible = true;
                    //trSubmit.Visible = true;
                    //trSubmit_New.Visible = false;
                }
                else
                {
                    //// trRemoval.Visible = false;
                    tblGrid.Visible = false;
                    //trSubmit.Visible = false;
                    //trSubmit_New.Visible = true;
                }
            }
            else
            {
                tblRemoval.Visible = false;
                trRemove.Visible = false;
                tblGrid.Visible = false;
                trIssueTyre.Visible = false;

            }
        }
        else
        {
            tblRemoval.Visible = false;
            trRemove.Visible = false;
            tblGrid.Visible = false;
            trIssueTyre.Visible = false;
            //tblIssueTyre.Visible = false;
        }

        if (GVTyreDetails.Rows.Count > 0 ||GV_TyreDetails.Rows.Count > 0)
        {
            trSubmit.Visible = true;
        }
        else
        {
            trSubmit.Visible = false;
        }
    }

    /// <summary>
    /// save records into table
    /// Display previous issued Tyre No. for Removal
    /// and redirect to result page
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit1_Click(object sender, EventArgs e)
    {
        hdfKMReading.Value = txtKmReading.Text.Trim();
        Boolean IsCommited = false;
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        CTIM.TD_ID = "";
        CTIM.VEH_NO = txtVehNo.Text.ToString().Trim();

        ///======================================
        System.Globalization.DateTimeFormatInfo dtfi = new System.Globalization.DateTimeFormatInfo();
        dtfi.ShortDatePattern = "dd MMM yyyy";
        dtfi.DateSeparator = "/";
        dtfi.ShortTimePattern = "hh:mm tt";
        DateTime Date = Convert.ToDateTime(txtDate.Text.Trim(), dtfi);

        CTIM.VEH_NO = txtVehNo.Text.ToString().Trim();
        if (txtDate.Text != "")
        {
            CTIM.IssueDate = Convert.ToDateTime(Common.getDateInddMMMyyyFormat(txtDate.Text.Replace("'", "''")));//Date; // DateFunction.ConvertStringToDate(txtDate.Text.Trim()).ToString("MM/dd/yyyy");
        }
        //txtDate.Text.ToString().Trim();
        CTIM.KM_RUN = Convert.ToInt32(txtKmReading.Text.ToString().Trim());
        //try
        //{
        foreach (GridViewRow r in GVTyreDetails.Rows)
        {
            CheckBox chkSelected = (CheckBox)GVTyreDetails.Rows[r.RowIndex].FindControl("chkSelected");
            //CTIM.MAKE = ((TextBox)GVTyreDetails.Rows[r.RowIndex].FindControl("lblMake")).Text.ToString().Trim();
            CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.ToString().Trim();
            Label lblTyreNo = (Label)GVTyreDetails.Rows[r.RowIndex].FindControl("lblTyreNo");
            HiddenField hdfTyreNo = (HiddenField)GVTyreDetails.Rows[r.RowIndex].FindControl("hdfTyreNo");
            try
            {
                CTIM.TYRE_ID = hdfTyreNo.Value.Trim();
                if (chkSelected.Checked)
                {
                    ////CTIM.UpdateTyreDtl();
                    IsCommited = true;
                }
            }
            catch (Exception ex)
            {
                lbl_Page_Error.Text = ex.Message.ToString();
            }
        }
        if (IsCommited == true)
        {
            tblGrid.Visible = true;
            // Response.Redirect("TyreIssueMsg.aspx");
        }
        //====================================

        ///////
        //--------------------------------Bind Grid 2 ;Display previous issued tyre no for Removal.        
        CTIM.BindGetTyreDetails(GV_TyreDetails);
        CalDistance_Cost();
        //RETURN TYRES AS PER AXEL 
        CTIM.GetVehicleDtls();
        txtAxel.Text = Convert.ToString(CTIM.Tyre_Attached);

        CountRows = GV_TyreDetails.Rows.Count;
        hdfPendingTyre.Value = Convert.ToString(CountRows);
        txtActualTyre.Text = Convert.ToString(Convert.ToInt32(hdfPendingTyre.Value) + Convert.ToInt32(txtAxel.Text));
        txtPendingTyre.Text = Convert.ToString(Convert.ToInt32(txtActualTyre.Text) - Convert.ToInt32(txtAxel.Text));

        if (CountRows > 0)
        {
            //trRemoval.Visible = true;
            tblGrid.Visible = true;
            //trSubmit.Visible = true;
            //trSubmit_New.Visible = false;
        }
        else
        {
            //// trRemoval.Visible = false;
            tblGrid.Visible = false;
            //trSubmit.Visible = false;
            //trSubmit_New.Visible = true;
        }
        //////

        //}
        //catch (Exception ex)
        //{
        //    lbl_Page_Error.Text = ex.Message.ToString();
        //}
        //finally
        //{
        //    //lbl_Page_Error.ForeColor = System.Drawing.Color.Red;                         
        //    btnSubmit.Enabled = false;
        //}
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
        //CTIM.REMOVAL_DATE = DT;
        ////CTIM.REMOVAL_DATE = Convert.ToDateTime(Common.getDateInddMMMyyyFormat(txtRemoveDT.Text.Replace("'", "''")));



        //updated by vidya on 21 jan 2014
        /*if (txtRemoveDT.Visible == true)
        {
            CTIM.REMOVAL_DATE = Convert.ToDateTime(Common.getDateInddMMMyyyFormat(txtRemoveDT.Text.Replace("'", "''")));
            //Date; // DateFunction.ConvertStringToDate(txtDate.Text.Trim()).ToString("MM/dd/yyyy");
        }
        else
        {
            CTIM.REMOVAL_DATE = Convert.ToDateTime(Common.getDateInddMMMyyyFormat("1/1/1950 12:00:00 AM"));
        }*/


        string mCheckSelected = "N";
        foreach (GridViewRow r in GV_TyreDetails.Rows)
        {
            CheckBox chkSelected1 = (CheckBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("chkSelected1");
            if (chkSelected1.Checked)
            {
                mCheckSelected = "Y";
            }
        }

        if (mCheckSelected == "Y")
        {
            CTIM.REMOVAL_DATE = Convert.ToDateTime(Common.getDateInddMMMyyyFormat(txtRemoveDT.Text.Replace("'", "''")));
        }
        else
        {
            CTIM.REMOVAL_DATE = Convert.ToDateTime(Common.getDateInddMMMyyyFormat("1/1/1950 12:00:00 AM"));
        }
        //Date; // DateFunction.ConvertStringToDate(txtDate.Text.Trim()).ToString("MM/dd/yyyy");
        CTIM.VEH_NO = txtVehNo.Text;
        CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.ToString().Trim();

        try
        {
            //For Removal tyre
            foreach (GridViewRow r in GV_TyreDetails.Rows)
            {
                CheckBox chkSelected1 = (CheckBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("chkSelected1");
                HiddenField hdfTyreNo = (HiddenField)GV_TyreDetails.Rows[r.RowIndex].FindControl("hdfTyreNo");
                Label lblFitmentDate = (Label)GV_TyreDetails.Rows[r.RowIndex].FindControl("lblFitmentDate");
                TextBox txtRemovalKM = (TextBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("txtRemovalKM");
                TextBox txtDistanceCovered = (TextBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("txtDistanceCovered");
                TextBox txtPerKMCost = (TextBox)GV_TyreDetails.Rows[r.RowIndex].FindControl("txtPerKMCost");

                if (chkSelected1.Checked)
                {
                    if (txtRemovalKM.Text != "")
                    {
                        REMOVAL_KM = Convert.ToDouble(txtRemovalKM.Text.Trim());
                    }
                    CTIM.RemovalKM = REMOVAL_KM;//Convert.ToInt32(txtRemovalKM.Text);
                    CTIM.TYRE_LOC = SessionUtilities.CurrentBranchCode.ToString().Trim();
                    //CTIM.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();
                    CTIM.TYRE_ID = hdfTyreNo.Value;
                    CTIM.Dist_Covered = Convert.ToDouble(txtDistanceCovered.Text);
                    PerKMCost = Convert.ToDouble(txtPerKMCost.Text);
                    CTIM.CostPerKM = Math.Round(PerKMCost, 2);//Convert.ToDouble(txtPerKMCost.Text);
                    CTIM.UpdateRemovalTyreDtl();
                    // lblMsg.ForeColor = System.Drawing.Color.Green;
                    // lblMsg.Text = "Tyre Removed successfully. !!!!";
                    IsCommit = true;
                }
            }


            //For Tyre in Stock 

            CTIM.TD_ID = "";
            CTIM.VEH_NO = txtVehNo.Text.ToString().Trim();

            ///======================================

            dtfi.ShortDatePattern = "dd MMM yyyy";
            dtfi.DateSeparator = "/";
            dtfi.ShortTimePattern = "hh:mm tt";
            DateTime Date = Convert.ToDateTime(txtDate.Text.Trim(), dtfi);

            CTIM.VEH_NO = txtVehNo.Text.ToString().Trim();
            if (txtDate.Text != "")
            {
                CTIM.IssueDate = Convert.ToDateTime(Common.getDateInddMMMyyyFormat(txtDate.Text.Replace("'", "''")));//Date; // DateFunction.ConvertStringToDate(txtDate.Text.Trim()).ToString("MM/dd/yyyy");
            }
            //txtDate.Text.ToString().Trim();
            CTIM.KM_RUN = Convert.ToInt32(txtKmReading.Text.ToString().Trim());
            CTIM.TYRE_LOC = SessionUtilities.CurrentBranchCode.ToString().Trim();
            foreach (GridViewRow r in GVTyreDetails.Rows)
            {
                CheckBox chkSelected = (CheckBox)GVTyreDetails.Rows[r.RowIndex].FindControl("chkSelected");
                //CTIM.MAKE = ((TextBox)GVTyreDetails.Rows[r.RowIndex].FindControl("lblMake")).Text.ToString().Trim();
                CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.ToString().Trim();
                Label lblTyreNo = (Label)GVTyreDetails.Rows[r.RowIndex].FindControl("lblTyreNo");
                HiddenField hdfTyreNo = (HiddenField)GVTyreDetails.Rows[r.RowIndex].FindControl("hdfTyreNo");
                try
                {
                    CTIM.TYRE_ID = hdfTyreNo.Value.Trim();
                    if (chkSelected.Checked)
                    {
                        CTIM.UpdateTyreDtl();
                        IsCommit = true;
                    }
                }
                catch (Exception ex)
                {
                    lbl_Page_Error.Text = ex.Message.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = ex.Message.ToString();
        }
        finally
        {
            // btnSubmit.Visible = false;
        }
        if (IsCommit == true)
        {
            Response.Redirect("TyreRemovalMsg.aspx?Flag=U");
        }
    }
    //protected void btnSubmit_New_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("TyreRemovalMsg.aspx?Flag=I");
    //}
}