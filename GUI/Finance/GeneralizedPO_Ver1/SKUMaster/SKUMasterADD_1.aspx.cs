using System;
using System.Data;
using System.IO;
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

public partial class GUI_Finance_GeneralizedPO_SKUMaster_SKUMasterADD : System.Web.UI.Page
{
    DataTable dt = new DataTable("table1");
    public static string straccd, p;
    protected void Page_Load(object sender, EventArgs e)
    {
        p = Request.QueryString["Operation"].ToString();
        if (!IsPostBack && !IsCallback)
        {
            straccd = "";
            if (p == "ADD")
            {
                for (int i = 0; i < 5; i++)
                {
                    dt.Rows.Add();
                }
                grvcontrols.DataSource = dt;
                grvcontrols.DataBind();
                tblAddRow.Style["display"] = "block";
            }
            else
            {
                straccd = Request.QueryString["SKUID"].ToString();
                for (int i = 0; i < 1; i++)
                {
                    dt.Rows.Add();
                }
                grvcontrols.DataSource = dt;
                grvcontrols.DataBind();
                tblAddRow.Style["display"] = "none";
                FillData();
            }
        }
    }
    protected void GvDocketDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlMatCat = e.Row.FindControl("ddlMatCat") as DropDownList;
            DataTable dsMatCat = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, "SELECT '' AS CodeID,'--Select--' AS CodeDesc UNION SELECT CodeID,CodeDesc FROM webx_master_general WHERE Codetype='MATCAT' AND StatusCode='Y'").Tables[0];
            ddlMatCat.DataSource = dsMatCat;
            ddlMatCat.DataTextField = "CodeDesc";
            ddlMatCat.DataValueField = "CodeID";
            ddlMatCat.DataBind();

            DropDownList ddlUOM = e.Row.FindControl("ddlUOM") as DropDownList;
            string Sql = "Select CodeDesc,CodeId From (SELECT '--Select--' AS CodeDesc,0 AS CodeId UNION SELECT CodeDesc,CodeId FROM WEBX_MASTER_GENERAL WHERE CODETYPE='UOM' and StatusCode='Y' ) T Order by T.Codeid ";
            DataTable UomDt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql).Tables[0];
            ddlUOM.DataSource = UomDt;
            ddlUOM.DataBind();
        }
    }
    protected void btnrows_Click(object sender, EventArgs e)
    {
        Int16 maxrows = 0;
        if (txtnorows.Text.ToString().CompareTo("") != 0)
        {
            try
            {
                maxrows = Convert.ToInt16(txtnorows.Text);
            }
            catch (Exception ex)
            {
                txtnorows.Text = "";
                txtnorows.Focus();
            }
        }
        for (int i = 0; i < maxrows; i++)
        {
            dt.Rows.Add();
        }
        grvcontrols.DataSource = dt;
        grvcontrols.DataBind();
    }
    public void GenerateNextCode()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "SELECT ISNULL(MAX(CONVERT(INT,SUBSTRING(SKU_ID,4,6))),0)+1 AS MAXOCAGCD FROM webx_PO_SKU_Master";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        int cd1 = (int)sqlcmd.ExecuteScalar();
        HidLastSKUCode.Value = cd1.ToString();
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string SKUCode = "";
        string TotalSKU = "";
        conn.Open();
        GenerateNextCode();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            string sql = "";
            for (int i = 0; i < grvcontrols.Rows.Count; i++)
            {
                if (((CheckBox)grvcontrols.Rows[i].FindControl("ChkSel")).Checked == true)
                {
                    DropDownList ddlMatCat = (DropDownList)grvcontrols.Rows[i].FindControl("ddlMatCat");
                    DropDownList ddlUOM = (DropDownList)grvcontrols.Rows[i].FindControl("ddlUOM");
                    TextBox txtSKUDesc = (TextBox)grvcontrols.Rows[i].FindControl("txtSKUDesc");
                    TextBox txtManufacture = (TextBox)grvcontrols.Rows[i].FindControl("txtManufacture");
                    TextBox txtSKUType = (TextBox)grvcontrols.Rows[i].FindControl("txtSKUType");
                    TextBox txtSKUSize = (TextBox)grvcontrols.Rows[i].FindControl("txtSKUSize");
                    TextBox txtRemark = (TextBox)grvcontrols.Rows[i].FindControl("txtRemark");
                    CheckBox ChkActive = (CheckBox)grvcontrols.Rows[i].FindControl("ChkActive");
                    TextBox txtUDF1 = (TextBox)grvcontrols.Rows[i].FindControl("txtUDF1");
                    TextBox txtUDF2 = (TextBox)grvcontrols.Rows[i].FindControl("txtUDF2");
                    TextBox txtUDF3 = (TextBox)grvcontrols.Rows[i].FindControl("txtUDF3");
                    TextBox txtUDF4 = (TextBox)grvcontrols.Rows[i].FindControl("txtUDF4");
                    TextBox txtUDF5 = (TextBox)grvcontrols.Rows[i].FindControl("txtUDF5");
                    if (p == "ADD")
                    {
                        SKUCode = NextSKUCode(i);
                        string ACtive = (ChkActive.Checked ? "Y" : "N");
                        sql = "INSERT INTO Webx_PO_SKU_Master (SKU_ID,SKU_Desc,MatCat_Id,Mfg_Desc,SKU_Type,SKU_Size,SKU_Remark,SKU_UOM,SKU_UDF1,SKU_UDF2,SKU_UDF3,SKU_UDF4,SKU_UDF5,ActiveFlag,EntryBy,EntryDt,UOM_ID) ";
                        sql = sql + "values('" + SKUCode + "','" + txtSKUDesc.Text + "','" + ddlMatCat.SelectedValue + "','" + txtManufacture.Text + "','" + txtSKUType.Text + "','" + txtSKUSize.Text + "','" + txtRemark.Text + "','" + ddlUOM.SelectedItem.ToString() + "','" + txtUDF1.Text.ToString() + "','" + txtUDF2.Text.ToString() + "','" + txtUDF3.Text.ToString() + "','" + txtUDF4.Text.ToString() + "','" + txtUDF5.Text.ToString() + "','" + ACtive.ToString() + "','" + SessionUtilities.CurrentEmployeeID + "',getdate(),'" + ddlUOM.SelectedValue.ToString() + "')";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql);
                        if (TotalSKU == "")
                        {
                            TotalSKU = SKUCode;
                        }
                        else
                        {
                            TotalSKU = TotalSKU + "," + SKUCode;
                        }
                    }
                    else
                    {
                        string ACtive = (ChkActive.Checked ? "Y" : "N");
                        sql = "UPDATE Webx_PO_SKU_Master ";
                        sql = sql + "SET SKU_Desc = '" + txtSKUDesc.Text + "',MatCat_Id = '" + ddlMatCat.SelectedValue + "',Mfg_Desc = '" + txtManufacture.Text + "',SKU_Type = '" + txtSKUType.Text + "',SKU_Size = '" + txtSKUSize.Text + "',SKU_UOM = '" + ddlUOM.SelectedItem.ToString() + "',SKU_UDF1 = '" + txtUDF1.Text.ToString() + "',SKU_UDF2 = '" + txtUDF2.Text.ToString() + "'";
                        sql = sql + ",SKU_UDF3 = '" + txtUDF3.Text.ToString() + "',SKU_UDF4 = '" + txtUDF4.Text.ToString() + "',SKU_UDF5 = '" + txtUDF5.Text.ToString() + "',ActiveFlag = '" + ACtive + "',UpdateBy = '" + SessionUtilities.CurrentEmployeeID + "',UpdateDt = getdate(),SKU_Remark = '" + txtRemark.Text + "'";
                        sql = sql + ",UOM_ID = '" + ddlUOM.SelectedValue.ToString() + "'";
                        sql = sql + "WHERE SKU_ID='" + straccd + "'";
                        SqlHelper.ExecuteNonQuery(trans, CommandType.Text, sql);
                        TotalSKU = straccd;
                    }
                }
            }
            trans.Commit();
            conn.Close();
            Response.Redirect("SKUMasterDone.aspx?DocTypeFlag=" + p + "&SKUCode=" + TotalSKU, false);
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            Response.End();
        }
    }
    public string NextSKUCode(Int32 RowIndex)
    {
        string cd = "";
        Int32 NextCode = Convert.ToInt32(HidLastSKUCode.Value) + RowIndex;
        cd = Convert.ToString(NextCode);
        if (cd.Length == 1)
        {
            cd = "SKU" + "0000" + cd;
        }
        else if (cd.Length == 2)
        {
            cd = "SKU" + "000" + cd;
        }
        else if (cd.Length == 3)
        {
            cd = "SKU" + "00" + cd;
        }
        else if (cd.Length == 4)
        {
            cd = "SKU" + "0" + cd;
        }
        else if (cd.Length == 5)
        {
            cd = "SKU" + cd;
        }
        return cd;
    }
    public void FillData()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string q = "SELECT * FROM webx_PO_SKU_Master WHERE SKU_ID='" + straccd + "'";
        SqlCommand c = new SqlCommand(q, cn);
        SqlDataReader dr = c.ExecuteReader();
        while (dr.Read())
        {
            DropDownList ddlMatCat = (DropDownList)grvcontrols.Rows[0].FindControl("ddlMatCat");
            DropDownList ddlUOM = (DropDownList)grvcontrols.Rows[0].FindControl("ddlUOM");
            TextBox txtSKUDesc = (TextBox)grvcontrols.Rows[0].FindControl("txtSKUDesc");
            TextBox txtManufacture = (TextBox)grvcontrols.Rows[0].FindControl("txtManufacture");
            TextBox txtSKUType = (TextBox)grvcontrols.Rows[0].FindControl("txtSKUType");
            TextBox txtSKUSize = (TextBox)grvcontrols.Rows[0].FindControl("txtSKUSize");
            TextBox txtRemark = (TextBox)grvcontrols.Rows[0].FindControl("txtRemark");
            CheckBox ChkActive = (CheckBox)grvcontrols.Rows[0].FindControl("ChkActive");
            TextBox txtUDF1 = (TextBox)grvcontrols.Rows[0].FindControl("txtUDF1");
            TextBox txtUDF2 = (TextBox)grvcontrols.Rows[0].FindControl("txtUDF2");
            TextBox txtUDF3 = (TextBox)grvcontrols.Rows[0].FindControl("txtUDF3");
            TextBox txtUDF4 = (TextBox)grvcontrols.Rows[0].FindControl("txtUDF4");
            TextBox txtUDF5 = (TextBox)grvcontrols.Rows[0].FindControl("txtUDF5");

            ddlMatCat.SelectedValue = dr["MatCat_Id"].ToString();
            ddlUOM.SelectedValue = dr["UOM_ID"].ToString();
            txtSKUDesc.Text = dr["SKU_Desc"].ToString();
            txtManufacture.Text = dr["Mfg_Desc"].ToString();
            txtSKUType.Text = dr["SKU_Type"].ToString();
            txtRemark.Text = dr["SKU_Remark"].ToString();
            ChkActive.Checked = (dr["ActiveFlag"].ToString() == "Y" ? true : false);
            txtUDF1.Text = dr["SKU_UDF1"].ToString();
            txtUDF2.Text = dr["SKU_UDF2"].ToString();
            txtUDF3.Text = dr["SKU_UDF3"].ToString();
            txtUDF4.Text = dr["SKU_UDF4"].ToString();
            txtUDF5.Text = dr["SKU_UDF5"].ToString();
            txtSKUSize.Text = dr["SKU_Size"].ToString();
        }
        dr.Close();
    }
}
