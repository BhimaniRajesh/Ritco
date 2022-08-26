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

public partial class GUI_admin_AutoEmail_AutoEmail_Step2 : System.Web.UI.Page
{
    SqlConnection conn;
    public static int chgV = 0;
    public static string RPTID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        RPTID = Request.QueryString["id"];

        if (RPTID == null)
            RPTID = "0";
        if (RPTID == "")
            RPTID = "0";
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (!IsPostBack)
        {
            if (RPTID == "0")
            {
                string strrpt = "select srno,ReportName=ReportName+' - '+type from  Webx_AutoEmail_Reports R where activeflag='Y' and (select count(*) from Webx_AutoEmail_Schedule where  ReportID=r.srno)<>'3' order by srno";
                SqlCommand cmd = new SqlCommand(strrpt, conn);
                SqlDataReader dr = cmd.ExecuteReader();
                DllListRPT.Items.Clear();
                DllListRPT.Items.Add(new ListItem("--Select--", ""));
                while (dr.Read())
                {
                    DllListRPT.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
                }
                dr.Close();


                conn.Close();

                txtDateFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtDateTo.Text = System.DateTime.Today.AddDays(+400).ToString("dd/MM/yyyy");
            }
            else
            {
                tr1.Style["display"] = "block";
                tr2.Style["display"] = "block";
                tr3.Style["display"] = "block";
                tr4.Style["display"] = "block";
                Tr5.Style["display"] = "block";
                BtnStep1.Style["display"] = "none";
                BtnStep2.Style["display"] = "none";


                string stredit = "select JobName,RoleID,ProfileID,freq_subday_interval,freq_relative_interval,R.srno,Freq,Reportname=Reportname+' - '+type,Freqty=(case when Freq=4 then 'Daily' when Freq=8 then 'Weekly' when Freq=16 then 'Monthly' end ) from Webx_AutoEmail_Reports R inner join Webx_AutoEmail_Schedule T on r.srno=t.ReportID  where t.srno=" + RPTID + "";
                SqlCommand cmdedit = new SqlCommand(stredit, conn);
                SqlDataReader dredit = cmdedit.ExecuteReader();

                string ED_RPTID = "",ED_RPTNM= "", ED_TYPE = "",ED_Fr = "", ED_Jname = "";
                string ED_RoleID = "", ED_ProfileID = "", ED_FST = "", ED_FT = "";



                while (dredit.Read())
                {
                    ED_RPTID = dredit["srno"].ToString();
                    ED_RPTNM = dredit["Reportname"].ToString();
                    ED_TYPE = dredit["Freqty"].ToString();
                    ED_Fr = dredit["Freq"].ToString();
                    ED_RoleID = dredit["RoleID"].ToString();
                    ED_ProfileID = dredit["ProfileID"].ToString();
                    ED_Jname = dredit["JobName"].ToString();
                    ED_FST = dredit["freq_subday_interval"].ToString();
                    ED_FT = dredit["freq_relative_interval"].ToString();
                }
                DllOccurs.Items.Clear();
                DllOccurs.Items.Add(new ListItem(ED_TYPE, ED_Fr));

                string[] strED_RoleID = ED_RoleID.Split(',');
                string[] strED_Fr = ED_FST.Split(',');

                if (ED_Fr == "8")
                {
                    foreach (ListItem l1 in chkWeek.Items)
                    {
                        for (int it = 0; it < strED_Fr.Length; it++)
                        {
                            if (l1.Value.ToString() == strED_Fr[it].ToString())
                            {
                                l1.Selected = true;
                            }
                        }
                    }

                    TrWeekly.Style["display"] = "block";
                }
                else
                {
                    if (ED_Fr == "16")
                        TrMonthly.Style["display"] = "block";

                    DllOnMnweek.SelectedValue = ED_FST;
                }

                DllOnMnDays.SelectedValue = ED_FT;
                

                DllListRPT.Items.Clear();
                DllListRPT.Items.Add(new ListItem(ED_RPTNM, ED_RPTID));

                dredit.Close();

                SqlCommand cmd = new SqlCommand("select srno,ROledesc from Webx_Master_Role where ACTIVEFLAG='Y'", conn);
                SqlDataReader dr = cmd.ExecuteReader();
                Int32 i = 0;
                chkDesig.Items.Clear();
                while (dr.Read())
                {
                    string a;
                    chkDesig.Items.Add(Convert.ToString(dr["ROledesc"]));
                    chkDesig.Items[i].Value = Convert.ToString(dr["srno"]);
                    i += 1;
                }
                chgV = i;

                foreach (ListItem l1 in chkDesig.Items)
                {
                    for (int it = 0; it < strED_RoleID.Length; it++)
                    {
                        if (l1.Value.ToString() == strED_RoleID[it].ToString())
                        {
                            l1.Selected = true;
                        }
                    }
                }

               


                hd1.Value = i.ToString();
                // Response.Write("..." + chgV);
                chkDesig.CssClass = "blackfnt";
                dr.Close();

                cmd = new SqlCommand("select name,PFNM=replace(replace(name,'_',' '),'MYProf','') from msdb.dbo.sysmail_profile", conn);
                dr = cmd.ExecuteReader();
                dllProfile.Items.Clear();
                dllProfile.Items.Add(new ListItem("--Select--", ""));
                while (dr.Read())
                {
                    dllProfile.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));

                }
                dllProfile.SelectedValue = ED_ProfileID;

