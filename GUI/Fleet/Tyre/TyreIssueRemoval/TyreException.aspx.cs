using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ApplicationManager;
using System.Data;
using System.Collections.Generic;
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;

public partial class GUI_Fleet_Tyre_TyreException : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
             //CTIM.GetTyreException(GV_TyreException);            
        }
    }

    protected void GV_TyreExceptionDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)//|| e.Row.RowType == DataControlRowType.EmptyDataRow
        {
            DropDownList ddlVehicleNo = (DropDownList)e.Row.FindControl("ddlVehicleNo");
            BindDropDown("USP_BIND_VEHNO", "LOCNAME", "LOCCODE", ddlVehicleNo);
        }
    }
    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        System.Data.SqlClient.SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        List<string> list = new List<string>();
        Boolean IsCommited = false;
        string  final = "";

        cls_TyreIssueMaster CTIM = new cls_TyreIssueMaster(Session["SqlProvider"].ToString().Trim());
        foreach (GridViewRow r in GV_TyreException.Rows)
        {
            CheckBox chkSelect = r.FindControl("chkSelect") as CheckBox;
            TextBox txtRemovalDT = r.FindControl("txtRemovalDT") as TextBox;
            TextBox txtVEHNO = r.FindControl("txtVEHNO") as TextBox;
            TextBox txtNoOfTyre = r.FindControl("txtNoOfTyre") as TextBox;
            TextBox txtSysTyreNo = r.FindControl("txtSysTyreNo") as TextBox;
            DropDownList ddlVehicleNo = r.FindControl("ddlVehicleNo") as DropDownList;
            TextBox txtNoTyres = r.FindControl("txtNoTyres") as TextBox;
            TextBox txtTyreNoNew = r.FindControl("txtTyreNoNew") as TextBox;
            TextBox txtPendingExcess = r.FindControl("txtPendingExcess") as TextBox;

            if (chkSelect.Checked)
            {
                list.Add(ddlVehicleNo.SelectedValue);

                CTIM.UpdateTyreException();
                IsCommited = true;
                
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
            Response.Redirect("ResultTyre.aspx?VHNO=" + final);
        }
    }
}