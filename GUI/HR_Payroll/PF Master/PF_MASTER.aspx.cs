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
    public static string pfcd, p;
    public string err = "";
    protected void Page_Load(object sender, EventArgs e)
    {




        if (!IsPostBack)
        {
            pfcd = "";
            SqlConnection cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            cn1.Open();
            string sql = "SELECT top 1 PF_CODE FROM  webx_pfmst";
            SqlCommand sqlCommand = new SqlCommand(sql, cn1);
            pfcd= Convert.ToString(sqlCommand.ExecuteScalar());


            if (pfcd == "")
            {

            }
            else
            {

                filldata();

            }
        }
         
        btn_submit.Attributes.Add("onclick", "javascript:return ValidateData()");
    }


    

    public void filldata()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string q = "select * from WEBX_PFMST where PF_CODE='" + pfcd + "'";
        SqlCommand c = new SqlCommand(q, cn);

        SqlDataReader d = c.ExecuteReader();

        while (d.Read())
        {
            txtpfcd.Text = d["pf_code"].ToString();
            txtvaliditydt.Text = Convert.ToDateTime(d["PF_VALIDITY_DT"].ToString()).ToString("dd/MM/yyyy");

            txtmaxage.Text = d["PF_MAX_AGE_LIMIT"].ToString();
            txtpfsallimit.Text = d["PF_SAL_LIMIT"].ToString();

            txtepf.Text = d["EMPLOYER_PF"].ToString();
            txtpension.Text = d["PENSION_FUND"].ToString();

            txtinspchg.Text = d["INSPECTION_CHRG"].ToString();
            txtvaliditydt.Text = Convert.ToDateTime(d["PF_VALIDITY_DT"]).ToString("dd/MM/yyyy");

            txtpfcd.Text = d["pf_code"].ToString();
            txtedli.Text = d["EDLI"].ToString();

            txtadminchg.Text = d["ADMIN_CHRG"].ToString();
            //tvaliditydt.Text = d["PF_VALIDITY_DT"].ToString();



            //PF_VALIDITY_DT,PF_MAX_AGE_LIMIT,PF_SAL_LIMIT,EMPLOYEE_PF,PENSION_FUND,EMPLOYER_PF,INSPECTION_CHRG,EDLI,ADMIN_CHRG

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
            if (pfcd == "")
            {

                sql = "Insert into WEBX_PFMST(PF_CODE,PF_VALIDITY_DT,PF_MAX_AGE_LIMIT,PF_SAL_LIMIT,EMPLOYEE_PF,PENSION_FUND,EMPLOYER_PF,INSPECTION_CHRG,EDLI,ADMIN_CHRG,etryby,enytrydate) values" +
                    "('" + txtpfcd.Text + "','" + valdt + "','" + txtmaxage.Text + "','" + txtpfsallimit.Text + "','" + txtemppf.Text + "','" + txtpension.Text + "','" + txtepf.Text + "','" + txtinspchg.Text + "','" + txtedli.Text + "','" + txtadminchg.Text + "','" + Session["empcd"].ToString() + "',getdate())";
                //,'" + Session["empcd"].ToString + "'";
                //,getdate())";
            }
            else
            {
                sql = "Update WEBX_PFMST set PF_CODE='" + txtpfcd.Text + "', PF_VALIDITY_DT='" + valdt + "',PF_MAX_AGE_LIMIT='" + txtmaxage.Text + "',PF_SAL_LIMIT='" + txtpfsallimit.Text + "',EMPLOYEE_PF='" + txtemppf.Text + "',EMPLOYER_PF='" + txtepf.Text + "',PENSION_FUND='" + txtpension.Text + "',INSPECTION_CHRG='" + txtinspchg.Text + "',EDLI='" + txtedli.Text + "',ADMIN_CHRG='" + txtadminchg.Text + "',UPDATEDBY='" + Session["empcd"].ToString() + "',UPDATEDDATE=getdate() WHERE  PF_CODE='" + pfcd + "'";


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
            if (pfcd == "")
            {
                lblerr.Text = "PF Code " + txtpfcd.Text + " Generated...";
            }
            else
            {
                lblerr.Text = "PF Code " + txtpfcd.Text + " Updated...";
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
