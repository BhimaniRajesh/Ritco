using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Fleet_Tyre_OldTyreStock_Query : System.Web.UI.Page
{
    public DataTable dt_san = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //btnAddRows_Click_pageload(sender, e);
            BindGrid();
            btnSubmit.Text = "Submit";
            //btnSubmit.Attributes.Add("OnClick", "javascript:CheckAction();");
        }
    }
    /// <summary>
    /// Bind grid on page load
    /// display list of old tyres (removal tyres + rejected tyres after claim/remold )
    /// </summary>
    public void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        //string sql = "USP_OldTyre_List";
        string sql = "USP_OldTyre_List_new";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        sqlcmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.SelectCommand.Parameters.Add("@Branch", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode.Trim();
        DataTable dtRoute = new DataTable();

        //da.SelectCommand.Parameters.Add("@FuelReqID", SqlDbType.VarChar).Value = Request.QueryString["FuelReqID"].ToString().Trim();

        DataSet ds = new DataSet();
        da.Fill(ds);

        GV_OldTyre.DataSource = ds;
        GV_OldTyre.DataBind();
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SelectAll(object sender, EventArgs e)
    {
        foreach (GridViewRow GV in GV_OldTyre.Rows)
        {
            CheckBox chkSelectAll = (CheckBox)GV_OldTyre.HeaderRow.FindControl("chkSelectAll");
            CheckBox chkSelect = (CheckBox)GV.FindControl("chkSelect");

            if (chkSelectAll.Checked)
            {
                chkSelect.Checked = true;
            }
            else
            {
                chkSelect.Checked = false;
            }
        }
    }

    protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
    {
        //foreach (GridViewRow r in GV_OldTyre.Rows)
        //{
        //    DropDownList ddlAction = r.FindControl("ddlAction") as DropDownList;
        //    if (ddlAction.SelectedValue != "I")
        //    {
        //        btnSubmit.Text = "Step-1";
        //    }
        //    else
        //    {

        //        btnSubmit.Text = "Submit";
        //    }
        //}

        if (ddlAction.SelectedValue != "I")
        {
            btnSubmit.Text = "Step-1";
        }
        else
        {
            btnSubmit.Text = "Submit";
        }
    }

    /// <summary>
    /// add 1 row on page load
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnAddRows_Click_pageload(object sender, EventArgs e)
    {
        //tblGrid.Visible = true;
        DataRow drow;
        for (int i = 0; i < 1; i++)
        {
            drow = dt_san.NewRow();
            dt_san.Rows.Add(drow);
        }
        GV_OldTyre.DataSource = dt_san;
        GV_OldTyre.DataBind();
        //btnSubmit.Visible = true;
    }
    /// <summary>
    /// save records
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();

        Boolean IsCommited = false;
        string Action = "", final = "";
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        foreach (GridViewRow r in GV_OldTyre.Rows)
        {
            CheckBox chkSelect = r.FindControl("chkSelect") as CheckBox;
            TextBox txtSysTyreNo = r.FindControl("txtSysTyreNo") as TextBox;
            HiddenField hdfTYRE_ID = r.FindControl("hdfTYRE_ID") as HiddenField;
            // DropDownList ddlAction = r.FindControl("ddlAction") as DropDownList;

            if (chkSelect.Checked)
            {
                if (ddlAction.SelectedValue == "I")
                {
                    CTIM.TYRE_ID = hdfTYRE_ID.Value; //txtSysTyreNo.Text.Trim();
                    list.Add(hdfTYRE_ID.Value);
                    CTIM.Actions = ddlAction.SelectedItem.ToString().Trim();
                    CTIM.Suffix = ddlAction.SelectedValue.ToString().Trim();

                    CTIM.UpdateOldTyreDtl();
                    IsCommited = true;
                }
                else
                {
                    list.Add(hdfTYRE_ID.Value.Trim());
                    IsCommited = true;
                }
            }
        }
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
            if (ddlAction.SelectedValue == "S")
            {
                Response.Redirect("TyreSale.aspx?Tyre_ID=" + final.Trim());
            }
            else if (ddlAction.SelectedValue == "C")
            {
                Response.Redirect("TyreClaim_New.aspx?Tyre_ID=" + final.Trim());
            }
            else if (ddlAction.SelectedValue == "R")
            {
                Response.Redirect("TyreRemold.aspx?Tyre_ID=" + final.Trim());
            }
            else
            {
                Response.Redirect("TyreUpdate_Msg.aspx?Tyre_ID=" + final.Trim());
                btnSubmit.Enabled = false;
            }

        }
    }
}