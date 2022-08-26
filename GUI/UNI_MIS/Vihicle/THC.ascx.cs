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

public partial class GUI_Vihicle_THC : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void ddlrmode_SelectedIndexChanged(object sender, EventArgs e)
    {

        //if (ddlloc.SelectedValue.ToString() == "All")
        //{

        //    ddlroute.Items.Clear();
        //    ddlroute.Items.Add("== Select Location First ==");

        //}
        //else
        //{
        //    poproute();

        //}


    }


    public void poproute()
    {


        //string rmode = ddlrmode.SelectedValue;
        //string sloc = ddlloc.SelectedValue;




        //this is
        SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;");





        //SqlConnection conn = new SqlConnection("data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;");

        //= new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";
        //conn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";

        // conn = new SqlConnection(sConn);
        try
        {
            conn.Open();
        }
        catch (Exception ee)
        {
            //lbl.Text = ee.Message;
        }





        SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = conn;


        sqlCommand.CommandType = CommandType.StoredProcedure;

        sqlCommand.CommandText = "sp_routes_for_thc_san";


        sqlCommand.Parameters.AddWithValue("@loccode", "");
        sqlCommand.Parameters.AddWithValue("@RouteMode", "");
        sqlCommand.Parameters.AddWithValue("@location", "");
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



        string vwname = "vw_" + strrmode.Trim() + "_vendors_attached";
        string v1 = ddlventype.SelectedItem.ToString();
        string qry = "";

        if (v1 == "Attached")
        {
            //qry = "Select * From " + vwname + " Where Vendor_Code in (Select vendorcode from webx_vendor_det where rtrim(ltrim(vendorbrcd))= '" + ddlloc.SelectedValue.ToString() + "');";

        }
        else if (v1 == "Own")
        {
            qry = "Select * From vw_Road_Vendors_Own";
        }
        else if (v1 == "Co - Loader")
        {
            //qry = "Select * From vw_Road_Vendors_Co_Loader Where Vendor_Code in (Select vendorcode from webx_vendor_det where rtrim(ltrim(vendorbrcd))='" + ddlloc.SelectedValue.ToString() + "');";

        }


        string sConn;
        SqlConnection conn;
        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_Live;";

        // this was
        sConn = "data source=202.87.45.71;UID=sa;PWD=eCfY$@p@$$;Database=RCPL_Ver2_Live;";


        //sConn = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=PTN_Live;";

        conn = new SqlConnection(sConn);
        conn.Open();

        SqlCommand sqlcmd = new SqlCommand(qry, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


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



        //string[] strArrDtFrom = txtDateFrom.Text.Split('/');
        //string[] strArrDtTo = txtDateTo.Text.Split('/');

        //DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
        //DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

        //string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


        //strro = ddlro.SelectedValue.ToString();
        //strlo = ddlloc.SelectedValue.ToString();
        //strven = ddlven.SelectedValue.ToString();
        //strdoctype = ddlDoctype.SelectedValue.ToString();
        //strdoclist = txtdoc.Text.ToString();
        //strroute = ddlroute.SelectedValue.ToString();


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

        //string strFinalQS = "?StrDate=" + strDate;
        //strFinalQS = strFinalQS + "&RO=" + strro;
        //strFinalQS = strFinalQS + "&Location=" + strlo;
        //strFinalQS = strFinalQS + "&seleItem=" + strselectlist;
        //strFinalQS = strFinalQS + "&Route=" + strroute;
        //strFinalQS = strFinalQS + "&Ven=" + strven;
        //strFinalQS = strFinalQS + "&DocType=" + strdoctype;
        //strFinalQS = strFinalQS + "&DocList=" + strdoclist;


        //Response.Redirect("Vehicle_2.aspx" + strFinalQS);


    }



    protected void ddlroute_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ddlven_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
