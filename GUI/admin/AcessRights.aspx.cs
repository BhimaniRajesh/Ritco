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

public partial class GUI_admin_AcessRights : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLocCode_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        if (txtLocCode.Text != "" && txtLocCode.Text != null)
        {
            rptAccess.Visible = true;
            rptEmp.Visible = false;

            string sql = "Select empcd,empnm,OPN,FIN,MKT,REP,TRK,ADM,OPN_Plevel,FIN_Plevel,MKT_Plevel,REP_Plevel,TRK_Plevel,ADM_Plevel,OCTROI,OCT_PLEVEL,CRM,CRM_PLEVEL,EXC,EXC_PLEVEL from WEBX_EMPMST where Activeflag='Y' and currbrcd='" + txtLocCode.Text + "'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();
            da.Fill(ds);

            DataTable dt = new DataTable();

            dt.Columns.Add("empcd", typeof(string));
            dt.Columns.Add("empnm", typeof(string));
            dt.Columns.Add("OPN", typeof(string));
            dt.Columns.Add("OPN_Plevel", typeof(string));
            dt.Columns.Add("FIN", typeof(string));
            dt.Columns.Add("FIN_Plevel", typeof(string));
            dt.Columns.Add("MKT", typeof(string));
            dt.Columns.Add("MKT_Plevel", typeof(string));
            dt.Columns.Add("ADM", typeof(string));
            dt.Columns.Add("ADM_Plevel", typeof(string));
            dt.Columns.Add("REP", typeof(string));
            dt.Columns.Add("REP_Plevel", typeof(string));
            dt.Columns.Add("TRK", typeof(string));
            dt.Columns.Add("TRK_Plevel", typeof(string));
            dt.Columns.Add("OCTROI", typeof(string));
            dt.Columns.Add("OCT_Plevel", typeof(string));
            dt.Columns.Add("CRM", typeof(string));
            dt.Columns.Add("CRM_Plevel", typeof(string));
            dt.Columns.Add("EXC", typeof(string));
            dt.Columns.Add("EXC_PLEVEL", typeof(string));

            DataRow dr3, dr4;

            foreach (DataRow drRows in ds.Tables[0].Rows)
            {
                Button btn = sender as Button;

                dr3 = dt.NewRow();
                dr3["empcd"] = (drRows["empcd"]);

                dr3["empnm"] = (drRows["empnm"]);

                dr3["OPN"] = (drRows["OPN"]);

                dr3["OPN_Plevel"] = (drRows["OPN_Plevel"]);

                dr3["FIN"] = (drRows["FIN"]);

                dr3["FIN_Plevel"] = (drRows["FIN_Plevel"]);

                dr3["MKT"] = (drRows["MKT"]);

                dr3["MKT_Plevel"] = (drRows["MKT_Plevel"]);

                dr3["ADM"] = (drRows["ADM"]);

                dr3["ADM_Plevel"] = (drRows["ADM_Plevel"]);

                dr3["REP"] = (drRows["REP"]);

                dr3["REP_Plevel"] = (drRows["REP_Plevel"]);

                dr3["TRK"] = (drRows["TRK"]);

                dr3["TRK_Plevel"] = (drRows["TRK_Plevel"]);

                dr3["OCTROI"] = (drRows["OCTROI"]);

                dr3["OCT_Plevel"] = (drRows["OCT_Plevel"]);

                dr3["CRM"] = (drRows["CRM"]);

                dr3["CRM_Plevel"] = (drRows["CRM_Plevel"]);

                dr3["EXC"] = (drRows["EXC"]);

                dr3["EXC_Plevel"] = (drRows["EXC_Plevel"]);

                dt.Rows.Add(dr3);

                rptAccess.DataSource = dt;
                rptAccess.DataBind();
                btnSubmitLoc.Visible = true;
                btnSubmitEmp.Visible = false;
            }


            foreach (RepeaterItem item in rptAccess.Items)
            {
                CheckBox cb = item.FindControl("CheckBox1") as CheckBox;
                Label chkdisp = item.FindControl("chkdisp") as Label;
                chkdisp.Visible = false;
                if (chkdisp.Text.ToString() == "A")
                {
                    cb.Checked = true;
                }
                CheckBox cb2 = item.FindControl("CheckBox2") as CheckBox;
                Label chkdisp2 = item.FindControl("chkdisp2") as Label;
                chkdisp2.Visible = false;
                if (chkdisp2.Text.ToString() == "P")
                {
                    cb2.Checked = true;
                }
                CheckBox cb3 = item.FindControl("CheckBox3") as CheckBox;
                Label chkdisp3 = item.FindControl("chkdisp3") as Label;
                chkdisp3.Visible = false;
                if (chkdisp3.Text.ToString() == "A")
                {
                    cb3.Checked = true;
                }
                CheckBox cb4 = item.FindControl("CheckBox4") as CheckBox;
                Label chkdisp4 = item.FindControl("chkdisp4") as Label;
                chkdisp4.Visible = false;
                if (chkdisp4.Text.ToString() == "P")
                {
                    cb4.Checked = true;
                }
                CheckBox cb5 = item.FindControl("CheckBox5") as CheckBox;
                Label chkdisp5 = item.FindControl("chkdisp5") as Label;
                chkdisp5.Visible = false;
                if (chkdisp5.Text.ToString() == "A")
                {
                    cb5.Checked = true;
                }
                CheckBox cb6 = item.FindControl("CheckBox6") as CheckBox;
                Label chkdisp6 = item.FindControl("chkdisp6") as Label;
                chkdisp6.Visible = false;
                if (chkdisp6.Text.ToString() == "P")
                {
                    cb6.Checked = true;
                }
                CheckBox cb7 = item.FindControl("CheckBox7") as CheckBox;
                Label chkdisp7 = item.FindControl("chkdisp7") as Label;
                chkdisp7.Visible = false;
                if (chkdisp7.Text.ToString() == "A")
                {
                    cb7.Checked = true;
                }
                CheckBox cb8 = item.FindControl("CheckBox8") as CheckBox;
                Label chkdisp8 = item.FindControl("chkdisp8") as Label;
                chkdisp8.Visible = false;
                if (chkdisp8.Text.ToString() == "P")
                {
                    cb8.Checked = true;
                }
                CheckBox cb9 = item.FindControl("CheckBox9") as CheckBox;
                Label chkdisp9 = item.FindControl("chkdisp9") as Label;
                chkdisp9.Visible = false;
                if (chkdisp9.Text.ToString() == "A")
                {
                    cb9.Checked = true;
                }
                CheckBox cb10 = item.FindControl("CheckBox10") as CheckBox;
                Label chkdisp10 = item.FindControl("chkdisp10") as Label;
                chkdisp10.Visible = false;
                if (chkdisp10.Text.ToString() == "P")
                {
                    cb10.Checked = true;
                }
                CheckBox cb11 = item.FindControl("CheckBox11") as CheckBox;
                Label chkdisp11 = item.FindControl("chkdisp11") as Label;
                chkdisp11.Visible = false;
                if (chkdisp11.Text.ToString() == "A")
                {
                    cb11.Checked = true;
                }
                CheckBox cb12 = item.FindControl("CheckBox12") as CheckBox;
                Label chkdisp12 = item.FindControl("chkdisp12") as Label;
                chkdisp12.Visible = false;
                if (chkdisp12.Text.ToString() == "P")
                {
                    cb12.Checked = true;
                }
                CheckBox cb13 = item.FindControl("CheckBox13") as CheckBox;
                Label chkdisp13 = item.FindControl("chkdisp13") as Label;
                chkdisp13.Visible = false;
                if (chkdisp13.Text.ToString() == "A")
                {
                    cb13.Checked = true;
                }
                CheckBox cb14 = item.FindControl("CheckBox14") as CheckBox;
                Label chkdisp14 = item.FindControl("chkdisp14") as Label;
                chkdisp14.Visible = false;
                if (chkdisp14.Text.ToString() == "P")
                {
                    cb14.Checked = true;
                }
                CheckBox cb15 = item.FindControl("CheckBox15") as CheckBox;
                Label chkdisp15 = item.FindControl("chkdisp15") as Label;
                chkdisp15.Visible = false;
                if (chkdisp15.Text.ToString() == "A")
                {
                    cb15.Checked = true;
                }
                CheckBox cb16 = item.FindControl("CheckBox16") as CheckBox;
                Label chkdisp16 = item.FindControl("chkdisp16") as Label;
                chkdisp16.Visible = false;
                if (chkdisp16.Text.ToString() == "P")
                {
                    cb16.Checked = true;
                }
                CheckBox cb17 = item.FindControl("CheckBox17") as CheckBox;
                Label chkdisp17 = item.FindControl("chkdisp17") as Label;
                chkdisp17.Visible = false;
                if (chkdisp17.Text.ToString() == "A")
                {
                    cb17.Checked = true;
                }
                CheckBox cb18 = item.FindControl("CheckBox18") as CheckBox;
                Label chkdisp18 = item.FindControl("chkdisp18") as Label;
                chkdisp18.Visible = false;
                if (chkdisp18.Text.ToString() == "P")
                {
                    cb18.Checked = true;
                }
                
            }

        }
        conn.Close();
    }
    protected void btnEMpCode_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (txtEmpCode.Text != "" && txtEmpCode != null)
        {
            rptEmp.Visible = true;
            rptAccess.Visible = false;

            string sqlemp = "Select empcd,empnm,OPN,FIN,MKT,REP,TRK,ADM,OPN_Plevel,FIN_Plevel,MKT_Plevel,REP_Plevel,TRK_Plevel,ADM_Plevel,OCTROI,OCT_PLEVEL,CRM,CRM_PLEVEL,EXC,EXC_PLEVEL from WEBX_EMPMST where Activeflag='Y' and empcd='" + txtEmpCode.Text + "' ";
            SqlCommand cmdemp = new SqlCommand(sqlemp, conn);
            SqlDataAdapter daemp = new SqlDataAdapter(cmdemp);

            DataSet dsemp = new DataSet();
            daemp.Fill(dsemp);

            DataTable dtemp = new DataTable();

            dtemp.Columns.Add("empcd", typeof(string));
            dtemp.Columns.Add("empnm", typeof(string));
            dtemp.Columns.Add("OPN", typeof(string));
            dtemp.Columns.Add("OPN_Plevel", typeof(string));
            dtemp.Columns.Add("FIN", typeof(string));
            dtemp.Columns.Add("FIN_Plevel", typeof(string));
            dtemp.Columns.Add("MKT", typeof(string));
            dtemp.Columns.Add("MKT_Plevel", typeof(string));
            dtemp.Columns.Add("ADM", typeof(string));
            dtemp.Columns.Add("ADM_Plevel", typeof(string));
            dtemp.Columns.Add("REP", typeof(string));
            dtemp.Columns.Add("REP_Plevel", typeof(string));
            dtemp.Columns.Add("TRK", typeof(string));
            dtemp.Columns.Add("TRK_Plevel", typeof(string));
            dtemp.Columns.Add("OCTROI", typeof(string));
            dtemp.Columns.Add("OCT_Plevel", typeof(string));
            dtemp.Columns.Add("CRM", typeof(string));
            dtemp.Columns.Add("CRM_Plevel", typeof(string));
            dtemp.Columns.Add("EXC", typeof(string));
            dtemp.Columns.Add("EXC_PLEVEL", typeof(string));

            DataRow dr5, dr6;

            foreach (DataRow drRowsemp in dsemp.Tables[0].Rows)
            {
                Button btn1 = sender as Button;

                dr5 = dtemp.NewRow();
                dr5["empcd"] = (drRowsemp["empcd"]);

                dr5["empnm"] = (drRowsemp["empnm"]);

                dr5["OPN"] = (drRowsemp["OPN"]);

                dr5["OPN_Plevel"] = (drRowsemp["OPN_Plevel"]);

                dr5["FIN"] = (drRowsemp["FIN"]);

                dr5["FIN_Plevel"] = (drRowsemp["FIN_Plevel"]);

                dr5["MKT"] = (drRowsemp["MKT"]);

                dr5["MKT_Plevel"] = (drRowsemp["MKT_Plevel"]);

                dr5["ADM"] = (drRowsemp["ADM"]);

                dr5["ADM_Plevel"] = (drRowsemp["ADM_Plevel"]);

                dr5["REP"] = (drRowsemp["REP"]);

                dr5["REP_Plevel"] = (drRowsemp["REP_Plevel"]);

                dr5["TRK"] = (drRowsemp["TRK"]);

                dr5["TRK_Plevel"] = (drRowsemp["TRK_Plevel"]);

                dr5["OCTROI"] = (drRowsemp["OCTROI"]);

                dr5["OCT_Plevel"] = (drRowsemp["OCT_Plevel"]);

                dr5["CRM"] = (drRowsemp["CRM"]);

                dr5["CRM_Plevel"] = (drRowsemp["CRM_Plevel"]);

                dr5["EXC"] = (drRowsemp["EXC"]);

                dr5["EXC_Plevel"] = (drRowsemp["EXC_Plevel"]);

                dtemp.Rows.Add(dr5);

                rptEmp.DataSource = dtemp;
                rptEmp.DataBind();
                btnSubmitEmp.Visible = true;
                btnSubmitLoc.Visible = false;

            }


            foreach (RepeaterItem itememp in rptEmp.Items)
            {
                CheckBox cb19 = itememp.FindControl("CheckBox19") as CheckBox;
                Label chkdisp19 = itememp.FindControl("chkdisp19") as Label;
                chkdisp19.Visible = false;
                if (chkdisp19.Text.ToString() == "A")
                {
                    cb19.Checked = true;
                }
                CheckBox cb20 = itememp.FindControl("CheckBox20") as CheckBox;
                Label chkdisp20 = itememp.FindControl("chkdisp20") as Label;
                chkdisp20.Visible = false;
                if (chkdisp20.Text.ToString() == "P")
                {
                    cb20.Checked = true;
                }
                CheckBox cb21 = itememp.FindControl("CheckBox21") as CheckBox;
                Label chkdisp21 = itememp.FindControl("chkdisp21") as Label;
                chkdisp21.Visible = false;
                if (chkdisp21.Text.ToString() == "A")
                {
                    cb21.Checked = true;
                }
                CheckBox cb22 = itememp.FindControl("CheckBox22") as CheckBox;
                Label chkdisp22 = itememp.FindControl("chkdisp22") as Label;
                chkdisp22.Visible = false;
                if (chkdisp22.Text.ToString() == "P")
                {
                    cb22.Checked = true;
                }
                CheckBox cb23 = itememp.FindControl("CheckBox23") as CheckBox;
                Label chkdisp23 = itememp.FindControl("chkdisp23") as Label;
                chkdisp23.Visible = false;
                if (chkdisp23.Text.ToString() == "A")
                {
                    cb23.Checked = true;
                }
                CheckBox cb24 = itememp.FindControl("CheckBox24") as CheckBox;
                Label chkdisp24 = itememp.FindControl("chkdisp24") as Label;
                chkdisp24.Visible = false;
                if (chkdisp24.Text.ToString() == "P")
                {
                    cb24.Checked = true;
                }
                CheckBox cb25 = itememp.FindControl("CheckBox25") as CheckBox;
                Label chkdisp25 = itememp.FindControl("chkdisp25") as Label;
                chkdisp25.Visible = false;
                if (chkdisp25.Text.ToString() == "A")
                {
                    cb25.Checked = true;
                }
                CheckBox cb26 = itememp.FindControl("CheckBox26") as CheckBox;
                Label chkdisp26 = itememp.FindControl("chkdisp26") as Label;
                chkdisp26.Visible = false;
                if (chkdisp26.Text.ToString() == "P")
                {
                    cb26.Checked = true;
                }
                CheckBox cb27 = itememp.FindControl("CheckBox27") as CheckBox;
                Label chkdisp27 = itememp.FindControl("chkdisp27") as Label;
                chkdisp27.Visible = false;
                if (chkdisp27.Text.ToString() == "A")
                {
                    cb27.Checked = true;
                }
                CheckBox cb28 = itememp.FindControl("CheckBox28") as CheckBox;
                Label chkdisp28 = itememp.FindControl("chkdisp28") as Label;
                chkdisp28.Visible = false;
                if (chkdisp28.Text.ToString() == "P")
                {
                    cb28.Checked = true;
                }
                CheckBox cb29 = itememp.FindControl("CheckBox29") as CheckBox;
                Label chkdisp29 = itememp.FindControl("chkdisp29") as Label;
                chkdisp29.Visible = false;
                if (chkdisp29.Text.ToString() == "A")
                {
                    cb29.Checked = true;
                }
                CheckBox cb30 = itememp.FindControl("CheckBox30") as CheckBox;
                Label chkdisp30 = itememp.FindControl("chkdisp30") as Label;
                chkdisp30.Visible = false;
                if (chkdisp30.Text.ToString() == "P")
                {
                    cb30.Checked = true;
                }
                CheckBox cb31 = itememp.FindControl("CheckBox31") as CheckBox;
                Label chkdisp31 = itememp.FindControl("chkdisp31") as Label;
                chkdisp31.Visible = false;
                if (chkdisp31.Text.ToString() == "A")
                {
                    cb31.Checked = true;
                }
                CheckBox cb32 = itememp.FindControl("CheckBox32") as CheckBox;
                Label chkdisp32 = itememp.FindControl("chkdisp32") as Label;
                chkdisp32.Visible = false;
                if (chkdisp32.Text.ToString() == "P")
                {
                    cb32.Checked = true;
                }
                CheckBox cb33 = itememp.FindControl("CheckBox33") as CheckBox;
                Label chkdisp33 = itememp.FindControl("chkdisp33") as Label;
                chkdisp33.Visible = false;
                if (chkdisp33.Text.ToString() == "A")
                {
                    cb33.Checked = true;
                }
                CheckBox cb34 = itememp.FindControl("CheckBox34") as CheckBox;
                Label chkdisp34 = itememp.FindControl("chkdisp34") as Label;
                chkdisp34.Visible = false;
                if (chkdisp34.Text.ToString() == "P")
                {
                    cb34.Checked = true;
                }
                CheckBox cb35 = itememp.FindControl("CheckBox35") as CheckBox;
                Label chkdisp35 = itememp.FindControl("chkdisp35") as Label;
                chkdisp35.Visible = false;
                if (chkdisp35.Text.ToString() == "A")
                {
                    cb35.Checked = true;
                }
                CheckBox cb36 = itememp.FindControl("CheckBox36") as CheckBox;
                Label chkdisp36 = itememp.FindControl("chkdisp36") as Label;
                chkdisp36.Visible = false;
                if (chkdisp36.Text.ToString() == "P")
                {
                    cb36.Checked = true;
                }
            }

        }
        conn.Close();
    }
    protected void btnSubmitLoc_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < rptAccess.Items.Count; i++)
        {
            string employee = ((Label)rptAccess.Items[i].FindControl("lblempcode")).Text;

            string chkoa = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox1")).Checked == true ? "Y" : "N";
            string chkop = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox2")).Checked == true ? "P" : "NP";

            string chkfa = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox3")).Checked == true ? "Y" : "N";
            string chkfp = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox4")).Checked == true ? "P" : "NP";

            string chkma = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox5")).Checked == true ? "Y" : "N";
            string chkmp = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox6")).Checked == true ? "P" : "NP";

            string chkaa = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox7")).Checked == true ? "Y" : "N";
            string chkap = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox8")).Checked == true ? "P" : "NP";

            string chkra = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox9")).Checked == true ? "Y" : "N";
            string chkrp = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox10")).Checked == true ? "P" : "NP";

            string chkta = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox11")).Checked == true ? "Y" : "N";
            string chktp = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox12")).Checked == true ? "P" : "NP";

            string chkocta = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox13")).Checked == true ? "Y" : "N";
            string chkoctp = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox14")).Checked == true ? "P" : "NP";

            string chkca = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox15")).Checked == true ? "Y" : "N";
            string chkcp = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox16")).Checked == true ? "P" : "NP";

            string chkea = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox17")).Checked == true ? "Y" : "N";
            string chkep = ((CheckBox)rptAccess.Items[i].FindControl("CheckBox18")).Checked == true ? "P" : "NP";

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string sql_update = "Update webx_EMPMST Set OPN='" + chkoa + "',FIN='" + chkfa + "',MKT='" + chkma + "',ADM='" + chkaa + "',REP='" + chkra + "',TRK='" + chkta + "',OPN_Plevel='" + chkop + "',FIN_Plevel='" + chkfp + "',MKT_Plevel='" + chkmp + "',ADM_Plevel='" + chkap + "',REP_Plevel='" + chkrp + "',TRK_Plevel='" + chktp + "',OCTROI='" + chkocta + "',OCT_PLEVEL='" + chkoctp + "',CRM='" + chkca + "',CRM_PLEVEL='" + chkcp + "',EXC='" + chkea + "',EXC_Plevel='" + chkep + "' Where empcd='" + employee + "'";
            SqlCommand cmd_update = new SqlCommand(sql_update, conn);
            cmd_update.ExecuteNonQuery();

            string sql_delete21 = "delete from  Webx_Master_ModuleAccess where UserId='" + employee + "'";
            SqlCommand cmd_delete21 = new SqlCommand(sql_delete21, conn);
            cmd_delete21.ExecuteNonQuery();

            string InsertRecord1 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','01','" + chkoa + "')";
            SqlCommand cmd_Insert1 = new SqlCommand(InsertRecord1, conn);
            cmd_Insert1.ExecuteNonQuery();

            string InsertRecord2 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','02','" + chkfa + "')";
            SqlCommand cmd_Insert2 = new SqlCommand(InsertRecord2, conn);
            cmd_Insert2.ExecuteNonQuery();

            string InsertRecord3 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','03','" + chkma + "')";
            SqlCommand cmd_Insert3 = new SqlCommand(InsertRecord3, conn);
            cmd_Insert3.ExecuteNonQuery();

            string InsertRecord4 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','04','" + chkaa + "')";
            SqlCommand cmd_Insert4 = new SqlCommand(InsertRecord4, conn);
            cmd_Insert4.ExecuteNonQuery();

            string InsertRecord5 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','05','" + chkra + "')";
            SqlCommand cmd_Insert5 = new SqlCommand(InsertRecord5, conn);
            cmd_Insert5.ExecuteNonQuery();

            string InsertRecord6 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','06','" + chkta + "')";
            SqlCommand cmd_Insert6 = new SqlCommand(InsertRecord6, conn);
            cmd_Insert6.ExecuteNonQuery();

            string InsertRecord7 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','07','" + chkocta + "')";
            SqlCommand cmd_Insert7 = new SqlCommand(InsertRecord7, conn);
            cmd_Insert7.ExecuteNonQuery();

            string InsertRecord8 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','08','" + chkca + "')";
            SqlCommand cmd_Insert8 = new SqlCommand(InsertRecord8, conn);
            cmd_Insert8.ExecuteNonQuery();

            string InsertRecord9 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee + "','09','" + chkea + "')";
            SqlCommand cmd_Insert9 = new SqlCommand(InsertRecord9, conn);
            cmd_Insert9.ExecuteNonQuery();



        }
        Response.Redirect("AccessRightDone.aspx");
    }
    protected void btnSubmitEmp_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < rptEmp.Items.Count; i++)
        {
            string employee1 = ((Label)rptEmp.Items[i].FindControl("lblempcode1")).Text;

            string chkoa = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox19")).Checked == true ? "Y" : "N";
            string chkop = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox20")).Checked == true ? "P" : "NP";

            string chkfa = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox21")).Checked == true ? "Y" : "N";
            string chkfp = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox22")).Checked == true ? "P" : "NP";

            string chkma = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox23")).Checked == true ? "Y" : "N";
            string chkmp = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox24")).Checked == true ? "P" : "NP";

            string chkaa = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox25")).Checked == true ? "Y" : "N";
            string chkap = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox26")).Checked == true ? "P" : "NP";

            string chkra = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox27")).Checked == true ? "Y" : "N";
            string chkrp = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox28")).Checked == true ? "P" : "NP";

            string chkta = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox29")).Checked == true ? "Y" : "N";
            string chktp = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox30")).Checked == true ? "P" : "NP";

            string chkocta = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox31")).Checked == true ? "Y" : "N";
            string chkoctp = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox32")).Checked == true ? "P" : "NP";

            string chkca = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox33")).Checked == true ? "Y" : "N";
            string chkcp = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox34")).Checked == true ? "P" : "NP";

            string chkea = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox35")).Checked == true ? "Y" : "N";
            string chkep = ((CheckBox)rptEmp.Items[i].FindControl("CheckBox36")).Checked == true ? "P" : "NP";

            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();

            string sql_update1 = "Update webx_EMPMST Set OPN='" + chkoa + "',FIN='" + chkfa + "',MKT='" + chkma + "',ADM='" + chkaa + "',REP='" + chkra + "',TRK='" + chkta + "',OPN_Plevel='" + chkop + "',FIN_Plevel='" + chkfp + "',MKT_Plevel='" + chkmp + "',ADM_Plevel='" + chkap + "',REP_Plevel='" + chkrp + "',TRK_Plevel='" + chktp + "',OCTROI='" + chkocta + "',OCT_PLEVEL='" + chkoctp + "',CRM='" + chkca + "',CRM_PLEVEL='" + chkcp + "',EXC='" + chkea + "',EXC_Plevel='" + chkep + "' Where empcd='" + employee1 + "'";
            SqlCommand cmd_update1 = new SqlCommand(sql_update1, conn);
            cmd_update1.ExecuteNonQuery();

            string sql_delete21 = "delete from  Webx_Master_ModuleAccess where UserId='" + employee1 + "'";
            SqlCommand cmd_delete21 = new SqlCommand(sql_delete21, conn);
            cmd_delete21.ExecuteNonQuery();

            string InsertRecord1 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','01','" + chkoa + "')";
            SqlCommand cmd_Insert1 = new SqlCommand(InsertRecord1, conn);
            cmd_Insert1.ExecuteNonQuery();

            string InsertRecord2 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','02','" + chkfa + "')";
            SqlCommand cmd_Insert2 = new SqlCommand(InsertRecord2, conn);
            cmd_Insert2.ExecuteNonQuery();

            string InsertRecord3 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','03','" + chkma + "')";
            SqlCommand cmd_Insert3 = new SqlCommand(InsertRecord3, conn);
            cmd_Insert3.ExecuteNonQuery();

            string InsertRecord4 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','04','" + chkaa + "')";
            SqlCommand cmd_Insert4 = new SqlCommand(InsertRecord4, conn);
            cmd_Insert4.ExecuteNonQuery();

            string InsertRecord5 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','05','" + chkra + "')";
            SqlCommand cmd_Insert5 = new SqlCommand(InsertRecord5, conn);
            cmd_Insert5.ExecuteNonQuery();

            string InsertRecord6 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','06','" + chkta + "')";
            SqlCommand cmd_Insert6 = new SqlCommand(InsertRecord6, conn);
            cmd_Insert6.ExecuteNonQuery();

            string InsertRecord7 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','07','" + chkocta + "')";
            SqlCommand cmd_Insert7 = new SqlCommand(InsertRecord7, conn);
            cmd_Insert7.ExecuteNonQuery();

            string InsertRecord8 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','08','" + chkca + "')";
            SqlCommand cmd_Insert8 = new SqlCommand(InsertRecord8, conn);
            cmd_Insert8.ExecuteNonQuery();

            string InsertRecord9 = "Insert into webx_Master_ModuleAccess (UserId,ModuleCode,HasAccess) Values('" + employee1 + "','09','" + chkea + "')";
            SqlCommand cmd_Insert9 = new SqlCommand(InsertRecord9, conn);
            cmd_Insert9.ExecuteNonQuery();
            
        }

        Response.Redirect("AccessRightDone.aspx");
    }
}
