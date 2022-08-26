using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using ApplicationManager;

public partial class GUI_Fleet_Operations_Issue_frmCheckListEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        tb_Description.Attributes.Add("OnBlur", "javascript:CheckValidChecklist(" + tb_Description.ClientID.ToString() + ");");
        if (!IsPostBack)
        {
            BindData(gvChecklist);
            RowNo.Style["display"] = "none";
            System.DateTime righnow = System.DateTime.Today;
            string strrightnow = righnow.ToString("dd/MM/yyyy");
            hfTodayDate.Value = righnow.ToString("dd/MM/yyyy");
            BindDropDown("usp_CheckList_Category", "CodeDesc", "CodeId", ddl_Category);
            Bind("usp_DocumentNameCode", "CodeDesc", "CodeId", lst_Document);
        }
    }
    protected void gvChecklist_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            DropDownList ddl_Category = (DropDownList)e.Row.FindControl("ddl_Category");
            ListBox lst_Document = (ListBox)e.Row.FindControl("lst_Document");

        }
    }

    protected void lnk_btn_Add_Click(object sender, EventArgs e)
    {
        lbl_Page_Error.Text = "";
        RowNo.Style["display"] = "block";
    }

    protected void gvChecklist_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvChecklist.PageIndex = e.NewPageIndex;
        BindData(gvChecklist);
    }

    protected void gvChecklist_SelectedIndexChanged(object sender, EventArgs e)
    {
        RowNo.Style["display"] = "block";
        lbl_Page_Error.Text = "";
        Label lbl_Category = (Label)gvChecklist.Rows[gvChecklist.SelectedIndex].FindControl("lbl_Category");
        Label lbl_Description = (Label)gvChecklist.Rows[gvChecklist.SelectedIndex].FindControl("lbl_Description");
        Label lbl_Document = (Label)gvChecklist.Rows[gvChecklist.SelectedIndex].FindControl("lbl_Document");
        HiddenField hfId1 = (HiddenField)gvChecklist.Rows[gvChecklist.SelectedIndex].FindControl("hfId");
        HiddenField hfcatcode = (HiddenField)gvChecklist.Rows[gvChecklist.SelectedIndex].FindControl("hfcatcode");
        HiddenField hfdoccode = (HiddenField)gvChecklist.Rows[gvChecklist.SelectedIndex].FindControl("hfdoccode");
        Label lbl_Active_Flag = (Label)gvChecklist.Rows[gvChecklist.SelectedIndex].FindControl("lbl_Active_Flag");

        ddl_Category.SelectedValue = hfcatcode.Value;
       
        string[] strArrCatId = hfdoccode.Value.ToString().Split(',');
        for (int i = 0; i < lst_Document.Items.Count; i++)
        {
            if (lst_Document.Items[i].Selected = true)
            {
                lst_Document.Items[i].Selected = false;
            }
        }
        for (int i = 0; i < strArrCatId.Length; i++)
        {
            for (int j = 0; j < lst_Document.Items.Count; j++)
            {
                if (strArrCatId[i] == lst_Document.Items[j].Value)
                {
                    lst_Document.Items[j].Selected = true;
                }
            }
        }
        

        tb_Description.Text = lbl_Description.Text;
        if (lbl_Active_Flag.Text == "Y")
        {
            chk_Active_Flag.Checked = true;
        }
        else
        {
            chk_Active_Flag.Checked = false;
        }
        hfId.Value = hfId1.Value;
    }

    public void BindData(GridView gv)
    {
        cls_CheckList_Mst objChecklist = new cls_CheckList_Mst(Session["SqlProvider"].ToString().Trim());
        objChecklist.BindGridChecklist(gv);
        gv.SelectedIndex = -1;
    }

    protected void btn_Cencel_Click(object sender, EventArgs e)
    {
        RowNo.Style["display"] = "none";
        BindData(gvChecklist);
        lbl_Category_Err.Text = "";
        ddl_Category.SelectedValue = "0";
        lbl_Page_Error.Text = "";
        tb_Description.Text = "";
        lbl_Desc_Err.Text = "";
        for (int i = 0; i < lst_Document.Items.Count; i++)
        {
            if (lst_Document.Items[i].Selected = true)
            {
                lst_Document.Items[i].Selected = false;
            }
        }
    }

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

    public void Bind(string strProc, string text, string value, ListBox l)
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
                l.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {

        cls_CheckList_Mst objChecklist = new cls_CheckList_Mst(Session["SqlProvider"].ToString().Trim());
        bool IsCommitted = false, IsDuplicate = false;
        string selDocument = "";

        try
        {
            objChecklist.Chk_Cat = ddl_Category.SelectedValue.ToString();
            objChecklist.Chk_Desc = tb_Description.Text.ToString().Trim();
            for (int i = 0; i < lst_Document.Items.Count; i++)
            {
                if (lst_Document.Items[i].Selected == true)
                {
                    selDocument = selDocument + "," + lst_Document.Items[i].Value;
                }
            }
            objChecklist.Chk_Document_Shown = selDocument.Substring(1, selDocument.Length - 1);
            objChecklist.EntryBy = SessionUtilities.CurrentEmployeeID.ToString().Trim();
            objChecklist.UpdatedBy = SessionUtilities.CurrentEmployeeID.ToString().Trim();
            objChecklist.UpdatedDt = DTM.ConvertToDate(hfTodayDate.Value.ToString());
            objChecklist.Company_Code = SessionUtilities.DefaultCompanyCode.ToString().Trim();
            if (chk_Active_Flag.Checked == true) { objChecklist.ActiveFlag = "Y"; } else { objChecklist.ActiveFlag = "N"; }

            objChecklist.BeginTransaction();
            try
            {
                if (hfId.Value == "")
                {
                    objChecklist.Chk_ID = "";
                    objChecklist.InsertCheckList();
                }
                else
                {
                    objChecklist.Chk_ID = hfId.Value;
                    objChecklist.UpdateCheckList();
                }
                IsCommitted = objChecklist.CommitTransaction();
            }
            catch (Exception ex)
            {
                objChecklist.RollBackTransaction();
                lbl_Page_Error.Text = ex.Message.ToString();
            }
        }
        catch (Exception ex)
        {

            lbl_Page_Error.Text = ex.Message.ToString();
        } 
        if (IsCommitted)
        {
            lbl_Page_Error.ForeColor = System.Drawing.Color.Green;
            lbl_Page_Error.Text = "CheckList Successfully Updated.";
            BindData(gvChecklist);
            hfId.Value = "";
            lbl_Category_Err.Text = "";
            ddl_Category.SelectedValue = "0";
            tb_Description.Text = "";
            lbl_Desc_Err.Text = "";
            chk_Active_Flag.Checked = false;
            for (int i = 0; i < lst_Document.Items.Count; i++)
            {
                if (lst_Document.Items[i].Selected = true)
                {
                    lst_Document.Items[i].Selected = false;
                }
            }
            RowNo.Style["display"] = "none";
        }
    }

}
