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

public partial class GUI_Finance_Fix_Asset_Fix_Asset_Add : System.Web.UI.Page
{

    public string err = "";
    int i = 0;
    DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            filldata();


        }
        // getstring();
        btn_submit.Attributes.Add("onclick", "javascript:return ValidateData()");
    }

    public void filldata()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string q = "select * from WEBX_SALHEADMST";
        SqlCommand c = new SqlCommand(q, cn);

        ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(c);
        da.Fill(ds);
        GV_D.DataSource = ds;
        GV_D.DataBind();

    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection conn = new SqlConnection(Session["Sqlprovider"].ToString().Trim());

            conn.Open();
            /*
             
              t_calbas="ctl00_MyCPH1_GV_D_ctl" + b + "_ddcalcbasis";
            d_tds="ctl00_MyCPH1_GV_D_ctl" + b + "_ddtds";
            
             t_shown="ctl00_MyCPH1_GV_D_ctl" + b + "_ddshoninsalslp";
           d_type="ctl00_MyCPH1_GV_D_ctl" + b + "_ddtype";
            
             t_printname="ctl00_MyCPH1_GV_D_ctl" + b + "_txtprintname";
            t_salhd="ctl00_MyCPH1_GV_D_ctl" + b + "_txtsalhead_Desc";
             */

            foreach (GridViewRow gridrow in GV_D.Rows)
            {



                CheckBox ch = (CheckBox)gridrow.FindControl("ch");


                if (ch.Checked == true)
                {

                    TextBox txtsalhead_Desc = (TextBox)gridrow.FindControl("txtsalhead_Desc");

                    TextBox txtprintname = (TextBox)gridrow.FindControl("txtprintname");
                    DropDownList ddtype = (DropDownList)gridrow.FindControl("ddtype");
                    DropDownList ddshoninsalslp = (DropDownList)gridrow.FindControl("ddshoninsalslp");
                    DropDownList ddtds = (DropDownList)gridrow.FindControl("ddtds");
                    DropDownList ddcalcbasis = (DropDownList)gridrow.FindControl("ddcalcbasis");


                    string sql = "";

                    sql = "Update WEBX_SALHEADMST set SAL_HEADNAME='" + txtsalhead_Desc.Text + "', SAL_PRINTNAME='" + txtprintname.Text + "',SAL_HEADTYPE='" + ddtype.SelectedValue.ToString() + "',PAYSLIP_SHOW_YN='" + ddshoninsalslp.SelectedValue.ToString() + "',SAL_CALBASIS='" + ddcalcbasis.SelectedValue.ToString() + "',TDS_YN='" + ddtds.SelectedValue.ToString() + "',UPDATEDBY='" + Session["empcd"].ToString() + "',UPDATEDDATE=getdate() WHERE  SAL_code='" + ch.Text + "'";


                    SqlCommand sqlcmd = new SqlCommand(sql, conn);

                    sqlcmd.ExecuteNonQuery();
                }
            }
        }




        catch (Exception e1)
        {
            err += e1.Message;
        }

        if (err == "")
        {
            Error.Visible = false;

            lblerr.Text = "Salary Head  Updated Successfully...";

            pnl1.Visible = false;
            plnerr.Visible = true;


        }
        else
        {
            lblerr.Text = err;
            pnl1.Visible = false;
            plnerr.Visible = true;

        }


    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("../masters.aspx");
    }


    public void CustomersGridView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        // BindGrid();
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DropDownList type = (DropDownList)e.Row.FindControl("ddtype");
            DropDownList ddshoninsalslp = (DropDownList)e.Row.FindControl("ddshoninsalslp");
            DropDownList ddcalcbasis = (DropDownList)e.Row.FindControl("ddcalcbasis");
            DropDownList ddtds = (DropDownList)e.Row.FindControl("ddtds");

            //if (GV_D.d)
            type.SelectedValue = ds.Tables[0].Rows[i]["SAL_HEADTYPE"].ToString();
            ddshoninsalslp.SelectedValue = ds.Tables[0].Rows[i]["PAYSLIP_SHOW_YN"].ToString();
            ddcalcbasis.SelectedValue = ds.Tables[0].Rows[i]["SAL_CALBASIS"].ToString();
            ddtds.SelectedValue = ds.Tables[0].Rows[i]["TDS_YN"].ToString();

            i++;

        }
    }

}
