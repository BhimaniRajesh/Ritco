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

public partial class GUI_admin_Accounts_masters_Accounts_Add_Accounts : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    public static string Edit_Accountcode = "", Flag = "ADD", Exist_GroupCode = "", strContractChargesTemp="";
    public static int AccountCode_count = 0,chk_count=0;
     
    protected void Page_Load(object sender, EventArgs e)
    {

        Edit_Accountcode = Request.QueryString.ToString();

        if (!IsPostBack)
        {
            strContractChargesTemp = "";
            //******************Starts Pay Bases*************************************
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlConnection conn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim());
           
            SqlDataReader dr_groups;
            conn.Open();
            string sql = "select groupcode,ltrim(rtrim(groupdesc))+':'+ltrim(rtrim(groupcode)),groupcode,groupdesc,grouplevel from webx_groups  WITH(NOLOCK)  order by groupdesc";
            //string sql = "select codetype_new,abbr_type from webx_typemst where   activeflag='Y'";
            SqlCommand cmd = new SqlCommand(sql, conn);
            dr_groups = cmd.ExecuteReader();

            cmbGroup.Items.Clear();
            //cmbGroup.Items.Add("Main level");

            cmbGroup.Items.Add(new ListItem("Main level", "~1"));

            while (dr_groups.Read())
            {
                cmbGroup.Items.Add(new ListItem(dr_groups.GetValue(1).ToString(), dr_groups.GetValue(0).ToString()));

            }
            cmbGroup.SelectedIndex = 0;
            cmbGroup.CssClass = "blackfnt";
            dr_groups.Close();
           

            //Edit_Accountcode = Request.QueryString.Get("grpcode");
           
        //  Response.Write("<br>Edit_Accountcode-" + Edit_Accountcode);
          // Response.End();
            if (Edit_Accountcode != "" && Edit_Accountcode != "ADD")
            {
                sql = "select *  from webx_acctInfo WITH(NOLOCK) where acccode='" + Edit_Accountcode + "'";
                ////Response.Write("<br>sql-" + sql);
                // Response.Write("<br>Edit_Accountcode-" + AccountCode_count);
                // Response.End();
                cmd = new SqlCommand(sql, conn);

                SqlDataReader dr = null;
                dr = cmd.ExecuteReader();
                string desc_code = "";
                if (dr.Read())
                {
                    AccountCode_count = 1;
                    txtAccDesc.Text = Convert.ToString(dr["Accdesc"]);

                    //desc_code = Convert.ToString(dr["parentcode"]).Trim() + "~" + Convert.ToString(dr["grouplevel"]).Trim();
                    //Response.Write("<br>desc_code-" + desc_code);
                    //Response.End();

                    cmbGroup.SelectedValue = Convert.ToString(dr["groupcode"]);//Convert.ToString(dr["groupcode"]).Trim() + "~" + Convert.ToString(dr["grouplevel"]).Trim();
                    cmbAccCategory.SelectedValue = Convert.ToString(dr["Acccategory"]);
                    string manual_yn = Convert.ToString(dr["manual_yn"]);
                    if (manual_yn == "Y")
                    {
                        chk_manual_voucher.Checked = true;
                        Manual_voucher_yn.Text = "Yes";
                    }
                    else
                    {
                        chk_manual_voucher.Checked = false;
                        Manual_voucher_yn.Text = "No";
                    }
                    string subgroup = Convert.ToString(dr["subgroup"]);
                    if (subgroup == "Y")
                    {

                        Chk_subgroup.Checked = true;
                        Txtsubgroup.Text = "Yes";
                    }
                    else
                    {
                        Chk_subgroup.Checked = false;
                        Txtsubgroup.Text = "No";
                    }
                    string ACTIVEFLAG = Convert.ToString(dr["ACTIVEFLAG"]);
                    if (ACTIVEFLAG == "Y")
                    {

                        Chk_activeflag.Checked = true;
                        Txtactiveflag.Text = "Yes";
                    }
                    else
                    {
                        Chk_activeflag.Checked = false;
                        Txtactiveflag.Text = "No";
                    }
                    string bankAcct_Deposit = Convert.ToString(dr["bankAcct_Deposit"]);
                    if (bankAcct_Deposit == "Y")
                    {

                        Chk_deposit.Checked = true;
                        Txt_deposit.Text = "Yes";
                    }
                    else
                    {
                        Chk_deposit.Checked = false;
                        Txt_deposit.Text = "No";
                    }

                    string AccountAccessIn = Convert.ToString(dr["AccountAccessIn"]);
                    bool Pay_yn = AccountAccessIn.Contains("P"), Rec_yn = AccountAccessIn.Contains("R");
                    if (Pay_yn == true)
                    {
                        chkpay_YN.Checked = true;
                        Txtpay_YN.Text = "Yes";
                    }
                    else
                    {
                        chkpay_YN.Checked = false;
                        Txtpay_YN.Text = "No";
                    }
                    if (Rec_yn == true)
                    {

                        chkrec_YN.Checked = true;
                        Txtrec_YN.Text = "Yes";
                    }
                    else
                    {
                        chkrec_YN.Checked = false;
                        Txtrec_YN.Text = "No";
                    }
                    string AccountAccessBy = Convert.ToString(dr["AccountAccessBy"]);
                    string[] AccountAccessBy_arr = AccountAccessBy.ToString().Split(',');
                    conn1.Open();
                    //for (int i = 1; i <= AccountAccessBy_arr.Length;i++ )
                    //{

                    sql = "select codeid as level_No,codedesc as level_Type from webx_master_general with(nolock) where codetype='HRCHY' order by codeid ";
                    //Response.Write("AccountAccessBy_arr--" + sql);
                    //Response.End();
                    cmd = new SqlCommand(sql, conn1);

                    SqlDataReader dr1 = null;
                    dr1 = cmd.ExecuteReader();
                    //string desc_code = "";
                    int edit_chk_count = 0;
                    while (dr1.Read())
                    {
                        edit_chk_count = edit_chk_count + 1;
                        if (AccountAccessBy.Contains(Convert.ToString(edit_chk_count)))
                        {
                            if (edit_chk_count == 1)
                            {
                                strContractChargesTemp += "<tr bgcolor='#ffffff'><td class='blackfnt' colspan='2' >Account Access By </td><td   colspan='2'><INPUT name=Chk_" + Convert.ToString(dr1["level_No"]) + " value='Y'  checked type=checkbox onclick='Chk_Text_YN_1(this," + Convert.ToString(dr1["level_No"]) + ")'>";
                            }
                            else
                            {
                                strContractChargesTemp += "<tr bgcolor='#ffffff'><td class='blackfnt'  colspan='2'> </td><td   colspan='2'><INPUT name=Chk_" + Convert.ToString(dr1["level_No"]) + " value='Y' class='blackfnt' checked type=checkbox onclick='Chk_Text_YN_1(this," + Convert.ToString(dr1["level_No"]) + ")'>";
                            }
                            strContractChargesTemp += "<INPUT name=Txt_" + Convert.ToString(dr1["level_No"]) + " value='Yes' type=text  maxlength='3' size='3' class='blackfnt' disabled>";
                            // strContractChargesTemp += "<td>";
                            strContractChargesTemp += "<font class=blackfnt> " + Convert.ToString(dr1["Level_Type"]) + " </font>";
                            strContractChargesTemp += "</td></tr>";
                        }
                        else
                        {
                            if (edit_chk_count == 1)
                            {
                                strContractChargesTemp += "<tr bgcolor='#ffffff'><td class='blackfnt' colspan='2' >Account Access By </td><td   colspan='2'><INPUT name=Chk_" + Convert.ToString(dr1["level_No"]) + " value='Y'   type=checkbox onclick='Chk_Text_YN_1(this," + Convert.ToString(dr1["level_No"]) + ")'>";
                            }
                            else
                            {
                                strContractChargesTemp += "<tr bgcolor='#ffffff'><td class='blackfnt'  colspan='2'> </td><td   colspan='2'><INPUT name=Chk_" + Convert.ToString(dr1["level_No"]) + " value='Y' class='blackfnt'  type=checkbox onclick='Chk_Text_YN_1(this," + Convert.ToString(dr1["level_No"]) + ")'>";
                            }
                            strContractChargesTemp += "<INPUT name=Txt_" + Convert.ToString(dr1["level_No"]) + " value='No' type=text  maxlength='3' size='3' class='blackfnt' disabled>";
                            // strContractChargesTemp += "<td>";
                            strContractChargesTemp += "<font class=blackfnt> " + Convert.ToString(dr1["Level_Type"]) + " </font>";
                            strContractChargesTemp += "</td></tr>";
                        }
                    }
                    dr1.Close();
                    //}
                    conn1.Close();
                    bkAcctNo.Text = Convert.ToString(dr["bkAcctNo"]);
                    bkLocCode.Text = Convert.ToString(dr["bkLocCode"]);
                    txtContPerson.Text = Convert.ToString(dr["Contperson"]);
                    txtAddress.Text = Convert.ToString(dr["Address"]);

                    txtPin.Text = Convert.ToString(dr["Pin"]);
                    txtCity.Text = Convert.ToString(dr["City"]);
                    txtFax.Text = Convert.ToString(dr["Fax"]);
                    Txtemail.Text = Convert.ToString(dr["Email"]);
                    TxtTel.Text = Convert.ToString(dr["Tel"]);
                    txtState.Text = Convert.ToString(dr["State"]);
                    depmethod.SelectedValue = Convert.ToString(dr["depmethod"]);
                    deprate.Text = Convert.ToString(dr["deprate"]);
                }
                //else 
                //{
                //    //lblGroupcode.Text = "<font class=blackfnt color=red><b>Invalid Account Code</b></font>";
                //     Response.Write("<font class=blackfnt color=red><b>Invalid Account Code</b></font>");
                //    Response.End();

                //}


                dr.Close();
            }
            else {
                                AccountCode_count = 0;
            }
        //Response.Write("<br>Edit_Accountcode-" + AccountCode_count);
       // Response.End();
        if (AccountCode_count > 0)
        {
            Flag = "EDIT";
        }
        if (Flag == "EDIT")
        {
            lblGroupcode.Text = Edit_Accountcode;
            mastertype.Text = "Edit Accounts ";
            mastertype1.Text = "Edit Accounts ";
        }
            if (Flag == "ADD")
            {
                sql = "select codeid as level_No,codedesc as level_Type from webx_master_general with(nolock) where codetype='HRCHY' order by codeid ";
                 cmd = new SqlCommand(sql, conn);
           
            SqlDataReader dr1 = null;
            dr1 = cmd.ExecuteReader();
            //string desc_code = "";
            
            while (dr1.Read())
            {
                chk_count = chk_count+1;

                //txtAccDesc.Text = Convert.ToString(dr1["Level_no"]);
                if (chk_count == 1)
                {
                    strContractChargesTemp += "<tr bgcolor='#ffffff'><td class='blackfnt' colspan='2' >Account Access By </td><td   colspan='2'><INPUT name=Chk_" + Convert.ToString(dr1["Level_no"]) + " value='Y'  checked type=checkbox onclick='Chk_Text_YN_1(this," + Convert.ToString(dr1["Level_no"]) + ")'>";
                }
                else
                {
                    strContractChargesTemp += "<tr bgcolor='#ffffff'><td class='blackfnt'  colspan='2'> </td><td   colspan='2'><INPUT name=Chk_" + Convert.ToString(dr1["Level_no"]) + " value='Y' class='blackfnt' checked type=checkbox onclick='Chk_Text_YN_1(this," + Convert.ToString(dr1["Level_no"]) + ")'>";
                }
                strContractChargesTemp += "<INPUT name=Txt_" + Convert.ToString(dr1["Level_no"]) + " value='Yes' type=text  maxlength='3' size='3' class='blackfnt' disabled>";
                    // strContractChargesTemp += "<td>";
                    strContractChargesTemp += "<font class=blackfnt> " + Convert.ToString(dr1["Level_Type"]) + " </font>";
                    strContractChargesTemp += "</td></tr>";
                

            }
          //  Response.Write(strContractChargesTemp);
          //  Response.End();
            dr1.Close();
            conn.Close();
            //******************end  Pay Bases*************************************
        }
            Submit.Attributes.Add("onclick", "javascript:return ADDme()");
            chk_manual_voucher.Attributes.Add("onclick", "javascript:return Chk_Text_YN(this,'" + Manual_voucher_yn.ClientID + "')");
            chkpay_YN.Attributes.Add("onclick", "javascript:return Chk_Text_YN(this,'" +Txtpay_YN.ClientID + "')");
            chkrec_YN.Attributes.Add("onclick", "javascript:return Chk_Text_YN(this,'" + Txtrec_YN.ClientID + "')");
            Chk_subgroup.Attributes.Add("onclick", "javascript:return Chk_Text_YN(this,'" + Txtsubgroup.ClientID + "')");
            Chk_activeflag.Attributes.Add("onclick", "javascript:return Chk_Text_YN(this,'" + Txtactiveflag.ClientID + "')");
            Chk_deposit.Attributes.Add("onclick", "javascript:return Chk_Text_YN(this,'" + Txt_deposit.ClientID + "')");
            txtPin.Attributes.Add("onblur", "javascript:return Pin_Email_val(this,'Pin')");
            Txtemail.Attributes.Add("onblur", "javascript:return Pin_Email_val(this,'Email')");
           
        }
    }
    protected void Submit_Click(object sender, EventArgs e)
    {
        string Groupdesc = "", ArrParentcode = "", Parentcode = "", Grouplevel = "", groupCode = "", Acct_prefix = "", entryby="";
        
        string Acccode = "",Accdesc = "",Groupcode = "",Acccategory = "",Brcd=Session["brcd"].ToString(),Address = "",Pin = "",City = "",Fax = "",Email = "",Tel = "",State = "",Contperson = "",secid = "",secdetailid = "",panno = "";
       string  Entryby = "",Entrydt = "",subgroup = "",ACTIVEFLAG = "",ACCTTYPE = "",manual_yn = "",strAccountAccessBy = "",strAccountAccessIn = "",strbkAcctNo = "",strbkloccode = "";
       string bankAcct_Deposit = "", str_depmethod = "", strdeprate = "";
      
       Accdesc = txtAccDesc.Text.ToString();
       Groupcode = cmbGroup.SelectedValue.ToString();
       
     //  Response.Write("Acccode-" + Acccode);
     //  Response.End();
       Acccategory = cmbAccCategory.SelectedValue.ToString();
       Address = txtAddress.Text.ToString();
       Pin = txtPin.Text.ToString();
       City = txtCity.Text.ToString();
      
        Fax=txtFax.Text.ToString();
        Email=Txtemail.Text.ToString();
        Tel=TxtTel.Text.ToString();
        State=txtState.Text.ToString();
        Contperson=txtContPerson.Text.ToString();
        //secid
        //secdetailid
        //panno
        Entryby=Session["empcd"].ToString();
        subgroup=Txtsubgroup.Text.ToString();

        if (Chk_subgroup.Checked)
        {
            subgroup = "Y";
        }
        else
        {
            subgroup = "N";
        }
        if(Chk_activeflag.Checked)
        {
            ACTIVEFLAG="Y";
        }
        else
        {
            ACTIVEFLAG="N";
        }
        ACCTTYPE = "F";
        
        if(chk_manual_voucher.Checked)
        {
            manual_yn="Y";
        }
        else
        {
            manual_yn="N";
        }

        strAccountAccessBy = AccountAccessBy.Value.ToString();
        strAccountAccessIn = AccountAccessIn.Value.ToString();
        strbkAcctNo = bkAcctNo.Text.ToString();
        strbkloccode = bkLocCode.Text.ToString();

        if (Chk_deposit.Checked)
        {
            bankAcct_Deposit = "Y";
        }
        else
        {
            bankAcct_Deposit = "N";
        }

        str_depmethod=depmethod.SelectedValue.ToString();
        strdeprate = deprate.Text.ToString();


        if (Flag == "ADD")
        {
           // groupCode = fn.GetGroupCode(Parentcode, Groupdesc);
            Acccode = fn.GetAccountCode(Groupcode);
            string SQL = "Insert into webx_acctInfo (Acccode,Accdesc,Groupcode,Acccategory,Brcd,Address,Pin,City,Fax,Email,Tel,State,Contperson,secid,secdetailid,panno,Entryby,Entrydt,subgroup,ACTIVEFLAG,ACCTTYPE,manual_yn,AccountAccessBy,AccountAccessIn,bkAcctNo,bkloccode,bankAcct_Deposit,depmethod,deprate,Company_Acccode) Values";
            SQL = SQL + "('" + Acccode + "','" + Accdesc + "','" + Groupcode + "','" + Acccategory + "','" + Brcd + "','" + Address + "','" + Pin + "','" + City + "','" + Fax + "','" + Email + "','" + Tel + "','" + State + "','" + Contperson + "',NUll,Null,Null,'" + Entryby + "',getdate(),'" + subgroup + "','" + ACTIVEFLAG + "','" + ACCTTYPE + "','" + manual_yn + "','" + strAccountAccessBy + "','" + strAccountAccessIn + "','" + strbkAcctNo + "','" + strbkloccode + "','" + bankAcct_Deposit + "','" + str_depmethod + "','" + strdeprate + "','" + Acccode + "')";
           // Response.Write("Acccode-" + SQL);
           // Response.End();
            SqlConnection Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlCommand cmd = new SqlCommand(SQL, Conn);
            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();
        }
        else
        {


            string SQL = "update webx_acctInfo set Accdesc='" + Accdesc + "',Groupcode='" + Groupcode + "',Acccategory='" + Acccategory + "',Brcd='" + Acccategory + "',Address='" + Address + "',Pin='" + Pin + "',City='" + City + "',Fax='" + Fax + "',Email='" + Email + "',Tel='" + Tel + "',State='" + State + "',Contperson='" + Contperson + "',secid=null,secdetailid=Null,panno=Null,Entryby='" + Session["empcd"].ToString() + "',Entrydt=getdate(),subgroup='" + subgroup + "',ACTIVEFLAG='" + ACTIVEFLAG + "',ACCTTYPE='" + ACCTTYPE + "',manual_yn='" + manual_yn + "',AccountAccessBy='" + strAccountAccessBy + "',AccountAccessIn='" + strAccountAccessIn + "',bkAcctNo='" + strbkAcctNo + "',bkloccode='" + strbkloccode + "',bankAcct_Deposit='" + bankAcct_Deposit + "',depmethod='" + str_depmethod + "',deprate='" + strdeprate + "' where Acccode='" + Edit_Accountcode + "' ";
         // Response.Write("Acccode-" + SQL);
          //   Response.End();
            SqlConnection Conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            SqlCommand cmd = new SqlCommand(SQL, Conn);
            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();
        }
        Response.Redirect("Accountslist.aspx?All");
    }
}
