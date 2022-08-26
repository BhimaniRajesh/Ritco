using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LocationEdit : System.Web.UI.Page
{
    SqlConnection cn,con; // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    //SqlConnection cn = new SqlConnection(comon.common.cnstr);
    MyFunctions fn = new MyFunctions();
    //public static string dHir;

    public static string dHir;
    public static string dLoc;
    public static string tAcLoc;
    public static string sqldH;
    public static string mydH;

    public static string strPayModePaid;
    public static string strPayModeTBB;
    public static string strPayModeToPay;
    public static string strPayModeFoc;
    public static string strPayModeBod;

    public static string strPayType;
    public static int intTotalPayTypes;
    public static string strPaymentTypeForEdit;
    public static string strActualLocationCode;

    public static string scriptStr,loccode;
    public static string strToday;
    public static int intRptTo;
    public static string strRptLoc;

    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        con = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (con.State == ConnectionState.Closed) con.Open();
        if (cn.State == ConnectionState.Closed) cn.Open();
        if (IsPostBack == false)
        {
            fn.GetUser();
            SqlCommand c1 = new SqlCommand("SELECT GETDATE() AS servdt", cn);
            DateTime d =  (DateTime)c1.ExecuteScalar();
            strToday = d.ToString("dd/MM/yyyy");
            //cn.Close();
            TextBox16.Attributes.Add("onblur", "javascript:return ValidateForm(this),chkdateloc(this)");
            txtLocEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txtBkStrDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txtBkEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txtdlStrDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txtdlyEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txttransStrDT.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txttransEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            check();
            dHir = Convert.ToString(Session["dHir"]);
            dLoc = Convert.ToString(Session["dLoc"]);
            tAcLoc = Convert.ToString(Session["tAcLoc"]);

            //ddLocHir.Items.Add("--Select--");
            //ddRptTo.Items.Add("--Select--");
            //ddRptLoc.Items.Add("--Select--");
            //ddState.Items.Add("--Select--");

            //getRptToLocData();

            //trBooking.Visible = false;
            //trDelivery.Visible = false;
            //trTranship.Visible = false;

            if (cn.State == ConnectionState.Closed)cn.Open();
            ddLocHir.Items.Clear();
            ddLocHir.Items.Add("--Select--");
            //string sqlstr = "Select level_type,level_no from webx_hierarchy where activeflag='Y' order by level_no asc";
            string sqlstr = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' order by level_no asc";
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddLocHir.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }
            dr.Close();

            ddRptTo.Items.Clear();
            ddRptTo.Items.Add("--Select--");
            //string sqlstr1 = "Select level_type,level_no from webx_hierarchy where activeflag='Y' order by level_no asc";
            string sqlstr1 = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' order by level_no asc";
            SqlCommand cmd1 = new SqlCommand(sqlstr1, cn);
            SqlDataReader dr1 = cmd1.ExecuteReader();

            while (dr1.Read())
            {

                ddRptTo.Items.Add(new ListItem(dr1.GetValue(0).ToString(), dr1.GetValue(1).ToString()));
            }
            dr1.Close();

            ddRptLoc.Items.Clear();
            ddRptLoc.Items.Add("--Select--");
            string sqlstr2 = "Select distinct LocName + ' : ' + LocCode, LocCode from webx_Location where  activeflag='Y'";
            SqlCommand cmd2 = new SqlCommand(sqlstr2, cn);
            SqlDataReader dr2 = cmd2.ExecuteReader();
            //ddRptLoc.Items.Clear();
            while (dr2.Read())
            {
                ddRptLoc.Items.Add(new ListItem(dr2.GetValue(0).ToString(), dr2.GetValue(1).ToString()));
            }
            dr2.Close();

            string sqlstrst = "Select distinct stcd,stnm from webx_state";
            SqlCommand cmdst = new SqlCommand(sqlstrst, cn);
            SqlDataReader drst = cmdst.ExecuteReader();
            while (drst.Read())
            {
                // ddState.Items.Add(new ListItem(drst.GetValue(0).ToString()));
                ddState.Items.Add(new ListItem(drst.GetValue(1).ToString(), drst.GetValue(0).ToString()));
            }
            drst.Close();

            //string sqlzone = "Select zonename, zonecode from webx_zonemaster order by zonename";
            string sqlzone = "Select codedesc as zonename,codeid as zonecode from webx_master_general where codetype='zone'";
            SqlCommand cmdzone = new SqlCommand(sqlzone, cn);

            SqlDataAdapter ddd2 = new SqlDataAdapter(cmdzone);
            DataSet dds = new DataSet();
            ddd2.Fill(dds);
            ddRgLoc.DataSource = dds;
            ddRgLoc.DataTextField = "zonename";
            ddRgLoc.DataValueField = "zonecode";
            ddRgLoc.DataBind();


            getData();

            //getRptToLocData();

            hidPayType.Value = "";

            if (txtBkOpr.Text == "Y")
            {
                chkBkOpr.Checked = true;
                pay.Visible = true;
                Service.Visible = true;
                bkOpr.Visible = true;

                getrmnData();
            }

            //getPaymentType();
        }

    }
    public static string Locationstr;
    public string Citystr;
    public void check()
    {
        Locationstr = fn.getLocationStr();
        //Citystr = fn.getAllCityStr();
        getLocationStr();
        getAllCityStr();
        //txtLocCod.Attributes.Add("onblur", "javascript:return Locationcheck(" + txtLocCod.ClientID + ")");
        TextBox6.Attributes.Add("onblur", "javascript:return Citycheck(" + TextBox6.ClientID + ")");
        txtNrPrLoc.Attributes.Add("onblur", "javascript:return DefNxtLoc(" + txtNrPrLoc.ClientID + ")");
        txtNxtLoc.Attributes.Add("onblur", "javascript:return DefNxtLoc(" + txtNxtLoc.ClientID + ")");
        txtAcLoc.Attributes.Add("onblur", "javascript:return DefNxtLoc(this)");
        txtDataLoc.Attributes.Add("onblur", "javascript:return check2loc(this)");
        txtEmail.Attributes.Add("onblur", "javascript:return EmailCheck(this)");
        //destn.Attributes.Add("onchange", "javascript:this.value=this.value.toUpperCase()");

    }
    private void getAllCityStr()
    {
        string sql = "select location from webx_citymaster";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("str", "'" + Convert.ToString(dr_Location["location"].ToString().ToUpper() + "'"));
        }
        dr_Location.Close();
    }
    private void getLocationStr()
    {
        string sql = "SELECT loccode FROM  webx_location where ActiveFlag='Y'";
        SqlCommand sqlCommand = new SqlCommand(sql, cn);
        SqlDataReader dr_Location;
        dr_Location = sqlCommand.ExecuteReader();
        while (dr_Location.Read())
        {
            Page.RegisterArrayDeclaration("strloc", "'" + Convert.ToString(dr_Location["loccode"].ToString().ToUpper() + "'"));
        }
        dr_Location.Close();
    }
    protected void ddLocHir_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddLocHir.SelectedItem.Text != "--Select--")
        {
            LocHierChanged();
        }
        else
        {
            ddRptTo.Items.Clear();
            ddRptTo.Items.Add("--Select--");
            ddRptLoc.Items.Clear();
            ddRptLoc.Items.Add("--Select--");
        }
    }

    private void LocHierChanged()
    {
        SqlConnection cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        //string sqlstr1 = "Select level_type,level_no from webx_hierarchy where level_no<" + ddLocHir.SelectedValue;
        //string sqlstr1 = "Select top 1 '--Select--' as level_type,'--Select--' as level_no from webx_hierarchy union Select level_type,convert(varchar,level_no) from webx_hierarchy where level_no<" + ddLocHir.SelectedValue + "";
        if (ddLocHir.SelectedValue.ToString() != "--Select--")
        {
            string sqlstr1 = "Select top 1 '--Select--' as level_type,'--Select--' as level_no from webx_master_general union Select codedesc as level_type,convert(varchar,codeid) as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y'";
            SqlCommand cmd1 = new SqlCommand(sqlstr1, cn1);
            SqlDataAdapter sqlDA = new SqlDataAdapter(cmd1);

            DataSet ds = new DataSet();

            sqlDA.Fill(ds);

            ddRptTo.Items.Clear();
            //ddRptTo.Items.Add("--Select--");
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddRptTo.DataSource = ds;
                ddRptTo.DataTextField = "level_type";
                ddRptTo.DataValueField = "level_no";

                ddRptTo.DataBind();
            }
        }
        cn1.Close();
    }

    protected void ddRptTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddRptTo.SelectedValue == "Head Office")
        //  {
        //        ddRptLoc.Items.Clear();
        //        ddRptLoc.Items.Add("--Select--");
        //        if (cn.State == ConnectionState.Closed)cn.Open();
        //        string mynwsqlstr1 = "Select level_type,level_no from webx_hierarchy where level_no='1'"; //" + ddLocHir.SelectedValue.ToString() + "'";
        //        SqlCommand mycmd1 = new SqlCommand(mynwsqlstr1, cn);
        //        SqlDataReader mynwdr1 = mycmd1.ExecuteReader();
        //        //ddRptTo.Items.Clear();
        //        while (mynwdr1.Read())
        //        {

        //            ddRptLoc.Items.Add(new ListItem(mynwdr1.GetValue(0).ToString(), mynwdr1.GetValue(1).ToString()));
        //        }
        //        mynwdr1.Close();
        //        cn.Close();
        //    }
        //    else
        //    {
        if (ddRptTo.SelectedItem.Text != "--Select--")
        {
            if (ddRptTo.SelectedItem.ToString() == "HEAD OFFICE" || ddRptTo.SelectedItem.ToString() == "Head Office")
            {
                ddRptLoc.Items.Clear();
                ddRptLoc.Items.Add("--Select--");
                if (cn.State == ConnectionState.Closed) cn.Open();
                //string mynwsqlstr1 = "Select level_type,level_no from webx_hierarchy where level_no='1'"; //" + ddLocHir.SelectedValue.ToString() + "'";

                //string mynwsqlstr1 = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' and codeid='1'";

                string mynwsqlstr1 = "Select distinct LocName + ' : ' + LocCode,Loccode from webx_Location where Loc_Level='1'  and activeflag='Y'";
                SqlCommand mycmd1 = new SqlCommand(mynwsqlstr1, cn);
                SqlDataReader mynwdr1 = mycmd1.ExecuteReader();
                //ddRptTo.Items.Clear();
                while (mynwdr1.Read())
                {

                    ddRptLoc.Items.Add(new ListItem(mynwdr1.GetValue(0).ToString(), mynwdr1.GetValue(1).ToString()));
                }
                mynwdr1.Close();
                cn.Close();
            }
            else
            {
                if (cn.State == ConnectionState.Closed) cn.Open();
                string sqlstr2 = "Select distinct LocName + ' : ' + LocCode, LocCode from webx_Location where Loc_Level='" + ddRptTo.SelectedValue.ToString() + "'  and activeflag='Y'";
                SqlCommand cmd2 = new SqlCommand(sqlstr2, cn);
                SqlDataReader dr2 = cmd2.ExecuteReader();
                ddRptLoc.Items.Clear();
                ddRptLoc.Items.Add("--Select--");
                while (dr2.Read())
                {
                    ddRptLoc.Items.Add(new ListItem(dr2.GetValue(0).ToString(), dr2.GetValue(1).ToString()));
                }
                dr2.Close();
                cn.Close();
            }
        }
        //}
    }

    protected void chkComp_CheckedChanged(object sender, EventArgs e)
    {
        if (chkComp.Checked == true)
        {
            TextBox15.Text = "Y";
        }
        else
        {
            TextBox15.Text = "N";
        }
    }


    protected void chkBkOpr_CheckedChanged(object sender, EventArgs e)
    {
        if (chkBkOpr.Checked == true)
        {

            txtBkOpr.Text = "Y";
            //txtBkStrDt.Enabled = true;
            //txtBkEndDt.Enabled = true;
            trBooking.Visible = true;
            pay.Visible = true;
            Service.Visible = true;
            bkOpr.Visible = true;
        }
        else
        {
            txtBkOpr.Text = "N";
            //txtBkStrDt.Enabled = false;
            //txtBkEndDt.Enabled = false;
            trBooking.Visible = false;
            pay.Visible = false;
            Service.Visible = false;
            bkOpr.Visible = false;
        }
    }

    protected void chktransOpr_CheckedChanged(object sender, EventArgs e)
    {
        if (chktransOpr.Checked == true)
        {
            txttransOpr.Text = "Y";
            trTranship.Visible = true;
            //txttransStrDT.Enabled = true;
            //txttransEndDt.Enabled = true;
        }
        else
        {
            txttransOpr.Text = "N";
            trTranship.Visible = false;
            //txttransStrDT.Enabled = false;
            //txttransEndDt.Enabled = false;
        }

    }

    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
        if (CheckBox2.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }
    protected void chkVol_CheckedChanged(object sender, EventArgs e)
    {
        if (chkVol.Checked == true)
        {
            txtVol.Text = "Y";
        }
        else
        {
            txtVol.Text = "N";
        }

    }
    protected void chkCod_CheckedChanged(object sender, EventArgs e)
    {
        if (chkCod.Checked == true)
        {
            txtCod.Text = "Y";
        }
        else
        {
            txtCod.Text = "N";
        }
    }
    protected void chkOda_CheckedChanged(object sender, EventArgs e)
    {
        if (chkOda.Checked == true)
        {
            txtOda.Text = "Y";
        }
        else
        {
            txtOda.Text = "N";
        }

    }
    protected void chkDly_CheckedChanged(object sender, EventArgs e)
    {
        if (chkDly.Checked == true)
        {
            TextBox26.Text = "Y";
            trDelivery.Visible = true;
            //txtdlStrDt.Enabled = true;
            //txtdlyEndDt.Enabled = true;           
        }
        else
        {
            TextBox26.Text = "N";
            trDelivery.Visible = false;
            //txtdlStrDt.Enabled = false;
            //txtdlyEndDt.Enabled = false;
        }
    }

    protected void c1_CheckedChanged(object sender, EventArgs e)
    {
        if (c1.Checked == true)
        {
            TextBox3.Text = "Y";
        }
        else
        {
            TextBox3.Text = "N";
        }


    }
    protected void c2_CheckedChanged(object sender, EventArgs e)
    {
        if (c2.Checked == true)
        {
            txtCutOff.Text = "Y";

        }
        else
        {
            txtCutOff.Text = "N";
        }

    }
    protected void c3_CheckedChanged(object sender, EventArgs e)
    {
        if (c3.Checked == true)
        {
            txtPickDor.Text = "Y";

        }
        else
        {
            txtPickDor.Text = "N";
        }

    }
    protected void c4_CheckedChanged(object sender, EventArgs e)
    {
        if (c4.Checked == true)
        {
            txtRail.Text = "Y";

        }
        else
        {
            txtRail.Text = "N";
        }

    }
    protected void c6_CheckedChanged(object sender, EventArgs e)
    {
        if (c6.Checked == true)
        {
            txtSea.Text = "Y";

        }
        else
        {
            txtSea.Text = "N";
        }

    }
    protected void c5_CheckedChanged(object sender, EventArgs e)
    {
        if (c5.Checked == true)
        {
            txtPickGodwn.Text = "Y";

        }
        else
        {
            txtPickGodwn.Text = "N";
        }

    }
    protected void chkUgd_CheckedChanged(object sender, EventArgs e)
    {
        if (chkUgd.Checked == true)
        {
            txtUgd.Text = "Y";

        }
        else
        {
            txtUgd.Text = "N";
        }

    }

    //private void getPaymentType()
    //{
    //    if (cn.State == ConnectionState.Closed)cn.Open();
    //    SqlCommand cmd = new SqlCommand("Select distinct CodeType_New,Abbr_Type,ActiveFlag from webx_TYPEMST where left(CodeType_New,1)='P' Order By CodeType_New",cn);
    //    SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

    //    DataSet dsPay = new DataSet();
    //    strPayType = "";
    //    sqlDA.Fill(dsPay);

    //    intTotalPayTypes = dsPay.Tables[0].Rows.Count;

    //    if (dsPay.Tables[0].Rows.Count > 0)
    //    {
    //        for (int i = 0; i < dsPay.Tables[0].Rows.Count; i++)
    //        {
    //            if(dsPay.Tables[0].Rows[i]["ActiveFlag"].ToString() == "Y") 
    //            {
    //                strPayType += "<td align='left'><input id='payment_type" + i.ToString() + "' type=checkbox value=" + dsPay.Tables[0].Rows[i]["CodeType_New"].ToString() + GetPaymentTypeChecked(dsPay.Tables[0].Rows[i]["CodeType_New"].ToString()) + " onclick='Payment_Type_Clicked(this)'>";
    //                strPayType += "<td align='left'><font class=blackfnt>" + dsPay.Tables[0].Rows[i]["Abbr_Type"].ToString().Trim() + "</font></td>";
    //                strPayType += "<td align='left'><font class=blackfnt>&nbsp;&nbsp;&nbsp;</font></td>";
    //            }
    //        }
    //        cn.Close();
    //    }
    //}
    private void getPaymentType()
    {

        if (con.State == ConnectionState.Closed)con.Open();
        //SqlCommand cmd = new SqlCommand("Select distinct CodeType_New,Abbr_Type,ActiveFlag from webx_TYPEMST where left(CodeType_New,1)='P' Order By CodeType_New", con);
        SqlCommand cmd = new SqlCommand("Select distinct codeid as CodeType_New,codedesc as Abbr_Type,statuscode as ActiveFlag from webx_master_general where left(codeid,1)='P' and codetype='PAYTYP' Order By CodeType_New", con);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);

        DataSet dsPay = new DataSet();
        strPayType = "";
        sqlDA.Fill(dsPay);
        int j;
        j = 0;
        if (dsPay.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsPay.Tables[0].Rows.Count; i++)
            {
                if (dsPay.Tables[0].Rows[i]["ActiveFlag"].ToString() == "Y")
                {
                    //strPayType += "<td align='left'><input id='payment_type" + i.ToString() + "' type=checkbox value=" + dsPay.Tables[0].Rows[i]["CodeType_New"].ToString() + " onclick='Payment_Type_Clicked(this)'>";
                    //strPayType += "<td align='left'><font class=blackfnt>" + dsPay.Tables[0].Rows[i]["Abbr_Type"].ToString().Trim() + "</font></td>";
                    //strPayType += "<td align='left'><font class=blackfnt>&nbsp;&nbsp;&nbsp;</font></td>";
                    ChkListPayType.Items.Add(Convert.ToString(dsPay.Tables[0].Rows[i]["Abbr_Type"]));
                    ChkListPayType.Items[j].Text = Convert.ToString(dsPay.Tables[0].Rows[i]["Abbr_Type"]);
                    ChkListPayType.Items[j].Value = Convert.ToString(dsPay.Tables[0].Rows[i]["CodeType_New"]);
                    ChkListPayType.CssClass = "blackfnt";
                    j += 1;
                }
            }

        }
    }
    public void getData()
    {
        string sqlstrVal;
        //if (chkBkOpr.Checked == false)  //&& ( txtBkOpr.Text == "" || txtBkOpr.Text == "N" ))
        //{
        if (cn.State == ConnectionState.Closed)cn.Open();
        if (tAcLoc == "")
        {
            string[] strLocCode = dLoc.ToString().Split(':'); //ddRptLoc.SelectedValue.Split(':');
            sqlstrVal = "Select loc_level,Report_Level,Report_Loc,LocCode,LocName,LocAddr,LocState,LocCity,LocPincode,cn_prefixcode,CashLimit, LocStdCode, LocTelno, LocFaxno, Locmobile, LocEmail,LocRegion, Loc_Account, Computerised, Dataentry, loc_startdt,loc_enddt, L.ActiveFlag, Op_Bkg, Op_Dly, Op_Tranship, OP_startdt, OP_enddt, Dly_StartDt, Dly_EndDt, OP_UGD, Transshipment_StartDt,Transshipment_EndDt, Default_NextLoc, Nearest_PrevLoc,Payment_Type,octroi_io,locstate,outsource_own,BankLedger=L.BankLedger+':'+A.Accdesc,U.UserName from webx_Location L outer Apply(select Name+'~'+UserId As UserName from WebX_Master_Users U with(NoLock) where L.UserName=U.UserId)U LEFT JOIN WEBX_ACCTINFO A ON A.Acccode=L.BankLedger where LocCode='" + strLocCode[1].Trim() + "'";
        }
        else
        {
            sqlstrVal = "Select loc_level,Report_Level,Report_Loc,LocCode,LocName,LocAddr,LocState,LocCity,LocPincode,cn_prefixcode,CashLimit, LocStdCode, LocTelno, LocFaxno, Locmobile, LocEmail,LocRegion, Loc_Account, Computerised, Dataentry, loc_startdt,loc_enddt, L.ActiveFlag, Op_Bkg, Op_Dly, Op_Tranship, OP_startdt, OP_enddt, Dly_StartDt, Dly_EndDt, OP_UGD, Transshipment_StartDt,Transshipment_EndDt, Default_NextLoc, Nearest_PrevLoc,Payment_Type,octroi_io,locstate,outsource_own,BankLedger=L.BankLedger+':'+A.Accdesc,U.UserName from webx_Location L outer Apply(select Name+'~'+UserId As UserName from WebX_Master_Users U with(NoLock) where L.UserName=U.UserId)U LEFT JOIN WEBX_ACCTINFO A ON A.Acccode=L.BankLedger where LocCode='" + tAcLoc + "'";
            //sqlstrVal = "Select loc_level,Report_Level,Report_Loc,LocCode,LocName,LocAddr,LocState,LocCity,LocPincode,cn_prefixcode, LocStdCode, LocTelno, LocFaxno, Locmobile, LocEmail,LocRegion, Loc_Account, Computerised, Dataentry, loc_startdt,loc_enddt, ActiveFlag, Op_Bkg, Op_Dly, Op_Tranship, OP_startdt, OP_enddt, Dly_StartDt, Dly_EndDt, OP_UGD, Transshipment_StartDt,Transshipment_EndDt, Default_NextLoc, Nearest_PrevLoc, Vol, COD_DOD, ODA, Octroi_Area, AirService, RailService, CutOff_YN, Bkg_CutOffTime,Pickup_Door, Pickup_Godown, BilledAT, Payment_Type from webx_Location where LocCode='" + tAcLoc + "'";
        }
        //sqlstrVal = "Select loc_level,Report_Level,Report_Loc,LocCode,LocName,LocAddr,LocState,LocCity,LocPincode,cn_prefixcode, LocStdCode, LocTelno, LocFaxno, Locmobile, LocEmail,LocRegion, Loc_Account, Computerised, Dataentry, loc_startdt,loc_enddt, ActiveFlag, Op_Bkg, Op_Dly, Op_Tranship, OP_startdt, OP_enddt, Dly_StartDt, Dly_EndDt, OP_UGD, Transshipment_StartDt,Transshipment_EndDt, Default_NextLoc, Nearest_PrevLoc, Vol, COD_DOD, ODA, Octroi_Area, AirService, RailService, CutOff_YN, Bkg_CutOffTime,Pickup_Door, Pickup_Godown, BilledAT, Payment_Type from webx_Location where LocCode='" + strLocCode[1].Trim() + "'";
        SqlCommand cmdVal = new SqlCommand(sqlstrVal, cn);
        SqlDataReader drVal = cmdVal.ExecuteReader();
        //ddLoc.Items.Clear();
        if(drVal.Read())
        {
            ddLocHir.Text = drVal["loc_level"].ToString();
            LocHierChanged();
            intRptTo = Convert.ToInt32(drVal["Report_Level"].ToString());
            strRptLoc = drVal["Report_Loc"].ToString();
            ddRptTo.SelectedValue = intRptTo.ToString();
            //ddRptTo.Text = drVal["Report_Level"].ToString();
            //ddRptLoc.Text = drVal["Report_Loc"].ToString();
            txtLocCod.Text = drVal["LocCode"].ToString();
            loccode = drVal["LocCode"].ToString();
            ddRptLoc.SelectedValue = strRptLoc;
            strActualLocationCode = txtLocCod.Text;
            txtLocNm.Text = drVal["LocName"].ToString();
            txtAdd.Text = drVal["LocAddr"].ToString();
            ddState.Text = drVal["LocState"].ToString();
            TextBox6.Text = drVal["LocCity"].ToString();
            txtPin.Text = drVal["LocPincode"].ToString();
            txtCNCod.Text = drVal["cn_prefixcode"].ToString();
            txtCashlimit.Text = drVal["CashLimit"].ToString();
            txtStdCod.Text = drVal["LocStdCode"].ToString();
            txtTel.Text = drVal["LocTelno"].ToString();
            Txt_User.Text = drVal["UserName"].ToString();            
            //txtFax.Text = drVal["LocFaxno"].ToString();
            txtMob.Text = drVal["Locmobile"].ToString();
            txtEmail.Text = drVal["LocEmail"].ToString();

            ddRgLoc.SelectedValue = drVal["LocRegion"].ToString();
            txtAcLoc.Text = drVal["Loc_Account"].ToString();
            TextBox15.Text = drVal["Computerised"].ToString();
            txtDataLoc.Text = drVal["Dataentry"].ToString();
            //TextBox16.Text =  Convert.ToDateTime(drVal["loc_startdt"].ToString()).ToString("dd/MM/yyyy");
            //txtLocEndDt.Text = (drVal["loc_enddt"].ToString().Trim() == "" || drVal["loc_enddt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["loc_enddt"].ToString()).ToString("dd/MM/yyyy"));
            TextBox16.Text = (drVal["loc_startdt"].ToString().Trim() == "" || drVal["loc_startdt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["loc_startdt"].ToString()).ToString("dd/MM/yyyy"));
            if (TextBox16.Text == "01/01/1900") { TextBox16.Text = ""; }
            txtLocEndDt.Text = (drVal["loc_enddt"].ToString().Trim() == "" || drVal["loc_enddt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["loc_enddt"].ToString()).ToString("dd/MM/yyyy"));
            if (txtLocEndDt.Text == "01/01/1900") { txtLocEndDt.Text = ""; }
            txtActFlag.Text = drVal["ActiveFlag"].ToString();
            txtBkOpr.Text = drVal["Op_Bkg"].ToString();
            TextBox26.Text = drVal["Op_Dly"].ToString();
            txttransOpr.Text = drVal["Op_Tranship"].ToString();
            txtBkStrDt.Text = (drVal["OP_startdt"].ToString().Trim() == "" || drVal["OP_startdt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["OP_startdt"].ToString()).ToString("dd/MM/yyyy"));
            if (txtBkStrDt.Text == "01/01/1900") { txtBkStrDt.Text = "";}
            txtBkEndDt.Text = (drVal["OP_enddt"].ToString().Trim() == "" || drVal["OP_enddt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["OP_enddt"].ToString()).ToString("dd/MM/yyyy"));
            if (txtBkEndDt.Text == "01/01/1900") { txtBkEndDt.Text = ""; }
            //spcmd.Parameters.Add("@dLocOnr", SqlDbType.VarChar).Value = ddLocOnr.SelectedValue;
            txtdlStrDt.Text = (drVal["Dly_StartDt"].ToString().Trim() == "" || drVal["Dly_StartDt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["Dly_StartDt"].ToString()).ToString("dd/MM/yyyy"));
            if (txtdlStrDt.Text == "01/01/1900") { txtdlStrDt.Text = ""; }
            txtdlyEndDt.Text = (drVal["Dly_EndDt"].ToString().Trim() == "" || drVal["Dly_EndDt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["Dly_EndDt"].ToString()).ToString("dd/MM/yyyy"));
            if (txtdlyEndDt.Text == "01/01/1900") { txtdlyEndDt.Text = ""; }
            txtUgd.Text = drVal["OP_UGD"].ToString();
            txttransStrDT.Text = (drVal["Transshipment_StartDt"].ToString().Trim() == "" || drVal["Transshipment_StartDt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["Transshipment_StartDt"].ToString()).ToString("dd/MM/yyyy"));
            if (txttransStrDT.Text == "01/01/1900") { txttransStrDT.Text = ""; }
            txttransEndDt.Text = (drVal["Transshipment_EndDt"].ToString().Trim() == "" || drVal["Transshipment_EndDt"].ToString().ToUpper() == "NULL" ? "" : Convert.ToDateTime(drVal["Transshipment_EndDt"].ToString()).ToString("dd/MM/yyyy"));
            if (txttransEndDt.Text == "01/01/1900") { txttransEndDt.Text = ""; }
            txtNxtLoc.Text = drVal["Default_NextLoc"].ToString();
            txtNrPrLoc.Text = drVal["Nearest_PrevLoc"].ToString();
            DropDownList1.SelectedValue = Convert.ToString(drVal["octroi_io"]);
            ddState.SelectedValue = Convert.ToString(drVal["locstate"]);
            ddLocOnr.SelectedValue = Convert.ToString(drVal["OutSource_Own"]);
            txtBank.Text = drVal["BankLedger"].ToString();
            getPaymentType();
            string paytype = drVal["Payment_Type"].ToString().Trim();
            Array pay;
            pay = paytype.Split(',');
            if ((paytype != null) && (paytype != ""))
            {
                for (int j = 0; j < pay.Length; j++)
                {
                    for (int i = 0; i < ChkListPayType.Items.Count; i++)
                    {

                        if (((string[])(pay))[j].Trim() == ChkListPayType.Items[i].Value)
                        {
                            ChkListPayType.Items[i].Selected = true;

                        }
                    }
                }
            }
            if (TextBox15.Text == "Y")
            {
                chkComp.Checked = true;
            }
            if (txtActFlag.Text == "Y")
            {
                CheckBox2.Checked = true;
            }
            if (txtBkOpr.Text == "Y")
            {
                chkBkOpr.Checked = true;
                //trBooking.Visible = true; 
            }
            if (TextBox26.Text == "Y")
            {
                chkDly.Checked = true;
                //trDelivery.Visible = true; 
            }
            if (txttransOpr.Text == "Y")
            {
                chktransOpr.Checked = true;
                // trTranship.Visible = true; 
            }
            if (txtUgd.Text == "Y")
            {
                chkUgd.Checked = true;
            }

        }
        drVal.Close();
        cn.Close();
        //}
    }
    static string PayTypeStr;
    protected void ChkListPayType_SelectedIndexChanged(object sender, EventArgs e)
    {
        PayTypeStr = "";
        for (int i = 0; i < ChkListPayType.Items.Count; i++)
        {
            if (ChkListPayType.Items[i].Selected == true)
            {
                PayTypeStr = PayTypeStr + "," + ChkListPayType.Items[i].Value.ToString().Trim();
            }
        }
        if (PayTypeStr.Length != 0)
        {
            PayTypeStr = PayTypeStr.Substring(1, PayTypeStr.Length - 1);
        }
    }
    public void getRptToLocData()
    {
        if (cn.State == ConnectionState.Closed)cn.Open();

        //string sqlRptTo = "Select level_type,level_no from webx_hierarchy where level_no = " + intRptTo; // +" and level_no<'" + ddLocHir.SelectedValue.ToString() + "'";
        //SqlCommand cmdRptTo = new SqlCommand(sqlRptTo, cn);
        //SqlDataReader drRptTo = cmdRptTo.ExecuteReader();
        //if (drRptTo.Read())
        //{
        //ddRptTo.SelectedValue = intRptTo.ToString(); // drRptTo["level_no"].ToString().Trim();
        //}
        //drRptTo.Close();

        //string sqlRptLoc = "Select distinct LocName + ' : ' + LocCode as LocDetail from webx_Location where Report_Loc='" + strRptLoc + "'";
        //string sqlRptLoc = "Select distinct LocCode from webx_Location where Report_Loc='" + strRptLoc + "'";
        //txtLocCod.Text = "";
        //SqlCommand cmdRptLoc = new SqlCommand(sqlRptLoc, cn);
        //SqlDataReader drRptLoc = cmdRptLoc.ExecuteReader();
        //if (drRptLoc.Read())
        //{
        //    ddRptLoc.SelectedValue = drRptLoc["LocCode"].ToString().Trim();
        //}
        //drRptLoc.Close();

        ddRptTo.Items.Clear();
        ddRptTo.Items.Add("--Select--");
        //string sqlstr1 = "Select level_type,level_no from webx_hierarchy where activeflag='Y' order by level_no asc";
        string sqlstr1 = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' order by level_no asc";
        SqlCommand cmd1 = new SqlCommand(sqlstr1, cn);
        SqlDataReader dr1 = cmd1.ExecuteReader();
        ddRptTo.Items.Clear();
        while (dr1.Read())
        {

            ddRptTo.Items.Add(new ListItem(dr1.GetValue(0).ToString(), dr1.GetValue(1).ToString()));
        }
        dr1.Close();

        cn.Close();
    }

    public void getrmnData()
    {
        string sqlstrVal;
        if (cn.State == ConnectionState.Closed)cn.Open();
        if (tAcLoc == "")
        {
            string[] strLocCode = dLoc.ToString().Split(':'); //ddRptLoc.SelectedValue.Split(':');
            sqlstrVal = "Select Vol, COD_DOD, ODA, Octroi_Area, AirService, RailService, CutOff_YN, Bkg_CutOffTime,Pickup_Door, Pickup_Godown, BilledAT, Payment_Type from webx_Location where LocCode='" + strLocCode[1].Trim() + "'";
        }
        else
        {
            sqlstrVal = "Select Vol, COD_DOD, ODA, Octroi_Area, AirService, RailService, CutOff_YN, Bkg_CutOffTime,Pickup_Door, Pickup_Godown, BilledAT, Payment_Type from webx_Location where LocCode='" + tAcLoc + "'";
        }
        //string[] strLocCode = dLoc.ToString().Split(':'); //ddRptLoc.SelectedValue.Split(':');
        //string sqlstrVal = "Select Vol, COD_DOD, ODA, Octroi_Area, AirService, RailService, CutOff_YN, Bkg_CutOffTime,Pickup_Door, Pickup_Godown, BilledAT, Payment_Type from webx_Location where LocCode='" + strLocCode[1].Trim() + "'";
        SqlCommand cmdVal = new SqlCommand(sqlstrVal, cn);
        SqlDataReader drVal = cmdVal.ExecuteReader();
        //ddLoc.Items.Clear();
        while (drVal.Read())
        {

            //spcmd.Parameters.Add("@PayType", SqlDbType.VarChar).Value = hidPayType.Value;

            txtVol.Text = drVal[0].ToString();
            txtCod.Text = drVal[1].ToString();
            txtOda.Text = drVal[2].ToString();
            //DropDownList1.SelectedValue.ToString() = drVal[3].ToString();
            TextBox3.Text = drVal[4].ToString();
            txtRail.Text = drVal[5].ToString();
            //txtSea.Text.ToString() = drVal[32].ToString();;
            //ListBox1.SelectedItem.ToString() = drVal[32].ToString();;
            txtCutOff.Text = drVal[6].ToString();
            TextBox8.Text = drVal[7].ToString();
            txtPickDor.Text = drVal[8].ToString();
            txtPickGodwn.Text = drVal[9].ToString();
            TextBox11.Text = drVal[10].ToString();

            strPaymentTypeForEdit = drVal[11].ToString();
            hidPayType.Value = strPaymentTypeForEdit;
            if (txtVol.Text == "Y")
            {
                chkVol.Checked = true;
            }
            if(txtCod.Text == "Y")
            {
                chkCod.Checked = true;
            }
            if (txtOda.Text == "Y")
            {
                chkOda.Checked = true;
            }
            if (TextBox3.Text == "Y")
            {
                c1.Checked = true;
            }
            if (txtCutOff.Text == "Y")
            {
                c2.Checked = true;
            }
            if (txtPickDor.Text == "Y")
            {
                c3.Checked = true;
            }
            if (txtRail.Text == "Y")
            {
                c4.Checked = true;
            }
            if (txtPickGodwn.Text == "Y")
            {
                c5.Checked = true;
            }
            if (txtSea.Text == "Y")
            {
                c6.Checked = true;
            }

        }
        drVal.Close();
        cn.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string[] strReportLocCode = ddRptLoc.SelectedValue.Split(':');
        string Bank=txtBank.Text;
        string Bankcode = Bank.Split(':')[0];
        //if (chkBkOpr.Checked == false)
        //{
        if (cn.State == ConnectionState.Closed)cn.Open();
        string BkStrDt, BkEndDt, dlStrDt, dlyEndDt, transStrDT, transEndDt, LocEndDt, loc_startdt;
        if (chkBkOpr.Checked == false)
        {
            txtBkStrDt.Text = "";
            txtBkEndDt.Text = "";
        }
        if (chkDly.Checked == false)
        {
            txtdlStrDt.Text = "";
            txtdlyEndDt.Text = "";
        }
        if (chktransOpr.Checked == false)
        {
            txttransStrDT.Text = "";
            txttransEndDt.Text = "";
        }
        loc_startdt = fn.Mydate(TextBox16.Text);
        LocEndDt = fn.Mydate(txtLocEndDt.Text);
        BkStrDt = fn.Mydate(txtBkStrDt.Text);
        BkEndDt = fn.Mydate(txtBkEndDt.Text);
        dlStrDt = fn.Mydate(txtdlStrDt.Text);
        dlyEndDt = fn.Mydate(txtdlyEndDt.Text);
        transStrDT = fn.Mydate(txttransStrDT.Text);
        transEndDt = fn.Mydate(txttransEndDt.Text);
        //string hPayTypeStr = hidden_PayTypeStr.Value;
        string CPayTypeStr = PayTypeStr;
        if (txtCashlimit.Text == "")
        {
            txtCashlimit.Text = "0";
        }
        var UserId = Txt_User.Text.Split('~');        
        string sqlupdate = "update webx_location set Loc_Level=" + ddLocHir.Text + ",Report_Level=" + ddRptTo.Text + ",LocName='" + txtLocNm.Text.Replace("'", "''") + "',Report_Loc='" + ddRptLoc.Text + "', LocAddr='" + txtAdd.Text.Replace("'", "''") + "', LocState='" + ddState.Text + "', LocCity='" + TextBox6.Text.Replace("'", "''") + "', LocPinCode='" + txtPin.Text.Replace("'", "''") + "', CashLimit='" + Convert.ToDecimal(txtCashlimit.Text) + "', LOCSTDCode='" + txtStdCod.Text.Replace("'", "''") + "', LocTelNo='" + txtTel.Text.Replace("'", "''") + "', LocMobile='" + txtMob.Text.Replace("'", "''") + "', LOCEmail='" + txtEmail.Text.Replace("'", "''") + "', LOC_Account='" + txtAcLoc.Text.Replace("'", "''") + "', ActiveFlag='" + txtActFlag.Text.Replace("'", "''") + "',LocRegion='" + ddRgLoc.Text + "',Computerised='" + TextBox15.Text.Replace("'", "''") + "',Dataentry='" + txtDataLoc.Text.Replace("'", "''") + "',loc_startdt='" + loc_startdt + "',loc_enddt='" + LocEndDt + "',UPDTBY='" + Convert.ToString(Session["empcd"]) + "',UPDTON=getdate(), Payment_Type='" + PayTypeStr + "',Vol='" + txtVol.Text.Replace("'", "''") + "',COD_DOD='" + txtCod.Text.Replace("'", "''") + "',ODA='" + txtOda.Text.Replace("'", "''") + "',op_bkg='" + txtBkOpr.Text.Replace("'", "''") + "',op_dly='" + TextBox26.Text.Replace("'", "''") + "',op_tranship='" + txttransOpr.Text.Replace("'", "''") + "',OutSource_Own='" + ddLocOnr.Text + "',Default_NextLoc='" + txtNxtLoc.Text.Replace("'", "''") + "',Nearest_PrevLoc='" + txtNrPrLoc.Text.Replace("'", "''") + "',Op_StartDt='" + BkStrDt + "',Op_EndDt='" + BkEndDt + "',Dly_StartDt='" + dlStrDt + "',Dly_EndDt='" + dlyEndDt + "',Transshipment_StartDt='" + transStrDT + "',Transshipment_EndDt='" + transEndDt + "',CPC='',Op_UGD='" + txtUgd.Text.Replace("'", "''") + "',octroi_io='" + DropDownList1.Text + "',CN_Prefixcode='" + txtCNCod.Text.Replace("'", "''") + "',BilledAt='" + TextBox11.Text.Replace("'", "''") + "',BankLedger='" + Bankcode + "',UserName='" + UserId[1].ToString() + "' where loccode='" + txtLocCod.Text + "'";
        //string sqlupdate = "update webx_location set Loc_Level=" + ddLocHir.Text + ",Report_Level=" + ddRptTo.Text + ",LocName='" + txtLocNm.Text.Replace("'", "''") + "',Report_Loc='" + ddRptLoc.Text + "', LocAddr='" + txtAdd.Text.Replace("'", "''") + "', LocState='" + ddState.Text + "', LocCity='" + TextBox6.Text.Replace("'", "''") + "', LocPinCode='" + txtPin.Text.Replace("'", "''") + "', CashLimit='" + Convert.ToDecimal(txtCashlimit.Text) + "', LOCSTDCode='" + txtStdCod.Text.Replace("'", "''") + "', LocTelNo='" + txtTel.Text.Replace("'", "''") + "', LocFaxNo='" + txtFax.Text.Replace("'", "''") + "', LocMobile='" + txtMob.Text.Replace("'", "''") + "', LOCEmail='" + txtEmail.Text.Replace("'", "''") + "', LOC_Account='" + txtAcLoc.Text.Replace("'", "''") + "', ActiveFlag='" + txtActFlag.Text.Replace("'", "''") + "',LocRegion='" + ddRgLoc.Text + "',Computerised='" + TextBox15.Text.Replace("'", "''") + "',Dataentry='" + txtDataLoc.Text.Replace("'", "''") + "',loc_startdt='" + loc_startdt + "',loc_enddt='" + LocEndDt + "',UPDTBY='" + Convert.ToString(Session["empcd"]) + "',UPDTON=getdate(), Payment_Type='" + PayTypeStr + "',Vol='" + txtVol.Text.Replace("'", "''") + "',COD_DOD='" + txtCod.Text.Replace("'", "''") + "',ODA='" + txtOda.Text.Replace("'", "''") + "',op_bkg='" + txtBkOpr.Text.Replace("'", "''") + "',op_dly='" + TextBox26.Text.Replace("'", "''") + "',op_tranship='" + txttransOpr.Text.Replace("'", "''") + "',OutSource_Own='" + ddLocOnr.Text + "',Default_NextLoc='" + txtNxtLoc.Text.Replace("'", "''") + "',Nearest_PrevLoc='" + txtNrPrLoc.Text.Replace("'", "''") + "',Op_StartDt='" + BkStrDt + "',Op_EndDt='" + BkEndDt + "',Dly_StartDt='" + dlStrDt + "',Dly_EndDt='" + dlyEndDt + "',Transshipment_StartDt='" + transStrDT + "',Transshipment_EndDt='" + transEndDt + "',CPC='',Op_UGD='" + txtUgd.Text.Replace("'", "''") + "',octroi_io='" + DropDownList1.Text + "',CN_Prefixcode='" + txtCNCod.Text.Replace("'", "''") + "',BilledAt='" + TextBox11.Text.Replace("'", "''") + "',BankLedger='"+ Bankcode +"' where loccode='" + txtLocCod.Text  + "'";
        SqlCommand cmd = new SqlCommand(sqlupdate, cn);

        try
        {
            cmd.ExecuteNonQuery();
        }
        catch (Exception eee)
        {
            btnSubmit.Text = eee.Message;

        }


        cn.Close();
        Response.Redirect("LocationEdSelect.aspx");



    }

    private string GetPaymentTypeChecked(string strPayTypeValue)
    {
        if (strPaymentTypeForEdit == null)
        {
            return " ";
        }

        if (strPaymentTypeForEdit != "")
        {
            if (strPaymentTypeForEdit.Contains(strPayTypeValue) == true)
            {
                return " checked='checked' ";
            }
            else
            {
                return " ";
            }
        }
        else
        {
            return " ";
        }
    }



    private string getDateInddMMMyyyFormat(string strDate)
    {
        string[] strDateParts = strDate.Split('/');

        return strDateParts[0] + "-" + getShortMonthName(Convert.ToInt32(strDateParts[1])) + "-" + strDateParts[2];
    }

    private string getShortMonthName(int intMonth)
    {
        string strShortMonthName = "";

        switch (intMonth)
        {
            case 1:
                strShortMonthName = "Jan";
                break;
            case 2:
                strShortMonthName = "Feb";
                break;
            case 3:
                strShortMonthName = "Mar";
                break;
            case 4:
                strShortMonthName = "Apr";
                break;
            case 5:
                strShortMonthName = "May";
                break;
            case 6:
                strShortMonthName = "Jun";
                break;
            case 7:
                strShortMonthName = "Jul";
                break;
            case 8:
                strShortMonthName = "Aug";
                break;
            case 9:
                strShortMonthName = "Sep";
                break;
            case 10:
                strShortMonthName = "Oct";
                break;
            case 11:
                strShortMonthName = "Nov";
                break;
            case 12:
                strShortMonthName = "Dec";
                break;
        }

        return strShortMonthName;
    }
    protected void TextBox6_TextChanged(object sender, EventArgs e)
    {

        TextBox6.Text = TextBox6.Text.ToUpper();

        if (TextBox6.Text == "")
        {
            //lblErrorCity.Visible = false;
            return;
        }

        String strSQL = "";

        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        sqlConn.Open();

        strSQL = "Select location from webx_citymaster where location = '" + TextBox6.Text + "'";

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

        DataSet dsLocation = new DataSet();

        sqlDA.Fill(dsLocation);

        //lblErrorCity.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? true : false);

        if (dsLocation.Tables[0].Rows.Count > 0)
        {
            TextBox6.Focus();
        }

        sqlConn.Close();


    }
    protected void ddState_SelectedIndexChanged(object sender, EventArgs e)
    {
        hidState.Value = ddState.Text;
    }
    protected void Txt_User_TextChanged(object sender, EventArgs e)
    {
        var UserId = Txt_User.Text.Split('~');
        string Sql_Customer = "select MOBILENO from WebX_Master_Users where Status='100' and UserId='" + UserId[1].ToString() + "'";
        SqlCommand Comd_Customer = new SqlCommand(Sql_Customer, cn);
        SqlDataAdapter Da = new SqlDataAdapter(Comd_Customer);
        DataSet dsMobileNo = new DataSet();
        Da.Fill(dsMobileNo);
        if (dsMobileNo.Tables[0].Rows.Count > 0)
        {
            txtMob.Text = dsMobileNo.Tables[0].Rows[0]["MOBILENO"].ToString();
            txtMob.Enabled = false;
        }
    }
}
