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
using System.Text;

public partial class AddLoc : System.Web.UI.Page
{
    SqlConnection cn;
    public static string strToday;
    public static string strPayModePaid, scriptStr;
    public static string strPayModeTBB;
    public static string strPayModeToPay;
    public static string strPayModeFoc;
    public static string strPayModeBod;
    MyFunctions fn = new MyFunctions();
    public static string strPayType;
    //MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        fn.GetUser();
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (cn.State == ConnectionState.Closed)cn.Open();
        check();
        hidPayType.Value = "";

        umsgbox.Hide();
        lblError.Text = "";

        if (IsPostBack == false)
        {
            //strToday = System.DateTime.Today.ToString("dd/MM/yyyy");

            
            SqlCommand c1 = new SqlCommand("SELECT GETDATE() AS servdt", cn);
            DateTime d = (DateTime)c1.ExecuteScalar();
            strToday = d.ToString("dd/MM/yyyy");
            cn.Close();

            TextBox16.Attributes.Add("onblur", "javascript:return ValidateForm(this),chkdateloc(this)");//Location start date
            txtLocEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(this),chkdatelocend(this)");
            txtBkStrDt.Attributes.Add("onblur", "javascript:return ValidateForm(this),chkdatebkg(this)");
            txtBkEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txtdlStrDt.Attributes.Add("onblur", "javascript:return ValidateForm(this),chkdatebkg(this)");
            txtdlyEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txttransStrDT.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            txttransEndDt.Attributes.Add("onblur", "javascript:return ValidateForm(this)");
            ddLocHir.Items.Add("--Select--");
            ddRptTo.Items.Add("--Select--");
            ddRptLoc.Items.Add("--Select--");
            ddState.Items.Add("--Select--");
            ddRgLoc.Items.Add("--Select--");  

            chkComp.Checked = false;
            CheckBox2.Checked = true;
            chkDly.Checked = false;
            chktransOpr.Checked = false;
            chkUgd.Checked = false;
            chkBkOpr.Checked = false;
            trBooking.Visible = false;
            trDelivery.Visible = false;
            trTranship.Visible = false;

            //tblOper.Visible = false;

            //txtBkStrDt.Enabled = false;
            //txtBkEndDt.Enabled = false;

            //txtdlStrDt.Enabled = false;
            //txtdlyEndDt.Enabled = false;

            //txttransStrDT.Enabled = false;
            //txttransEndDt.Enabled = false;

            //Delivery.Visible = false;
            //booking.Visible = false;
            //Tranship.Visible = false;
                       
            TextBox15.Text = "N";
            txtActFlag.Text = "Y";
            txtBkOpr.Text = "N";
            TextBox26.Text = "N";
            txttransOpr.Text = "N";
            txtUgd.Text = "N";
            txtVol.Text = "N";
            txtCod.Text = "N";
            txtOda.Text = "N";
            TextBox3.Text = "N";
            txtRail.Text = "N";
            txtSea.Text = "N";
            txtCutOff.Text = "N";
            txtPickDor.Text = "N";
            txtPickGodwn.Text = "N";

            if (cn.State == ConnectionState.Closed)cn.Open();

            //string sqlstr = "Select level_type,level_no from webx_hierarchy where activeflag='Y' order by level_no asc";
            string sqlstr = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' order by level_no asc";
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                ddLocHir.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }
            dr.Close();
            string sqlstrst = "Select distinct stcd,stnm from webx_state order by stnm";
            SqlCommand cmdst = new SqlCommand(sqlstrst, cn);
            SqlDataReader drst = cmdst.ExecuteReader();
            while (drst.Read())
            {
                // ddState.Items.Add(new ListItem(drst.GetValue(0).ToString()));
                ddState.Items.Add(new ListItem(drst.GetValue(1).ToString(), drst.GetValue(0).ToString()));
            }
            drst.Close();

            string sqlzone = "Select codedesc as zonename,codeid as zonecode from webx_master_general where codetype='zone'";
            SqlCommand cmdzone = new SqlCommand(sqlzone, cn);
            SqlDataReader drzone = cmdzone.ExecuteReader();
            while (drzone.Read())
            {
                ddRgLoc.Items.Add(new ListItem(drzone.GetValue(0).ToString(), drzone.GetValue(1).ToString()));
            }
            drzone.Close();

