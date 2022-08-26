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


public partial class GUI_Admin_Vendor_contract_vendorContract_rail : System.Web.UI.Page
{
    int _lastEditedPage,srno, vehtype = 0;
    decimal slabfrom, Slabto, slabrate = 0, slabvalue = 0;
    public static string vendorCode, ContID, Flag, docName, Chargetype, matrixcode, Matrixdesc, calmethod, calmethod1, kmrs, slabbasis = "Per Km.", chargebasis, Fixed_YN, Rate_YN, chrgbasis = "Per trip";
    public int sno = 0;
    SqlConnection cn;
    public DataSet1 _dataSet = new DataSet1();
    protected void Page_Load(object sender, EventArgs e)
    {
        Flag = Request.QueryString.Get("Flag");
        vendorCode = Request.QueryString.Get("vendorCode");
        ContID = Request.QueryString.Get("ContID");
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        if (!IsPostBack)
        {
            Inetialized();
            BindGrid();
            //// popAgnt();
           Validation();
            intetilisedrows();
            roww.Text = "5";

          

            txtchrgbasis.Value = chrgbasis;
            txtslabbasis.Value = slabbasis;
            lbcharge.Text = chrgbasis;
            lbslab.Text = slabbasis;

            txtmaxchrg.Text = "0.00";
            txtminchrg.Text = "0.00";

            txtslabvalfrom1.Text = "0.00";
            txtslabvalto1.Text = "0.00";
            txtslabvalfrom2.Text = "0.00";
            txtslabvalto2.Text = "0.00";
            txtslabvalfrom3.Text = "0.00";
            txtslabvalto3.Text = "0.00";
            txtslabvalfrom4.Text = "0.00";
            txtslabvalto4.Text = "0.00";
            txtslabvalfrom5.Text = "0.00";
            txtslabvalto5.Text = "0.00";
            txtslabvalfrom6.Text = "0.00";
            txtslabvalto6.Text = "0.00";
            if (Flag == "Y")
            {
                kmrs = "KM";
                RetriveData();
            }
        }

        txtslabvalfrom1.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalto1.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalfrom2.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalto2.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalfrom3.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalto3.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalfrom4.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalto4.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalfrom5.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalto5.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalfrom6.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtslabvalto6.Attributes.Add("onblur", "javascript:return Check_num(this)");


        txtmaxchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
        txtminchrg.Attributes.Add("onblur", "javascript:return Check_num(this)");
    }
    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");


    }

    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
            intetilisedrows();
        }
        Validation();
    }
    private void BindGrid()
    {
        GV_D.DataSource = _dataSet.WorkExperianceData;
        GV_D.DataBind();
        _lastEditedPage = GV_D.PageIndex;
    }

    private void Validation()
    {

        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
            //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");


            
            TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1");
            TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
            TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
            TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");
            TextBox txtchrg5 = (TextBox)gridrow.FindControl("txtchrg5");
            TextBox txtchrg6 = (TextBox)gridrow.FindControl("txtchrg6");
            TextBox txtminchrgvar = (TextBox)gridrow.FindControl("txtminchrgvar");
            TextBox txtmaxchrgvar = (TextBox)gridrow.FindControl("txtmaxchrgvar");

            

            //St.Items.Add("--Select--");



            
            txtchrg1.Text = "0.00";
            txtchrg2.Text = "0.00";
            txtchrg3.Text = "0.00";
            txtchrg4.Text = "0.00";
            txtchrg5.Text = "0.00";
            txtchrg6.Text = "0.00";

            txtminchrgvar.Text = "0.00";
            txtmaxchrgvar.Text = "0.00";
            
            txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrg2.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrg3.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrg4.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrg5.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtchrg6.Attributes.Add("onblur", "javascript:return Check_num(this)");

            txtminchrgvar.Attributes.Add("onblur", "javascript:return Check_num(this)");
            txtmaxchrgvar.Attributes.Add("onblur", "javascript:return Check_num(this)");



            //DropDownList Vehtype0 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype");
            //DropDownList Vehtype1 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype1");
            //DropDownList Vehtype2 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype2");
            //DropDownList Vehtype3 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype3");
            //DropDownList Vehtype4 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype4");

        }

    }

    private void intetilisedrows()
    {

        cn.Open();
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");
            //DropDownList Vehtype = (DropDownList)gridrow.FindControl("ddVehtype");


            TextBox txtchrg0 = (TextBox)gridrow.FindControl("txtchrg");
            TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1");
            TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
            TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
            TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");

            //St.Items.Add("--Select--");

            string sqlstr = "select '--Select--' as rutnm,'' as rutcd from webx_rutmas  union select (rutcd +' : '+rutnm) as rutnm,rutcd from webx_rutmas where rutcat='L' and activeFlag='Y' order by [rutnm]";
            SqlCommand cmd = new SqlCommand(sqlstr, cn);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                Route.Items.Add(new ListItem(dr.GetValue(0).ToString(), dr.GetValue(1).ToString()));
            }

            dr.Close();

            //txtchrg0.Text = "0.00";
            //txtchrg1.Text = "0.00";
            //txtchrg2.Text = "0.00";
            //txtchrg3.Text = "0.00";
            //txtchrg4.Text = "0.00";
            //txtchrg0.Attributes.Add("onblur", "javascript:return Check_num(this)");
            //txtchrg1.Attributes.Add("onblur", "javascript:return Check_num(this)");
            //txtchrg2.Attributes.Add("onblur", "javascript:return Check_num(this)");
            //txtchrg3.Attributes.Add("onblur", "javascript:return Check_num(this)");
            //txtchrg4.Attributes.Add("onblur", "javascript:return Check_num(this)");

            //string sqlstr2 = "select '--Select--' as Type_Name,'' as Type_code from webx_vehicle_type  union select Type_Name=(convert(varchar,Type_code,106)+' : '+[Type_Name]),Type_code=convert(varchar,Type_code,106) from webx_vehicle_type where  activeFlag='Y' order by [Type_code]";
            //SqlCommand cmd1 = new SqlCommand(sqlstr2, cn);
            //SqlDataReader dr1 = cmd1.ExecuteReader();

            //while (dr1.Read())
            //{

            //    Vehtype.Items.Add(new ListItem(Convert.ToString(dr1[0]), Convert.ToString(dr1[1])));
            //}

            //dr1.Close();

            //DropDownList Vehtype0 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype");
            //DropDownList Vehtype1 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype1");
            //DropDownList Vehtype2 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype2");
            //DropDownList Vehtype3 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype3");
            //DropDownList Vehtype4 = (DropDownList)GV_D.HeaderRow.FindControl("ddVehtype4");
            //string sqlstr2 = "select '--Select--' as Type_Name,'0' as Type_code from webx_vehicle_type  union select Type_Name=(convert(varchar,Type_code,106)+' : '+[Type_Name]),Type_code=convert(varchar,Type_code,106) from webx_vehicle_type where  activeFlag='Y' order by [Type_code]";
            //// cn.Open();
            //SqlCommand cmd1 = new SqlCommand(sqlstr2, cn);
            //SqlDataReader dr1 = cmd1.ExecuteReader();
            //while (dr1.Read())
            //{

            //    Vehtype0.Items.Add(new ListItem(Convert.ToString(dr1[0]), Convert.ToString(dr1[1])));
            //    Vehtype1.Items.Add(new ListItem(Convert.ToString(dr1[0]), Convert.ToString(dr1[1])));
            //    Vehtype2.Items.Add(new ListItem(Convert.ToString(dr1[0]), Convert.ToString(dr1[1])));
            //    Vehtype3.Items.Add(new ListItem(Convert.ToString(dr1[0]), Convert.ToString(dr1[1])));
            //    Vehtype4.Items.Add(new ListItem(Convert.ToString(dr1[0]), Convert.ToString(dr1[1])));
            //}
            //dr1.Close();
            // cn.Close(); 



        }


        cn.Close();
    }

   
    protected void Submit_Click(object sender, EventArgs e)
    {
        int a, b;
        string SQL_MAXSRNO = "select srno from webx_vendor_contract_matrix where vendorcode='" + vendorCode + "' and contractcd='" + ContID + "' and matrixcode='9'";

        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        SqlCommand MAXSRNO = new SqlCommand(SQL_MAXSRNO, cn);

        a = Convert.ToInt32(MAXSRNO.ExecuteScalar());

        string SQL_MAXSRNO1 = "select isnull(max(srno),0) from webx_vendor_contract_matrix";
        SqlCommand MAXSRNO1 = new SqlCommand(SQL_MAXSRNO1, cn);

        b = Convert.ToInt32(MAXSRNO1.ExecuteScalar());


        if (Flag == "Y")
        {
            srno = a;
        }
        else
        {
            if (b == null || b==0)
            {
                srno = 1;
            }
            else
            {
                srno = b + 1;
            }
        }


        docName = "THC";/// Convert.ToString(cboapptrans.SelectedValue);
        Chargetype = "NA";
        matrixcode = "5";
        Matrixdesc = "Rail Route";
        decimal OtherChrg = 0;
        calmethod = "Higher";
        //OtherChrg = Convert.ToDecimal(txtaddwtchrg.Text);

        String SQL_Insert_update, SQL_Delete, SQL_Delete1, SQL_Delete2, SQL_update_vendor, SQL_update_vendor_contract;
         SqlTransaction trans;
        trans = cn.BeginTransaction();
        try
        {

            if (Flag == "N")
            {
                SQL_Insert_update = "exec webx_vendor_contract_matrix_InsertData '" + vendorCode + "','" + matrixcode + "','" + Matrixdesc + "','" + Chargetype + "','" + docName + "','" + ContID + "'," + OtherChrg + "," + srno + ",'" + calmethod + "'";

            }
            else
            {
                SQL_Insert_update = "exec webx_vendor_contract_matrix_updateData " + srno + ",'" + matrixcode + "','" + Matrixdesc + "','" + Chargetype + "','" + docName + "'," + OtherChrg + ",'" + calmethod + "'";

                SQL_Delete = "exec webx_vendor_contract_charges_deletedata '" + vendorCode + "','" + matrixcode + "','" + ContID + "'";
                SQL_Delete1 = "exec webx_vendor_contract_charges_deletedata '" + vendorCode + "','5','" + ContID + "'";
                ///SQL_Delete2 = "exec webx_vendor_contract_charges_deletedata '" + vendorCode + "','5','" + ContID + "'";

                SqlCommand sqlcmd1 = new SqlCommand(SQL_Delete, cn);
                sqlcmd1.Transaction = trans;
                sqlcmd1.ExecuteNonQuery();
                SqlCommand sqlcmd2 = new SqlCommand(SQL_Delete1, cn);
                sqlcmd2.Transaction = trans;
                sqlcmd2.ExecuteNonQuery();
                //SqlCommand sqlcmd3 = new SqlCommand(SQL_Delete2, cn);
                //sqlcmd3.ExecuteNonQuery();
            }
            SqlCommand sqlcmd = new SqlCommand(SQL_Insert_update, cn);
            sqlcmd.Transaction = trans;
            sqlcmd.ExecuteNonQuery();


            insert_data();


            SQL_update_vendor = "update webx_vendor_hdr set contract_YN='Y' where VendorCode='" + vendorCode + "'";
            SqlCommand update_vendor = new SqlCommand(SQL_update_vendor, cn);
            update_vendor.Transaction = trans;
            update_vendor.ExecuteNonQuery();

            SQL_update_vendor_contract = "update webx_vendor_contract_summary set complete_YN='Y' where VendorCode='" + vendorCode + "' and CONTRACTCD='" + ContID + "'";
            SqlCommand update_vendor_contract = new SqlCommand(SQL_update_vendor_contract, cn);
            update_vendor_contract.Transaction = trans;
            update_vendor_contract.ExecuteNonQuery();

            trans.Commit();

            cn.Close();

        }
        catch (Exception e1)
        {
            Response.Write("<font class='redfnt' >Error : " + e1.Message + "</font>");

            trans.Rollback();


            cn.Close();
            Response.End();
        }

        string final;
        final = "?ContID=" + ContID;
        final += "&Flag=" + Flag;
        final += "&vendorCode=" + vendorCode;

        Response.Redirect("vendorContract_Done.aspx" + final);
    }


    protected void insert_data()
    {
        SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();
        String sql_insertDetails;
         SqlTransaction trans;
        trans = cn.BeginTransaction();
        try
        {
            if (calmethod == "Fixed" || calmethod == "Both" || calmethod == "Higher")
            {
                slabfrom = Convert.ToDecimal(txtminchrg.Text);
                Slabto = Convert.ToDecimal(txtmaxchrg.Text);
                slabrate = 0;

                chargebasis = Convert.ToString(txtchrgbasis.Value);
                Fixed_YN = "Y";
                Rate_YN = "N";
                //calmethod1 = Convert.ToString(cbokmrs.SelectedValue);
                slabvalue = 0;
                vehtype = 0;
                calmethod1 = "NA";
                sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabvalue + "," + slabrate + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + ",0,0,'NA','" + calmethod1 + "','Fixed'";

                Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                insertDetails.Transaction = trans;
                insertDetails.ExecuteNonQuery();
            }



            if (calmethod == "Variable" || calmethod == "Both" || calmethod == "Higher")
            {
                foreach (GridViewRow gridrow in GV_D.Rows)
                {
                    DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");

                    TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1");
                    TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
                    TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
                    TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");
                    TextBox txtchrg5 = (TextBox)gridrow.FindControl("txtchrg5");
                    TextBox txtchrg6 = (TextBox)gridrow.FindControl("txtchrg6");
                    TextBox txtminchrgvar = (TextBox)gridrow.FindControl("txtminchrgvar");
                    TextBox txtmaxchrgvar = (TextBox)gridrow.FindControl("txtmaxchrgvar");
                    decimal MinVal, maxVal = 0;
                    MinVal = Convert.ToDecimal(txtminchrgvar.Text);
                    maxVal = Convert.ToDecimal(txtmaxchrgvar.Text);
                    for (int i = 0; i < 6; i++)
                    {

                        decimal chrgvalue = 0;
                        int vehtype = 0;
                        String chargebasis, Fixed_YN, Rate_YN, routecd;

                        slabfrom = 0;
                        Slabto = 0;
                        slabrate = 0;
                        chargebasis = Convert.ToString(txtslabbasis.Value);

                        if (chargebasis == "")
                        {
                            chargebasis = "Per KG.";
                        }


                        Fixed_YN = "N";
                        Rate_YN = "Y";


                        if (i == 0)
                        {
                            chrgvalue = Convert.ToDecimal(txtchrg1.Text);
                            slabfrom = Convert.ToDecimal(txtslabvalfrom1.Text);
                            Slabto = Convert.ToDecimal(txtslabvalto1.Text);

                        }
                        else if (i == 1)
                        {
                            chrgvalue = Convert.ToDecimal(txtchrg2.Text);
                            slabfrom = Convert.ToDecimal(txtslabvalfrom2.Text);
                            Slabto = Convert.ToDecimal(txtslabvalto2.Text);
                        }
                        else if (i == 2)
                        {
                            chrgvalue = Convert.ToDecimal(txtchrg3.Text);
                            slabfrom = Convert.ToDecimal(txtslabvalfrom3.Text);
                            Slabto = Convert.ToDecimal(txtslabvalto3.Text);

                        }
                        else if (i == 3)
                        {
                            chrgvalue = Convert.ToDecimal(txtchrg4.Text);
                            slabfrom = Convert.ToDecimal(txtslabvalfrom4.Text);
                            Slabto = Convert.ToDecimal(txtslabvalto4.Text);
                        }
                        else if (i == 4)
                        {
                            chrgvalue = Convert.ToDecimal(txtchrg5.Text);
                            slabfrom = Convert.ToDecimal(txtslabvalfrom5.Text);
                            Slabto = Convert.ToDecimal(txtslabvalto5.Text);
                        }
                        else if (i == 5)
                        {
                            chrgvalue = Convert.ToDecimal(txtchrg6.Text);
                            slabfrom = Convert.ToDecimal(txtslabvalfrom6.Text);
                            Slabto = Convert.ToDecimal(txtslabvalto6.Text);
                        }

                        routecd = Route.SelectedValue.ToString();

                        // Response.Write("<br> Route : " + chrgvalue);
                        //Response.Write("<br> Route : " + vehtype);
                        if ((slabfrom > 0 || Slabto > 0) && chrgvalue > 0 && routecd != "")
                        {
                            sql_insertDetails = "exec webx_vendor_contract_charges_insertData '" + vendorCode + "','" + matrixcode + "'," + slabfrom + "," + Slabto + "," + slabrate + "," + chrgvalue + ",'" + chargebasis + "','" + docName + "','" + Fixed_YN + "','" + Rate_YN + "','" + ContID + "','" + vehtype + "'," + srno + "," + MinVal + "," + maxVal + ",'" + routecd + "','NA','Variable'";

                            Response.Write(" <br> sql_insertDetails : " + sql_insertDetails);
                            SqlCommand insertDetails = new SqlCommand(sql_insertDetails, cn);
                            insertDetails.Transaction = trans;
                            insertDetails.ExecuteNonQuery();
                        }




                    }


                }

            }
            trans.Commit();

            cn.Close();

        }
        catch (Exception e1)
        {
            Response.Write("<font class='redfnt' >Error : " + e1.Message + "</font>");

            trans.Rollback();


            cn.Close();
            Response.End();
        }
    }

    private void RetriveData()
    {
       // SqlConnection cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        cn.Open();

        String sql_edit = "select slabfrom,slabto from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Fixed'";
        SqlCommand cmd3 = new SqlCommand(sql_edit, cn);
        SqlDataReader dr = cmd3.ExecuteReader();
        //String mcode = "";
        while (dr.Read())
        {
            //txtaddwtchrg.Text = dr["otherchrg"].ToString();
            // mcode = dr["matrixcode"].ToString();

            txtminchrg.Text = dr["slabfrom"].ToString();
            txtmaxchrg.Text = dr["slabto"].ToString();
        }
        dr.Close();

        String sql_edit1 = "select distinct slabfrom,slabto from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' ";
        SqlCommand cmd31 = new SqlCommand(sql_edit1, cn);
        SqlDataReader dr1 = cmd31.ExecuteReader();
        //String mcode = "";
        int i1 = 1;
        while (dr1.Read())
        {
            //int abc = i1;
            //txtaddwtchrg.Text = dr["otherchrg"].ToString();
            // mcode = dr["matrixcode"].ToString();

            //txtminchrg.Text = dr1["slabfrom"].ToString();
           // txtmaxchrg.Text = dr1["slabto"].ToString();

            if (i1 == 1)
            {
                txtslabvalfrom1.Text = dr1["slabfrom"].ToString();
                txtslabvalto1.Text = dr1["slabto"].ToString();
            }
            if (i1 == 2)
            {
                txtslabvalfrom2.Text = dr1["slabfrom"].ToString();
                txtslabvalto2.Text = dr1["slabto"].ToString();
            }
            if (i1 == 3)
            {
                txtslabvalfrom3.Text = dr1["slabfrom"].ToString();
                txtslabvalto3.Text = dr1["slabto"].ToString();
            }
            if (i1 == 4)
            {
                txtslabvalfrom4.Text = dr1["slabfrom"].ToString();
                txtslabvalto4.Text = dr1["slabto"].ToString();
            }
            if (i1 == 5)
            {
                txtslabvalfrom5.Text = dr1["slabfrom"].ToString();
                txtslabvalto5.Text = dr1["slabto"].ToString();
            }
            if (i1 == 6)
            {
                txtslabvalfrom6.Text = dr1["slabfrom"].ToString();
                txtslabvalto6.Text = dr1["slabto"].ToString();
            }

            i1 = i1 + 1;
        }
        dr1.Close();

        String sql_edit2 = "select slabfrom,slabto,slabrate,minval,maxval,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and chargetype='Variable' order by chargeid";
        SqlCommand cmd32 = new SqlCommand(sql_edit2, cn);
        SqlDataReader dr2 = cmd32.ExecuteReader();

       // Boolean a;
       // a = dr2.Read();

        string Slab_Rate = "", ROute_cd = "", MinValsr = "", MaxValsr = "";
        String abcd = "";
        while (dr2.Read())
        {
            String Temp1 = dr2["routecd"].ToString();

            if (Temp1 != abcd)
            {
                if (ROute_cd == "")
                {
                    ROute_cd = Convert.ToString(dr2["routecd"]);
                    MinValsr = Convert.ToString(dr2["minval"]);
                    MaxValsr = Convert.ToString(dr2["maxval"]);
                }
                else
                {
                    ROute_cd = ROute_cd + "~" + Convert.ToString(dr2["routecd"]);
                    MinValsr = MinValsr + "~" + Convert.ToString(dr2["minval"]);
                    MaxValsr = MaxValsr + "~" + Convert.ToString(dr2["maxval"]);
                }


            }
           
            abcd = dr2["routecd"].ToString();
           // i2 = i2 + 1;
        }
        dr2.Close();
        int i2 = 0;
        string[] ROute_cd_arr = ROute_cd.Split('~');
        string[] MinValsr_arr = MinValsr.Split('~');
        string[] MaxValsr_arr = MaxValsr.Split('~');
        int Rl = ROute_cd_arr.Length;

        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            DropDownList Route = (DropDownList)gridrow.FindControl("ddRoute");

            TextBox txtchrg1 = (TextBox)gridrow.FindControl("txtchrg1");
            TextBox txtchrg2 = (TextBox)gridrow.FindControl("txtchrg2");
            TextBox txtchrg3 = (TextBox)gridrow.FindControl("txtchrg3");
            TextBox txtchrg4 = (TextBox)gridrow.FindControl("txtchrg4");
            TextBox txtchrg5 = (TextBox)gridrow.FindControl("txtchrg5");
            TextBox txtchrg6 = (TextBox)gridrow.FindControl("txtchrg6");
            TextBox txtminchrgvar = (TextBox)gridrow.FindControl("txtminchrgvar");
            TextBox txtmaxchrgvar = (TextBox)gridrow.FindControl("txtmaxchrgvar");

           

          //  txtREG_NO.Text = REG_NO_arr[i];
            //For x = LBound(ROute_cd_arr) To UBound(ROute_cd_arr)
            if (i2 < Rl)
            {
                String Rt_cd= ROute_cd_arr[i2];
                Route.Text = ROute_cd_arr[i2];
                txtminchrgvar.Text = MinValsr_arr[i2];
                txtmaxchrgvar.Text = MaxValsr_arr[i2];

                String sql_edit3 = "select slabfrom,slabto,slabrate,minval,maxval,routecd from webx_vendor_contract_charges with(NOLOCK) where vendorcode='" + vendorCode + "' and routecd='" + Rt_cd + "' and chargetype='Variable' order by chargeid";
                SqlCommand cmd33 = new SqlCommand(sql_edit3, cn);
                SqlDataReader dr3 = cmd33.ExecuteReader();
                int i3=1;
                while (dr3.Read())
                {
                    if(i3==1)
                    {
                        txtchrg1.Text = Convert.ToString(dr3["slabrate"]);
                    }
                    if (i3 == 2)
                    {
                        txtchrg2.Text = Convert.ToString(dr3["slabrate"]);
                    }
                    if (i3 == 3)
                    {
                        txtchrg3.Text = Convert.ToString(dr3["slabrate"]);
                    }
                    if (i3 == 4)
                    {
                        txtchrg4.Text = Convert.ToString(dr3["slabrate"]);
                    }
                    if (i3 == 5)
                    {
                        txtchrg5.Text = Convert.ToString(dr3["slabrate"]);
                    }
                    if (i3 == 6)
                    {
                        txtchrg6.Text = Convert.ToString(dr3["slabrate"]);
                    }
                    i3 = i3 + 1;
                }


                dr3.Close();
                
                i2 = i2 + 1;
            }


            
        }
       
        cn.Close();

    }
}
