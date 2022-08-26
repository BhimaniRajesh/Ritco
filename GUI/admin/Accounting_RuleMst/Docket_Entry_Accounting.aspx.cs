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

public partial class GUI_admin_setting_cust_opn_bal_sel_brnch : System.Web.UI.Page
{
    public string custcode, vendorcode,custloc,vendorloc;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btnSubmit.Attributes.Add("onclick", "javascript:return OnSubmit()");
           //***********Modue Entry
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            string Sql = "select Module_Code,Module_Name from Webx_Accounting_Module where Module_Code='01'";
            SqlCommand Cmd = new SqlCommand(Sql, conn);
            SqlDataReader dr;
            dr = Cmd.ExecuteReader();
                DLL_Module.Items.Clear();
                DLL_Module.SelectedIndex = 0;
                DLL_Module.CssClass = "blackfnt";
            while (dr.Read())
            {
                DLL_Module.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

            }
            dr.Close();
           //***********Instance type Type
               Sql = "select Instance_Code,Instance_Name from Webx_Accounting_Instance";
                Cmd = new SqlCommand(Sql, conn);
                dr = Cmd.ExecuteReader();
                LT_Acct_instance.Items.Clear();
                //LT_Acct_instance.Items.Add(new ListItem("Select", ""));
                
                while (dr.Read())
                {
                    LT_Acct_instance.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
                }
                LT_Acct_instance.SelectedIndex = 0;
                LT_Acct_instance.CssClass = "blackfnt";
                dr.Close();
             //***********Instance type Type
                Sql = "select BasedOn_Code,BasedOn_Name from Webx_Accounting_BasedOn";
                Cmd = new SqlCommand(Sql, conn);
                dr = Cmd.ExecuteReader();
                LT_Acct_Based_On.Items.Clear();
                //LT_Acct_Based_On.Items.Add(new ListItem("Select", ""));
                
                while (dr.Read())
                {
                    LT_Acct_Based_On.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
                }
                dr.Close();
                LT_Acct_Based_On.SelectedIndex = 0;
                LT_Acct_Based_On.CssClass = "blackfnt";

