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

public partial class GUI_admin_BussinesTypeWiseModeMaster_BusinessTypeWiseMode : System.Web.UI.Page
{

    SqlConnection con;
    static DataTable dttransmode;
    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(Session["SqlProvider"].ToString());
        con.Open();

        string sqlstr = "";
        SqlCommand cmd;
        DataTable dt = new DataTable();

        if (!IsPostBack)
        {
            dttransmode = new DataTable();
            sqlstr = "SELECT codeid,codedesc FROM webx_master_general WHERE codetype='TRN' AND statuscode='Y' ORDER BY codeid";
            cmd = new SqlCommand(sqlstr, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dttransmode);

            sqlstr = "SELECT codeid,codedesc,air_yn='N',road_yn='N',train_yn='N',express_yn='N',";
            sqlstr = sqlstr + "defaultvalue='0',enabled='0',computerised='N' FROM webx_master_general WHERE codetype='BUT' AND statuscode='Y'";
            cmd = new SqlCommand(sqlstr, con);
            da = new SqlDataAdapter(cmd);
            da.Fill(dt);


            sqlstr = "SELECT * FROM webx_dcr_business_transmode";
            cmd = new SqlCommand(sqlstr, con);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["codeid"].ToString().CompareTo(dr["businesstype"]) == 0)
                    {
                        dt.Rows[i]["air_yn"] = dr["air_yn"].ToString();
                        dt.Rows[i]["road_yn"] = dr["road_yn"].ToString();
                        dt.Rows[i]["train_yn"] = dr["train_yn"].ToString();
                        dt.Rows[i]["express_yn"] = dr["express_yn"].ToString();
                        dt.Rows[i]["defaultvalue"] = dr["defaultvalue"].ToString();
                        dt.Rows[i]["enabled"] = dr["enabled"].ToString();
                        dt.Rows[i]["computerised"] = dr["computerised"].ToString();
                    }
                }
            }
            dr.Close();

            grvbusiness.DataSource = dt;
            grvbusiness.DataBind();



        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {

        SqlCommand cmd;
        string sqlstr = "";

        SqlTransaction trn = con.BeginTransaction();

        try
        {
            sqlstr = "DELETE FROM webx_dcr_business_transmode";
            cmd = new SqlCommand(sqlstr, con,trn);
            cmd.ExecuteNonQuery();

            foreach (GridViewRow grv in grvbusiness.Rows)
            {
                HiddenField hdnbusinesstype = (HiddenField)grv.FindControl("hdnbusinesstype");
                CheckBox chkair = (CheckBox)grv.FindControl("chkair");
                CheckBox chkroad = (CheckBox)grv.FindControl("chkroad");
                CheckBox chktrain = (CheckBox)grv.FindControl("chktrain");
                CheckBox chkexpress = (CheckBox)grv.FindControl("chkexpress");
                CheckBox chkenabled = (CheckBox)grv.FindControl("chkenabled");
                CheckBox chkcomputerised = (CheckBox)grv.FindControl("chkcomputerised");
                DropDownList cmbtransmode = (DropDownList)grv.FindControl("cmbtransmode");

                sqlstr = "INSERT INTO webx_dcr_business_transmode VALUES(";
                sqlstr = sqlstr + "'" + hdnbusinesstype.Value + "',";
                sqlstr = sqlstr + "'" + (chkair.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chkroad.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chktrain.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chkexpress.Checked == true ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + cmbtransmode.SelectedValue + "',";
                sqlstr = sqlstr + "'" + (chkenabled.Checked ? "Y" : "N") + "',";
                sqlstr = sqlstr + "'" + (chkcomputerised.Checked ? "Y" : "N") + "')";
                cmd = new SqlCommand(sqlstr, con, trn);
                cmd.ExecuteNonQuery();

            }
        }
        catch (Exception ex)
        {
            trn.Rollback();
            return;
        }

        trn.Commit();
        con.Close();
        Response.Redirect("~/GUI/Default.aspx");
    }

    protected void grvbusiness_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label lblairname = (Label)(e.Row.FindControl("lblairname"));
            Label lblroadname = (Label)(e.Row.FindControl("lblroadname"));
            Label lbltrainname = (Label)(e.Row.FindControl("lbltrainname"));
            //Label lblexpressname = (Label)(e.Row.FindControl("lblexpressname"));

            lblairname.Text = dttransmode.Rows[0]["codedesc"].ToString();
            lblroadname.Text = dttransmode.Rows[1]["codedesc"].ToString();
            lbltrainname.Text = dttransmode.Rows[2]["codedesc"].ToString();
            //lblexpressname.Text = dttransmode.Rows[3]["codedesc"].ToString();

        }
        else if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList cmbtransmode = (DropDownList)e.Row.FindControl("cmbtransmode");
            cmbtransmode.DataSource = dttransmode;
            cmbtransmode.DataBind();

            CheckBox chkair = (CheckBox)e.Row.FindControl("chkair");
            CheckBox chkroad = (CheckBox)e.Row.FindControl("chkroad");
            CheckBox chktrain = (CheckBox)e.Row.FindControl("chktrain");
            CheckBox chkexpress = (CheckBox)e.Row.FindControl("chkexpress");

            CheckBox chkenabled = (CheckBox)e.Row.FindControl("chkenabled");
            CheckBox chkcomputerised = (CheckBox)e.Row.FindControl("chkcomputerised");

            cmbtransmode.SelectedValue = DataBinder.Eval(e.Row.DataItem, "defaultvalue").ToString();

            if (DataBinder.Eval(e.Row.DataItem, "air_yn").ToString().CompareTo("Y") == 0)
            {
                chkair.Checked = true;
            }

            if (DataBinder.Eval(e.Row.DataItem, "road_yn").ToString().CompareTo("Y") == 0)
            {
                chkroad.Checked = true;
            }

            if (DataBinder.Eval(e.Row.DataItem, "train_yn").ToString().CompareTo("Y") == 0)
            {
                chktrain.Checked = true;
            }

            if (DataBinder.Eval(e.Row.DataItem, "express_yn").ToString().CompareTo("Y") == 0)
            {
                chkexpress.Checked = true;
            }

            if (DataBinder.Eval(e.Row.DataItem, "enabled").ToString().CompareTo("Y") == 0)
            {
                chkenabled.Checked = true;
            }

            if (DataBinder.Eval(e.Row.DataItem, "computerised").ToString().CompareTo("Y") == 0)
            {
                chkcomputerised.Checked = true;
            }
        }

    }


}
