using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;    
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.ApplicationBlocks.Data;


public partial class GodownTransfer : System.Web.UI.Page
{
    #region Variable[s]
    private string ErrorMsg = string.Empty; 
    SqlConnection conn;
    #endregion

    #region Event[s]
    protected void Page_Load(object sender, EventArgs e)
    {
        // Session["brcd"] = "VAPI";
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        try
        {
            if (!Page.IsPostBack)
            {
                txtFromDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                bindRouteMode();
                bindPaybase();
                trGrid.Style["display"] = "none";
                trBtnUpdate.Style["display"] = "none";
                trlblMsg.Style["display"] = "none";
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        try
        {
            //Validation();

            if (string.IsNullOrEmpty(ErrorMsg))
            {
                bindDocketGrid();               
            }
            else
            {
                Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=" + ErrorMsg, false);
            }
        }
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow gr in gvDocketInfo.Rows)
            {
               
                CheckBox chkSelect = (CheckBox)gr.FindControl("chkSelect");
                DropDownList ddlNewGodown = (DropDownList)gr.FindControl("ddlNewGodown");
                HiddenField hdfDockNo = (HiddenField)gr.FindControl("hdfDockNo");

                if (chkSelect.Checked)
                {
                    string strsql_proc = "Update webx_trans_docket_status set godown = '" + ddlNewGodown.SelectedValue + "' where dockno='" + hdfDockNo.Value + "'";
                    SqlCommand cmd = new SqlCommand(strsql_proc, conn);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            // bindDocketGrid();

            Response.Redirect("SuccessMsg.aspx", false);
        }         
        catch (Exception Exc)
        {
            Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
        }
    }
    protected void gvDocketInfo_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // ((CheckBox)e.Row.FindControl("chkSelect")).Attributes.Add("onclick", "checkBoxStatus(" + ((CheckBox)e.Row.FindControl("chkSelect")).ClientID + "," + ((DropDownList)e.Row.FindControl("ddlNewGodown")).ClientID + ")");

            string sql = "";

            DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");

            sql = "select godown_srno, godown_desc from webx_godownmst a inner join webx_location  l on a.spdbrcd =l.loccode where loccode='" + Session["brcd"].ToString() + "' or Report_loc='" + Session["brcd"].ToString() + "'";
            sql = "select godown_srno, godown_desc from webx_godownmst a where spdbrcd='" + cboLO.SelectedValue.ToString() + "' "; 

            conn.Open();
            SqlCommand cmd_pbov = new SqlCommand(sql, conn);
            SqlDataReader dr_pbov;
            DropDownList ddlNewGodown = (DropDownList)e.Row.FindControl("ddlNewGodown");

            if (ddlNewGodown != null)
            {
                dr_pbov = cmd_pbov.ExecuteReader();
                ddlNewGodown.Items.Clear();

                ddlNewGodown.CssClass = "blackfnt";                
                while (dr_pbov.Read())
                {
                    ddlNewGodown.Items.Add(new ListItem(dr_pbov.GetValue(1).ToString(), dr_pbov.GetValue(0).ToString()));
                }
                dr_pbov.Close();

                ddlNewGodown.Items.ToString().ToUpper();
            }
            conn.Close();

            if (ddlNewGodown.Items.Count <= 1)
            {
                lblMsg.Text = "Only one godown for given location.";
                trGrid.Style["display"] = "none";
                trBtnUpdate.Style["display"] = "none";
                trlblMsg.Style["display"] = "block";
            }
            else
            {
                ddlNewGodown.Items.Add(new ListItem("Select", "0"));
                HiddenField hdfGodownSrNo = (HiddenField)e.Row.FindControl("hdfGodownSrNo");
                ddlNewGodown.SelectedValue = "0";
            }           
        }
    }
    #endregion

    #region Private Function[s]
   
