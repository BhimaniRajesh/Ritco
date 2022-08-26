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
    public static string esicd, p;
    public string err = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        p = Request.QueryString["pa"].ToString();



        if (!IsPostBack)
        {
            esicd = "";
            if (p == "1")
            {

            }
            else
            {

                esicd = Request.QueryString["esino"].ToString();
                filldata();

            }
        }
        getstring();
        btn_submit.Attributes.Add("onclick", "javascript:return ValidateData()");
    }


    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "";
        if (p == "1")
        {
            sql = "SELECT ESI_CODE FROM  WEBX_ESICMST";
        }
        else
        {
            sql = "SELECT ESI_CODE FROM  WEBX_ESICMST where ESI_CODE <> '" + esicd + "'";
        }
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["ESI_CODE"] + "'"));
        }
        dr_Location.Close();
    }

    public void filldata()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string q = "select * from WEBX_ESICMST where ESI_CODE='" + esicd + "'";
        SqlCommand c = new SqlCommand(q, cn);

        SqlDataReader d = c.ExecuteReader();

        while (d.Read())
        {
             txtesicd.Text = d["ESI_CODE"].ToString();
            txtvaliditydt.Text = Convert.ToDateTime(d["ESI_VALIDITY_DT"].ToString()).ToString("dd/MM/yyyy");

            txtmaxage.Text = d["ESI_MAX_AGE_LIMIT"].ToString();
            txtpfsallimit.Text = d["ESI_SAL_LIMIT"].ToString();

            txtemp.Text = d["ESI_EMPLOYEE"].ToString();
            txtempr.Text = d["ESI_EMPLOYER"].ToString();



        }
        d.Close();


    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection conn = new SqlConnection(Session["Sqlprovider"].ToString().Trim());

            conn.Open();
            string valdt = "";
            if (txtvaliditydt.Text != "")
            {
                string[] strArrDtFrom = txtvaliditydt.Text.Split('/');

                valdt = strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2];
            }

            string sql = "";
            if (p == "1")
            {

                sql = "Insert into WEBX_ESICMST(ESI_CODE,ESI_VALIDITY_DT,ESI_MAX_AGE_LIMIT,ESI_SAL_LIMIT,ESI_EMPLOYEE,ESI_EMPLOYER,etryby,enytrydate) values" +
                    "('" + txtesicd.Text + "','" + valdt + "','" + txtmaxage.Text + "','" + txtpfsallimit.Text + "','" + txtemp.Text + "','" + txtempr.Text + "','" + Session["empcd"].ToString() + "',getdate())";
                //,'" + Session["empcd"].ToString + "'";
                //,getdate())";
            }
            else
            {
                sql = "Update WEBX_ESICMST set ESI_CODE='" + txtesicd.Text + "', ESI_VALIDITY_DT='" + valdt + "',ESI_MAX_AGE_LIMIT='" + txtmaxage.Text + "',ESI_SAL_LIMIT='" + txtpfsallimit.Text + "',ESI_EMPLOYEE='" + txtemp.Text + "',ESI_EMPLOYER='" + txtempr.Text + "',UPDATEDBY='" + Session["empcd"].ToString() + "',UPDATEDDATE=getdate() WHERE  ESI_CODE='" + esicd + "'";


            }


            SqlCommand sqlcmd = new SqlCommand(sql, conn);

            sqlcmd.ExecuteNonQuery();
        }

        catch (Exception e1)
        {
            err += e1.Message;
        }

        if (err == "")
        {
            Error.Visible = false;
            if (p == "1")
            {
                lblerr.Text = "ESI Code " + txtesicd.Text + " Generated...";
            }
            else
            {
                lblerr.Text = "PF Code " + txtesicd.Text + " Updated...";
            }
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

}
