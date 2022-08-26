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
    public static string straccd,p;
    protected void Page_Load(object sender, EventArgs e)
    {
       
        p = Request.QueryString["pa"].ToString();


        if (!IsPostBack)
        {
            straccd = "";
            if (p == "1")
            {
                popgrp();
            }
            else
            {
                popgrp();
                straccd = Request.QueryString["accode"].ToString();
                filldata();

            }
        }
        btn_submit.Attributes.Add("onclick", "javascript:return ValidateData()");
    }


    public string getnewassetcd()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        string sql = "Select max(convert(int,substring(assetcd,3,6)))+1 as maxOCAGCD from webx_assetmaster";

        
        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        int cd1 = (int)sqlcmd.ExecuteScalar();

        string cd = Convert.ToString(cd1);


    //    if len(maxOCAGCD)=1 then
    // assetcd ="FA" + "0000" + CStr(maxOCAGCD)
    //elseif len(maxOCAGCD)=2 then
    // assetcd ="FA" + "000" + CStr(maxOCAGCD)
    //elseif len(maxOCAGCD)=3 then
    // assetcd ="FA" + "00" + CStr(maxOCAGCD)
    //elseif len(maxOCAGCD)=4 then
    // assetcd="FA" + "0" + CStr(maxOCAGCD)
    //elseif len(maxOCAGCD)=5 then
    // assetcd="FA" + CStr(maxOCAGCD)
    //end if 


        if (cd.Length == 1)
        {
            cd = "FA" + "0000" + cd;
        }
        else if (cd.Length == 2)
        {
            cd = "FA" + "000" + cd;
        }

        else if (cd.Length == 3)
        {
            cd = "FA" + "00" + cd;
        }
        else if (cd.Length == 4)
        {
            cd = "FA" + "0" + cd;
        }
        else if (cd.Length == 5)
        {
            cd = "FA" +cd;
        }

        return cd;



    
    
    
    }
    public void popgrp()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        string sql = "select top 1 '--Select--' as c1,'--Select--' as c2 from webx_acctinfo union select Acccode as c2,Accdesc as c1 from webx_acctinfo where acccategory='Fixed Assets'";
            //"select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";

        
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
    
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        ddlassetgrp.DataSource = ds;
        ddlassetgrp.DataTextField = "c2";
        ddlassetgrp.DataValueField = "c1";
        ddlassetgrp.DataBind();
    
    }
    public void filldata()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        string q = "select * from webx_assetmaster where assetcd='" + straccd + "'";
        SqlCommand c = new SqlCommand(q, cn);

        SqlDataReader d = c.ExecuteReader();

        while (d.Read())
        {
            txtdesc.Text = d["assetname"].ToString();
            txtprefix.Text = d["prefix"].ToString();

            l1.Text = straccd;
          
            ddlassetgrp.SelectedValue = d["grpasstcd"].ToString();


            ddlcat.SelectedValue = d["category"].ToString();


            ddlunit.SelectedValue = d["units"].ToString();

            

        }
        d.Close();
 

    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string sql = "";
        if (p == "1")
        {
            string acd = getnewassetcd();

              sql = "Insert into webx_assetmaster(assetcd,assetname,GRPASSTCD,UNITS,CATEGORY,ENTRYBY,ENTRYON,prefix) values('" + acd + "','" + txtdesc.Text + "','" + ddlassetgrp.SelectedValue.ToString() + "','" + ddlunit.SelectedValue.ToString() + "','" + ddlcat.SelectedValue.ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'" + txtprefix.Text + "')";
        }
        else
        {
              sql = "Update webx_assetmaster set assetname='" + txtdesc.Text + "',GRPASSTCD='" + ddlassetgrp.SelectedValue.ToString() + "',UNITS='" + ddlunit.SelectedValue.ToString() + "',CATEGORY='" + ddlcat.SelectedValue.ToString() + "',updtBY='" + Session["empcd"].ToString() + "',updtON=getdate(),prefix='" + txtprefix.Text + "' where assetcd='" + straccd + "' ";
                    
        
        }
        

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        
        sqlcmd.ExecuteNonQuery();

        Response.Redirect("fa.aspx");


    
    


    }

}
