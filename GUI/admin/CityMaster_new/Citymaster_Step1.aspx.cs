using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;


public partial class GUI_WebAdmin_CityMaster_new_Citymaster_Step1 : System.Web.UI.Page
{

    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    SqlConnection cn;
    public static string City_str = "", edit_yn = "", cityid = "", txtcityid = "";
    public string cityFlg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        cityid = Request.QueryString["id"];
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        if (!IsPostBack)
        {
            // txtagnttax.Text = "0";
            roww.Text = "1";
            Inetialized();
            getstring();
            BindGrid();
            // popAgnt();
            Validation();
            intetilisedrows();
            City_str = getLocationStr();
        }
        else
        {
            // ReverseBind();
        }

        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtCityname = (TextBox)gridrow.FindControl("txtCityname");
            HiddenField HidCityName = (HiddenField)gridrow.FindControl("HidCityName");
            //if (!(Page.IsPostBack))
            //{
            cityid = Request.QueryString["id"];

            if (cityid != "" && cityid != null)
            {
                cityFlg = "Y";
                if (!IsPostBack)
                {
                    RetriveData();
                    txtCityname.Text = cityid;
                    HidCityName.Value = cityid;
                    txtcityid = txtCityname.Text;
                }
            }
            else
            {
                cityFlg = "N";
            }
            //}
        }
        if (cityFlg == "Y")
        {
            //trrow.Visible = false;
            tblrow.Visible = false;
            Page.RegisterHiddenField("mode", "edit");
            mode.Value = "edit";
        }
        else
        {
            Page.RegisterHiddenField("mode", "add");
            mode.Value = "add";
        }
    }
    private void getstring()
    {
        string sql = "SELECT loccode FROM  webx_location";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["loccode"] + "'"));
        }
        dr_Location.Close();
    }
    public string getLocationStr()
    {
        string Citystr = "";
        string sql = "SELECT Location FROM  webx_Citymaster";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_City = null;
        dr_City = sqlCommand.ExecuteReader();
        while (dr_City.Read())
        {
            Page.RegisterArrayDeclaration("cityarray", "'" + Convert.ToString(dr_City["Location"] + "'"));
        }
        dr_City.Close();
        return Citystr;
    }
    protected void chk11_CheckedChanged(object sender, EventArgs e)
    {

        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            CheckBox chk1 = (CheckBox)gridrow.FindControl("chk11");
            TextBox ODA = (TextBox)gridrow.FindControl("txtODA");
            TextBox ODAKM = (TextBox)gridrow.FindControl("txtODA_KM");

            if (chk1.Checked == true)
            {
                ODA.Text = "Y";
                ODAKM.ReadOnly = false;
            }
            else
                if (chk1.Checked == false)
            {
                ODA.Text = "N";
                ODAKM.Text = "0";
                ODAKM.ReadOnly = true;
            }
        }
    }


    private void intetilisedrows()
    {
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            DropDownList St = (DropDownList)gridrow.FindControl("ddState");
            DropDownList Zone = (DropDownList)gridrow.FindControl("ddZone");

            TextBox SeptVal = (TextBox)gridrow.FindControl("txtSeptVal");
            //St.Items.Add("--Select--");
            //cn.Open();
            string sqlstr = "select '--Select--' as stnm,'' as stcd from WEBX_STATE  union Select stnm,stcd from WEBX_STATE  with(NOLOCK)  order by stnm";
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                St.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }

            dr.Close();

            //St.Items.Add("--Select--");
            string sqlstr1 = "select '--Select--' as ZoneName,'--Select--' as ZoneCode from webx_master_general  union Select codedesc as zonename, codeid as zonecode from webx_master_general where  codetype='zone' AND StatusCode='Y' order by zonename";
            SqlCommand cmd1 = new SqlCommand(sqlstr1, cn);
            SqlDataReader dr1 = cmd1.ExecuteReader();

            while (dr1.Read())
            {

                Zone.Items.Add(new ListItem(dr1.GetValue(0).ToString(), dr1.GetValue(1).ToString()));
            }

            dr1.Close();
            //cn.Close();
        }
    }

    private void Inetialized()
    {

        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        //_dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");


    }
    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        if ((roww.Text == "") || (roww.Text == "0"))
        {
            roww.Text = "1";
        }
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
            intetilisedrows();
        }
        Validation();
        //if (cityFlg != "Y")
        //{
        //    string js;
        //    js = "<script language=\"javascript\" type=\"text/javascript\">kmdisable()</script>";
        //    Page.RegisterClientScriptBlock("a", js);
        //}
    }
    private void BindGrid()
    {
        GV_D.DataSource = _dataSet.WorkExperianceData;
        GV_D.DataBind();
        _lastEditedPage = GV_D.PageIndex;
    }
    //public void EvereyRow()
    //{

    //        TextBox txtCityname = (TextBox)gridrow.FindControl("txtCityname");
    //        DropDownList ddState = (DropDownList)gridrow.FindControl("ddState");
    //        DropDownList ddZone = (DropDownList)gridrow.FindControl("ddZone");
    //        TextBox txtRoadBKG_loc = (TextBox)gridrow.FindControl("txtRoadBKG_loc");
    //        TextBox txtRoaddly_loc = (TextBox)gridrow.FindControl("txtRoaddly_loc");
    //        TextBox txtAirBKG_loc = (TextBox)gridrow.FindControl("txtAirBKG_loc");


    //        TextBox txtAirdly_loc = (TextBox)gridrow.FindControl("txtAirdly_loc");
    //        TextBox txtRailBKG_loc = (TextBox)gridrow.FindControl("txtRailBKG_loc");
    //        TextBox txtRaildly_loc = (TextBox)gridrow.FindControl("txtRaildly_loc");
    //        CheckBox chk11 = (CheckBox)gridrow.FindControl("chk11");
    //        TextBox txtODA = (TextBox)gridrow.FindControl("txtODA");
    //        TextBox txtODA_KM = (TextBox)gridrow.FindControl("txtODA_KM");
    //        Label lbvalidate = (Label)gridrow.FindControl("lbvalidate");

    //}


    public void Validation()
    {
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtCityname = (TextBox)gridrow.FindControl("txtCityname");
            DropDownList ddState = (DropDownList)gridrow.FindControl("ddState");
            DropDownList ddZone = (DropDownList)gridrow.FindControl("ddZone");
            TextBox txtRoadBKG_loc = (TextBox)gridrow.FindControl("txtRoadBKG_loc");
            TextBox txtRoaddly_loc = (TextBox)gridrow.FindControl("txtRoaddly_loc");
            TextBox txtAirBKG_loc = (TextBox)gridrow.FindControl("txtAirBKG_loc");


            TextBox txtAirdly_loc = (TextBox)gridrow.FindControl("txtAirdly_loc");
            TextBox txtRailBKG_loc = (TextBox)gridrow.FindControl("txtRailBKG_loc");
            TextBox txtRaildly_loc = (TextBox)gridrow.FindControl("txtRaildly_loc");
            CheckBox chk11 = (CheckBox)gridrow.FindControl("chk11");
            TextBox txtODA = (TextBox)gridrow.FindControl("txtODA");
            TextBox txtODA_KM = (TextBox)gridrow.FindControl("txtODA_KM");
            Label lbvalidate = (Label)gridrow.FindControl("lbvalidate");


            txtCityname.Attributes.Add("onblur", "return Citycheck(this)");
            txtRoadBKG_loc.Attributes.Add("onblur", "return checklocation(this)");
            txtRoaddly_loc.Attributes.Add("onblur", "return checklocation(this)");
            txtAirBKG_loc.Attributes.Add("onblur", "return checklocation(this)");
            txtAirdly_loc.Attributes.Add("onblur", "return checklocation(this)");
            txtRailBKG_loc.Attributes.Add("onblur", "return checklocation(this)");
            txtRaildly_loc.Attributes.Add("onblur", "return checklocation(this)");
            //txtCityname.Attributes.Add("onChange", "return checklocation(this)");
            //if (cityid == "")
            //{
            txtCityname.Attributes.Add("onblur", "return Citycheck(this," + ((HiddenField)(gridrow.FindControl("HidCityName"))).ClientID + "),checkduplicate(this)");
            // }
        }


        Button11.Attributes.Add("onclick", "javascript:return Submitdata()");


    }

    private void RetriveData()
    {
        /// SqlConnection conn = new SqlConnection("Data Source=202.87.45.69;Initial Catalog=WEBX_FLEET;UID=sa;pwd=!@ECfy#$");
        /// 
        //cn.Open();
        foreach (GridViewRow gridrow in GV_D.Rows)
        {

            //  TextBox txtCityname = (TextBox)gridrow.FindControl("txtCityname");
            DropDownList ddState = (DropDownList)gridrow.FindControl("ddState");
            DropDownList ddZone = (DropDownList)gridrow.FindControl("ddZone");
            TextBox txtRoadBKG_loc = (TextBox)gridrow.FindControl("txtRoadBKG_loc");
            TextBox txtRoaddly_loc = (TextBox)gridrow.FindControl("txtRoaddly_loc");
            TextBox txtAirBKG_loc = (TextBox)gridrow.FindControl("txtAirBKG_loc");

            TextBox txtAirdly_loc = (TextBox)gridrow.FindControl("txtAirdly_loc");
            TextBox txtRailBKG_loc = (TextBox)gridrow.FindControl("txtRailBKG_loc");
            TextBox txtRaildly_loc = (TextBox)gridrow.FindControl("txtRaildly_loc");
            CheckBox chk11 = (CheckBox)gridrow.FindControl("chk11");
            TextBox txtODA = (TextBox)gridrow.FindControl("txtODA");
            TextBox txtODA_KM = (TextBox)gridrow.FindControl("txtODA_KM");
            Label lbvalidate = (Label)gridrow.FindControl("lbvalidate");
            CheckBox chkStatus = (CheckBox)gridrow.FindControl("chkStatus");
            TextBox txtHindiCityname = (TextBox)gridrow.FindControl("txtHindiCityname");

            string sql = "select * from webx_citymaster where LOCATION='" + cityid.Replace("'", "''") + "' ";
            SqlCommand cmd1 = new SqlCommand(sql, cn);
            SqlDataReader dr = cmd1.ExecuteReader();

            while (dr.Read())
            {
                ddState.SelectedValue = Convert.ToString(dr["State"]);
                ddZone.SelectedValue = Convert.ToString(dr["region"]);
                txtODA.Text = Convert.ToString(dr["oda_yn"]);
                txtODA_KM.Text = Convert.ToString(dr["odakm"]);

                txtRoadBKG_loc.Text = Convert.ToString(dr["book_loc"]);
                txtRoaddly_loc.Text = Convert.ToString(dr["Del_loc"]);
                txtAirBKG_loc.Text = Convert.ToString(dr["Book_loc_air"]);
                txtAirdly_loc.Text = Convert.ToString(dr["Del_loc_air"]);
                txtRailBKG_loc.Text = Convert.ToString(dr["Book_loc_Rail"]);
                txtRaildly_loc.Text = Convert.ToString(dr["Del_loc_Rail"]);
                txtHindiCityname.Text = Convert.ToString(dr["LocationHindi"]);

                if (Convert.ToString(dr["activeflag"]) == "Y")
                {
                    chkStatus.Checked = true;
                }
                else
                {
                    chkStatus.Checked = false;
                }
                if (txtODA.Text == "Y")
                {
                    chk11.Checked = true;
                    txtODA_KM.Enabled = true;
                }
                else
                {
                    chk11.Checked = false;
                }

            }
        }
        //cn.Close();

    }
    //private void ReverseBind()
    //{
    //    DataSet1.WorkExperianceDataRow datarow;// = null;

    //    foreach (GridViewRow gridrow in GV_D.Rows)
    //    {

    //        datarow = _dataSet.WorkExperianceData[gridrow.DataItemIndex];
    //        //// datarow.DOCKNO = ((TextBox)gridrow.FindControl("txtdockno")).Text;
    //        // //datarow.DECLVAL = ((TextBox)gridrow.FindControl("txtdockno")).Text;
    //        // datarow.OCTAMT = ((TextBox)gridrow.FindControl("txtoctamt")).Text;
    //        // datarow.OCTAMT_PER = ((TextBox)gridrow.FindControl("txtrcpno")).Text;
    //        // datarow.CLEAR_CHRG = ((TextBox)gridrow.FindControl("txtrcpdt")).Text;
    //        // _dataSet.WorkExperianceData[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
    //    }
    //}

    protected void Button11_Click(object sender, EventArgs e)
    {
        Button11.Attributes.Add("onclick", "javascript:return Submitdata()");
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn.Open();
        if (cn.State == ConnectionState.Closed)
        {
            cn.Open();
        }
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtCityname = (TextBox)gridrow.FindControl("txtCityname");
            DropDownList ddState = (DropDownList)gridrow.FindControl("ddState");
            DropDownList ddZone = (DropDownList)gridrow.FindControl("ddZone");
            TextBox txtRoadBKG_loc = (TextBox)gridrow.FindControl("txtRoadBKG_loc");
            TextBox txtRoaddly_loc = (TextBox)gridrow.FindControl("txtRoaddly_loc");
            TextBox txtAirBKG_loc = (TextBox)gridrow.FindControl("txtAirBKG_loc");


            TextBox txtAirdly_loc = (TextBox)gridrow.FindControl("txtAirdly_loc");
            TextBox txtRailBKG_loc = (TextBox)gridrow.FindControl("txtRailBKG_loc");
            TextBox txtRaildly_loc = (TextBox)gridrow.FindControl("txtRaildly_loc");
            CheckBox chk11 = (CheckBox)gridrow.FindControl("chk11");
            TextBox txtODA = (TextBox)gridrow.FindControl("txtODA");
            TextBox txtODA_KM = (TextBox)gridrow.FindControl("txtODA_KM");
            Label lbvalidate = (Label)gridrow.FindControl("lbvalidate");
            CheckBox chkStatus = (CheckBox)gridrow.FindControl("chkStatus");
            TextBox txtHindiCityname = (TextBox)gridrow.FindControl("txtHindiCityname");
            float ODA_KM;
            if (txtODA_KM.Text == "")
            {
                ODA_KM = 0;
            }
            else
            {
                ODA_KM = Convert.ToInt32(txtODA_KM.Text);
            }

            if (cityFlg == "Y")
            {
                if (txtCityname.Text != "")
                {
                    string spsql = "Update  webx_citymaster set Location='" + txtCityname.Text.Replace("'", "''") + "', Region='" + ddZone.SelectedValue + "', book_loc='" + txtRoadBKG_loc.Text + "', Del_loc='" + txtRoaddly_loc.Text + "', state='" + ddState.SelectedValue + "', oda_yn='" + txtODA.Text + "', Book_loc_air='" + txtAirBKG_loc.Text + "', Del_loc_air='" + txtAirdly_loc.Text + "', Book_loc_Rail='" + txtRailBKG_loc.Text + "', Del_loc_Rail='" + txtRaildly_loc.Text + "',LocationHindi=N'"+ txtHindiCityname.Text + "'";

                    if (chkStatus.Checked)
                    {
                        spsql = spsql + " ,activeflag='Y' ";
                    }
                    else {
                        spsql = spsql + " ,activeflag='N' ";
                    }
                    
                    //, ODAkm='" + Convert.ToInt32(txtODA_KM.Text) + "' where Location='" + cityid + "' 
                    //spsql = spsql + "('" + txtCityname.Text + "','" + ddZone.SelectedValue + "','" + txtRoadBKG_loc.Text + "','" + txtRoaddly_loc.Text + "','" + ddState.SelectedValue + "','" + txtODA.Text + "','" + Convert.ToInt32(txtODA_KM.Text) + "','" + txtAirBKG_loc.Text + "','" + txtAirdly_loc.Text + "','" + txtRailBKG_loc.Text + "','" + txtRaildly_loc.Text + "')";
                    if (txtODA_KM.Text == "")
                    {
                        spsql = spsql + ", ODAkm='' where Location='" + cityid + "'";
                    }
                    else
                    {
                        spsql = spsql + ", ODAkm='" + Convert.ToInt32(txtODA_KM.Text) + "' where Location='" + cityid + "'";
                    }
                    SqlCommand valCmd = new SqlCommand(spsql, cn);
                    valCmd.ExecuteNonQuery();
                    Response.Redirect("Citymaster_step2.aspx");
                }

            }
            else
            {

                if (txtCityname.Text != "")
                {
                    string spsql = "insert into webx_citymaster(Location,LocationHindi, Region, book_loc, Del_loc, state, oda_yn, Book_loc_air, Del_loc_air, Book_loc_Rail, Del_loc_Rail,activeflag,ODAkm) values ";
                    //spsql = spsql + "('" + txtCityname.Text.Replace("'", "''") + "','" + ddZone.SelectedValue + "','" + txtRoadBKG_loc.Text + "','" + txtRoaddly_loc.Text + "','" + ddState.SelectedValue + "','" + txtODA.Text + "','" + txtAirBKG_loc.Text + "','" + txtAirdly_loc.Text + "','" + txtRailBKG_loc.Text + "','" + txtRaildly_loc.Text + "','" + Convert.ToString(chkStatus.Checked) == "true" ? "Y" : "N" + "'";
					spsql = spsql + "('" + txtCityname.Text.Replace("'", "''") + "',N'" + txtHindiCityname.Text + "','" + ddZone.SelectedValue + "','" + txtRoadBKG_loc.Text + "','" + txtRoaddly_loc.Text + "','" + ddState.SelectedValue + "','" + txtODA.Text + "','" + txtAirBKG_loc.Text + "','" + txtAirdly_loc.Text + "','" + txtRailBKG_loc.Text + "','" + txtRaildly_loc.Text + "'";
					
					if (chkStatus.Checked)
                    {
                        spsql = spsql + " ,'Y' ";
                    }
                    else
                    {
                        spsql = spsql + " ,'N' ";
                    }
					
                    if (txtODA_KM.Text == "")
                    {
                        spsql = spsql + ",'')";
                    }
                    else
                    {
                        spsql = spsql + ",'" + Convert.ToInt32(txtODA_KM.Text) + "')";
                    }

                    SqlCommand valCmd = new SqlCommand(spsql, cn);
                    valCmd.ExecuteNonQuery();
                }
            }
        }
        Response.Redirect("~/GUI/Admin/company_structure.aspx");
    }
    protected void GV_D_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ((Button)(e.Row.FindControl("cmdRoadBkg_loc"))).Attributes.Add("onclick", "return nwOpen(" + ((TextBox)e.Row.FindControl("txtRoadBkg_loc")).ClientID + ")");
            ((Button)(e.Row.FindControl("cmdRoaddly_loc"))).Attributes.Add("onclick", "return nwOpen(" + ((TextBox)e.Row.FindControl("txtRoaddly_loc")).ClientID + ")");
            ((Button)(e.Row.FindControl("cmdAirBKG_loc"))).Attributes.Add("onclick", "return nwOpen(" + ((TextBox)e.Row.FindControl("txtAirBKG_loc")).ClientID + ")");
            ((Button)(e.Row.FindControl("cmdAirdly_loc"))).Attributes.Add("onclick", "return nwOpen(" + ((TextBox)e.Row.FindControl("txtAirdly_loc")).ClientID + ")");
            ((Button)(e.Row.FindControl("cmdRailBKG_loc"))).Attributes.Add("onclick", "return nwOpen(" + ((TextBox)e.Row.FindControl("txtRailBKG_loc")).ClientID + ")");
            ((Button)(e.Row.FindControl("cmdRaildly_loc"))).Attributes.Add("onclick", "return nwOpen(" + ((TextBox)e.Row.FindControl("txtRaildly_loc")).ClientID + ")");
            ((CheckBox)(e.Row.FindControl("chk11"))).Attributes.Add("onclick", "return oda_yn(this," + ((TextBox)e.Row.FindControl("txtODA")).ClientID + "," + ((TextBox)e.Row.FindControl("txtODA_KM")).ClientID + ")");
            ((TextBox)(e.Row.FindControl("txtODA_KM"))).Attributes.Add("onblur", "return Nagative_Chk_wDecimal(this)");
            ((TextBox)(e.Row.FindControl("txtODA_KM"))).Enabled = false;
            //if ((cityFlg == "Y") && ((TextBox)e.Row.FindControl("txtODA")).Text == "Y")
            //{
            //    ((TextBox)(e.Row.FindControl("txtODA_KM"))).Enabled = true;
            //}
        }
    }
}
