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
using Microsoft.ApplicationBlocks.Data;
using System.Data.SqlClient;
using WebX.Controllers;
using WebX.Entity;

public partial class GUI_admin_ChargeMaster_ChargeSubRule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnchargerule.Value = DocketRules.GetDefaultValue("CHRG_RULE");
            lblprimarybase.Text = DataProvider.GetCodeTypeName(hdnchargerule.Value);
            if (hdnchargerule.Value.CompareTo("NONE") != 0)
            {
                DataTable dtmain = new DataTable();
                DataColumn dtcol = new DataColumn("basecode", typeof(string));
                dtmain.Columns.Add(dtcol);
                dtcol = new DataColumn("basecodename", typeof(string));
                dtmain.Columns.Add(dtcol);
                dtcol = new DataColumn("chargesubrule", typeof(string));
                dtmain.Columns.Add(dtcol);

                string sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='" + hdnchargerule.Value + "'";
                DataTable dtcodes = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
                if (dtcodes.Rows.Count > 0)
                {
                    for (int i = 0; i < dtcodes.Rows.Count; i++)
                    {
                        DataRow dtr = dtmain.NewRow();
                        dtr["basecode"] = dtcodes.Rows[i]["codeid"].ToString();
                        dtr["basecodename"] = dtcodes.Rows[i]["codedesc"].ToString();
                        dtr["chargesubrule"] = "";
                        dtmain.Rows.Add(dtr);
                    }
                }

                sqlstr = "SELECT * FROM webx_charge_base WHERE chargerule='" + hdnchargerule.Value + "'";
                DataTable dtrules = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, sqlstr).Tables[0];
                if (dtcodes.Rows.Count > 0)
                {
                    try
                    {
                        for (int i = 0; i < dtrules.Rows.Count; i++)
                        {
                            if (dtrules.Rows[i]["basecode"].ToString().CompareTo(dtmain.Rows[i]["basecode"]) == 0)
                            {
                                try
                                {
                                    dtmain.Rows[i]["chargesubrule"] = dtrules.Rows[i]["chargesubrule"].ToString();
                                }
                                catch (Exception ex) { }
                            }
                        }
                    }
                    catch (Exception ex) { }
                }
                grvcharge.DataSource = dtmain;
                grvcharge.DataBind();
            }

        }
    }
    protected void grvcharge_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //T001132
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlsubrule = (DropDownList)e.Row.FindControl("ddlsubrule");
            try
            {
                ddlsubrule.SelectedValue = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "chargesubrule"));
            }
            catch (Exception ex) { }
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(SessionUtilities.ConnectionString);
        con.Open();

        SqlTransaction trn = con.BeginTransaction();

        try
        {
            string sqlstr = "DELETE FROM webx_charge_base WHERE chargerule='" + hdnchargerule.Value + "'";
            sqlstr = sqlstr + " AND chargetype='DKT'";
            SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);

            foreach (GridViewRow grvrow in grvcharge.Rows)
            {
                DropDownList ddlsubrule = (DropDownList)grvrow.FindControl("ddlsubrule");
                HiddenField hdnbasecode = (HiddenField)grvrow.FindControl("hdnbasecode");
                string basecode = Convert.ToString(DataBinder.Eval(grvrow.DataItem, "basecode"));
                sqlstr = "INSERT INTO webx_charge_base VALUES('DKT','" + hdnchargerule.Value + "',";
                sqlstr = sqlstr + "'" + hdnbasecode.Value + "','" + ddlsubrule.SelectedValue + "','Y','" + SessionUtilities.CurrentEmployeeID + "',GETDATE())";
                SqlHelper.ExecuteNonQuery(trn, CommandType.Text, sqlstr);
            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=DataBase Updation Failed&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }

        trn.Commit();
        Response.Redirect("~/GUI/Default.aspx");
    }

}