                dr.Close();

                string strdate = "select job_id,Startdt=convert(varchar,convert(datetime,convert(varchar,active_start_date)),103),ENDDT=convert(varchar,convert(datetime,convert(varchar,active_end_date)),103),Starttime=(case when left(active_start_time,1)='0' then right(convert(varchar,convert(datetime,convert(varchar,getdate(),6)+' '+left(convert(varchar,active_start_time),2)+':'+right(left(convert(varchar,active_start_time),4),2)),100)  ,6) else right(convert(varchar,convert(datetime,convert(varchar,getdate(),6)+' '+left(convert(varchar,active_start_time),2)+':'+right(left(convert(varchar,active_start_time),4),2)),100)  ,7) end),ENDtime=(case when left(active_end_time,1)='0' then right(convert(varchar,convert(datetime,convert(varchar,getdate(),6)+' '+left(convert(varchar,active_end_time),2)+':'+right(left(convert(varchar,active_start_time),4),2)),100)  ,6) else right(convert(varchar,convert(datetime,convert(varchar,getdate(),6)+' '+left(convert(varchar,active_end_time),2)+':'+right(left(convert(varchar,active_start_time),4),2)),100)  ,7) end) from (select job_id,active_start_date,active_end_date,active_start_time=(case when len(active_start_time)<>6 then '0'+convert(varchar,active_start_time)  else convert(varchar,active_start_time) end),active_end_time=(case when len(active_end_time)<>6 then '0'+convert(varchar,active_end_time) else convert(varchar,active_end_time) end) ,freq_subday_interval,freq_relative_interval  from  msdb.dbo.sysschedules A inner join   msdb.dbo.sysjobschedules b on a.schedule_id=b.schedule_id  where  job_id =(select job_id from msdb.dbo.sysjobs where name='" + ED_Jname + "'))T ";
                cmd = new SqlCommand(strdate, conn);
                 dr = cmd.ExecuteReader();

                 string ED_STDT = "", ED_ENDDT = "", ED_STTM = "", ED_ENDTM = "";

                 while (dr.Read())
                 {
                     ED_STDT = dr["Startdt"].ToString();
                     ED_ENDDT = dr["ENDDT"].ToString();
                     ED_STTM = dr["Starttime"].ToString();
                     ED_ENDTM = dr["ENDtime"].ToString();
                 }
                 dr.Close();

