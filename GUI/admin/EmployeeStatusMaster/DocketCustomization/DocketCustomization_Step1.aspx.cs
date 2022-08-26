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

public partial class GUI_admin_DocketCustomization_DocketCustomization_Step1 : System.Web.UI.Page
{
    SqlConnection con;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(Session["SqlProvider"].ToString());
        }
        catch (Exception ex)
        {
            Response.Redirect("~/GUI/Operation/DocketEntry/ErrorPage.aspx?heading=Session Expired&detail1=" + ex.Message.Replace('\n', '_'));
            return;
        }
        con.Open();

        if (!IsPostBack)
        {
            string strsql = "SELECT * FROM webx_rules_docket";
            SqlCommand cmd = new SqlCommand(strsql, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            /*
                    WE UPDATE CONTRACT AS PER FOLLOWING METHOD
             *      C   --      CUSTOMER WISE CONTRACT
             *      CD  --      FIRST CHECK FOR CUSOMER WISE CONTRACT IF DOESN'T EXIST THEN GOTO MINIMUM
             *      D   --      ONLY DEFAULT CONTRACT
             *      W   --      WITHOUT CONTRACT
             * 
             *      ALSO MINIMUM FREIGHT TOBE USED OR NOT
             *      L   --      LOCATION TO LOCATION FREIGHT ONLY
             *      M   --      USE MINIMUM FREIGHT WHICH IS DEFINED IN STEP 2
             */

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                // Updating paid contract type
                if (dt.Rows[i]["code"].ToString().CompareTo("P01CONTRACT") == 0)
                {
                    optpaidcontract.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }

                if (dt.Rows[i]["code"].ToString().CompareTo("P02CONTRACT") == 0)
                {
                    opttbbcontract.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }

                if (dt.Rows[i]["code"].ToString().CompareTo("P03CONTRACT") == 0)
                {
                    opttopaycontract.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }

                if (dt.Rows[i]["code"].ToString().CompareTo("P01DEPTH") == 0)
                {
                    optpaiddepthtype.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }

                if (dt.Rows[i]["code"].ToString().CompareTo("P02DEPTH") == 0)
                {
                    opttbbdepthtype.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }

                if (dt.Rows[i]["code"].ToString().CompareTo("P03DEPTH") == 0)
                {
                    opttopaydepthtype.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }


                if (dt.Rows[i]["code"].ToString().CompareTo("P01PROCEED") == 0)
                {
                    optpaidproceed.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }

                if (dt.Rows[i]["code"].ToString().CompareTo("P02PROCEED") == 0)
                {
                    opttbbproceed.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }

                if (dt.Rows[i]["code"].ToString().CompareTo("P03PROCEED") == 0)
                {
                    opttopayproceed.SelectedValue = dt.Rows[i]["defaultvalue"].ToString();
                }
            }
        }
    }


    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlTransaction trn = con.BeginTransaction();
        try
        {
            string sqlstr = "";
            SqlCommand cmd;

            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + optpaidcontract.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P01CONTRACT'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + opttbbcontract.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P02CONTRACT'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + opttopaycontract.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P03CONTRACT'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + optpaiddepthtype.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P01depth'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + opttbbdepthtype.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P02depth'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + opttopaydepthtype.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P03depth'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + optpaidproceed.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P01PROCEED'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + opttbbproceed.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P02PROCEED'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();


            sqlstr = "UPDATE webx_rules_docket SET defaultvalue='" + opttopayproceed.SelectedValue + "'";
            sqlstr = sqlstr + " WHERE code='P03PROCEED'";
            cmd = new SqlCommand(sqlstr, con, trn);
            cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            trn.Rollback();
            return;
        }
        trn.Commit();
        Response.Redirect("DocketCustomization_Step2.aspx");
    }
}
