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
    public static string qryPRS, qryDRS,thccalled;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // mypanal.Visible = false;
            txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtDateTo.Text = txtDateFrom.Text;
            popRO();
            thccalled = Session["thccalledas"].ToString();
            ddlDoctype.Items.Add(new ListItem(thccalled, "T"));
             ddlDoctype.Items.Add(new ListItem("PRS", "P"));
             ddlDoctype.Items.Add(new ListItem("DRS", "D"));
             ddlDoctype.Items.Add(new ListItem("PRS+DRS", "PD"));
           
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






    protected void ddlloc_SelectedIndexChanged(object sender, EventArgs e)
    {

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



    //protected void btnShow_Click1(object sender, EventArgs e)
    //{

    //    string s1, s2, s3, s4, s5, strselectlist, strro, strlo, strroute, strven, strdoctype, strdoclist;
    //    s1 = s2 = s3 = s4 = s5 = strselectlist = "";



    //    string[] strArrDtFrom = txtDateFrom.Text.Split('/');
    //    string[] strArrDtTo = txtDateTo.Text.Split('/');

    //    DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
    //    DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

    //    string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


    //    strro = ddlro.SelectedValue.ToString();
    //    strlo = ddlloc.SelectedValue.ToString();
    //    strven = ddlven.SelectedValue.ToString();
    //    strdoctype = ddlDoctype.SelectedValue.ToString();
    //    strdoclist = txtdoc.Text.ToString();
    //    strroute = ddlroute.SelectedValue.ToString();


    //    foreach (ListItem li in CheckBoxList1.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s1 = s1 += "," + li.Value.ToString();

    //        }
    //        else
    //        {
    //            s1 += "";
    //        }


    //    }

    //    foreach (ListItem li in CheckBoxList2.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s2 = s2 += "," + li.Value.ToString();

    //        }
    //        else
    //        {
    //            s2 += "";
    //        }

    //    }
    //    foreach (ListItem li in CheckBoxList3.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s3 = s3 += "," + li.Value.ToString();

    //        }
    //        else
    //        {
    //            s3 += "";
    //        }
    //    }
    //    foreach (ListItem li in CheckBoxList4.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s4 = s4 += "," + li.Value.ToString();

    //        }

    //        else
    //        {
    //            s4 += "";
    //        }
    //    }
    //    foreach (ListItem li in CheckBoxList5.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s5 = s5 += "," + li.Value.ToString();

    //        }
    //        else
    //        {
    //            s5 += "";
    //        }



    //    }

    //    if (s1 == ",")
    //    {
    //        s1 = "";
    //    }

    //    if (s2 == ",")
    //    {
    //        s2 = "";
    //    }

    //    if (s3 == ",")
    //    {
    //        s3 = "";
    //    }

    //    if (s4 == ",")
    //    {
    //        s4 = "";
    //    }

    //    if (s5 == ",")
    //    {
    //        s5 = "";
    //    }

    //    strselectlist = s1 + s2 + s3 + s4 + s5;

    //    string strFinalQS = "?StrDate=" + strDate;
    //    strFinalQS = strFinalQS + "&RO=" + strro;
    //    strFinalQS = strFinalQS + "&Location=" + strlo;
    //    strFinalQS = strFinalQS + "&seleItem=" + strselectlist;
    //    strFinalQS = strFinalQS + "&Route=" + strroute;
    //    strFinalQS = strFinalQS + "&Ven=" + strven;
    //    strFinalQS = strFinalQS + "&DocType=" + strdoctype;
    //    strFinalQS = strFinalQS + "&DocList=" + strdoclist;


    //    Response.Redirect("Vehicle_2.aspx" + strFinalQS);


    //}

    protected void btnShow_Click1(object sender, EventArgs e)
    {

        if (Page.IsValid == true)
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
            strven = txtven.Text;
            strdoctype = ddlDoctype.SelectedValue.ToString();
            strdoclist = txtdoc.Text.ToString();
            strroute = "";


            foreach (ListItem li in CheckBoxList1.Items)
            {
                if (li.Selected == true)
                {

                    if (li.Value.ToString() != "")
                    {
                        s1 = s1 += "," + li.Value.ToString();
                    }


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
                    if (li.Value.ToString() != "")
                    {


                        s2 = s2 += "," + li.Value.ToString();
                    }

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
                    if (li.Value.ToString() != "")
                    {

                        s3 = s3 += "," + li.Value.ToString();
                    }


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

                    if (li.Value.ToString() != "")
                    {

                        s4 = s4 += "," + li.Value.ToString();
                    }

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

                    if (li.Value.ToString() != "")
                    {

                        s5 = s5 += "," + li.Value.ToString();
                    }

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

            strselectlist = s1 + s2 + s3 + s4 + s5;

            int i;
            i = strselectlist.Length;

            strselectlist = strselectlist.Substring(1, i - 1);


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

    }
    protected void BtnPRS_Click1(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
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
            strven = txtven.Text;
            strdoctype = ddlDoctype.SelectedValue.ToString();
            strdoclist = txtdoc.Text.ToString();
            strroute = "";


            foreach (ListItem li in CheckBoxList6.Items)
            {
                if (li.Selected == true)
                {

                    if (li.Value.ToString() != "")
                    {
                        s1 = s1 += "," + li.Value.ToString();
                    }


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
                    if (li.Value.ToString() != "")
                    {


                        s2 = s2 += "," + li.Value.ToString();
                    }

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
                    if (li.Value.ToString() != "")
                    {

                        s3 = s3 += "," + li.Value.ToString();
                    }


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

                    if (li.Value.ToString() != "")
                    {

                        s4 = s4 += "," + li.Value.ToString();
                    }

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

                    if (li.Value.ToString() != "")
                    {

                        s5 = s5 += "," + li.Value.ToString();
                    }

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

            strselectlist = s1 + s2 + s3 + s4 + s5;

            int i;
            i = strselectlist.Length;

            strselectlist = strselectlist.Substring(1, i - 1);


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
    



    protected void btnDRS_Click1(object sender, EventArgs e)
    {
        if (Page.IsValid == true)
        {
            string s1, s2, s3, s4, s5, s6, strselectlist, strro, strlo, strroute, strven, strdoctype, strdoclist;
            s1 = s2 = s3 = s4 = s5 = s6 = strselectlist = "";



            string[] strArrDtFrom = txtDateFrom.Text.Split('/');
            string[] strArrDtTo = txtDateTo.Text.Split('/');

            DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
            DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

            string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


            strro = ddlro.SelectedValue.ToString();
            strlo = ddlloc.SelectedValue.ToString();
            strven = txtven.Text;
            strdoctype = ddlDoctype.SelectedValue.ToString();
            strdoclist = txtdoc.Text.ToString();
            strroute = "";


            foreach (ListItem li in CheckBoxList11.Items)
            {
                if (li.Selected == true)
                {

                    if (li.Value.ToString() != "")
                    {
                        s1 = s1 += "," + li.Value.ToString();
                    }


                }
                else
                {
                    s1 += "";
                }


            }

            foreach (ListItem li in CheckBoxList12.Items)
            {
                if (li.Selected == true)
                {
                    if (li.Value.ToString() != "")
                    {


                        s2 = s2 += "," + li.Value.ToString();
                    }

                }
                else
                {
                    s2 += "";
                }

            }
            foreach (ListItem li in CheckBoxList13.Items)
            {
                if (li.Selected == true)
                {
                    if (li.Value.ToString() != "")
                    {

                        s3 = s3 += "," + li.Value.ToString();
                    }


                }
                else
                {
                    s3 += "";
                }
            }
            foreach (ListItem li in CheckBoxList14.Items)
            {
                if (li.Selected == true)
                {

                    if (li.Value.ToString() != "")
                    {

                        s4 = s4 += "," + li.Value.ToString();
                    }

                }

                else
                {
                    s4 += "";
                }
            }
            foreach (ListItem li in CheckBoxList15.Items)
            {
                if (li.Selected == true)
                {

                    if (li.Value.ToString() != "")
                    {

                        s5 = s5 += "," + li.Value.ToString();
                    }

                }
                else
                {
                    s5 += "";
                }



            }
            foreach (ListItem li in CheckBoxList16.Items)
            {
                if (li.Selected == true)
                {

                    if (li.Value.ToString() != "")
                    {

                        s6 = s6 += "," + li.Value.ToString();
                    }

                }
                else
                {
                    s6 += "";
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
            if (s6 == ",")
            {
                s6 = "";
            }

            strselectlist = s1 + s2 + s3 + s4 + s5 + s6;


            int i;
            i = strselectlist.Length;

            strselectlist = strselectlist.Substring(1, i - 1);


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

    }








    //protected void btnDRS_Click1(object sender, EventArgs e)
    //{
    //    string s1, s2, s3, s4, s5, strselectlist, strro, strlo, strroute, strven, strdoctype, strdoclist;
    //    s1 = s2 = s3 = s4 = s5 = strselectlist = "";



    //    string[] strArrDtFrom = txtDateFrom.Text.Split('/');
    //    string[] strArrDtTo = txtDateTo.Text.Split('/');

    //    DateTime dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]);
    //    DateTime dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]);

    //    string strDate = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("dd MMM yy") + " - " + Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("dd MMM yy");


    //    strro = ddlro.SelectedValue.ToString();
    //    strlo = ddlloc.SelectedValue.ToString();
    //    strven = ddlvenPRS.SelectedValue.ToString();
    //    strdoctype = ddlDoctype.SelectedValue.ToString();
    //    strdoclist = txtdoc.Text.ToString();
    //    strroute = "";


    //    foreach (ListItem li in CheckBoxList6.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s1  += "," + li.Value.ToString();

    //        }
    //        else
    //        {
    //            s1 += s1;
    //        }


    //    }

    //    foreach (ListItem li in CheckBoxList7.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s2= s2+ "," + li.Value.ToString();

    //        }


    //    }
    //    foreach (ListItem li in CheckBoxList8.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s3  += "," + li.Value.ToString();

    //        }
    //        else
    //        {
    //            s3 += s3;
    //        }
    //    }
    //    foreach (ListItem li in CheckBoxList9.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s4   += "," + li.Value.ToString();

    //        }

    //        else
    //        {
    //            s4 += s4;
    //        }
    //    }
    //    foreach (ListItem li in CheckBoxList10.Items)
    //    {
    //        if (li.Selected == true)
    //        {

    //            s5 +=  "," + li.Value.ToString();

    //        }
    //        else
    //        {
    //            s5 += s5;
    //        }



    //    }

    //    if (s1 == ",")
    //    {
    //        s1 = "";
    //    }

    //    if (s2 == ",")
    //    {
    //        s2 = "";
    //    }

    //    if (s3 == ",")
    //    {
    //        s3 = "";
    //    }

    //    if (s4 == ",")
    //    {
    //        s4 = "";
    //    }

    //    if (s5 == ",")
    //    {
    //        s5 = "";
    //    }

    //    strselectlist = s1 + s2 + s3 + s4 + s5;


    //    string strFinalQS = "?StrDate=" + strDate;
    //    strFinalQS = strFinalQS + "&RO=" + strro;
    //    strFinalQS = strFinalQS + "&Location=" + strlo;
    //    strFinalQS = strFinalQS + "&seleItem=" + strselectlist;
    //    strFinalQS = strFinalQS + "&Route=" + strroute;
    //    strFinalQS = strFinalQS + "&Ven=" + strven;
    //    strFinalQS = strFinalQS + "&DocType=" + strdoctype;
    //    strFinalQS = strFinalQS + "&DocList=" + strdoclist;


    //    Response.Redirect("Vehicle_2.aspx" + strFinalQS);


    //}


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

}


