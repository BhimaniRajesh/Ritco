using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class GUI_Fleet_Tyre_OldTyreStock_Query : BasePage
{
    public DataTable dt_san = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        UserMessage.Hide();
        if (!IsPostBack)
        {
            //btnAddRows_Click_pageload(sender, e);
            CreateToken();
            //BindGrid();
			
            btnSubmit.Text = "Submit";
            //btnSubmit.Attributes.Add("OnClick", "javascript:CheckAction();");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gwTyreList_PageIndexChanged(object sender, EventArgs e)
    {
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gwTyreList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_OldTyre.PageIndex = e.NewPageIndex;
        GV_OldTyre.DataBind();
        BindGrid();
    }

    /// <summary>
    /// Bind grid on page load
    /// display list of old tyres (removal tyres + rejected tyres after claim/remold )
    /// </summary>
    public void BindGrid()
    {

        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(SessionUtilities.ConnectionString.Trim());
        CTIM.TYRE_LOC = SessionUtilities.CurrentBranchCode.ToString().Trim();
		
		
        
		
        var dt = new DataTable();
        dt = CTIM.BindOldTyreDetails(txtVehicleNo.Text,ddlAction.SelectedItem.Value);
	
        GV_OldTyre.DataSource = dt;
        GV_OldTyre.DataBind();

        //SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //conn.Open();
        ////string sql = "USP_OldTyre_List";
        //string sql = "USP_OldTyre_List_new";
        //SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.StoredProcedure;
        //SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        ////DataTable dtRoute = new DataTable();

        ////da.SelectCommand.Parameters.Add("@FuelReqID", SqlDbType.VarChar).Value = Request.QueryString["FuelReqID"].ToString().Trim();

        //DataSet ds = new DataSet();
        //da.Fill(ds);

        //GV_OldTyre.DataSource = ds;
        //GV_OldTyre.DataBind();


        if (GV_OldTyre.Rows.Count > 0)
        {
            trSubmit.Visible = true;
			ddlAction.Enabled=false;
			txtVehicleNo.Enabled=false;
        }
        else
        {
            trSubmit.Visible = false;
        }
    }
    /// <summary>
    /// change button caption as per selection of Action
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAction.SelectedValue != "I")
        {
            btnSubmit.Text = "Step-1";
        }
        else
        {
            btnSubmit.Text = "Submit";
        }
		// if (ddlAction.SelectedItem.Value == "K")
        // {
            // txtVehicleNo.Visible = true;
        // }else{
			
			// txtVehicleNo.Visible = false;
		// }
		
    }

    /// <summary>
    /// Add 1 row on page load
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
        btnSubmit.Enabled = false;
        List<string> list = new List<string>();

        Boolean IsCommited = false;
        string Action = "", final = "";
        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        if (IsTokenValid()) // Genuine Click of Submit Button
        {

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
            ConsumeToken();
        }

        cls_TyreIssueMaster.Tyre_IDs = "";

        for (int i = 0; i < list.Count; i++)
        {
            if (final == "")
            {
                final = list[i];
                cls_TyreIssueMaster.Tyre_IDs = list[i];
            }
            else
            {
                final = final + "," + list[i];
                cls_TyreIssueMaster.Tyre_IDs = cls_TyreIssueMaster.Tyre_IDs + "," + list[i];
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
            else if (ddlAction.SelectedValue == "K")
            {
                Response.Redirect("TyreCPKM.aspx?Tyre_ID=" + final.Trim());
            }
            else
            {
                Response.Redirect("TyreUpdate_Msg.aspx?Tyre_ID=" + final.Trim());
                btnSubmit.Enabled = false;
            }
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            trsearch.Visible=false;
            divList.Visible=true;
            BindGrid();
        }
        catch(Exception ex)
        {
            UserMessage.Show(ex.Message);
        }
    }
}