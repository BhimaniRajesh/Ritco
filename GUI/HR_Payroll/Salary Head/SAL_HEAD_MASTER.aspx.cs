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
    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    SqlConnection cn;
    public DataTable dt_san = new DataTable();
    public static string pfcd, p;
    public string err = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        p = Request.QueryString["pa"].ToString();



        if (!IsPostBack)
        {
            pfcd = "";
            if (p == "1")
            {
                creatgrd();
            }
            else
            {

                pfcd = Request.QueryString["pfno"].ToString();
                filldata();

            }
        }
         getstring();
         getstring2();
        btn_submit.Attributes.Add("onclick", "javascript:return ValidateData()");
    }


    private void getstring()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "";

        sql = "SELECT sal_headname FROM  WEBX_SALHEADMST";
        
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["sal_headname"] + "'"));
        }
        dr_Location.Close();
    }

    private void getstring2()
    {
        //holidaystr = "";
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        string sql = "";

        sql = "SELECT SAL_PRINTNAME FROM  WEBX_SALHEADMST";

        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str2", "'" + Convert.ToString(dr_Location["SAL_PRINTNAME"] + "'"));
        }
        dr_Location.Close();
    }


    protected void roww_TextChanged(object sender, EventArgs e)
    {

        creatgrd();
    }

    public void creatgrd()
    {

        int rowno;

        rowno = Convert.ToInt32(roww.Text);


        dt_san.Clear();
        Int32 i;
        DataRow drow;


        for (i = 0; i < rowno; i++)
        {
            drow = dt_san.NewRow();
            dt_san.Rows.Add(drow);

        }


        GV_D.DataSource = dt_san;
        GV_D.DataBind();



    }


    public void filldata()
    {
        //SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn.Open();

        //string q = "select * from WEBX_PFMST where PF_CODE='" + pfcd + "'";
        //SqlCommand c = new SqlCommand(q, cn);

        //SqlDataReader d = c.ExecuteReader();

        //while (d.Read())
        //{
        //    txtpfcd.Text = d["pf_code"].ToString();
        //    txtvaliditydt.Text = Convert.ToDateTime(d["PF_VALIDITY_DT"].ToString()).ToString("dd/MM/yyyy");

        //    txtmaxage.Text = d["PF_MAX_AGE_LIMIT"].ToString();
        //    txtpfsallimit.Text = d["PF_SAL_LIMIT"].ToString();

        //    txtepf.Text = d["EMPLOYER_PF"].ToString();
        //    txtpension.Text = d["PENSION_FUND"].ToString();

        //    txtinspchg.Text = d["INSPECTION_CHRG"].ToString();
        //    txtvaliditydt.Text = Convert.ToDateTime(d["PF_VALIDITY_DT"]).ToString("dd/MM/yyyy");

        //    txtpfcd.Text = d["pf_code"].ToString();
        //    txtedli.Text = d["EDLI"].ToString();

        //    txtadminchg.Text = d["ADMIN_CHRG"].ToString();
        //    //tvaliditydt.Text = d["PF_VALIDITY_DT"].ToString();



        //    //PF_VALIDITY_DT,PF_MAX_AGE_LIMIT,PF_SAL_LIMIT,EMPLOYEE_PF,PENSION_FUND,EMPLOYER_PF,INSPECTION_CHRG,EDLI,ADMIN_CHRG

        //}
        //d.Close();


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

                TextBox txtsalhead_Desc = (TextBox)gridrow.FindControl("txtsalhead_Desc");

                if (txtsalhead_Desc.Text != "")
                {

                    TextBox txtprintname = (TextBox)gridrow.FindControl("txtprintname");
                    DropDownList ddtype = (DropDownList)gridrow.FindControl("ddtype");
                    DropDownList ddshoninsalslp = (DropDownList)gridrow.FindControl("ddshoninsalslp");
                    DropDownList ddtds = (DropDownList)gridrow.FindControl("ddtds");
                    DropDownList ddcalcbasis = (DropDownList)gridrow.FindControl("ddcalcbasis");




                    string sql = "";
                    if (p == "1")
                    {

                        sql = "Insert into WEBX_SALHEADMST(SAL_HEADNAME,SAL_PRINTNAME,SAL_HEADTYPE,PAYSLIP_SHOW_YN,SAL_CALBASIS,TDS_YN,etryby,enytrydate)" +
                       " values ('" + txtsalhead_Desc.Text + "','" + txtprintname.Text + "','" + ddtype.SelectedValue.ToString() + "','" + ddshoninsalslp.SelectedValue.ToString() + "','" + ddcalcbasis.SelectedValue.ToString() + "','" + ddtds.SelectedValue.ToString() + "','" + Session["empcd"].ToString() + "',getdate())";
                        //,'" + Session["empcd"].ToString + "'";
                        //,getdate())";
                    }
                    else
                    {
                      //  sql = "Update WEBX_SALHEADMST set SAL_HEADNAME='" + txtsalhead_Desc.Text + "', SAL_PRINTNAME='" + txtprintname.Text + "',SAL_HEADTYPE='" + ddtype.SelectedValue.ToString() + "',PAYSLIP_SHOW_YN='" + ddshoninsalslp.SelectedValue.ToString() + "',SAL_CALBASIS='" + ddcalcbasis.SelectedValue.ToString() + "',TDS_YN='" + ddtds.SelectedValue.ToString() + "',UPDATEDBY='" + Session["empcd"].ToString() + "',UPDATEDDATE=getdate() WHERE  PF_CODE='" + pfcd + "'";


                    }


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
            if (p == "1")
            {
                lblerr.Text = "Salary Head Code Generated Successfully...";
            }
            else
            {
                lblerr.Text = "Salary Head  Updated Successfully...";
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
