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

public partial class GUI_admin_VehicleMaster_VehicleMasterEdit : System.Web.UI.Page
{
    SqlConnection cn;  // = new SqlConnection(ConfigurationManager.AppSettings["dbConn"].ToString());
    public static string strTVhclNo;
    public static string strDVhclNo;
    public static string strToday;
    protected void Page_Load(object sender, EventArgs e)
    {
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        strToday = System.DateTime.Today.ToString("dd/MM/yyyy");
        getstring();
        btnSubmit.Attributes.Add("onclick", "javascript:return Chk(" + ddVehicleType.ClientID + "," + ddVndrNm.ClientID + "," + lstPermitStates.ClientID + "," + lstRut.ClientID + "," + txtVhclInsuranceDt.ClientID + "," + txtFitnessDt.ClientID + "," + btnSubmit.ClientID + ")");
        if (IsPostBack == false)
        {

            strTVhclNo = Session["ssTVhclNo"].ToString().Trim();
            strDVhclNo = Session["ssDVhclNo"].ToString().Trim();

            if (strTVhclNo != "")
            {
                lblVhclNo.Text = strTVhclNo;
            }
            else
            {
                lblVhclNo.Text = Convert.ToString(Session["vehno"]);//strDVhclNo; 
            }
 
            //ddVehicleType.Items.Add("--Select--");
            ddVndrNm.Items.Add("--Select--");

            
            SqlCommand cmdddVndrNm = new SqlCommand("select VENDORNAME,vendorcode from webx_VENDOR_HDR order by VENDORNAME", cn);
            SqlDataReader drddVndrNm = cmdddVndrNm.ExecuteReader();
            while (drddVndrNm.Read())
            {
                ddVndrNm.Items.Add(new ListItem(drddVndrNm.GetValue(0).ToString(), drddVndrNm.GetValue(1).ToString()));
            }
            drddVndrNm.Close();


            ddVehicleType.Items.Clear();
            string strSQL = "Select Type_Code, [Type_Name] AS VehicleType From webx_vehicle_type";
            SqlCommand cmdVhclType = new SqlCommand(strSQL, cn);
            SqlDataAdapter daVhclType = new SqlDataAdapter(cmdVhclType);
            DataSet dsVehicleType = new DataSet();
            daVhclType.Fill(dsVehicleType);
            //if (dsVehicleType.Tables[0].Rows.Count > 0)
            //{

                ddVehicleType.DataTextField = "VehicleType";
                ddVehicleType.DataValueField = "Type_Code";
                ddVehicleType.DataSource = dsVehicleType;
                ddVehicleType.DataBind();
            //}
            ddVehicleType.Items.Insert(0, new ListItem("--Select--", "-1"));


            SqlCommand cmdlstPermit = new SqlCommand("select distinct STNM as StatePermit, STCD from webx_STATE order by STNM", cn);
            SqlDataAdapter dalstPermit = new SqlDataAdapter(cmdlstPermit);
            DataSet dslstPermit = new DataSet();
            dalstPermit.Fill(dslstPermit);
            //if (dslstPermit.Tables[0].Rows.Count > 0)
            //{
                lstPermitStates.DataSource = dslstPermit;
                lstPermitStates.DataTextField = "StatePermit";
                lstPermitStates.DataValueField = "STCD";
                lstPermitStates.DataBind();
            //}
            lstPermitStates.Items.Insert(0, new ListItem("National Permit", "A"));

            SqlCommand cmdlstRut = new SqlCommand("select distinct(RUTCD + ' : ' + RUTNM) as Rut,rutcd from webx_RUTMAS where RUTNM is not Null order by Rut,rutcd", cn);
            SqlDataAdapter dalstRut = new SqlDataAdapter(cmdlstRut);
            DataSet dslstRut = new DataSet();
            dalstRut.Fill(dslstRut);
            //if (dslstRut.Tables[0].Rows.Count > 0)
            //{
                lstRut.DataSource = dslstRut;
                lstRut.DataTextField = "Rut";
                lstRut.DataValueField = "Rutcd";
                lstRut.DataBind();
            //}
            popVentype();
            cn.Close();

            getData();
        }
        string js = "<script language =\"javascript\" type=\"text/javascript\">document.getElementById(\"ctl00_MyCPH1_txtPayload\").disabled = true</script>";
        Page.RegisterStartupScript("abc", js);
    }
    public void popVentype()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from webx_VENDOR_type union select type_name + ' : ' + type_code as a, type_code as b from webx_VENDOR_type  where type_code in (2,3,5,8)";
        string sqldd = "select top 1 '-- Select --' as a,'-- Select --' as b from  webx_master_general union select codedesc + ' : ' + codeid as a, codeid as b from  webx_master_general where codetype='VENDTY' and codeid in ('02','03','05','08')";
        SqlCommand cmd = new SqlCommand(sqldd, cn);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        cmbvendortype.DataSource = ds;
        cmbvendortype.DataTextField = "a";
        cmbvendortype.DataValueField = "b";
        cmbvendortype.DataBind();

    }
    private void getstring()
    {
        //holidaystr = "";
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
    string state,route;
    public void getData()
    {
        string sql;
        cn.Open();
        if (strTVhclNo != "")
        {
            sql = "select * from webx_VEHICLE_HDR where vehno='" + strTVhclNo + "'";
        }
        else
        {
            sql = "select * from webx_VEHICLE_HDR where vehno='" + Convert.ToString(Session["vehno"]) + "'";
        }

        SqlCommand cmd = new SqlCommand(sql, cn);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            cmbvendortype.Text = Convert.ToString(dr["VENDORTYPE"]);
            ddVehicleType.Text = dr["vehicle_type"].ToString();
            ddVndrNm.Text = dr["VENDORCODE"].ToString();
            //ddTonnage.SelectedValue = dr["VEHTONS"].ToString();
            //lstPermitStates.Text = dr["VEHPERMIT"].ToString();
            state = Convert.ToString(dr["VEHPERMIT"]);
            route = Convert.ToString(dr["VEHROUTECD"]);
            Array a1, a2;
            a1 = state.Split(',');
            a2 = route.Split(',');   
            //((string[])(str))[0] + " " + ((string[])(str))[2];
            for (int i = 0; i < a1.Length; i++)
            {
                String strelement = ((string[])(a1))[i];
                for(int j=0; j<lstPermitStates.Items.Count;j++)
                {
                    if(lstPermitStates.Items[j].Value.Trim() == strelement.Trim())
                    {
                        lstPermitStates.Items[j].Selected = true;   
                    }
                }
            }

            for (int i = 0; i < a2.Length; i++)
            {
                String strelement = ((string[])(a2))[i];
                for (int j = 0; j < lstRut.Items.Count; j++)
                {
                    if (lstRut.Items[j].Value.Trim() == strelement.Trim())
                    {
                        lstRut.Items[j].Selected = true;
                    }
                }
            }
                //lstRut.Text = dr["VEHROUTECD"].ToString();
                //txtMadeBy.Text = dr["VEHMADEBY"].ToString();
            //txtModel.Text = dr["VEHMODEL"].ToString();
            txtRcBookNo.Text = dr["VEHRCBKNO"].ToString();
            txtRgnNo.Text = dr["VEHREGNO"].ToString();
            string vehregdt = dr["VEHREGDT"].ToString();
            txtRgnDt.Text = (vehregdt == "" || vehregdt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vehregdt).ToString("dd/MM/yyyy"));
                //dr["VEHREGDT"].ToString();
            txtChasisNo.Text = dr["VEHCHASISNO"].ToString();
            txtEngineNo.Text = dr["VEHENGINENO"].ToString();
            string vhclInsDt = dr["Insurance_Validity_Date"].ToString();
            txtVhclInsuranceDt.Text = (vhclInsDt == "" || vhclInsDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclInsDt).ToString("dd/MM/yyyy"));
            string vhclFitnessDt = dr["Fitness_Validity_Date"].ToString();
            txtFitnessDt.Text = (vhclFitnessDt == "" || vhclFitnessDt.ToUpper() == "NULL" ? "" : Convert.ToDateTime(vhclFitnessDt).ToString("dd/MM/yyyy"));
            txtActFlag.Text = dr["ACTIVEFLAG"].ToString();
            txtCntrlBranch.Text = dr["Conrtl_branch"].ToString();
            //ddVhclCategory.Text = dr["VEHT_CAT"].ToString();
            txtDrivers.Text = dr["Drivers"].ToString();
            txtLength.Text = dr["length"].ToString();
            txtWidth.Text = dr["width"].ToString();
            txtHeight.Text = dr["Height"].ToString();
            txtGVW.Text = dr["GVW"].ToString();
            txtUnladen.Text = dr["Unld_Wt"].ToString();
            txtPayload.Text = dr["Payload"].ToString();
            txtRate.Text = dr["rate_km"].ToString();
            if (txtActFlag.Text == "Y")
            {
                c1.Checked = true; 
            }
            txtCapacity.Text = Convert.ToString(dr["capacity"]);
        }
        dr.Close();
        cn.Close();
    }
    protected void c1_CheckedChanged(object sender, EventArgs e)
    {
        if (c1.Checked == true)
        {
            txtActFlag.Text = "Y";
        }
        else
        {
            txtActFlag.Text = "N";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //if (Convert.ToDateTime(txtFitnessDt.Text) < System.DateTime.Today)
        //{
        //    lblMsg.Text = "Please insert date after current date in Fitness Certificate Date";
        //    lblMsg.Focus();
        //}
        //else
        //    if (Convert.ToDateTime(txtVhclInsuranceDt.Text) < System.DateTime.Today)
        //    {
        //        lblMsg.Text = "Please insert date after current date in Vehicle Insurance Date";
        //        lblMsg.Focus();
        //    }
        //else
        //{
            string a;
            int j = 1;
            a = "";
            for (int i = 0; i < lstRut.Items.Count; i++)
            {
                if (lstRut.Items[i].Selected == true)
                {
                    Array Ar;
                    if (j == 1)
                    {

                        Ar = lstRut.Items[i].Text.Split(':');
                        a = ((string[])(Ar))[0].Trim();
                        j += 1;
                    }
                    else
                    {
                        j += 1;
                        Ar = lstRut.Items[i].Text.Split(':');

                        a = a + "," + ((string[])(Ar))[0].Trim();
                    }
                }
            }

            string b = "";
            int k = 1;
            for (int l = 0; l < lstPermitStates.Items.Count; l++)
            {
                if (lstPermitStates.Items[l].Selected == true)
                {

                    if (k == 1)
                    {
                        //ar1 = lstPermitStates.Items[l].Text.Split(':');
                        b = lstPermitStates.Items[l].Value;
                        k += 1;
                    }
                    else
                    {
                        k += 1;
                        //ar1 = lstPermitStates.Items[l].Text.Split(':');

                        b = b + "," + lstPermitStates.Items[l].Value;
                    }

                }
            }
            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }
            string vtype = "";
            if (cmbvendortype.Text == "-- Select --")
            {
                vtype = "";
            }
            else
            {
                vtype = cmbvendortype.Text;
            }
            string sqlAdd = "update webx_VEHICLE_HDR set vehicle_type = '" + Convert.ToInt32(ddVehicleType.Text) + "', VENDORCODE = '" + ddVndrNm.Text + "',VENDORTYPE='" + vtype + "'," +
                            "VEHPERMIT = '" + b + "',VEHROUTECD = '" + a + "'," +
                            "VEHRCBKNO = '" + txtRcBookNo.Text.Replace("'", "''") + "'," +
                            "VEHREGNO = '" + txtRgnNo.Text.Replace("'", "''") + "'";

                            if (txtRgnDt.Text.Trim() == "")
                            {
                                sqlAdd += ",VEHREGDT = NULL";
                            }
                            else
                            {
                                sqlAdd += ",VEHREGDT = '" + getDateInddMMMyyyFormat(txtRgnDt.Text.Replace("'", "''")) + "'";
                            }

                            sqlAdd += ",VEHCHASISNO = '" + txtChasisNo.Text.Replace("'", "''").Trim() + "',VEHENGINENO = '" + txtEngineNo.Text.Replace("'", "''") + "'";

                            if (txtVhclInsuranceDt.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",Insurance_Validity_Date = NULL";
                            }
                            else
                            {
                                sqlAdd += ",Insurance_Validity_Date ='" + getDateInddMMMyyyFormat(txtVhclInsuranceDt.Text.Replace("'", "''")) + "'";
                            }

                            if (txtFitnessDt.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",Fitness_Validity_Date = NULL";
                            }
                            else
                            {
                                sqlAdd += ",Fitness_Validity_Date ='" + getDateInddMMMyyyFormat(txtFitnessDt.Text.Replace("'", "''")) + "'";
                            }

                            sqlAdd += ",ACTIVEFLAG = '" + txtActFlag.Text.Replace("'", "''").Trim() + "',UPDTBY = '" + Session["empcd"].ToString().Trim() + "',UPDTON = '" + System.DateTime.Now + "',Conrtl_branch = '" + txtCntrlBranch.Text.Replace("'", "''") + "'";

                            if (txtDrivers.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",Drivers = '0'";
                            }
                            else
                            {
                                sqlAdd += ",Drivers = '" + Convert.ToDecimal(txtDrivers.Text.Replace("'", "''")) + "'";
                            }

                            if (txtLength.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",length = '0'";
                            }
                            else
                            {
                                sqlAdd += ",length = '" + Convert.ToDecimal(txtLength.Text.Replace("'", "''")) + "'";
                            }

                            if (txtWidth.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",width = '0'";
                            }
                            else
                            {
                                sqlAdd += ",width = '" + Convert.ToDecimal(txtWidth.Text.Replace("'", "''")) + "'";
                            }

                            if (txtHeight.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",Height = '0'";
                            }
                            else
                            {
                                sqlAdd += ",Height = '" + Convert.ToDecimal(txtHeight.Text.Replace("'", "''")) + "'";
                            }

                            if (txtGVW.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",GVW = '0'";
                            }
                            else
                            {
                                sqlAdd += ",GVW = '" + Convert.ToDecimal(txtGVW.Text.Replace("'", "''")) + "'";
                            }

                            if (txtUnladen.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",Unld_Wt = '0'";
                            }
                            else
                            {
                                sqlAdd += ",Unld_Wt = '" + Convert.ToDecimal(txtUnladen.Text.Replace("'", "''")) + "'";
                            }

                            if (txtPayload.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",Payload = '0'";
                            }
                            else
                            {
                                sqlAdd += ",Payload = '" + Convert.ToDecimal(txtPayload.Text.Replace("'", "''")) + "'";
                            }

                            if (txtRate.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",rate_km = '0'";
                            }
                            else
                            {
                                sqlAdd += ",rate_km = '" + Convert.ToDecimal(txtRate.Text.Replace("'", "''")) + "'";
                            }

                            if (txtCapacity.Text.Replace("'", "''").Trim() == "")
                            {
                                sqlAdd += ",capacity = '0'";
                            }
                            else
                            {
                                sqlAdd += ",capacity = '" + Convert.ToDecimal(txtCapacity.Text.Replace("'", "''")) + "'";
                            }

                            sqlAdd += "where VEHNO = '" + lblVhclNo.Text + "'";

                                        //                "VEHT_CAT = '" + ddVhclCategory.SelectedValue + "',Drivers = '" + txtDrivers.Text + "',length = '" + Convert.ToInt32(txtLength.Text) + "'," +
                                        //                "width = '" + Convert.ToInt32(txtWidth.Text) + "',Height = '" + Convert.ToInt32(txtHeight.Text) + "',GVW = '" + Convert.ToInt32(txtGVW.Text) + "'," +
                                        //                "Unld_Wt = '" + Convert.ToInt32(txtUnladen.Text) + "',Payload = '" + Convert.ToInt32(txtPayload.Text) + "',rate_km = '" + Convert.ToInt32(txtRate.Text) + "' where VEHNO = '" + lblVhclNo.Text + "'";



                                        //string sqlAdd = "update webx_VEHICLE_HDR set vehicle_type = '" + Convert.ToInt32(ddVehicleType.Text) + "', VENDORCODE = '" + ddVndrNm.Text + "'," +
                                        //                "VEHTONS = '" + Convert.ToInt32(ddTonnage.SelectedValue) + "',VEHPERMIT = '" + b + "',VEHROUTECD = '" + a + "'," +
                                        //                "VEHMADEBY = '" + txtMadeBy.Text + "',VEHMODEL = '" + txtModel.Text + "',VEHRCBKNO = '" + txtRcBookNo.Text + "'," +
                                        //                "VEHREGNO = '" + txtRgnNo.Text + "',VEHREGDT = '" + Convert.ToDateTime(txtRgnDt.Text) + "',VEHCHASISNO = '" + txtChasisNo.Text + "'," +
                                        //                "VEHENGINENO = '" + txtEngineNo.Text + "',Insurance_Validity_Date = '" + Convert.ToDateTime(txtVhclInsuranceDt.Text) + "'," +
                                        //                "Fitness_Validity_Date = '" + Convert.ToDateTime(txtFitnessDt.Text) + "',ACTIVEFLAG = '" + txtActFlag.Text + "'," +
                                        //                "UPDTBY = '" + Session["empcd"].ToString().Trim() + "',UPDTON = '" + System.DateTime.Now + "',Conrtl_branch = '" + txtCntrlBranch.Text + "'," +
                                        //                "VEHT_CAT = '" + ddVhclCategory.SelectedValue + "',Drivers = '" + txtDrivers.Text + "',length = '" + Convert.ToInt32(txtLength.Text) + "'," +
                                        //                "width = '" + Convert.ToInt32(txtWidth.Text) + "',Height = '" + Convert.ToInt32(txtHeight.Text) + "',GVW = '" + Convert.ToInt32(txtGVW.Text) + "'," +
                                        //                "Unld_Wt = '" + Convert.ToInt32(txtUnladen.Text) + "',Payload = '" + Convert.ToInt32(txtPayload.Text) + "',rate_km = '" + Convert.ToInt32(txtRate.Text) + "' where VEHNO = '" + lblVhclNo.Text + "'";
                            SqlCommand cmdAdd = new SqlCommand(sqlAdd, cn);
                            cmdAdd.ExecuteNonQuery();
                            cn.Close();
                            //lblMsg.Text = "Record successfully updated";
                            //lblMsg.Focus();
                            Response.Redirect("VehicleMasterEdSelect.aspx");
        //}
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        ddVehicleType.SelectedValue = "";
        ddVndrNm.SelectedValue = "";
        //ddTonnage.SelectedValue = "";
        lstPermitStates.Text = "";
        lstRut.Text = "";
        //txtMadeBy.Text = "";
        //txtModel.Text = "";
        txtRcBookNo.Text = "";
        txtRgnNo.Text = "";
        txtRgnDt.Text = "";
        txtChasisNo.Text = "";
        txtEngineNo.Text = "";
        txtVhclInsuranceDt.Text = "";
        txtFitnessDt.Text = "";
        txtActFlag.Text = "";
        txtCntrlBranch.Text = "";
        //ddVhclCategory.SelectedValue = "";
        txtDrivers.Text = "";
        txtLength.Text = "";
        txtWidth.Text = "";
        txtHeight.Text = "";
        txtGVW.Text = "";
        txtUnladen.Text = "";
        txtPayload.Text = "";
        txtRate.Text = "";

    }
    protected void ddVehicleType_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}

