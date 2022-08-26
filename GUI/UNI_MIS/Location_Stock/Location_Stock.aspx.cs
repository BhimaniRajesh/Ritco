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

public partial class GUI_UNI_MIS_Login_View_Login_view : System.Web.UI.Page
{

    public byte byteRadButtonSelection;


    protected void Page_Load(object sender, EventArgs e)
    {
        
            if (!IsPostBack)
            {
                // mypanal.Visible = false;
                txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtDateTo.Text = txtDateFrom.Text;
                popRO();
                popRO2();
                popLOC3();
                rdreptype.SelectedIndex = 0;
               
            }

        
    }
    
   

     

    public void popRO()
    {
       

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string s = Session["SqlProvider"].ToString().Trim();
        // conn = new SqlConnection(sConn);
        conn.Open();

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
            //
            if (loclvl == 1)
            {
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";

                SqlCommand sqlcmd = new SqlCommand(sql, conn);

                DataSet ds = new DataSet();

                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


                da.Fill(ds, "tab");
                ddlro.DataSource = ds;
                ddlro.DataTextField = "c1";
                ddlro.DataValueField = "c2";
                ddlro.DataBind();



                //ddlro2.DataSource = ds;
                //ddlro2.DataTextField = "c1";
                //ddlro2.DataValueField = "c2";
                //ddlro2.DataBind();


            }
            else
            {
                string concat = brcd + " : " + locnm;


                ddlro.Items.Clear();

                ddlro.Items.Add(concat);
                ddlro.DataBind();
                ddlro.SelectedItem.Value = brcd;

                popLOC();




             //   ddlro2.Items.Clear();

                //ddlro2.Items.Add(concat);
                //ddlro2.DataBind();
                //ddlro2.SelectedItem.Value = brcd;

                //popLOC2();

            }





        }
        else
        {
            ddlro.Enabled = false;
            ddlloc.Items.Clear();
            ddlloc.Items.Add(brcd);



           // ddlro2.Enabled = false;
            //ddlloc2.Items.Clear();
            //ddlloc2.Items.Add(brcd);
        }





    }




    public void popRO2()
    {


        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string s = Session["SqlProvider"].ToString().Trim();
        // conn = new SqlConnection(sConn);
        conn.Open();

        
                string sql = "select top 1 'All' as c1,'All' as c2 from webx_location  union select loccode+' : '+locname c1,loccode c2 FROM webx_location where LOC_LEVEL='2' or loccode in (select loccode from webx_location where loc_level='1')";

                SqlCommand sqlcmd = new SqlCommand(sql, conn);

                DataSet ds = new DataSet();

                SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

                da.Fill(ds, "tab");
            
                ddlro2.DataSource = ds;
                ddlro2.DataTextField = "c1";
                ddlro2.DataValueField = "c2";
                ddlro2.DataBind();

          


    }
    public void popLOC()
    {
         SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       
          conn.Open();
        string strro = ddlro.SelectedValue.ToString();
        string sql = "select top 1 '-All-' as c1,'-All-' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        //sqlcmd.CommandType = CommandType.Text;
        //select loccode+':'+locname c1 from webx_location
        //ddlro.DataTextField = "-ALL-";
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        ddlloc.DataSource = ds;
        ddlloc.DataTextField = "c1";
        ddlloc.DataValueField = "loccode";
        ddlloc.DataBind();
    }


    public void popLOC2()
    {
          SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string strro = ddlro2.SelectedValue.ToString();
        string sql = "select top 1 '-All-' as c1,'-All-' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
         DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        ddlloc2.DataSource = ds;
        ddlloc2.DataTextField = "c1";
        ddlloc2.DataValueField = "loccode";
        ddlloc2.DataBind();
    }
    public void popLOC3()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();

        string sql = "select top 1 '-All-' as c1,'-All-' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location";
        //string sql = "select loccode from webx_location where report_loc= '" + strro + "'";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        ddlloc2.DataSource = ds;
        ddlloc2.DataTextField = "c1";
        ddlloc2.DataValueField = "loccode";
        ddlloc2.DataBind();
    }



   
    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {
        popLOC();
    }
    
    protected void ddlloc_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void radDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = new RadioButtonList();
        rbl = (RadioButtonList)sender;

        byteRadButtonSelection = Convert.ToByte(rbl.SelectedItem.Value);

        if (rbl.Items[0].Selected)
        {
            txtDateFrom.ReadOnly = false;
            txtDateTo.ReadOnly = false;
        }
        else
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
        }

        if (rbl.Items[1].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddDays(-7).ToString("dd/MM/yyyy");
            txtDateTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
        else if (rbl.Items[2].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Now.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }
        

    }
    public void daterange(object source, ServerValidateEventArgs value)
    {

        string[] strDtFrom = txtDateFrom.Text.Split('/');
        DateTime dt1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));
        string[] strDtTo = txtDateTo.Text.Split('/');
        DateTime dt2 = new DateTime(Convert.ToInt16(strDtTo[2]), Convert.ToInt16(strDtTo[1]), Convert.ToInt16(strDtTo[0]));

        System.TimeSpan diffResult = dt2.Subtract(dt1);
        if (diffResult.Days > 31)
        {
            value.IsValid = false;
        }

        else if (dt1 > dt2)
        {
            value.IsValid = false;
            CustomValidator1.ErrorMessage = "From Date Can not Be Greter Than To Date.";
        }
        else
        {
            value.IsValid = true;

        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        
     if (Page.IsValid == true)
        {
           
            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");

            Session["dt"] = strDate;
            string strFinalQS = "?strDateRange=" + strDate;
            string s1, s2;
            s1 = ddlloc.SelectedValue.ToString();
            s2 = ddlloc2.SelectedValue.ToString();
            if (s1 == "-All-")
            {
                s1 = "All";
            }
            if (s2 == "-All-")
            {
                s2 = "All";
            }
            strFinalQS = strFinalQS + "&strloc=" + s1;
            strFinalQS = strFinalQS + "&strro=" + ddlro.SelectedValue.ToString();
            strFinalQS = strFinalQS + "&strloc2=" + s2;
            strFinalQS = strFinalQS + "&strro2=" + ddlro2.SelectedValue.ToString();
            strFinalQS = strFinalQS + "&reptype=" + rdreptype.SelectedValue.ToString();
            strFinalQS = strFinalQS + "&reppara="+"new";


            if (rdreptype.SelectedValue.ToString() == "S")
            {
                Response.Redirect("Show_Summary_Location_stock.aspx" + strFinalQS);
            }
            else
            {
                Response.Redirect("Show_Detail_Location_stock.aspx" + strFinalQS);
            }

            
            
        }

    }
    protected void ddlventype2_SelectedIndexChanged(object sender, EventArgs e)
    {
           
    }
    protected void ddlro2_SelectedIndexChanged(object sender, EventArgs e)
    {
        popLOC2();
    }
}

