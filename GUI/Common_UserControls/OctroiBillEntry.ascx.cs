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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public partial class GUI_Common_UserControls_OctroiBillEntry : System.Web.UI.UserControl
{
    DataTable dtOctBillEntry = new DataTable();

    public GridView OctroiBillEntry
    {
        get
        {
            return gvBillEntry; 
        }
    }

    public TextBox Remarks
    {
        get
        {
            return txtremarks; 
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dtOctBillEntry = AssignTable(); 
            //dtOctBillEntry.Rows.Add();
            int rows = 0;
            rows = Convert.ToInt16(txtRow.Text);
            for (int i = 1; i <= rows; i++)
            {
                dtOctBillEntry.Rows.Add();
            }
            gvBillEntry.DataSource = dtOctBillEntry;
            gvBillEntry.DataBind();             
        }
    }
    
    protected void txtdockno_TextChanged(object sender, EventArgs e)
    {
        //foreach (GridViewRow gv in gvBillEntry.Rows)
        //{
        //    TextBox txtdockno = gv.FindControl("txtdockno") as TextBox;
        //    TextBox txtoctamt = gv.FindControl("txtoctamt") as TextBox;
        //    TextBox txtrcpno = gv.FindControl("txtrcpno") as TextBox;
        //    TextBox txtrcpdt = gv.FindControl("txtrcpdt") as TextBox;
        //    HiddenField hidDockDate = gv.FindControl("hidDockDate") as HiddenField;
        //    HiddenField hidStatus = gv.FindControl("hidStatus") as HiddenField;

        //    string str = "exec usp_get_AgentBill_GridDetails '" + txtdockno.Text.Trim() + "'";
        //    SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, str);
        //    if (dr.Read())
        //    {
        //        txtoctamt.Text = dr["OCTAMT"].ToString();
        //        txtrcpno.Text = dr["RECPTNO"].ToString();
        //        txtrcpdt.Text = dr["RECPTDT"].ToString();
        //        hidDockDate.Value = dr["DOCKDT"].ToString();
        //        txtoctamt.ReadOnly = true;
        //        txtrcpno.ReadOnly = true;
        //        txtrcpdt.ReadOnly = true;               
        //    }
        //    else
        //    {
        //        txtoctamt.ReadOnly = false;
        //        txtrcpno.ReadOnly = false;
        //        txtrcpdt.ReadOnly = false;                
        //    }

        //    string strStatus = "exec usp_get_Status '" + txtdockno.Text + "'";
        //    SqlDataReader drStatus = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, strStatus);
        //    if (drStatus.Read())
        //    {
        //        hidStatus.Value = drStatus["Status"].ToString();
        //    }            
        //}

        //TextBox txtdocketno = (TextBox)sender;
        //TextBox txtoctroiamt = (TextBox)txtdocketno.Parent.FindControl("txtoctamt");
        //txtoctroiamt.Focus();
    }

    public DataTable AssignTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("DOCKNO");
        dt.Columns.Add("OCTAMT");
        dt.Columns.Add("RECPTNO");
        dt.Columns.Add("RECPTDT");
        return dt;
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        int rows = 0;
        rows = Convert.ToInt16(txtRow.Text);

        dtOctBillEntry = AssignTable();

        foreach (GridViewRow gv in gvBillEntry.Rows)
        {
            TextBox txtdockno = gv.FindControl("txtdockno") as TextBox;
            TextBox txtoctamt = gv.FindControl("txtoctamt") as TextBox;
            TextBox txtrcpno = gv.FindControl("txtrcpno") as TextBox;
            TextBox txtrcpdt = gv.FindControl("txtrcpdt") as TextBox;

            DataRow dr = dtOctBillEntry.NewRow();
            dr["DOCKNO"] = txtdockno.Text;
            dr["OCTAMT"] = txtoctamt.Text;
            dr["RECPTNO"] = txtrcpno.Text;
            dr["RECPTDT"] = txtrcpdt.Text;
            dtOctBillEntry.Rows.Add(dr);
        }

        for (int i = 1; i <= rows; i++)
        {
            dtOctBillEntry.Rows.Add();
        }
        if (dtOctBillEntry.Rows.Count == 0)
            dtOctBillEntry.Rows.Add();

        gvBillEntry.DataSource = dtOctBillEntry;
        gvBillEntry.DataBind();
    }
    protected void gvBillEntry_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType == DataControlRowType.DataRow)        
        {
            string VID = "cal.select(document.aspnetForm." + ((TextBox)e.Row.FindControl("txtrcpdt")).ClientID.ToString() + ",'" + ((LinkButton)e.Row.FindControl("lnkBtnIssueDate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Row.FindControl("lnkBtnIssueDate")).Attributes.Add("onclick", VID);            
        }
    }
}
