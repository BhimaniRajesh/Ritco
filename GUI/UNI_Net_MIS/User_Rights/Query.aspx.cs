using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class GUI_UNI_Net_MIS_User_Rights_Query : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void NextStop_TextChanged(object sender, EventArgs e)
    {
        bool boo;
        boo = IsNextStopValid();
    }
    protected void ShowDocketsForMF(object sender, EventArgs e)
    {
        //if (IsNextStopValid() && IsUserCodeValid())
        //{
           
        //    txtNextStop.Enabled = false;
        //    txtNextStop.ForeColor = System.Drawing.Color.Blue;
           
        //}


        string final;
        final = "?Location=" + txtNextStop.Text.ToString();
        final += "&Employee=" + txtPreparedBy.Text.ToString();
        
        Response.Redirect("Result.aspx" + final);
    }

    protected bool IsNextStopValid()
    {
        lblError1.Visible = false;
        //trSubmit.Visible = true;
        btnSubmit.Enabled = true;
    
        if (txtNextStop.Text.Trim() != "")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            SqlCommand cmd = new SqlCommand("usp_ValidLocationCodeRPT", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = txtNextStop.Text.Trim();
            cmd.Parameters.Add("@LOGBRCD", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds2 = new DataSet();

            da.Fill(ds2);

            //if (txtNextStop.Text.ToString().ToUpper().Trim() == Session["brcd"].ToString().ToUpper().Trim())
            //{
            //    lblError1.Visible = true;
            //    lblError1.Text = "Next Stop Not will be " + txtNextStop.Text.ToString().ToUpper().Trim();
            //}

            //Raise Error if No Records Found for given Next Stop Code
            lblError1.Visible = (ds2.Tables[0].Rows.Count > 0 ? false : true);
            btnSubmit.Enabled = (ds2.Tables[0].Rows.Count > 0 ? true : false);
          
            if (lblError1.Visible)
            {
                txtNextStop.Focus();
            }
        }

        return !(lblError1.Visible);
    }

    protected void PreparedBy_TextChanged(object sender, EventArgs e)
    {
        bool boo;
        boo = IsUserCodeValid();
    }

 
    protected bool IsUserCodeValid()
    {
        lblError2.Visible = false;
        //trSubmit.Visible = true;
        btnSubmit.Enabled = true;
        if (txtPreparedBy.Text.Trim() != "")
        {

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            //string[] strEmployee = txtPreparedBy.Text.ToString().Split('~');

            SqlCommand cmd = new SqlCommand("usp_ValidUserCodeRPT", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@usercode", SqlDbType.VarChar).Value = txtPreparedBy.Text.ToString().Trim();
            cmd.Parameters.Add("@brcd", SqlDbType.VarChar).Value = Session["brcd"].ToString().Trim();
            cmd.Parameters.Add("@mainbrcd", SqlDbType.VarChar).Value = Session["mainbrcd"].ToString().Trim();

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds2 = new DataSet();

            da.Fill(ds2);



            //Raise Error if No Records Found for given Next Stop Code
            lblError2.Visible = (ds2.Tables[0].Rows.Count > 0 ? false : true);
            //lblErrorNL.Visible = (ds2.Tables[0].Rows.Count > 0 ? false : true);
            btnSubmit.Enabled = (ds2.Tables[0].Rows.Count > 0 ? true : false);

            //Focus Control on Error
            if (lblError2.Visible)
            {
                txtPreparedBy.Focus();
            }

        }

        return !(lblError2.Visible);
    }
}