    private void bindPaybase()
    {
        conn.Open();
        string sql = "Select CodeID, CodeDesc From WebX_Master_General where CodeType=ltrim(rtrim('PAYTYP')) Union Select CodeID='All', CodeDesc='All'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.Text;
        // cmd.Parameters.Add("@codetype", SqlDbType.VarChar).Value = "PAYTYP";    

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        ddlPaybase.Items.Clear();
        ddlPaybase.CssClass = "blackfnt";
        // ddlPaybase.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            ddlPaybase.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
        }
        dr.Close();
        conn.Close();
        ddlPaybase.SelectedValue = "All"; 
    }
    private void bindRouteMode()
    {
        conn.Open();
        string sql = "Select CodeID, CodeDesc From WebX_Master_General where CodeType=ltrim(rtrim('TRN')) Union Select CodeID='All', CodeDesc='All'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.Text;
        // cmd.Parameters.Add("@codetype", SqlDbType.VarChar).Value = "TRN";

        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();

        ddlMode.Items.Clear();
        ddlMode.CssClass = "blackfnt";
        // ddlMode.Items.Add(new ListItem("Select", "0"));
        while (dr.Read())
        {
            ddlMode.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
        }
        dr.Close();
        conn.Close();
        ddlMode.SelectedValue = "All";
    }
    private void bindDocketGrid()
    {
        string[] strArrDtFrom = txtFromDate.Text.Split('/');
       // string[] strArrDtTo = txtToDate.Text.Split('/');

        string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy");
        //string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

        DropDownList cboRO = (DropDownList)Fromlc.FindControl("cboRO");
        DropDownList cboLO = (DropDownList)Fromlc.FindControl("cboLO");
        DropDownList CboGodown = (DropDownList)Fromlc.FindControl("DDL_BankList");

        string RO = cboRO.SelectedValue.ToString();
        string LO = cboLO.SelectedValue.ToString();

        string Godown = CboGodown.SelectedValue.ToString();

        if (RO == "")
            RO = "All";
        if (LO == "")
            LO = "All";
        if (Godown == "")
            Godown = "All";

        if (RO == LO)
            RO = "All";

        string sql = "usp_webx_DocketGodown_Select";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@RO", SqlDbType.VarChar).Value = RO.ToString();
        cmd.Parameters.Add("@LO", SqlDbType.VarChar).Value = LO.ToString();
        cmd.Parameters.Add("@godown", SqlDbType.VarChar).Value = Godown.ToString();
        cmd.Parameters.Add("@ASONDT", SqlDbType.VarChar).Value = dtFrom;
      //  cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = dtTo;
        cmd.Parameters.Add("@Paybase", SqlDbType.VarChar).Value = ddlPaybase.SelectedValue;
        cmd.Parameters.Add("@Mode", SqlDbType.VarChar).Value = ddlMode.SelectedValue;

        DataSet ds = new DataSet();
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        adp.Fill(ds);

        if (ds.Tables[0].Rows.Count > 0)
        {           
            trlblMsg.Style["display"] = "none";
            trGrid.Style["display"] = "block";
            trBtnUpdate.Style["display"] = "block";
            gvDocketInfo.DataSource = ds.Tables[0];
            gvDocketInfo.DataBind();
        }
        else
        {
            lblMsg.Text = "No record[s] found....."; 
            trlblMsg.Style["display"] = "block";
        }

        //foreach (GridViewRow gr in gvDocketInfo.Rows)
        //{
        //    HiddenField hdfGodownSrNo = (HiddenField)gr.FindControl("hdfGodownSrNo");
        //    DropDownList ddlNewGodown1 = (DropDownList)gr.FindControl("ddlNewGodown");
        //    if (hdfGodownSrNo != null)
        //    {
        //        if (!string.IsNullOrEmpty(hdfGodownSrNo.Value))
        //        {
        //            Label lblPaybase = (Label)gr.FindControl("lblPaybase");                 
        //            ddlNewGodown1.SelectedValue = hdfGodownSrNo.Value;
        //        }
        //    }
        //}
    }
    #endregion
}
