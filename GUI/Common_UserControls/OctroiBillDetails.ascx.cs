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
using Microsoft.ApplicationBlocks.Data;   

public partial class GUI_Common_UserControls_OctroiBillDetails : System.Web.UI.UserControl
{
    DataTable dtOctDetails = new DataTable();
    public DataGrid OctDetails
    {
        get
        {
            return DataGrid1; 
        }
    }
    public HiddenField hidSRule
    {
        get
        {
            return hidStaxRule; 
        }

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dtOctDetails = AssignTable();
            int rows = 0;
            rows = Convert.ToInt16(roww.Text.Trim());
            for (int i = 1; i <= rows; i++)
            {                
                DataRow dr = dtOctDetails.NewRow();
                dr["DOCKNO"] = "";
                dr["DECLVAL"] = "";
                dr["OCT_AMT"] = "";
                dr["oct_percentage"] = "";
                dr["clearance_chrg"] = 0;
                dr["processing_per"] = 0;
                dr["process_chrg"] = 0;
                dr["OTCHG"] = 0;
                dr["SVRCAMT"] = 0.00;
                dr["CESSAMT"] = 0.00;
                dr["Hedu_Cess"] = 0.00;
                dr["DKTTOT"] = 0;
                dr["OCT_RECEIPTNO"] = "";
                dr["recptdt"] = "";
                dtOctDetails.Rows.Add(dr);
            }
            DataGrid1.DataSource = dtOctDetails;
            Bind();            
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        int rows = 0;
        rows = Convert.ToInt16(roww.Text);

        dtOctDetails = AssignTable();

        foreach (DataGridItem drow in DataGrid1.Items)
        {
            TextBox txtdockno = (TextBox)drow.FindControl("txtdockno");
            TextBox txtdeclval = (TextBox)drow.FindControl("txtdeclval");
            TextBox txtoctamt = (TextBox)drow.FindControl("txtoctamt");
            TextBox txtoctper = (TextBox)drow.FindControl("txtoctper");
            TextBox txtclearchrg = (TextBox)drow.FindControl("txtclearchrg");
            TextBox txtprochrg_per = (TextBox)drow.FindControl("txtprochrg_per");
            TextBox txtprochrg = (TextBox)drow.FindControl("txtprochrg");
            TextBox txtotchg = (TextBox)drow.FindControl("txtotchg");
            TextBox txtRate = (TextBox)drow.FindControl("txtRate");
            TextBox txtstax = (TextBox)drow.FindControl("txtstax");
            TextBox txtcess = (TextBox)drow.FindControl("txtcess");
            TextBox txthcess = (TextBox)drow.FindControl("txthcess");
            TextBox txttotalamt = (TextBox)drow.FindControl("txttotalamt");
            TextBox txtrcptno = (TextBox)drow.FindControl("txtrcptno");
            TextBox txtrcptdate = (TextBox)drow.FindControl("txtrcptdate");            
            
            DataRow dr = dtOctDetails.NewRow();
            dr["DOCKNO"] = txtdockno.Text;
            dr["DECLVAL"] = txtdeclval.Text;
            dr["OCT_AMT"] = txtoctamt.Text;
            dr["oct_percentage"] = txtoctper.Text;
            dr["clearance_chrg"] = txtclearchrg.Text;
            dr["processing_per"] = txtprochrg_per.Text;
            dr["process_chrg"] = txtprochrg.Text;
            dr["OTCHG"] = txtotchg.Text;            
            dr["SVRCAMT"] = txtstax.Text;
            dr["CESSAMT"] = txtcess.Text;
            dr["Hedu_Cess"] = txthcess.Text;
            dr["DKTTOT"] = txttotalamt.Text;
            dr["OCT_RECEIPTNO"] = txtrcptno.Text;
            dr["recptdt"] = txtrcptdate.Text;  
            
            dtOctDetails.Rows.Add(dr);
        }

        for (int i = 1; i <= rows; i++)
        {
            DataRow drow = dtOctDetails.NewRow();
            drow["DOCKNO"] = "";
            drow["DECLVAL"] = "";
            drow["OCT_AMT"] = "";
            drow["oct_percentage"] = "";
            drow["clearance_chrg"] = 0;
            drow["processing_per"] = 0;
            drow["process_chrg"] = 0;
            drow["OTCHG"] = 0;            
            drow["SVRCAMT"] = 0.00;
            drow["CESSAMT"] = 0.00;
            drow["Hedu_Cess"] = 0.00;
            drow["DKTTOT"] = 0;
            drow["OCT_RECEIPTNO"] = "";
            drow["recptdt"] = "";
            dtOctDetails.Rows.Add(drow);
            //dtOctDetails.Rows.Add();
        }
        if (dtOctDetails.Rows.Count == 0)
            dtOctDetails.Rows.Add();

        DataGrid1.DataSource = dtOctDetails;
        Bind();                           
    }
    protected void txtdockno_TextChanged(object sender, EventArgs e)
    {
        //foreach(DataGridItem gv in DataGrid1.Items)
        //{
        //    TextBox txtdockno = gv.FindControl("txtdockno") as TextBox;
        //    TextBox txtdeclval = gv.FindControl("txtdeclval") as TextBox;
        //    HiddenField hidDockDate = gv.FindControl("hidDockDate") as HiddenField;
        //    HiddenField hidStatus = gv.FindControl("hidStatus") as HiddenField;

        //    string str = "exec usp_get_PrepareOctroiBill_GridDetails '" + txtdockno.Text + "'";
        //    SqlDataReader dr = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text,str);
        //    if (dr.Read())
        //    {
        //        txtdeclval.Text = dr["DECLVAL"].ToString();
        //        hidDockDate.Value = dr["DOCKDT"].ToString();                
        //    }
        //    string strStatus = "exec usp_get_Status '" + txtdockno.Text + "'";
        //    SqlDataReader drStatus = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text,strStatus);
        //    if (drStatus.Read())
        //    {
        //        hidStatus.Value = drStatus["Status"].ToString(); 
        //    }               
        //}     
    }
    public DataTable AssignTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("DOCKNO");
        dt.Columns.Add("DECLVAL");
        dt.Columns.Add("OCT_AMT");
        dt.Columns.Add("oct_percentage");
        dt.Columns.Add("clearance_chrg");
        dt.Columns.Add("processing_per");
        dt.Columns.Add("process_chrg");
        dt.Columns.Add("OTCHG");
        dt.Columns.Add("Rate");
        dt.Columns.Add("SVRCAMT");
        dt.Columns.Add("CESSAMT");
        dt.Columns.Add("Hedu_Cess");
        dt.Columns.Add("DKTTOT");
        dt.Columns.Add("OCT_RECEIPTNO");
        dt.Columns.Add("recptdt");         
        return dt;
    }
    public void Bind()
    {
        string sql = "select * from webx_modules_rules where Rule_DESC = 'Service Tax For Octroi Bill' and Module_name = 'Prepare Octroi Bill'";
        SqlDataReader drRule = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, sql);
        if (drRule.Read())
        {
            string status = drRule["RULE_Y_N"].ToString();
            hidRate.Value = drRule["RULE_VALUE"].ToString(); 
            hidStaxRule.Value = status;  
            
            if (status == "N")
            {                
                DataGrid1.Columns[10].Visible = false;
                DataGrid1.Columns[11].Visible = false;
                DataGrid1.Columns[12].Visible = false;
                DataGrid1.DataBind();
            }
            else
            {
                DataGrid1.DataBind();
                DataGrid1.Columns[10].Visible = true;
                DataGrid1.Columns[11].Visible = true;
                DataGrid1.Columns[12].Visible = true;                
            }
        }
    }
    protected void  DataGrid1_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string VID = "cal.select(document.aspnetForm." + ((TextBox)e.Item.FindControl("txtrcptdate")).ClientID.ToString() + ",'" + ((LinkButton)e.Item.FindControl("lnkBtnIssueDate")).ClientID.ToString() + "','dd/MM/yyyy'); return false;";
            ((LinkButton)e.Item.FindControl("lnkBtnIssueDate")).Attributes.Add("onclick", VID);

            RadioButton rbd = e.Item.FindControl("rdbParty") as RadioButton;
            rbd.Attributes.Add("onclick", "SelectSingleFile(this)");

            if (e.Item.ItemIndex == 0)
            {
                rbd.Checked = true;  
            }

        }
    }
}