            cn.Close();

            getPaymentType();

            hidPayType.Value = "";

            //if (chkBkOpr.Checked == false && chkDly.Checked == false && chktransOpr.Checked == false)
            //{
            //    tblOper.Visible = false;
            //}

            ddLocHir.Focus();


        }
        
    }
    public string Locationstr,Citystr;
    public void check()
    {
        Locationstr = fn.getLocationStr();
        getLocationStr();
        getAllCityStr(); 
        txtLocCod.Attributes.Add("onblur", "javascript:return Locationcheck(" + txtLocCod.ClientID + ")");
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
        if (ddLocHir.SelectedIndex == 0)
        {
            ddRptTo.Items.Clear();
            ddRptTo.Items.Add("--Select--");
            ddRptLoc.Items.Clear();
            ddRptLoc.Items.Add("--Select--");
        }
       // else if (ddLocHir.SelectedItem.ToString() == "HEAD OFFICE" || ddLocHir.SelectedItem.ToString() == "Head Office")
        else
        {
            ddRptTo.Items.Clear();
            ddRptTo.Items.Add("--Select--");
            if (cn.State == ConnectionState.Closed)cn.Open();
            //string nwsqlstr1 = "Select level_type,level_no from webx_hierarchy where level_no='1'"; //" + ddLocHir.SelectedValue.ToString() + "'";
            string nwsqlstr1 = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' order by level_no asc";
            SqlCommand cmd1 = new SqlCommand(nwsqlstr1, cn);
            SqlDataReader nwdr1 = cmd1.ExecuteReader();
            //ddRptTo.Items.Clear();
            while (nwdr1.Read())
            {

                ddRptTo.Items.Add(new ListItem(nwdr1.GetValue(0).ToString(), nwdr1.GetValue(1).ToString()));
            }
            nwdr1.Close();
            cn.Close();

            ddRptLoc.Items.Clear();
            ddRptLoc.Items.Add("--Select--");
            if (cn.State == ConnectionState.Closed)cn.Open();
            string nwsqlstr = "Select  LocName + ' : ' + LocCode,LocCode,* from webx_Location where activeflag='Y' and  Loc_Level='1'";  //" + ddRptTo.SelectedValue.ToString() + "'";
            SqlCommand nwcmd = new SqlCommand(nwsqlstr, cn);
            SqlDataReader nwdr = nwcmd.ExecuteReader();
            while (nwdr.Read())
              {
                ddRptLoc.Items.Add(new ListItem(nwdr.GetValue(0).ToString(),nwdr.GetValue(1).ToString()));
              }
            nwdr.Close();
            cn.Close();
        }
        //else
        //{
        //    ddRptTo.Items.Clear();
        //    ddRptTo.Items.Add("--Select--");
        //    if (cn.State == ConnectionState.Closed)cn.Open();
        //    //string sqlstr1 = "Select level_type,level_no from webx_hierarchy where level_no<'" + ddLocHir.SelectedValue.ToString() + "'";
        //    string sqlstr1 = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' and codeid<='" + ddLocHir.SelectedValue.ToString() + "'";
        //    SqlCommand cmd1 = new SqlCommand(sqlstr1, cn);
        //    SqlDataReader dr1 = cmd1.ExecuteReader();
            
        //    while (dr1.Read())
        //    {

        //        ddRptTo.Items.Add(new ListItem(dr1.GetValue(0).ToString(), dr1.GetValue(1).ToString()));
        //    }
        //    dr1.Close();
        //    cn.Close();

        //    ddRptLoc.Items.Clear();
        //    ddRptLoc.Items.Add("--Select--");
        //    if (cn.State == ConnectionState.Closed)cn.Open();
        //    string nwsqlstr = "Select distinct LocName + ' : ' + LocCode,LocCode from webx_Location where Loc_Level='" + ddLocHir.SelectedValue.ToString() + "'";  //" + ddRptTo.SelectedValue.ToString() + "'";
        //    //                "Select distinct LocName + ' : ' + LocCode from webx_Location where Loc_Level='" + ddHir.SelectedValue.ToString() + "'"
        //    SqlCommand nwcmd = new SqlCommand(nwsqlstr, cn);
        //    SqlDataReader nwdr = nwcmd.ExecuteReader();
            
        //    while (nwdr.Read())
        //    {
        //        ddRptLoc.Items.Add(new ListItem(nwdr.GetValue(0).ToString(), nwdr.GetValue(1).ToString()));
        //    }
        //    nwdr.Close();
        //    cn.Close();
        //}
    }
    protected void ddRptTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddRptTo.SelectedValue.ToString() == "8")
        {
            ddRptLoc.Items.Clear();
            ddRptLoc.Items.Add("--Select--");
            if (cn.State == ConnectionState.Closed)cn.Open();
            //string mynwsqlstr1 = "Select level_type,level_no from webx_hierarchy where level_no='1'"; //" + ddLocHir.SelectedValue.ToString() + "'";

            //string mynwsqlstr1 = "Select codedesc as level_type,codeid as level_no from webx_master_general where  codetype='hrchy' and  statuscode='Y' and codeid='1'";

            string mynwsqlstr1 = "Select  LocName + ' : ' + LocCode,LocCode,* from webx_Location where activeflag='Y' and  Loc_Level='1'";
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
            ddRptLoc.Items.Clear();
            ddRptLoc.Items.Add("--Select--");
            if (cn.State == ConnectionState.Closed)cn.Open();
            string sqlstr2 = "Select distinct LocName + ' : ' + LocCode,Loccode from webx_Location where Loc_Level='" + ddRptTo.SelectedValue.ToString() + "' and activeflag='Y'";
            SqlCommand cmd2 = new SqlCommand(sqlstr2, cn);
            SqlDataReader dr2 = cmd2.ExecuteReader();
            //ddRptLoc.Items.Clear();
            while (dr2.Read())
            {
                ddRptLoc.Items.Add(new ListItem(dr2.GetValue(0).ToString(), dr2.GetValue(1).ToString()));
            }
            dr2.Close();
            cn.Close();
        }
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
            //booking.Visible = true;
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
            //booking.Visible = false;
            trBooking.Visible = false; 
            pay.Visible = false;
            Service.Visible = false;
            bkOpr.Visible = false;
            for (int i = 0; i < ChkListPayType.Items.Count; i++)
            {
                ChkListPayType.Items[i].Selected = false;
            }
        }

        //if (chkBkOpr.Checked == false && chkDly.Checked == false && chktransOpr.Checked == false)
        //{
        //    tblOper.Visible = false;
        //}
    }

    protected void chktransOpr_CheckedChanged(object sender, EventArgs e)
    {
        if (chktransOpr.Checked == true)
        {
            txttransOpr.Text = "Y";
            trTranship.Visible = true;
            //txttransStrDT.Enabled = true;
            //txttransEndDt.Enabled = true;
            //Tranship.Visible = true;
        }
        else
        {
            trTranship.Visible = false;
            txttransOpr.Text = "N";
            //txttransStrDT.Enabled = false;
            //txttransEndDt.Enabled = false;
            //Tranship.Visible = false;
        }

        //if (chkBkOpr.Checked == false && chkDly.Checked == false && chktransOpr.Checked == false)
        //{
        //    tblOper.Visible = false;
        //}
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
            //Delivery.Visible = true;
        }
        else
        {
            TextBox26.Text = "N";
            trDelivery.Visible = false;
            //txtdlStrDt.Enabled = false;
            //txtdlyEndDt.Enabled = false;
            //Delivery.Visible = false;
        }

        //if (chkBkOpr.Checked == false && chkDly.Checked == false && chktransOpr.Checked == false)
        //{
        //    tblOper.Visible = false;
        //}
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

    private void getPaymentType()
    {
        
        if (cn.State == ConnectionState.Closed)cn.Open();
        //SqlCommand cmd = new SqlCommand("Select distinct codeid as CodeType_New,codedesc as Abbr_Type,statuscode as ActiveFlag from webx_master_general where left(codeid,1)='P' and codetype='PAYTYP' Order By CodeType_New",cn);
        SqlCommand cmd = new SqlCommand("Select distinct codeid as CodeType_New,codedesc as Abbr_Type,statuscode as ActiveFlag from webx_master_general where left(codeid,1)='P' and codetype='PAYTYP' Order By CodeType_New", cn);
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
                if(dsPay.Tables[0].Rows[i]["ActiveFlag"].ToString() == "Y") 
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try {
        string[] strReportLocCode = ddRptLoc.SelectedValue.Split(':');
		string Bank=txtBank.Text;
        string Bankcode = Bank.Split(':')[0];

        //if (chkBkOpr.Checked == false)
        //{
        //    if (cn.State == ConnectionState.Closed)cn.Open();

        //    //txtLocEndDt.Text
            
        //    string spsql = "webx_LocMst";
        //    SqlCommand spcmd = new SqlCommand(spsql, cn);
        //    spcmd.CommandType = CommandType.StoredProcedure;

        //    spcmd.Parameters.Add("@dLocHir", SqlDbType.Int).Value = Convert.ToInt32(ddLocHir.SelectedValue);
        //    spcmd.Parameters.Add("@dRptTo", SqlDbType.Int).Value = Convert.ToInt32(ddRptTo.SelectedValue);
        //    spcmd.Parameters.Add("@dRptLoc", SqlDbType.VarChar).Value = strReportLocCode[1].Trim();
        //    spcmd.Parameters.Add("@tLocCod", SqlDbType.VarChar).Value = txtLocCod.Text.ToString();
        //    spcmd.Parameters.Add("@tLocNm", SqlDbType.VarChar).Value = txtLocNm.Text.ToString();
        //    spcmd.Parameters.Add("@tAdd", SqlDbType.VarChar).Value = txtAdd.Text.ToString();
        //    spcmd.Parameters.Add("@dState", SqlDbType.VarChar).Value = ddState.SelectedValue.ToString();
        //    spcmd.Parameters.Add("@TBox6", SqlDbType.VarChar).Value = TextBox6.Text.ToString();
        //    spcmd.Parameters.Add("@tPin", SqlDbType.VarChar).Value = txtPin.Text.ToString();
        //    spcmd.Parameters.Add("@tCNCod", SqlDbType.VarChar).Value = txtCNCod.Text.ToString();
        //    spcmd.Parameters.Add("@tStdCod", SqlDbType.VarChar).Value = txtStdCod.Text.ToString();
        //    spcmd.Parameters.Add("@tTel", SqlDbType.VarChar).Value = txtTel.Text.ToString();
        //    spcmd.Parameters.Add("@tFax", SqlDbType.VarChar).Value = txtFax.Text.ToString();
        //    spcmd.Parameters.Add("@tMob", SqlDbType.VarChar).Value = txtMob.Text.ToString();
        //    spcmd.Parameters.Add("@tEmail", SqlDbType.VarChar).Value = txtEmail.Text.ToString();
            
        //    spcmd.Parameters.Add("@dRgLoc", SqlDbType.VarChar).Value = ddRgLoc.SelectedValue.ToString();
        //    spcmd.Parameters.Add("@tAcLoc", SqlDbType.VarChar).Value = txtAcLoc.Text.ToString();
        //    spcmd.Parameters.Add("@TBox15", SqlDbType.VarChar).Value = TextBox15.Text.ToString();
        //    spcmd.Parameters.Add("@tDataLoc", SqlDbType.VarChar).Value = txtDataLoc.Text.ToString();
            
        //    if (TextBox16.Text != "")
        //    {
        //        spcmd.Parameters.Add("@TBox16", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(TextBox16.Text);
        //    }
            
        //    if (txtLocEndDt.Text != "")
        //    {
        //        spcmd.Parameters.Add("@tLocEndDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtLocEndDt.Text);
        //    }

        //    spcmd.Parameters.Add("@tActFlag", SqlDbType.VarChar).Value = txtActFlag.Text.ToString();
        //    spcmd.Parameters.Add("@tBkOpr", SqlDbType.VarChar).Value = txtBkOpr.Text.ToString();
        //    spcmd.Parameters.Add("@TBox26", SqlDbType.VarChar).Value = TextBox26.Text.ToString();
        //    spcmd.Parameters.Add("@ttransOpr", SqlDbType.VarChar).Value = txttransOpr.Text.ToString();

        //    if (txtBkStrDt.Text != "")
        //    {
        //        spcmd.Parameters.Add("@tBkStrDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtBkStrDt.Text);
        //    }

        //    if (txtBkEndDt.Text != "")
        //    {
        //        spcmd.Parameters.Add("@tBkEndDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtBkEndDt.Text);
        //    }
        //    if (ddLocOnr.SelectedItem.Text != "--Select--")
        //    {
        //        spcmd.Parameters.Add("@dLocOnr", SqlDbType.VarChar).Value = ddLocOnr.SelectedValue;
        //    }

        //    if (txtdlStrDt.Text != "")
        //    {
        //        spcmd.Parameters.Add("@tdlStrDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtdlStrDt.Text);
        //    }
            
        //    if (txtdlyEndDt.Text != "")
        //    {
        //        spcmd.Parameters.Add("@tdlyEndDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtdlyEndDt.Text);
        //    }
            
        //    spcmd.Parameters.Add("@tUgd", SqlDbType.VarChar).Value = txtUgd.Text.ToString();
            
        //    if (txttransStrDT.Text != "")
        //    {
        //        spcmd.Parameters.Add("@ttransStrDT", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txttransStrDT.Text);
        //    }
            
        //    if (txttransEndDt.Text != "")
        //    {
        //        spcmd.Parameters.Add("@ttransEndDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txttransEndDt.Text);
        //    }

        //    spcmd.Parameters.Add("@tNxtLoc", SqlDbType.VarChar).Value = txtNxtLoc.Text.ToString();
        //    spcmd.Parameters.Add("@tNrPrLoc", SqlDbType.VarChar).Value = txtNrPrLoc.Text.ToString(); 

        //    spcmd.ExecuteNonQuery();

        //    cn.Close();

        //    Response.Redirect("LocationEdSelect.aspx");

        //}
        //else
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
            if (txtCashlimit.Text == "")
            {
                txtCashlimit.Text = "0";
            }
            loc_startdt = fn.Mydate(TextBox16.Text);
            LocEndDt = fn.Mydate(txtLocEndDt.Text);
            BkStrDt = fn.Mydate(txtBkStrDt.Text);
            BkEndDt = fn.Mydate(txtBkEndDt.Text);
            dlStrDt = fn.Mydate(txtdlStrDt.Text);
            dlyEndDt = fn.Mydate(txtdlyEndDt.Text);
            transStrDT = fn.Mydate(txttransStrDT.Text);
            transEndDt = fn.Mydate(txttransEndDt.Text);
            var UserId = Txt_User.Text.Split('~');
            string hPayTypeStr = hidden_PayTypeStr.Value;
            string CPayTypeStr = PayTypeStr;
            string sqlinsert = "Insert into webx_location (Loc_Level, Report_Level, LocCode, LocName, Report_Loc, LocAddr, LocState, LocCity, LocPinCode, CashLimit, LOCSTDCode, LocTelNo, LocFaxNo, LocMobile, LOCEmail, LOC_Account, ActiveFlag,LocRegion,Computerised,Dataentry,loc_startdt,loc_enddt,UPDTBY,UPDTON, Payment_Type,Vol,COD_DOD,ODA,op_bkg,op_dly,op_tranship,OutSource_Own,Default_NextLoc,Nearest_PrevLoc,Op_StartDt,Op_EndDt,Dly_StartDt,Dly_EndDt,Transshipment_StartDt,Transshipment_EndDt,CPC,Op_UGD,octroi_io,CN_Prefixcode,BilledAt,BankLedger,UserName)values(" + ddLocHir.Text + "," + ddRptTo.Text + ",'" + txtLocCod.Text.Replace("'", "''") + "','" + txtLocNm.Text.Replace("'", "''") + "','" + ddRptLoc.Text + "','" + txtAdd.Text.Replace("'", "''") + "','" + ddState.Text + "','" + TextBox6.Text.Replace("'", "''") + "','" + txtPin.Text.Replace("'", "''") + "','" + Convert.ToDecimal(txtCashlimit.Text) + "','" + txtStdCod.Text.Replace("'", "''") + "','" + txtTel.Text.Replace("'", "''") + "','" + "" + "','" + txtMob.Text.Replace("'", "''") + "','" + txtEmail.Text.Replace("'", "''") + "','" + txtAcLoc.Text.Replace("'", "''") + "','" + txtActFlag.Text.Replace("'", "''") + "','" + ddRgLoc.Text + "','" + TextBox15.Text.Replace("'", "''") + "','" + txtDataLoc.Text.Replace("'", "''") + "','" + loc_startdt + "','" + LocEndDt + "','" + Convert.ToString(Session["empcd"]) + "',getdate(),'" + hPayTypeStr + "','" + txtVol.Text.Replace("'", "''") + "','" + txtCod.Text.Replace("'", "''") + "','" + txtOda.Text.Replace("'", "''") + "','" + txtBkOpr.Text.Replace("'", "''") + "','" + TextBox26.Text.Replace("'", "''") + "','" + txttransOpr.Text.Replace("'", "''") + "','" + ddLocOnr.Text + "','" + txtNxtLoc.Text.Replace("'", "''") + "','" + txtNrPrLoc.Text.Replace("'", "''") + "','" + BkStrDt + "','" + BkEndDt + "','" + dlStrDt + "','" + dlyEndDt + "','" + transStrDT + "','" + transEndDt + "','','" + txtUgd.Text.Replace("'", "''") + "','" + DropDownList1.Text + "','" + txtCNCod.Text.Replace("'", "''") + "','" + TextBox11.Text.Replace("'", "''") + "','" + Bankcode + "','" + UserId[1].ToString() + "')";
            SqlCommand cmd = new SqlCommand(sqlinsert, cn);
            cmd.ExecuteNonQuery(); 

            //string spsql = "webx_LocMst_all";
            //SqlCommand spcmd = new SqlCommand(spsql, cn);
            //spcmd.CommandType = CommandType.StoredProcedure;

            //spcmd.Parameters.Add("@dLocHir", SqlDbType.Int).Value = Convert.ToInt32(ddLocHir.SelectedValue);
            //spcmd.Parameters.Add("@dRptTo", SqlDbType.Int).Value = Convert.ToInt32(ddRptTo.SelectedValue);
            //spcmd.Parameters.Add("@dRptLoc", SqlDbType.VarChar).Value = strReportLocCode[1].Trim();
            //spcmd.Parameters.Add("@tLocCod", SqlDbType.VarChar).Value = txtLocCod.Text.ToString();
            //spcmd.Parameters.Add("@tLocNm", SqlDbType.VarChar).Value = txtLocNm.Text.ToString();
            //spcmd.Parameters.Add("@tAdd", SqlDbType.VarChar).Value = txtAdd.Text.ToString();
            //spcmd.Parameters.Add("@dState", SqlDbType.VarChar).Value = ddState.SelectedValue.ToString();
            //spcmd.Parameters.Add("@TBox6", SqlDbType.VarChar).Value = TextBox6.Text.ToString();
            //spcmd.Parameters.Add("@tPin", SqlDbType.VarChar).Value = txtPin.Text.ToString();
            //spcmd.Parameters.Add("@tCNCod", SqlDbType.VarChar).Value = txtCNCod.Text.ToString();
            //spcmd.Parameters.Add("@tStdCod", SqlDbType.VarChar).Value = txtStdCod.Text.ToString();
            //spcmd.Parameters.Add("@tTel", SqlDbType.VarChar).Value = txtTel.Text.ToString();
            //spcmd.Parameters.Add("@tFax", SqlDbType.VarChar).Value = txtFax.Text.ToString();
            //spcmd.Parameters.Add("@tMob", SqlDbType.VarChar).Value = txtMob.Text.ToString();
            //spcmd.Parameters.Add("@tEmail", SqlDbType.VarChar).Value = txtEmail.Text.ToString();

            //spcmd.Parameters.Add("@dRgLoc", SqlDbType.VarChar).Value = ddRgLoc.SelectedValue.ToString();
            //spcmd.Parameters.Add("@tAcLoc", SqlDbType.VarChar).Value = txtAcLoc.Text.ToString();
            //spcmd.Parameters.Add("@TBox15", SqlDbType.VarChar).Value = TextBox15.Text.ToString();
            //spcmd.Parameters.Add("@tDataLoc", SqlDbType.VarChar).Value = txtDataLoc.Text.ToString();
            //if (TextBox16.Text != "")
            //{
            //    spcmd.Parameters.Add("@TBox16", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(TextBox16.Text);
            //}

            //if (txtLocEndDt.Text != "")
            //{
            //    spcmd.Parameters.Add("@tLocEndDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtLocEndDt.Text);
            //}

            //spcmd.Parameters.Add("@tActFlag", SqlDbType.VarChar).Value = txtActFlag.Text.ToString();
            //spcmd.Parameters.Add("@tBkOpr", SqlDbType.VarChar).Value = txtBkOpr.Text.ToString();
            //spcmd.Parameters.Add("@TBox26", SqlDbType.VarChar).Value = TextBox26.Text.ToString();
            //spcmd.Parameters.Add("@ttransOpr", SqlDbType.VarChar).Value = txttransOpr.Text.ToString();
            
            //if (txtBkStrDt.Text != "")
            //{
            //    spcmd.Parameters.Add("@tBkStrDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtBkStrDt.Text);
            //}

            //if (txtBkEndDt.Text != "")
            //{
            //    spcmd.Parameters.Add("@tBkEndDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtBkEndDt.Text);
            //}
            
            ////spcmd.Parameters.Add("@dLocOnr", SqlDbType.VarChar).Value = ddLocOnr.SelectedValue;

            //if (txtdlStrDt.Text != "")
            //{
            //    spcmd.Parameters.Add("@tdlStrDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtdlStrDt.Text);
            //}

            //if (txtdlyEndDt.Text != "")
            //{
            //    spcmd.Parameters.Add("@tdlyEndDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txtdlyEndDt.Text);
            //}
            
            //spcmd.Parameters.Add("@tUgd", SqlDbType.VarChar).Value = txtUgd.Text.ToString();

            //if (txttransStrDT.Text != "")
            //{
            //    spcmd.Parameters.Add("@ttransStrDT", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txttransStrDT.Text);
            //}

            //if (txttransEndDt.Text != "")
            //{
            //    spcmd.Parameters.Add("@ttransEndDt", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(txttransEndDt.Text);
            //}

            //spcmd.Parameters.Add("@tNxtLoc", SqlDbType.VarChar).Value = txtNxtLoc.Text.ToString();
            //spcmd.Parameters.Add("@tNrPrLoc", SqlDbType.VarChar).Value = txtNrPrLoc.Text.ToString(); 


            //spcmd.Parameters.Add("@PayType", SqlDbType.VarChar).Value = hidPayType.Value;
            
            ////spcmd.Parameters.Add("@tdlyEndDt", SqlDbType.DateTime).Value = txtdlyEndDt.Text.ToString();
            ////spcmd.Parameters.Add("@tUgd", SqlDbType.VarChar).Value = txtUgd.Text.ToString();
            ////spcmd.Parameters.Add("@ttransStrDT", SqlDbType.DateTime).Value = txttransStrDT.Text.ToString();
            ////spcmd.Parameters.Add("@ttransEndDt", SqlDbType.DateTime).Value = txttransEndDt.Text.ToString();
            //spcmd.Parameters.Add("@tVol", SqlDbType.VarChar).Value = txtVol.Text.ToString();
            //spcmd.Parameters.Add("@tCod", SqlDbType.VarChar).Value = txtCod.Text.ToString();
            //spcmd.Parameters.Add("@tOda", SqlDbType.VarChar).Value = txtOda.Text.ToString();
            //spcmd.Parameters.Add("@dd1", SqlDbType.VarChar).Value = DropDownList1.SelectedValue.ToString();
            //spcmd.Parameters.Add("@TBox3", SqlDbType.VarChar).Value = TextBox3.Text.ToString();
            //spcmd.Parameters.Add("@tRail", SqlDbType.VarChar).Value = txtRail.Text.ToString();
            //spcmd.Parameters.Add("@tSea", SqlDbType.DateTime).Value = txtSea.Text.ToString();
            ////spcmd.Parameters.Add("@LB1", SqlDbType.VarChar).Value = ListBox1.SelectedItem.ToString();
            //spcmd.Parameters.Add("@tCutOff", SqlDbType.VarChar).Value = txtCutOff.Text.ToString();
            
            //if (TextBox8.Text != "")
            //{
            //    spcmd.Parameters.Add("@TBox8", SqlDbType.DateTime).Value = getDateInddMMMyyyFormat(TextBox8.Text);
            //}

            //spcmd.Parameters.Add("@tPickDor", SqlDbType.VarChar).Value = txtPickDor.Text.ToString();
            //spcmd.Parameters.Add("@tPickGodwn", SqlDbType.VarChar).Value = txtPickGodwn.Text.ToString();
            //spcmd.Parameters.Add("@TBox11", SqlDbType.VarChar).Value = TextBox11.Text.ToString();
            //spcmd.Parameters.Add("@dLocOnr", SqlDbType.VarChar).Value = TextBox11.Text.ToString();
            //spcmd.ExecuteNonQuery();

            //cn.Close();

            Response.Redirect("LocationEdSelect.aspx");
        //}
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
            umsgbox.Show(ex.Message);
            return;
        }
  
    }
    //protected void txtLocCod_TextChanged(object sender, EventArgs e)
    //    {
    //    txtLocCod.Text = txtLocCod.Text.ToUpper();

    //    if (txtLocCod.Text == "")
    //    {
    //        lblErrorLocation.Visible = false;
    //        return;
    //    }

    //    String strSQL = "";

    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    strSQL = "Select LocCode FROM webx_location WHERE LocCode = '" + txtLocCod.Text + "'";

    //    SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
    //    SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //    DataSet dsLocation = new DataSet();

    //    sqlDA.Fill(dsLocation);

    //    lblErrorLocation.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? true : false);

    //    if (dsLocation.Tables[0].Rows.Count > 0)
    //    {
    //        txtLocCod.Focus();
    //    }

    //    sqlConn.Close();
    //}

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
    //protected void TextBox6_TextChanged(object sender, EventArgs e)
    //{
    //    TextBox6.Text = TextBox6.Text.ToUpper();

    //    if (TextBox6.Text == "")
    //    {
    //        lblErrorCity.Visible = false;
    //        return;
    //    }

    //    String strSQL = "";

    //    SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

    //    sqlConn.Open();

    //    strSQL = "Select location from webx_citymaster where location = '" + TextBox6.Text + "'";

    //    SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
    //    SqlDataAdapter sqlDA = new SqlDataAdapter(sqlCommand);

    //    DataSet dsLocation = new DataSet();

    //    sqlDA.Fill(dsLocation);

    //    lblErrorCity.Visible = (dsLocation.Tables[0].Rows.Count > 0 ? true : false);

    //    if (dsLocation.Tables[0].Rows.Count > 0)
    //    {
    //        TextBox6.Focus();
    //    }

    //    sqlConn.Close();
    //}
    static string PayTypeStr;
    protected void ChkListPayType_SelectedIndexChanged(object sender, EventArgs e)
    {
        PayTypeStr = "";
        for (int i = 0; i < ChkListPayType.Items.Count; i++)
        {
            if (ChkListPayType.Items[i].Selected == true)
            {
                PayTypeStr = PayTypeStr +","+ ChkListPayType.Items[i].Value.ToString().Trim();    
            }
        }
        if (PayTypeStr.Length != 0)
        {
            PayTypeStr = PayTypeStr.Substring(1, PayTypeStr.Length - 1);
        }
            hidden_PayTypeStr.Value = PayTypeStr;
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