                BindGrind();
                BindGrind1();
                conn.Close();

           
        }
    }
    public void BindGrind()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Sql = "";
        //***********Paybas Type
        if (LT_Acct_Based_On.SelectedValue.ToString() == "PAYTYP")
        {
            Sql = "select a.Codeid Paybas_CD,a.Codedesc +'-'+'Cnote/HWB'+' Entry ' as Paybas_Desc,a.Codeid  As Basedon_CD,'Normal' as" +
                " Basedon_Desc ,'CN BOOKING - '+ a.Codedesc   AS OPR_E,'CN CANCEL - '+ a.Codedesc   AS OPR_C from  webx_master_general" +
                " a where a.codetype='PAYTYP' and a.statuscode='Y' and a.codeid<>'P04'";

        }
        else
        {
            Sql = "select a.Codeid Paybas_CD,a.Codedesc +'-'+'Cnote/HWB'+' Entry ' as Paybas_Desc,b.Codeid As Basedon_CD,b.Codedesc as Basedon_Desc ,'CN BOOKING - '+ a.Codedesc   AS OPR_E,'CN CANCEL - '+ a.Codedesc   AS OPR_C from  " +
                  "webx_master_general as a ,webx_master_general  as b where a.codetype='PAYTYP' and a.statuscode='Y' and a.codeid<>'P04' and b.codeid<>'P04' " +
                  "and b.codetype='" + LT_Acct_Based_On.SelectedValue.ToString() + "' and b.statuscode='Y' order by a.codeid,b.codeid";
        }
        SqlCommand Cmd = new SqlCommand(Sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(Cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GV_PayBaseWise.DataSource = ds;
        GV_PayBaseWise.DataBind();
        //conn.Close();
        SqlDataReader dr;
        foreach (GridViewRow gridrow in GV_PayBaseWise.Rows)
        {

            DropDownList DLL_Cr_Ledger = (DropDownList)gridrow.FindControl("DLL_Cr_Ledger");
            DropDownList DLL_Dr_Ledger = (DropDownList)gridrow.FindControl("DLL_Dr_Ledger");
            DropDownList DLL_Instance = (DropDownList)gridrow.FindControl("DLL_Instance");
                 //***********Instance type Type
            /*if (LT_Acct_Based_On.SelectedValue.ToString() == "TRN")
            {
                Sql = "select Acccode,Company_acccode+':'+accDesc as accdesc from webx_acctinfo where acccode in ('IOI0001','IOI0002','IOI0003','PI102','PI104','PI106') order by Company_acccode";
            }
            if (LT_Acct_Based_On.SelectedValue.ToString() == "BUT")
            {
                Sql = "select Acccode,Company_acccode+':'+accDesc as accdesc from webx_acctinfo where acccode in ('IOI0001','IOI0002','IOI0003','PI102','PI104','PI106') order by Company_acccode";
            }*/
            Sql = "exec Webx_Accounting_BasedOn_Listing '" + LT_Acct_Based_On.SelectedValue.ToString() + "','01'";
            Cmd = new SqlCommand(Sql, conn);
            dr = Cmd.ExecuteReader();
            DLL_Cr_Ledger.Items.Clear();
            DLL_Cr_Ledger.Items.Add(new ListItem("Select", ""));

            while (dr.Read())
            {
                DLL_Cr_Ledger.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            // DLL_Cr_Ledger.SelectedIndex = 0;
            DLL_Cr_Ledger.CssClass = "blackfnt";
            dr.Close();
            //***********Instance type Type
            Sql = "select Acccode,Company_acccode+':'+accDesc as accdesc from webx_acctinfo where acccode in ('ACC0006','ACC0001','CDA0001','CDA0002') order by Company_acccode ";
            Cmd = new SqlCommand(Sql, conn);
            dr = Cmd.ExecuteReader();
            DLL_Dr_Ledger.Items.Clear();
            DLL_Dr_Ledger.Items.Add(new ListItem("Select", ""));

            while (dr.Read())
            {
                DLL_Dr_Ledger.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            dr.Close();
            //DLL_Dr_Ledger.SelectedIndex = 0;
            DLL_Dr_Ledger.CssClass = "blackfnt";
            //***********Instance type Type
            Sql = "select Instance_Code,Instance_Name from Webx_Accounting_Instance";
            Cmd = new SqlCommand(Sql, conn);
            dr = Cmd.ExecuteReader();
            DLL_Instance.Items.Clear();
            DLL_Instance.Items.Add(new ListItem("Select", ""));

            while (dr.Read())
            {
                DLL_Instance.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            DLL_Instance.SelectedIndex = 0;
            DLL_Instance.CssClass = "blackfnt";
            dr.Close();
        }
    }
    public void BindGrind1()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string Sql = "";
        //***********Paybas Type

        Sql = "select Charge_Code+'_'+a.Codeid as  Paybas_CD,Charge_Name +'-'+' Charges '+a.Codedesc +'-'+'Cnote/HWB'+' Entry ' as Paybas_Desc,'NA'  As Basedon_CD,'Normal' as  " +
            " Basedon_Desc ,'BILL GENERATION'   AS OPR_E,'BILL CANCELLATION'   AS OPR_C from  Webx_Accounting_Charges B , webx_master_general A " +
            " where a.codetype='PAYTYP' and a.statuscode='Y' and a.codeid<>'P04'  and module_code='02'";

        SqlCommand Cmd = new SqlCommand(Sql, conn);
        SqlDataAdapter da = new SqlDataAdapter(Cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        GV_Accounting_Charges.DataSource = ds;
        GV_Accounting_Charges.DataBind();
        //conn.Close();
        SqlDataReader dr;
        foreach (GridViewRow gridrow in GV_Accounting_Charges.Rows)
        {

            DropDownList DLL_Cr_Ledger = (DropDownList)gridrow.FindControl("DLL_Cr_Ledger");
            DropDownList DLL_Dr_Ledger = (DropDownList)gridrow.FindControl("DLL_Dr_Ledger");
            DropDownList DLL_Instance = (DropDownList)gridrow.FindControl("DLL_Instance");
            Sql = "select Acccode,Company_acccode+':'+accDesc as accdesc from webx_acctinfo where   ACCCODE IN ( 'CLO0023','LCS0001','LCS0002') order by Company_acccode";
            Cmd = new SqlCommand(Sql, conn);
            dr = Cmd.ExecuteReader();
            DLL_Cr_Ledger.Items.Clear();
            DLL_Cr_Ledger.Items.Add(new ListItem("Select", ""));

            while (dr.Read())
            {
                DLL_Cr_Ledger.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
            }
            // DLL_Cr_Ledger.SelectedIndex = 0;
            DLL_Cr_Ledger.CssClass = "blackfnt";
            dr.Close();
            //***********Instance type Type
            //Sql = "select Acccode,Company_acccode+':'+accDesc as accdesc from webx_acctinfo where acccode in ('CDA0001') order by Company_acccode ";
            //Cmd = new SqlCommand(Sql, conn);
            //dr = Cmd.ExecuteReader();
            DLL_Dr_Ledger.Items.Clear();
            DLL_Dr_Ledger.Items.Add(new ListItem("NA", "NA"));
 
            DLL_Dr_Ledger.SelectedIndex = 0;
            DLL_Dr_Ledger.CssClass = "blackfnt";
            //***********Instance type Type
            //Sql = "select Instance_Code,Instance_Name from Webx_Accounting_Instance where  Module_Code='02'";
            //Cmd = new SqlCommand(Sql, conn);
            //dr = Cmd.ExecuteReader();
            DLL_Instance.Items.Clear();
            DLL_Instance.Items.Add(new ListItem("NA", "NA"));

            DLL_Instance.SelectedIndex = 0;
            DLL_Instance.CssClass = "blackfnt";

        }
    }
    protected void LT_Acct_Based_On_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrind();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlTransaction trans;
        trans = conn.BeginTransaction();
        try
        {
            string[] Hnd_Paybas_Str_Submit_Arr;

            string Sql = "", From_Accdesc = "", To_Accdesc = "";
            Hnd_Paybas_Str_Submit_Arr = Hnd_Paybas_Str.Value.Split('~');

            Sql = "delete from Webx_Accounting_Rule where Module_Code='01'";
            SqlCommand Cmd = new SqlCommand(Sql, conn, trans);
            Cmd.ExecuteNonQuery();

            foreach (GridViewRow gridrow in GV_PayBaseWise.Rows)
            {

                DropDownList DLL_Cr_Ledger = (DropDownList)gridrow.FindControl("DLL_Cr_Ledger");
                DropDownList DLL_Dr_Ledger = (DropDownList)gridrow.FindControl("DLL_Dr_Ledger");
                DropDownList DLL_Instance = (DropDownList)gridrow.FindControl("DLL_Instance");

                HiddenField Hnd_paybas = (HiddenField)gridrow.FindControl("Hnd_paybas");
                HiddenField Hnd_BasedOn_CD = (HiddenField)gridrow.FindControl("Hnd_BasedOn_CD");

                HiddenField OPR_E = (HiddenField)gridrow.FindControl("OPR_E");
                HiddenField OPR_C = (HiddenField)gridrow.FindControl("OPR_C");

                TextBox Narration_Entry = (TextBox)gridrow.FindControl("Narration_Entry");
                TextBox Narration_Cancel = (TextBox)gridrow.FindControl("Narration_Cancel");

                string[] DLL_Cr_Ledger_Arr = DLL_Cr_Ledger.SelectedItem.Text.ToString().Split(':');
                From_Accdesc = DLL_Cr_Ledger_Arr[1].ToString();
                string[] DLL_Dr_Ledger_Arr = DLL_Dr_Ledger.SelectedItem.Text.ToString().Split(':');
                To_Accdesc = DLL_Dr_Ledger_Arr[1].ToString();

                Sql = "insert into Webx_Accounting_Rule (Module_Code,PayBas,Instance_Code,BasedOn_Type,BasedOn_Code,From_Acccode,From_Accdesc,To_Acccode,To_Accdesc,Opertitle_Entry,Opertitle_Cancel,Narration_Entry,Narration_Cancel ) values "+
                    "('01','" + Hnd_paybas.Value.ToString() + "','" + DLL_Instance.SelectedValue.ToString() + "','" + LT_Acct_Based_On.SelectedValue.ToString() + "','" + Hnd_BasedOn_CD.Value.ToString() + "','" + DLL_Cr_Ledger.SelectedValue.ToString() + "','" + From_Accdesc + "','" + DLL_Dr_Ledger.SelectedValue.ToString() + "','" + To_Accdesc + "' " +
                    " ,'" + OPR_E.Value.ToString() + "','" + OPR_C.Value.ToString() + "','" + Narration_Entry.Text.ToString() + "','" + Narration_Cancel.Text.ToString() + "') ";
                Cmd = new SqlCommand(Sql, conn, trans);
                Cmd.ExecuteNonQuery();

            }

            foreach (GridViewRow gridrow in GV_Accounting_Charges.Rows)
            {

                DropDownList DLL_Cr_Ledger = (DropDownList)gridrow.FindControl("DLL_Cr_Ledger");
                DropDownList DLL_Dr_Ledger = (DropDownList)gridrow.FindControl("DLL_Dr_Ledger");
                DropDownList DLL_Instance = (DropDownList)gridrow.FindControl("DLL_Instance");

                HiddenField Hnd_paybas = (HiddenField)gridrow.FindControl("Hnd_paybas");
                HiddenField Hnd_BasedOn_CD = (HiddenField)gridrow.FindControl("Hnd_BasedOn_CD");

                HiddenField OPR_E = (HiddenField)gridrow.FindControl("OPR_E");
                HiddenField OPR_C = (HiddenField)gridrow.FindControl("OPR_C");

                TextBox Narration_Entry = (TextBox)gridrow.FindControl("Narration_Entry");
                TextBox Narration_Cancel = (TextBox)gridrow.FindControl("Narration_Cancel");

                string[] DLL_Cr_Ledger_Arr = DLL_Cr_Ledger.SelectedItem.Text.ToString().Split(':');
                From_Accdesc = DLL_Cr_Ledger_Arr[1].ToString();
                string[] DLL_Dr_Ledger_Arr = DLL_Dr_Ledger.SelectedItem.Text.ToString().Split(':');
                To_Accdesc = "NA";// DLL_Dr_Ledger_Arr[1].ToString();

                Sql = "insert into Webx_Accounting_Rule (Module_Code,PayBas,Instance_Code,BasedOn_Type,BasedOn_Code,From_Acccode,From_Accdesc,To_Acccode,To_Accdesc,Opertitle_Entry,Opertitle_Cancel,Narration_Entry,Narration_Cancel ) values " +
                    "('01','" + Hnd_paybas.Value.ToString() + "','" + DLL_Instance.SelectedValue.ToString() + "','" + LT_Acct_Based_On.SelectedValue.ToString() + "','" + Hnd_BasedOn_CD.Value.ToString() + "','" + DLL_Cr_Ledger.SelectedValue.ToString() + "','" + From_Accdesc + "','" + DLL_Dr_Ledger.SelectedValue.ToString() + "','" + To_Accdesc + "' " +
                    " ,'" + OPR_E.Value.ToString() + "','" + OPR_C.Value.ToString() + "','" + Narration_Entry.Text.ToString() + "','" + Narration_Cancel.Text.ToString() + "') ";
                Cmd = new SqlCommand(Sql, conn, trans);
                Cmd.ExecuteNonQuery();

            }
            
            trans.Commit();
            conn.Close();
            Response.Redirect("../ManageRules.aspx");
        }
        catch (Exception e1)
        {
            Response.Write("<br><br><br><center><font class='blackboldfnt' color='red'><b>Error : " + e1.Message + "</b></font></center>");
            string msg = e1.Message.ToString();
            msg = msg.Replace('\n', ' ');
            trans.Rollback();
            //Response.Redirect("Message.aspx?" + e1.Message);
            Response.End();
        }
     }
}
