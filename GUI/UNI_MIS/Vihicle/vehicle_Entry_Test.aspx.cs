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

public partial class vehicle_Entry : System.Web.UI.Page
{
    public byte byteRadButtonSelection;
    public static string qryPRS,qryDRS;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           // mypanal.Visible = false;
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
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
        else if (rbl.Items[3].Selected)
        {
            txtDateFrom.ReadOnly = true;
            txtDateTo.ReadOnly = true;
            txtDateFrom.Text = System.DateTime.Today.AddYears(-50).ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
        }

    }

    protected void ddlDoctype_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDoctype.SelectedValue.ToString() == "T")
        {
            m1.Visible = false;
            pnlDRS.Visible = false;
            pnl1.Visible = true;
        }
        else if (ddlDoctype.SelectedValue.ToString() == "P")
        {
            pnl1.Visible = false;
            pnlDRS.Visible = false;
            m1.Visible = true;

        }

        else if (ddlDoctype.SelectedValue.ToString() == "D" || ddlDoctype.SelectedValue.ToString() == "PD")
        {
            pnlDRS.Visible = true;
            pnl1.Visible = false;
            m1.Visible = false;
        
        }

        else
        {
            pnl1.Visible = false;
            m1.Visible = false;
            pnlDRS.Visible = false;
        }



    }
    protected void ddlrmode_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlloc.SelectedValue.ToString() == "All")
        {

            ddlroute.Items.Clear();
            ddlroute.Items.Add("== Select Location First ==");

        }
        else
        {
            poproute();

        }


    }


    public void poproute()
    {


        string rmode = ddlrmode.SelectedValue;
        string sloc = ddlloc.SelectedValue;




        //this is
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //    new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");





        //SqlConnection conn = new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;");

        //= 

        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
        //conn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";

        // conn = new SqlConnection(sConn);
        try
        {
            conn.Open();
        }
        catch (Exception ee)
        {
            lbl.Text = ee.Message;
        }





        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = conn;


        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.CommandText = "sp_routes_for_thc_san";


        sqlCommand.Parameters.AddWithValue("@loccode", "");
        sqlCommand.Parameters.AddWithValue("@RouteMode", rmode);
        sqlCommand.Parameters.AddWithValue("@location", sloc);
        sqlCommand.Parameters.AddWithValue("@NonStandardCode", "9888");

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);

        DataSet ds = new DataSet();
        da.Fill(ds, "tab");
        ddlroute.DataSource = ds;
        ddlroute.DataTextField = "san";
        ddlroute.DataValueField = "routecd";
        ddlroute.DataBind();

        ddlventype.Items.Clear();
        popVenType();

    }

    public void popVenType()
    {

        if (ddlrmode.SelectedValue.ToString() == "R" || ddlrmode.SelectedValue.ToString() == "A")
        {

            ddlventype.Items.Add("Select");
            ddlventype.Items.Add("Attached");
            ddlventype.Items.Add("Own");

        }
        else if (ddlrmode.SelectedValue.ToString() == "S")
        {
            ddlventype.Items.Add("Select");
            ddlventype.Items.Add("Attached");
            ddlventype.Items.Add("Own");
            ddlventype.Items.Add("Co - Loader");
            // ddlventype.Items.Add("A", "ABCD");


        }
        else
        {
            ddlventype.Items.Add("Select");
        }




    }


    protected void ddlloc_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlventype_SelectedIndexChanged(object sender, EventArgs e)
    {
        PopVen();

    }

    public void PopVen()
    {



        string rmode = ddlrmode.SelectedItem.ToString();

        string strrmode = "";
        if (rmode == "Train")
        {
            strrmode = "Rail";
        }
        else if (rmode == "Road")
        {
            strrmode = "Road";
        }
        else if (rmode == "Air")
        {
            strrmode = "Air";
        }


        string vwname = "vw_" + strrmode.Trim() + "_vendors_attached";
        string v1 = ddlventype.SelectedItem.ToString();
        string qry = "";

        if (v1 == "Attached")
        {
            qry = "Select * From " + vwname + " Where Vendor_Code in (Select vendorcode from webx_vendor_det where rtrim(ltrim(vendorbrcd))= '" + ddlloc.SelectedValue.ToString() + "');";

        }
        else if (v1 == "Own")
        {
            qry = "Select * From vw_Road_Vendors_Own";
        }
        else if (v1 == "Co - Loader")
        {
            qry = "Select * From vw_Road_Vendors_Co_Loader Where Vendor_Code in (Select vendorcode from webx_vendor_det where rtrim(ltrim(vendorbrcd))='" + ddlloc.SelectedValue.ToString() + "');";

        }


        string sConn;
        //SqlConnection conn;
       // sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";

        // this was

       // sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";


        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;";

        //conn = new SqlConnection(sConn);
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlCommand sqlcmd = new SqlCommand(qry, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);

// Invalid object name 'vw__vendors_attached'.
        da.Fill(ds, "tab1");


        ddlven.DataSource = ds;


        ddlven.DataTextField = "Vendor_name";
        ddlven.DataValueField = "Vendor_code";
        ddlven.DataBind();
        if (ds.Tables[0].Rows.Count == 0)
        {
            ddlven.Items.Clear();
            ddlven.Items.Add("No Vendor Avilable For This Route");
        }

        //ddlloc.DataTextField = "c1";
        //ddlloc.DataValueField = "loccode";
        //ddlloc.DataBind();



    }

    protected void CheckBox41_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox41.Checked;
        for (int i = 0; i < CheckBoxList1.Items.Count; i++)
        {
            CheckBoxList1.Items[i].Selected = Flag;
        }
    }
    protected void CheckBox42_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox42.Checked;
        for (int i = 0; i < CheckBoxList2.Items.Count; i++)
        {
            CheckBoxList2.Items[i].Selected = Flag;
        }

    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox1.Checked;
        for (int i = 0; i < CheckBoxList3.Items.Count; i++)
        {
            CheckBoxList3.Items[i].Selected = Flag;
        }
    }
    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox2.Checked;
        for (int i = 0; i < CheckBoxList4.Items.Count; i++)
        {
            CheckBoxList4.Items[i].Selected = Flag;
        }
    }
    protected void CheckBox3_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox3.Checked;
        for (int i = 0; i < CheckBoxList5.Items.Count; i++)
        {
            CheckBoxList5.Items[i].Selected = Flag;
        }
    }



    protected void btnShow_Click1(object sender, EventArgs e)
    {

        string s1, s2, s3, s4, s5, strselectlist, strro, strlo, strroute, strven, strdoctype, strdoclist;
        s1 = s2 = s3 = s4 = s5 = strselectlist = "";



        string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        string[] strArrDtTo = txtDateTo.Text.Split('/');

        DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        strro = ddlro.SelectedValue.ToString();
        strlo = ddlloc.SelectedValue.ToString();
        strven = ddlven.SelectedValue.ToString();
        strdoctype = ddlDoctype.SelectedValue.ToString();
        strdoclist = txtdoc.Text.ToString();
        strroute = ddlroute.SelectedValue.ToString();


        foreach (ListItem li in CheckBoxList1.Items)
        {
            if (li.Selected == true)
            {

                s1 = s1 += "," + li.Value.ToString();

            }
            else
            {
                s1 += "";
            }


        }

        foreach (ListItem li in CheckBoxList2.Items)
        {
            if (li.Selected == true)
            {

                s2 = s2 += "," + li.Value.ToString();

            }
            else
            {
                s2 += "";
            }

        }
        foreach (ListItem li in CheckBoxList3.Items)
        {
            if (li.Selected == true)
            {

                s3 = s3 += "," + li.Value.ToString();

            }
            else
            {
                s3 += "";
            }
        }
        foreach (ListItem li in CheckBoxList4.Items)
        {
            if (li.Selected == true)
            {

                s4 = s4 += "," + li.Value.ToString();

            }

            else
            {
                s4 += "";
            }
        }
        foreach (ListItem li in CheckBoxList5.Items)
        {
            if (li.Selected == true)
            {

                s5 = s5 += "," + li.Value.ToString();

            }
            else
            {
                s5 += "";
            }



        }

        if (s1 == ",")
        {
            s1 = "";
        }

        if (s2 == ",")
        {
            s2 = "";
        }

        if (s3 == ",")
        {
            s3 = "";
        }

        if (s4 == ",")
        {
            s4 = "";
        }

        if (s5 == ",")
        {
            s5 = "";
        }

        strselectlist = s1 + "," + s2 + "," + s3 + "," + s4 + "," + s5;

        string strFinalQS = "?StrDate=" + strDate;
        strFinalQS = strFinalQS + "&RO=" + strro;
        strFinalQS = strFinalQS + "&Location=" + strlo;
        strFinalQS = strFinalQS + "&seleItem=" + strselectlist;
        strFinalQS = strFinalQS + "&Route=" + strroute;
        strFinalQS = strFinalQS + "&Ven=" + strven;
        strFinalQS = strFinalQS + "&DocType=" + strdoctype;
        strFinalQS = strFinalQS + "&DocList=" + strdoclist;


        Response.Redirect("Vehicle_2.aspx" + strFinalQS);


    }
    protected void BtnPRS_Click1(object sender, EventArgs e)
    {
        string s1, s2, s3, s4, s5, strselectlist, strro, strlo, strroute, strven, strdoctype, strdoclist;
        s1 = s2 = s3 = s4 = s5 = strselectlist = "";



        string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        string[] strArrDtTo = txtDateTo.Text.Split('/');

        DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        strro = ddlro.SelectedValue.ToString();
        strlo = ddlloc.SelectedValue.ToString();
        strven = ddlvenPRS.SelectedValue.ToString();
        strdoctype = ddlDoctype.SelectedValue.ToString();
        strdoclist = txtdoc.Text.ToString();
        strroute = "";


        foreach (ListItem li in CheckBoxList6.Items)
        {
            if (li.Selected == true)
            {

                s1 = s1 += "," + li.Value.ToString();

            }
            else
            {
                s1 += "";
            }


        }

        foreach (ListItem li in CheckBoxList7.Items)
        {
            if (li.Selected == true)
            {

                s2 = s2 += "," + li.Value.ToString();

            }
            else
            {
                s2 += "";
            }

        }
        foreach (ListItem li in CheckBoxList8.Items)
        {
            if (li.Selected == true)
            {

                s3 = s3 += "," + li.Value.ToString();

            }
            else
            {
                s3 += "";
            }
        }
        foreach (ListItem li in CheckBoxList9.Items)
        {
            if (li.Selected == true)
            {

                s4 = s4 += "," + li.Value.ToString();

            }

            else
            {
                s4 += "";
            }
        }
        foreach (ListItem li in CheckBoxList10.Items)
        {
            if (li.Selected == true)
            {

                s5 = s5 += "," + li.Value.ToString();

            }
            else
            {
                s5 += "";
            }



        }

        if (s1 == ",")
        {
            s1 = "";
        }

        if (s2 == ",")
        {
            s2 = "";
        }

        if (s3 == ",")
        {
            s3 = "";
        }

        if (s4 == ",")
        {
            s4 = "";
        }

        if (s5 == ",")
        {
            s5 = "";
        }

        strselectlist = s1 + "," + s2 + "," + s3 + "," + s4 + "," + s5;

        string strFinalQS = "?StrDate=" + strDate;
        strFinalQS = strFinalQS + "&RO=" + strro;
        strFinalQS = strFinalQS + "&Location=" + strlo;
        strFinalQS = strFinalQS + "&seleItem=" + strselectlist;
        strFinalQS = strFinalQS + "&Route=" + strroute;
        strFinalQS = strFinalQS + "&Ven=" + strven;
        strFinalQS = strFinalQS + "&DocType=" + strdoctype;
        strFinalQS = strFinalQS + "&DocList=" + strdoclist;


        Response.Redirect("Vehicle_2.aspx" + strFinalQS);



    }
    protected void ddldelby_SelectedIndexChanged(object sender, EventArgs e)
    {

        ddlvenPRS.Items.Clear();

        if (ddldelby.SelectedItem.Value.ToString() == "Own")
        {
            pnlventype.Visible = true;
            pnlstaff.Visible = true;

            string vendortypecls = "";

            if (ddlventype2.SelectedItem.ToString() == "Attached")
            {
                vendortypecls = " and m.vendor_type in('2','3')";
            }
            else if (ddlventype2.SelectedItem.ToString() == "Attached")
            {
                vendortypecls = " and m.vendor_type='5'";
            }


            qryPRS = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_PDCHDR_ARCH c, webx_vendor_det d where m.vendorcode=d.vendorcode " + vendortypecls + " and vendorbrcd='HQTR' and c.pdcbr = '" + ddlloc.SelectedValue.ToString() + "' order by m.vendorname";
        }
        else
        {
            pnlventype.Visible = false;
            pnlstaff.Visible = false;

               qryPRS = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_PDCHDR_ARCH c, webx_vendor_det d where m.vendorcode=d.vendorcode and vendorbrcd='HQTR' and c.pdcbr = '" + ddlloc.SelectedValue.ToString() + "' order by m.vendorname";

               popvenPRS();



        }


    }
    protected void ddlroute_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddlven_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddlventypePRS_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddlvenPRS_SelectedIndexChanged(object sender, EventArgs e)
    {
 
    }
    protected void ddlstaff_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    protected void CheckBox4_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox4.Checked;
        for (int i = 0; i < CheckBoxList6.Items.Count; i++)
        {
            CheckBoxList6.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox5_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox5.Checked;
        for (int i = 0; i < CheckBoxList7.Items.Count; i++)
        {
            CheckBoxList7.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox6_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox6.Checked;
        for (int i = 0; i < CheckBoxList8.Items.Count; i++)
        {
            CheckBoxList8.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox7_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox7.Checked;
        for (int i = 0; i < CheckBoxList9.Items.Count; i++)
        {
            CheckBoxList9.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox8_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox8.Checked;
        for (int i = 0; i < CheckBoxList10.Items.Count; i++)
        {
            CheckBoxList10.Items[i].Selected = Flag;
        }
    }
    protected void ddlventype2_SelectedIndexChanged(object sender, EventArgs e)
    {
        popvenPRS();
        popStaff();

    }
    
    
    public void popvenPRS()
    {


        //  string  qry = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_PDCHDR_ARCH c, webx_vendor_det d where m.vendorcode=d.vendorcode " +vendortypecls+" and vendorbrcd='HQTR' and c.pdcbr = '"+ddlloc.SelectedValue.ToString()+"' order by m.vendorname";
        string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";

        // this was
       //
        //sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";


        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;";

        //conn = new SqlConnection(sConn);

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlCommand sqlcmd = new SqlCommand(qryPRS, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds);


        ddlvenPRS.DataSource = ds;


        ddlvenPRS.DataTextField = "Vendorname";
        ddlvenPRS.DataValueField = "Vendorcode";
        ddlvenPRS.DataBind();
        if (ds.Tables[0].Rows.Count == 0)
        {
            ddlvenPRS.Items.Clear();
            ddlvenPRS.Items.Add("No Vendor Avilable For This Route");
        }


    }

    public void popStaff()
    {
         

        string qry = " select m.empcd,m.empnm from webx_empmst m where currbrcd='"+ddlloc.SelectedValue.ToString()+"' order by empnm";




        string sConn;
        //SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";

        // this was

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
      //  sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";


        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;";

      //  conn = new SqlConnection(sConn);
        conn.Open();

        SqlCommand sqlcmd = new SqlCommand(qry, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds);


        ddlstaff.DataSource = ds;


        ddlstaff.DataTextField = "empnm";
        ddlstaff.DataValueField = "empcd";
        ddlstaff.DataBind();
        if (ds.Tables[0].Rows.Count == 0)
        {
            ddlstaff.Items.Clear();
            ddlstaff.Items.Add("No Staff Avilable For This Route");
        }
    
    }


    

    public void popStaffDRS()
    {


        string qry = " select m.empcd,m.empnm from webx_empmst m where currbrcd='" + ddlloc.SelectedValue.ToString() + "' order by empnm";




        string sConn;
       // SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";

        // this was
        //sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;";

       // conn = new SqlConnection(sConn);
        conn.Open();

        SqlCommand sqlcmd = new SqlCommand(qry, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds);


        ddlstaffDRS.DataSource = ds;


        ddlstaffDRS.DataTextField = "empnm";
        ddlstaffDRS.DataValueField = "empcd";
        ddlstaffDRS.DataBind();
        if (ds.Tables[0].Rows.Count == 0)
        {
            ddlstaffDRS.Items.Clear();
            ddlstaffDRS.Items.Add("No Staff Avilable For This Route");
        }

    }












    protected void btnDRS_Click1(object sender, EventArgs e)
    {
        string s1, s2, s3, s4, s5, strselectlist, strro, strlo, strroute, strven, strdoctype, strdoclist;
        s1 = s2 = s3 = s4 = s5 = strselectlist = "";



        string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        string[] strArrDtTo = txtDateTo.Text.Split('/');

        DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        strro = ddlro.SelectedValue.ToString();
        strlo = ddlloc.SelectedValue.ToString();
        strven = ddlvenPRS.SelectedValue.ToString();
        strdoctype = ddlDoctype.SelectedValue.ToString();
        strdoclist = txtdoc.Text.ToString();
        strroute = "";


        foreach (ListItem li in CheckBoxList6.Items)
        {
            if (li.Selected == true)
            {

                s1  += "," + li.Value.ToString();

            }
            else
            {
                s1 += s1;
            }


        }

        foreach (ListItem li in CheckBoxList7.Items)
        {
            if (li.Selected == true)
            {

                s2= s2+ "," + li.Value.ToString();

            }
            

        }
        foreach (ListItem li in CheckBoxList8.Items)
        {
            if (li.Selected == true)
            {

                s3  += "," + li.Value.ToString();

            }
            else
            {
                s3 += s3;
            }
        }
        foreach (ListItem li in CheckBoxList9.Items)
        {
            if (li.Selected == true)
            {

                s4   += "," + li.Value.ToString();

            }

            else
            {
                s4 += s4;
            }
        }
        foreach (ListItem li in CheckBoxList10.Items)
        {
            if (li.Selected == true)
            {

                s5 +=  "," + li.Value.ToString();

            }
            else
            {
                s5 += s5;
            }



        }

        if (s1 == ",")
        {
            s1 = "";
        }

        if (s2 == ",")
        {
            s2 = "";
        }

        if (s3 == ",")
        {
            s3 = "";
        }

        if (s4 == ",")
        {
            s4 = "";
        }

        if (s5 == ",")
        {
            s5 = "";
        }

        strselectlist = s1 + "," + s2 + "," + s3 + "," + s4 + "," + s5;

        string strFinalQS = "?StrDate=" + strDate;
        strFinalQS = strFinalQS + "&RO=" + strro;
        strFinalQS = strFinalQS + "&Location=" + strlo;
        strFinalQS = strFinalQS + "&seleItem=" + strselectlist;
        strFinalQS = strFinalQS + "&Route=" + strroute;
        strFinalQS = strFinalQS + "&Ven=" + strven;
        strFinalQS = strFinalQS + "&DocType=" + strdoctype;
        strFinalQS = strFinalQS + "&DocList=" + strdoclist;


        Response.Redirect("Vehicle_2.aspx" + strFinalQS);


    }
    protected void ddldelbyDRS_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldelbyDRS.SelectedItem.Value.ToString() == "Own")
        {
            pnlventypeDRS.Visible = true;
            pnlstaffdrs.Visible = true;

            string vendortypecls = "";

            if (ddlventypeDRS.SelectedItem.ToString() == "Attached")
            {
                vendortypecls = " and m.vendor_type in('2','3')";
            }
            else if (ddlventypeDRS.SelectedItem.ToString() == "Own")
            {
                vendortypecls = " and m.vendor_type='5'";
            }


            qryDRS = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_PDCHDR_ARCH c, webx_vendor_det d where m.vendorcode=d.vendorcode " + vendortypecls + " and vendorbrcd='HQTR' and c.pdcbr = '" + ddlloc.SelectedValue.ToString() + "' order by m.vendorname";
        }
        else
        {
            pnlventypeDRS.Visible = false;
            pnlstaffdrs.Visible = false;

            qryDRS = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_PDCHDR_ARCH c, webx_vendor_det d where m.vendorcode=d.vendorcode and vendorbrcd='HQTR' and c.pdcbr = '" + ddlloc.SelectedValue.ToString() + "' order by m.vendorname";

            popvenDRS();

        }



    }

    protected void CheckBox9_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox9.Checked;
        for (int i = 0; i < CheckBoxList11.Items.Count; i++)
        {
            CheckBoxList11.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox10_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox10.Checked;
        for (int i = 0; i < CheckBoxList12.Items.Count; i++)
        {
            CheckBoxList12.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox11_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox11.Checked;
        for (int i = 0; i < CheckBoxList13.Items.Count; i++)
        {
            CheckBoxList13.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox12_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox12.Checked;
        for (int i = 0; i < CheckBoxList14.Items.Count; i++)
        {
            CheckBoxList14.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox13_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox13.Checked;
        for (int i = 0; i < CheckBoxList15.Items.Count; i++)
        {
            CheckBoxList15.Items[i].Selected = Flag;
        }
    }

    protected void CheckBox14_CheckedChanged(object sender, EventArgs e)
    {
        bool Flag = CheckBox14.Checked;
        for (int i = 0; i < CheckBoxList16.Items.Count; i++)
        {
            CheckBoxList16.Items[i].Selected = Flag;
        }
    }

    public void popvenDRS()
    {


        //  string  qry = "select distinct m.vendorcode,m.vendorname from webx_vendor_hdr m ,webx_PDCHDR_ARCH c, webx_vendor_det d where m.vendorcode=d.vendorcode " +vendortypecls+" and vendorbrcd='HQTR' and c.pdcbr = '"+ddlloc.SelectedValue.ToString()+"' order by m.vendorname";
        string sConn;
       // SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";

        // this was
        sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";


        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;";
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       // conn = new SqlConnection(sConn);
        conn.Open();

        SqlCommand sqlcmd = new SqlCommand(qryDRS, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds);


        ddlvenDRS.DataSource = ds;


        ddlvenDRS.DataTextField = "Vendorname";
        ddlvenDRS.DataValueField = "Vendorcode";
        ddlvenDRS.DataBind();
        if (ds.Tables[0].Rows.Count == 0)
        {
            ddlvenDRS.Items.Clear();
            ddlvenDRS.Items.Add("No Vendor Avilable For This Route");
        }



    
    }

    protected void ddlventypeDRS_SelectedIndexChanged(object sender, EventArgs e)
    {
        popvenDRS();
        popStaffDRS();
    }
    protected void ddlvenDRS_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddlstaffDRS_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}


