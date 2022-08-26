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

public partial class OutStanding_OutStand : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    protected void Page_Load(object sender, EventArgs e)
    {

        string scr1 = @"<script>
        function update1(elemValue)
        {        
            document.getElementById('ctl00_MyCPH1_txtPartyCode').value=elemValue;        
        }
        </script>";

        Page.RegisterClientScriptBlock("update1", scr1);
        btnBranchPopup.Attributes.Add("onclick", "window.open('PopUp_Cust.aspx?ID=C',null,'left=600, top=100, height=300, width= 450, status=no, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');");



        if (!IsPostBack)
        {
            //txtDateFrom.Text = DateTime.Now.Day.ToString() + "/" + DateTime.Now.Month.ToString() + "/" + DateTime.Now.Year.ToString();
          

            popRO();
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



            }
            else
            {
                string concat = brcd + " : " + locnm;


                ddlro.Items.Clear();

                ddlro.Items.Add(concat);
                ddlro.DataBind();
                ddlro.SelectedItem.Value = brcd;

                popLOC();




            }





        }
        else
        {
            ddlro.Enabled = false;
            ddlloc.Items.Clear();
            ddlloc.Items.Add(brcd);


        }





    }

    public void popLOC()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string strro = ddlro.SelectedValue.ToString();
        string sql = "select top 1 'All' as c1,'All' as loccode from webx_location  union select loccode+' : '+locname c1,loccode  from webx_location where report_loc= '" + strro + "'";
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

    
    protected void ddlro_SelectedIndexChanged(object sender, EventArgs e)
    {

        popLOC();
    }

    protected void ddlloc_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddlbilltype_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnShow_Click1(object sender, EventArgs e)
    {
        //string[] strdt = txtdt.Text.Split('/');

        //DateTime dt = Convert.ToDateTime(strdt[1] + "/" + strdt[0] + "/" + strdt[2]);


        //string strqDate = Convert.ToDateTime(strdt[1] + "/" + strdt[0] + "/" + strdt[2]).ToString("dd MMM yy") ;
        string strro = ddlro.SelectedValue.ToString();
        string strloc = ddlloc.SelectedValue.ToString();
        string strcust = txtPartyCode.Text;
       // string strflowtype = radFlow.SelectedValue.ToString();
        string strdttype = rddttype.SelectedValue.ToString();
        string strbr_cst = rdbrcst.SelectedValue.ToString();
        string strageos = ddlageos.SelectedValue.ToString();
        string strbilltype = ddlbilltype.SelectedValue.ToString();



        string strFinalQS = "?OSDate=" + "";
        strFinalQS = strFinalQS + "&RO=" + strro;
        strFinalQS = strFinalQS + "&Location=" + strloc;
        strFinalQS = strFinalQS + "&Cust=" + strcust;
        strFinalQS = strFinalQS + "&BillType=" + strbilltype;
        strFinalQS = strFinalQS + "&AgeOs=" + strageos;
        strFinalQS = strFinalQS + "&DateType=" + strdttype;
        strFinalQS = strFinalQS + "&Br_Cst=" + strbr_cst;

        Session["age"] = strageos;

        Response.Redirect("Show_OutStanding2.aspx" + strFinalQS);
   

    }

   


    //protected void rdbrcst_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //    //int val=rdbrcst.SelectedValue
    //    if (rdbrcst.SelectedValue.ToString() == "1")
    //    {
    //        ddlro.Enabled = false;
    //        ddlloc.Enabled = false;
    //    }

    //    else
    //    {
    //        ddlro.Enabled = true;
    //        ddlloc.Enabled = true;
    //    }
    //}
    protected void rddttype_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    
}