                 txtDateFrom.Text = ED_STDT;
                 txtDateTo.Text = ED_ENDDT;
                 txtEntime.Text = ED_ENDTM;
                 txtSttime.Text = ED_STTM;
            }
        }
        conn.Close();
       // this.TimePicker1.MinimumTime = new TimeSpan(9, 0, 0);
    }
    protected void BtnStep1_Click(object sender, EventArgs e)
    {
        tr1.Style["display"] = "block";
        tr2.Style["display"] = "block";

        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();

        SqlCommand cmd = new SqlCommand("select srno,ROledesc from Webx_Master_Role where ACTIVEFLAG='Y'", conn);
        SqlDataReader dr = cmd.ExecuteReader();
        Int32 i = 0;
        chkDesig.Items.Clear();
        while (dr.Read())
        {
            string a;
            chkDesig.Items.Add(Convert.ToString(dr["ROledesc"]));
            chkDesig.Items[i].Value = Convert.ToString(dr["srno"]);
            i += 1;
        }
        chgV = i;

        hd1.Value = i.ToString();
       // Response.Write("..." + chgV);
        chkDesig.CssClass = "blackfnt";
        dr.Close();

        cmd = new SqlCommand("select name,PFNM=replace(replace(name,'_',' '),'MYProf','') from msdb.dbo.sysmail_profile", conn);
         dr = cmd.ExecuteReader();
         dllProfile.Items.Clear();
         dllProfile.Items.Add(new ListItem("--Select--", ""));
         while (dr.Read())
         {
             dllProfile.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
           
         }
       
       
        dr.Close();

        conn.Close();
        DllListRPT.Enabled = false;
        BtnStep1.Enabled = false;
    }
    protected void BtnStep2_Click(object sender, EventArgs e)
    {
        tr3.Style["display"] = "block";
        tr4.Style["display"] = "block";
        Tr5.Style["display"] = "block";
        chkDesig.Enabled = false;
        dllProfile.Enabled = false;
        BtnStep2.Enabled = false;
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();


        string strQy = "select * from (select freq='4',FreqTYp='Daily' union select freq='8',FreqTYp='Weekly' union select freq='16',FreqTYp='Monthly')t where freq not in (select freq from Webx_AutoEmail_Schedule where reportid='"+DllListRPT.SelectedValue.ToString()+"' )   ";
        SqlCommand cmd = new SqlCommand(strQy, conn);
        SqlDataReader dr = cmd.ExecuteReader();
        DllOccurs.Items.Clear();
        DllOccurs.Items.Add(new ListItem("--Select--", ""));
        while (dr.Read())
        {
            DllOccurs.Items.Add(new ListItem(dr.GetValue(1).ToString(), dr.GetValue(0).ToString()));
        }
        dr.Close();


        conn.Close();
    }
    protected void BtnStep3_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        DllListRPT.Enabled = true;
        BtnStep1.Enabled = true;
        chkDesig.Enabled = true;
        dllProfile.Enabled = true;
        BtnStep2.Enabled = true;
        string Roleid = "", FreqSubnt = "",Profileid="";
        Profileid = dllProfile.SelectedValue.ToString();
        string RPTFreQ = DllOccurs.SelectedValue.ToString();
       

        string stRPTID = DllListRPT.SelectedValue.ToString();
       
        string MonthWeek = DllOnMnDays.SelectedValue.ToString();
        string FreQInt = dllOccEVE.SelectedValue.ToString();
        FreqSubnt = DllOnMnweek.SelectedValue.ToString();
        if (RPTFreQ == "8")
        {
           /// RPTFreQ = "";
            int fq = 0;
            foreach (ListItem li in chkWeek.Items)
            {
                if (li.Selected == true)
                {
                    fq += Convert.ToInt16(li.Value);                               
                }
            }
            FreQInt = fq.ToString();
            //MonthWeek = "1";
        }

        if (RPTFreQ == "8")
        {
            foreach (ListItem li in chkWeek.Items)
            {
                if (li.Selected == true)
                {
                    if (FreqSubnt == "")
                        FreqSubnt = li.Value.ToString();
                    else
                        FreqSubnt = FreqSubnt + "," + li.Value.ToString();

                }
            }

        }


        foreach (ListItem li in chkDesig.Items)
        {
            if (li.Selected == true)
            {
                if (Roleid == "")
                    Roleid = li.Value.ToString();
                else
                    Roleid = Roleid + "," + li.Value.ToString();

            }
        }

         string profileNM=dllProfile.SelectedValue.ToString();

         string strrightnow, strrightnow1;
         strrightnow = txtDateFrom.Text.ToString();
         strrightnow1 = txtDateTo.Text.ToString();
         string[] strArrDtFrom = strrightnow.Split('/');
         string[] strArrDtTo = strrightnow1.Split('/');
         string dtFrom = Convert.ToDateTime(strArrDtFrom[1] + "/" + strArrDtFrom[0] + "/" + strArrDtFrom[2]).ToString("yyyyMMdd");
         string dtTo = Convert.ToDateTime(strArrDtTo[1] + "/" + strArrDtTo[0] + "/" + strArrDtTo[2]).ToString("yyyyMMdd");
         string frmtm = txtSttime.Text.ToString();
         string totm = txtEntime.Text.ToString();

         string DBnm = "";
         SqlCommand cmd1 = new SqlCommand("select db_name() ", conn);
         DBnm = cmd1.ExecuteScalar().ToString();

         string strUpdae = "Y";

         if (RPTID == "0")
         {
             strUpdae = "N";
         }

         string submitstr = "exec WebxNet_AddUpdate_Job '" + stRPTID + "','" + RPTFreQ + "','Chirag','" + DBnm + "','" + MonthWeek + "','" + FreQInt + "','" + dtFrom + "','" + dtTo + "','" + frmtm + "','" + totm + "','" + profileNM + "','" + Roleid + "','" + FreqSubnt + "','" + strUpdae + "','Y'";
        Response.Write("..." + submitstr);

        
        SqlCommand cmd = new SqlCommand(submitstr, conn);
        cmd.ExecuteNonQuery();

        conn.Close();
        Response.Redirect("./ReportList.aspx");
    }
}
