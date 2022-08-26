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

public partial class SFM_SalesTarget1 : System.Web.UI.Page
{
    public static SqlConnection conn;
    SqlCommand cmd = new SqlCommand();
    public string Employeecode, allIndustry, sqlstr;
   
    protected void Page_Load(object sender, EventArgs e)
    {
//        string scr = @"<script>
//                    function update(elemValue)
//                  {
//                     document.getElementById('ctl00_MyCPH1_txtEmployeeCode').value=elemValue;
//                  }
//                  </script>";

//        Page.RegisterClientScriptBlock("update", scr);
        //btnPopUp.Attributes.Add("onclick", "window.open('PopupEmployee.aspx',null,'left=600, top=100, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");

        Button3.Attributes.Add("onclick", "javascript:return check(" + cboSelectLocation.ClientID + ")");
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (!IsPostBack)
        {
            popRO();
            //conn.Open();
            SqlDataReader drIndustry;

            cmd.CommandText = "select CodeDesc,CodeId from Webx_Master_General where CodeType='IND'";
            cmd.Connection = conn;
            drIndustry = cmd.ExecuteReader();

            cboIndustry.Items.Clear();
            cboIndustry.Items.Add("Select");
            cboIndustry.Items.Add("All");
            while (drIndustry.Read())
            {
                cboIndustry.Items.Add(new ListItem(drIndustry.GetValue(0).ToString(), drIndustry.GetValue(1).ToString()));

            }

            drIndustry.Close();
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        string totProspect = "";
        foreach (ListItem li in cboCustomerId.Items)
        {
            if (li.Selected == true)
            {
                totProspect = totProspect + li.Value+",";
            }
            
            
        }
        if (totProspect != "")
        {
            totProspect = totProspect.Substring(0, totProspect.Length - 1);
        }
        string final = "?ProspectId=" + totProspect;
        final = final + "&Industry=" + cboIndustry.SelectedValue.ToString();
        final = final + "&year=" + cboYear.SelectedValue.ToString();
        //final = final + "&acccategory=" + cboAccCategory.SelectedValue.ToString();
        //final = final + "&employee=" + txtEmployeeCode.Text;
        final = final + "&employee=" + DropDownList1.SelectedValue.ToString();
        final = final + "&period=" + cboPeriod.SelectedValue.ToString();

        Response.Redirect("SalesTarget2.aspx" + final);
        
    }
    protected void cboIndustry_SelectedIndexChanged(object sender, EventArgs e)
    {
        string sql;
        string strIndustry = cboIndustry.SelectedValue.ToString();
        string locationcode = cboSelectLocation.SelectedValue.ToString();
        if (locationcode == "All")
        {
        locationcode = "%";
        }
       
        if (DropDownList1.SelectedValue == "--All--")
        {
            Employeecode = "";
        }
        else
        {
            Employeecode = DropDownList1.SelectedValue.ToString();
        }
        if (cboIndustry.SelectedItem.ToString() == "All")
        {
            allIndustry = "";
            sql = "select ProspectCode+' : '+CompanyName c1,ProspectCode from webx_ProspectCustomer where industryCode like '" + allIndustry + "%' and flag is null and entryby like '" + Employeecode + "%' and loccode='" + locationcode + "'";
        }
        else
        {
            sql = "select ProspectCode+' : '+CompanyName c1,ProspectCode from webx_ProspectCustomer where industryCode='" + strIndustry + "' and flag is null and entryby like '" + Employeecode + "%' and loccode='" + locationcode + "'";
        }
        
        //sql = "select ProspectCode+' : '+CompanyName c1,ProspectCode from webx_ProspectCustomer where industryCode='" + strIndustry + "' and flag is null and entryby like '" + Employeecode + "%'";
        //string sql = "select top 1 'All' as c1,'All' as ProspectCode from webx_ProspectCustomer union Select ProspectCode+' : '+CompanyName c1,ProspectCode from webx_ProspectCustomer where industryCode ='" + strIndustry + "' and flag is null and entryby like '" + Employeecode + "%'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
        da.Fill(ds, "tab1");
        cboCustomerId.DataSource = ds;
      
        cboCustomerId.DataTextField = "c1";
        cboCustomerId.DataValueField = "ProspectCode";
        cboCustomerId.DataBind();

        //conn.Close();
    }

    public void popRO()
    {
        string brcd = Session["brcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();

        
        if (loclvl <= 2)
        {
            
            if (loclvl == 1)
            {
                
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' ";
                //or loccode in (select loccode from webx_location where loc_level='1')";
                SqlCommand sqlcmd = new SqlCommand(sql, conn);
                DataSet ds = new DataSet();
                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

                da.Fill(ds, "tab");
                cboSelectRo.DataSource = ds;
                cboSelectRo.DataTextField = "c1";
                cboSelectRo.DataValueField = "c2";
                cboSelectRo.DataBind();
                
                popLOC();

            }
            else
            {
                string concat = brcd + " : " + locnm;
                cboSelectRo.Items.Clear();
                cboSelectRo.Items.Add(concat);
                cboSelectRo.DataBind();
                cboSelectRo.SelectedItem.Value = brcd;

                popLOC();

            }
        }
        else
        {
            string sqlcode = "select Report_Loc from webx_Location where LocCode='" + brcd + "'";
            SqlCommand sqlcmd = new SqlCommand(sqlcode, conn);
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

            da.Fill(ds, "tab");
            cboSelectRo.DataSource = ds;
            cboSelectRo.DataTextField = "Report_Loc";
            cboSelectRo.DataValueField = "Report_Loc";
            cboSelectRo.DataBind();

            string region = cboSelectRo.SelectedItem.ToString();

            string sqlcode1 = "select LocCode as c1,LocCode +':'+ LocName as c2 from webx_Location where LocCode='" + region + "'";
            SqlCommand command = new SqlCommand(sqlcode1, conn);
            DataSet ds1 = new DataSet();
            SqlDataAdapter da1 = new SqlDataAdapter(command);

            da1.Fill(ds1, "tab");
            cboSelectRo.DataSource = ds1;
            cboSelectRo.DataTextField = "c2";
            cboSelectRo.DataValueField = "c1";
            cboSelectRo.DataBind();
            
            cboSelectLocation.Items.Clear();
            cboSelectLocation.Items.Add("Select");
            cboSelectLocation.Items.Add(brcd);


        }
    }

    public void popLOC()
    {
        string strro = cboSelectRo.SelectedValue.ToString();
        string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

        da.Fill(ds, "tab1");
        cboSelectLocation.DataSource = ds;
        cboSelectLocation.DataTextField = "c1";
        cboSelectLocation.DataValueField = "loccode";
        cboSelectLocation.DataBind();

    }
    protected void cboSelectLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        string brcd = Session["brcd"].ToString();
        string empcd = Session["empcd"].ToString();
        string q1 = "Select Loc_level,locname from webx_location where loccode='" + brcd + "'";
        SqlCommand sqlcmd1 = new SqlCommand(q1, conn);
        SqlDataReader dr;
        dr = sqlcmd1.ExecuteReader();

        dr.Read();
        int loclvl = Convert.ToInt16(dr["Loc_level"]);
        string locnm = dr["locname"].ToString();
        dr.Close();
        if (loclvl == 1)
        {
             sqlstr = "select top 1 '--All--' as Name, '--All--' as UserID from WebX_Master_Users union select Name,UserID from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "'";
        }
        else if (Session["mainbrcd"].ToString().Trim() != Session["brcd"].ToString().Trim())
        {
            sqlstr = "select top 1 '--All--' as Name, '--All--' as UserID from WebX_Master_Users union select Name,UserID from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "'";
        }
        else if (Session["mainbrcd"].ToString().Trim() == Session["brcd"].ToString().Trim())
        {
            sqlstr = "select top 1 '--All--' as Name, '--All--' as UserID from WebX_Master_Users union select Name,UserID from WebX_Master_Users where BranchCode='" + cboSelectLocation.SelectedValue.ToString() + "' and UserID='" + empcd + "' ";
        }
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        SqlDataReader dread = cmd.ExecuteReader();
        DropDownList1.Items.Clear();
        while (dread.Read())
        {
            DropDownList1.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
        }
        dread.Close();
        //conn.Close();
    }
    protected void cboSelectRo_SelectedIndexChanged(object sender, EventArgs e)
    {
        popLOC();
    }
}
