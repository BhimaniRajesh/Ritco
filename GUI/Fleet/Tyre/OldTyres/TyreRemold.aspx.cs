using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class GUI_Fleet_Tyre_TyreRemold : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.MinValue);

        if (!IsPostBack)
        {
            cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
            string Str = Request.QueryString["Tyre_ID"];
            //string Str = "T0011,T0012,T0013,T0014,T0015,T0018";
            CTIM.GetTyres_Remold(GV_TyreRemold, Str);
            BindDropDown("USP_VendorList", "Vendor", "vendorcode", ddlVendor);
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
    protected void GV_TyreSale_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            TextBox txtVendorNM = (TextBox)e.Row.FindControl("txtVendorNM");
            TextBox txtAmount = (TextBox)e.Row.FindControl("txtAmount");
            TextBox txtReason = (TextBox)e.Row.FindControl("txtReason");
            //txtAmount.Enabled = false;
            //txtReason.Enabled = false;
            //txtVendorNM.Attributes.Add("OnBlur", "javascript:CheckVendor();");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    ////protected void SelectAll(object sender, EventArgs e)
    ////{
    ////    foreach (GridViewRow GV in GV_TyreRemold.Rows)
    ////    {
    ////        CheckBox chkSelectAll = (CheckBox)GV_TyreRemold.HeaderRow.FindControl("chkSelectAll");
    ////        CheckBox chkSelect = (CheckBox)GV.FindControl("chkSelect");

    ////        if (chkSelectAll.Checked)
    ////        {
    ////            chkSelect.Checked = true;
    ////        }
    ////        else
    ////        {
    ////            chkSelect.Checked = false;
    ////        }
    ////    }
    ////}

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>

    ////protected void ddlRemoldRej_SelectedIndexChanged(object sender, EventArgs e)
    ////{
    ////    foreach (GridViewRow GV in GV_TyreRemold.Rows)
    ////    {
    ////        DropDownList ddlRemoldRej = (DropDownList)GV.FindControl("ddlRemoldRej");
    ////        TextBox txtAmount = (TextBox)GV.FindControl("txtAmount");
    ////        TextBox txtReason = (TextBox)GV.FindControl("txtReason");


    ////        if (ddlRemoldRej.SelectedValue != "0")
    ////        {
    ////            if (ddlRemoldRej.SelectedValue == "Y")
    ////            {
    ////                txtAmount.Enabled = true;
    ////                txtReason.Enabled = false;
    ////            }
    ////            else
    ////            {
    ////                txtAmount.Enabled = false;
    ////                txtAmount.Text = "0.00";
    ////                txtReason.Enabled = true;
    ////            }
    ////        }
    ////        else
    ////        {
    ////            txtAmount.Enabled = false;
    ////            txtReason.Enabled = false;
    ////        }
    ////    }
    ////}
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();
        Boolean IsCommited = false;
        string[] ARR_vendcd;
        string VendorCD = "", VendorNM = "", final = "";
        string Amount = "", Reason = "";
        string mCheck = "REMOLD", mDocuementNo = "";
        GetFinancialYear objFinYear = new GetFinancialYear(Convert.ToString(Session["SqlProvider"]));

        string Xml_PAY_MST = "<root><Tyre_MST>";
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (mCheck == "REMOLD")
        {
            string YearVal = "";

            YearVal = objFinYear.FinancialYear();

            //string mSTR = "WebX_SP_GetNextDocumentCode";
            string mSTR = "WebX_SP_GetNextDocumentCode_FA";
            SqlCommand mcmd1 = new SqlCommand(mSTR, conn);
            mcmd1.CommandType = CommandType.StoredProcedure;
            mcmd1.Parameters.Add("@LocCode", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.ToString().Trim();
            mcmd1.Parameters.Add("@FinYear", SqlDbType.VarChar).Value = YearVal.Substring(0, 2).Trim();
            mcmd1.Parameters.Add("@Document", SqlDbType.VarChar).Value = mCheck;
            SqlDataReader rFR = mcmd1.ExecuteReader();
            if (rFR.Read())
            {
                mDocuementNo = rFR[0].ToString().Trim();
                list.Add(rFR[0].ToString().Trim());
            }
            rFR.Close();
            conn.Close();
        }


        foreach (GridViewRow gridrow in GV_TyreRemold.Rows)
        {
            CheckBox chkSelect = gridrow.FindControl("chkSelect") as CheckBox;
            TextBox txtSysTyreNo = gridrow.FindControl("txtSysTyreNo") as TextBox;
            TextBox txtVendorNM = gridrow.FindControl("txtVendorNM") as TextBox;
            //TextBox txtRemoldDT = gridrow.FindControl("txtRemoldDT") as TextBox;
            TextBox txtAmount = gridrow.FindControl("txtAmount") as TextBox;
            TextBox txtReason = gridrow.FindControl("txtReason") as TextBox;
            TextBox txtDist = gridrow.FindControl("txtDist") as TextBox;
            HiddenField hdfTyreID = gridrow.FindControl("hdfTyreID") as HiddenField;

            if (chkSelect.Checked)
            {
                //ARR_vendcd = txtVendorNM.Text.Split('~');
                //VendorCD = ARR_vendcd[0].ToString();
                //VendorNM = ARR_vendcd[1].ToString();
                //if (txtAmount.Text == "")
                //{
                //    Amount = "0.00";
                //}
                //else
                //{
                //    Amount = txtAmount.Text;
                //}
                //if (txtReason.Text == "")
                //{
                //    Reason = Convert.ToString(DBNull.Value);
                //}
                //else
                //{
                //    Reason = txtReason.Text;
                //}

                list.Add(txtSysTyreNo.Text.Trim());

                CTIM.TYRE_ID = hdfTyreID.Value;//txtSysTyreNo.Text.Trim();
                CTIM.ENTRY_BY = SessionUtilities.CurrentEmployeeID.Trim();
                CTIM.CLAIM_REMOLD_SALE_ID = mDocuementNo;
                CTIM.VendorCode = ddlVendor.SelectedValue.Trim();
                CTIM.ACTION_DT = txtRemoldDT.Text.Trim();
                CTIM.BRANCH = SessionUtilities.CurrentBranchCode.Trim();
                CTIM.STATUS = "Pending";
                CTIM.Actions = "REMOLD";
                CTIM.REMOLD_AMT = 0;
                CTIM.Suffix = "R";
                CTIM.Dist_Covered = Convert.ToDouble(txtDist.Text.Trim());

                CTIM.UpdateTyreDtl_RemoldNew();
                IsCommited = true;

                ////Xml_PAY_MST = Xml_PAY_MST + "<TYRE_ID>" + txtSysTyreNo.Text.ToString() + "</TYRE_ID>";
                ////Xml_PAY_MST = Xml_PAY_MST + "<Suffix>R</Suffix>";
                ////Xml_PAY_MST = Xml_PAY_MST + "<Actions>Remold</Actions>";
                ////Xml_PAY_MST = Xml_PAY_MST + "<VendorCode>" + VendorCD.Trim() + "</VendorCode>";
                ////Xml_PAY_MST = Xml_PAY_MST + "<Remold_Amt>" + Amount.Trim() + "</Remold_Amt>";
                ////if (txtRemoldDT.Text != "")
                ////{
                ////    Xml_PAY_MST = Xml_PAY_MST + "<Remold_DT>" +txtRemoldDT.Text.Trim() + "</Remold_DT>";
                ////}
                ////else
                ////{
                ////    Xml_PAY_MST = Xml_PAY_MST + "<Remold_DT></Remold_DT>";
                ////}
                ////Xml_PAY_MST = Xml_PAY_MST + "<R_Remark>" + Reason.Trim() + "</R_Remark>";
            }
        }
        Xml_PAY_MST = Xml_PAY_MST + "</Tyre_MST></root>";
        CTIM.XMLData = Xml_PAY_MST.Trim();
        ////CTIM.UpdateTyreDtl_Remold();


        IsCommited = true;

        for (int i = 0; i < list.Count; i++)
        {
            if (final == "")
            {
                final = list[i];
            }
            else
            {
                final = final + "," + list[i];
            }
        }

        if (IsCommited)
        {
            btnSubmit.Enabled = false;
            ////Response.Redirect("TyreUpdate_Msg.aspx?Tyre_ID=" + final.Trim());
            Response.Redirect("ClaimMsg.aspx?ID=" + mDocuementNo);
        }
    }
}