using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

using WebX.Entity;
using WebX.Controllers;

public partial class GUI_admin_Godown_Master_GodownMaster : System.Web.UI.Page
{
	#region Variable[s]   
	static DataTable dtGodown = new DataTable();
	#endregion

	#region Form Event[s]
	protected void Page_Load(object sender, EventArgs e)
	{
		try
		{
			if (!Page.IsPostBack)
			{
				bindLocationDDL();
				txtAddRows.Text = "0";
				btnSubmit.Visible = false;

				if (Request.QueryString["Flag"] == "Edit")
				{
					string LocCode = Convert.ToString(Request.QueryString["LocCode"]);

					for (int i = 0; i < ddlLocation.Items.Count; i++)
					{
						if (ddlLocation.Items[i].Value.Trim() == LocCode.Trim())
						{
							ddlLocation.SelectedIndex = i;
						}
					}

					getData();
					ddlLocation.Enabled = false;
				}
			}
		}
		catch (Exception Exc)
		{
			Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
		}
	}
	protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
	{
		GodownMasterController objGodownMaster = new GodownMasterController();

		try
		{
			getData();
		}
		catch (Exception Exc)
		{
			Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
		}
	}

	protected void CmdAddRows_Click(object sender, EventArgs e)
	{
		try
		{
			Int32 i;
			DataRow drow;
			//if (dtGodown != null && dtGodown.Rows.Count > 0)
			//{
			//    i = Convert.ToInt32(txtAddRows.Text) - Convert.ToInt32(dtGodown.Rows.Count);
			//}
			//else
			//{
			//    i = Convert.ToInt32(txtAddRows.Text);
			//}

			i = Convert.ToInt32(txtAddRows.Text);

			if (i > 0)
			{
				for (Int32 j = i; j > 0; j--)
				{
					drow = dtGodown.NewRow();
					dtGodown.Rows.Add(drow);
				}
			}
			gvGodown.DataSource = dtGodown;
			gvGodown.DataBind();

			btnSubmit.Visible = true;
		}
		catch (Exception Exc)
		{
			Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
		}
	}
	protected void btnSubmit_Click(object sender, EventArgs e)
	{
		GodownMasterController objGodownMaster = new GodownMasterController();
		GodownMaster objectGodownMaster = new GodownMaster();
		int result = 0;

		try
		{
			foreach (GridViewRow dr in gvGodown.Rows)
			{
				string godown_name, godown_desc;

				HiddenField hdfGodownNo;
				godown_name = ((TextBox)dr.FindControl("txtGodownName")).Text.Replace("'", "''").Trim();
				godown_desc = ((TextBox)dr.FindControl("txtDescription")).Text.Replace("'", "''").Trim();
				hdfGodownNo = ((HiddenField)dr.FindControl("hdfGodownNo"));
				var chkActiveFlag = ((CheckBox)dr.FindControl("chkActiveFlag"));
				string Area = ((TextBox)dr.FindControl("txtArea")).Text;
				string Address = ((TextBox)dr.FindControl("txtAddress")).Text;
				string ValidityDate = ((TextBox)dr.FindControl("txtValidityDate")).Text;

				objectGodownMaster.BranchCode = ddlLocation.Text.Trim();
				objectGodownMaster.Name = godown_name;
				objectGodownMaster.Description = godown_desc;
				objectGodownMaster.UpdateBy = Convert.ToString(Session["empcd"]);
				objectGodownMaster.UpdateOnDate = System.DateTime.Now.Date;
				if (chkActiveFlag.Checked == true)
				{
					objectGodownMaster.ActiveFlag = "Y";
				}
				else
				{
					objectGodownMaster.ActiveFlag = "N";
				}
				objectGodownMaster.Area = Area;
				objectGodownMaster.Address = Address;
				objectGodownMaster.ValidityDate = ValidityDate;

				if (!string.IsNullOrEmpty(hdfGodownNo.Value))
				{
					if ((!string.IsNullOrEmpty(godown_name.Trim())) && (!string.IsNullOrEmpty(godown_desc.Trim())))
					{
						objectGodownMaster.SrNo = Convert.ToDouble(hdfGodownNo.Value);
						result = objGodownMaster.updateGodownMaster(objectGodownMaster);
					}
				}
				else
				{
					if ((!string.IsNullOrEmpty(godown_name.Trim())) && (!string.IsNullOrEmpty(godown_desc.Trim())))
						result = objGodownMaster.insertGodownMaster(objectGodownMaster);
				}
			}

			if (result > 0)
				Response.Redirect("GodownMasterDone.aspx?Flag=Add&LocCode=" + ddlLocation.SelectedValue.Trim(), false);
			else
				Response.Redirect("ErrorPage.aspx?heading=Error in Insert Record. Please Reenter record detail");
		}
		catch (Exception Exc)
		{
			Response.Redirect("~/GUI/admin/ErrorPage.aspx?heading=Error in data retrival.&detail1=" + Exc.Message.Replace('\n', '_'));
		}
	}
	protected void gvGodown_RowDataBound(object sender, GridViewRowEventArgs e)
	{
		try
		{
			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				((TextBox)e.Row.FindControl("txtGodownName")).Attributes.Add("onchange", "Javascript:return checkGodown(this);");
				CheckBox chkActiveFlag = ((CheckBox)e.Row.FindControl("chkActiveFlag"));
				var str = DataBinder.Eval(e.Row.DataItem, "ActiveFlag");
				if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "ActiveFlag")).CompareTo("Y") == 0)
				{
					chkActiveFlag.Checked = true;
				}					
				else {
					chkActiveFlag.Checked = false;
				}
			}
		}
		catch (Exception Exc)
		{
			throw Exc;
		}
	}
	#endregion

	#region Private function[s]  
	private void getData()
	{
		GodownMasterController objGodownMaster = new GodownMasterController();

		try
		{
			if (ddlLocation.SelectedValue != "0")
			{
				gvGodown.DataSource = null;
				dtGodown.Clear();
				dtGodown = objGodownMaster.getGodownByLocation(ddlLocation.SelectedValue);

				gvGodown.DataSource = dtGodown;
				gvGodown.DataBind();

				if (dtGodown != null && dtGodown.Rows.Count > 0)
				{
					txtAddRows.Text = Convert.ToString(dtGodown.Rows.Count);
					btnSubmit.Visible = true;
				}
				else
				{
					txtAddRows.Text = "0";
					btnSubmit.Visible = false;
				}
			}
		}
		catch (Exception Exc)
		{
			throw Exc;
		}
	}
	private void bindLocationDDL()
	{
		try
		{
			GodownMasterController objGodownMaster = new GodownMasterController();
			DataTable dtLocationList = new DataTable();

			ddlLocation.Items.Clear();
			dtLocationList = objGodownMaster.getAllLocationList();

			if (dtLocationList != null && dtLocationList.Rows.Count > 0)
			{
				ddlLocation.DataTextField = "Location";
				ddlLocation.DataValueField = "spdbrcd";
				ddlLocation.DataSource = dtLocationList;
				ddlLocation.DataBind();
			}
			ddlLocation.Items.Insert(0, new ListItem("Select", "0"));
		}
		catch (Exception Exc)
		{
			throw Exc;
		}
	}
	#endregion
}
