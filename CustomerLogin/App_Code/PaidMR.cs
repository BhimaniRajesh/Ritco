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
/// <summary>
/// Summary description for PaidMR
/// </summary>
/// 
public class PaidMR : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
	public PaidMR()
	{
		

	}
    public string PaidMRGen(string Dockno, string Docksf)
    {
       
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string UCGmrsno="",Mrsno = fn.MRNogen(Session["brcd"].ToString()), empcd = Session["empcd"].ToString(), empnm = fn.GetEmpName(empcd);
        string dbcode=Session["brcd"].ToString(),dbname=fn.GetLocation(dbcode);
        string sql = "select * from vw_master_docket_charges_cnor_cnee  where DOCKNO ='"+ Dockno +"' and DOCKSF ='"+ Docksf +"' and (ORGNCD ='"+ dbcode +"' or REASSIGN_DESTCD ='"+ dbcode +"')";
        int CNT_DKT = 0;
        SqlCommand cmd = new SqlCommand(sql, conn);
       
        conn.Open();
       
        SqlDataReader sdr = cmd.ExecuteReader();
        string DOCKDT = "", ORGNCD = "", DESTCD = "", CDELDT = "", deldt = "", CSGNCD = "", CSGNNM = "", CSGNPIN = "", CSGNADD = "", CSGNPHONE = "", PKGSNO = "", CHRGWT = "", SVCTAX = "";
        string Dkttot = "", cess = "", ENTRYBY = "", PAYBAS = "", trn_mod = "", HEDU_CESS="";
        double Freight = 0, totfrt = 0, tot = 0, netamt = 0, ot = 0, st = 0, dc = 0, tds = 0, acd = 0, otded = 0, DIPLOMATCHG = 0, deductamt=0,col_cess=0 ;
        if (sdr.Read())
        {

            DOCKDT = Convert.ToString(sdr["DOCKDT"]);
            ORGNCD = Convert.ToString(sdr["ORGNCD"]);
            DESTCD = Convert.ToString(sdr["REASSIGN_DESTCD"]);
            CDELDT = Convert.ToString(sdr["CDELDT"]);
            deldt = Convert.ToString(sdr["CDELDT"]);
            CSGNCD = Convert.ToString(sdr["CSGNCD"]);
              CSGNNM = Convert.ToString(sdr["CSGNNM"]);
              CSGNPIN = Convert.ToString(sdr["CSGNPINCODE"]);
              CSGNPHONE = Convert.ToString(sdr["CSGNteleno"]);
              CSGNADD = Convert.ToString(sdr["CSGNADDR"]);
              PKGSNO = Convert.ToString(sdr["PKGSNO"]);
              CHRGWT = Convert.ToString(sdr["CHRGWT"]);
              PAYBAS = Convert.ToString(sdr["PAYBAS"]);
              Dkttot = Convert.ToString(sdr["Dkttot"]);
              SVCTAX = Convert.ToString(sdr["SVCTAX"]);
              cess = Convert.ToString(sdr["cess"]);
              trn_mod = Convert.ToString(sdr["trn_mod"]);
              HEDU_CESS = Convert.ToString(sdr["HEDU_CESS"]);
              Freight = Convert.ToDouble(Dkttot) - Convert.ToDouble(SVCTAX) - Convert.ToDouble(cess) - Convert.ToDouble(HEDU_CESS);
            ENTRYBY = Convert.ToString(sdr["ENTRYBY"]);
           
        }
        sdr.Close();
        
        //if (DOCKDT != "")
        //{
        //    DOCKDT = fn.Mydate1(DOCKDT);
        //}
        string paybasis = fn.Getpaybas(PAYBAS);
        string bkgstn = fn.GetLocation(ORGNCD);
        string destn = fn.GetLocation(DESTCD);
        empcd = "'" + empcd.Trim() + "'";
       // Mrsno = "'" + Mrsno.Trim() + "'";
        string REBOOK_FLAG = "N";
        string mrbrncd = "'" + ORGNCD.Trim() + "'";
        string mrbrnnm = "'" + bkgstn.Trim() + "'";
        string ptycd = "'" + CSGNCD.Trim() + "'";
        string ptynm = "'" + CSGNNM.Trim() + "'";
        string ptypin = "'" + CSGNPIN.Trim() + "'";
        string ptyadd = "'" + CSGNADD.Trim().Replace(",","") + "'";
        string ptytel = "'" + CSGNPHONE.Trim() + "'";
        string docbkbrncd = "'" + ORGNCD.Trim() + "'";
        string docbkbrnnm = "'" + bkgstn.Trim() + "'";
        string docdelbrncd = "'" + DESTCD.Trim() + "'";
        string docdelbrnnm = "'" + destn.Trim() + "'";
        string nopckg = PKGSNO.Trim();
        string delbas = "'" + PAYBAS.Trim() + "'";
        string delbasd = "'" + paybasis.Trim() + "'";
        string docdeldt = "'" + deldt.Trim() + "'";
        totfrt = Freight;
        tot = totfrt + Convert.ToDouble(SVCTAX) + Convert.ToDouble(cess) + Convert.ToDouble(HEDU_CESS);
        netamt = tot;
        st= Convert.ToDouble(SVCTAX);
        col_cess = Convert.ToDouble(cess);
        string gSVCTAX = "'" + SVCTAX.Trim() + "'";
        string gDKTTOT = "'" + Dkttot.Trim() + "'";

        sql = "Select * from WEBX_CHARGEMST";
        cmd = new SqlCommand(sql, conn);
        SqlDataReader dr = null;
        dr = cmd.ExecuteReader();
        string ServiceTax = "", OtherTax = "", H_OtherTax = "";
        while (dr.Read())
        {
            ServiceTax = Convert.ToString(dr["ServiceTax"].ToString());
            OtherTax = Convert.ToString(dr["EDU_CESS_RATE"].ToString());

            H_OtherTax = Convert.ToString(dr["HEDU_CESS_RATE"].ToString());
        }
        dr.Close();
        if (trn_mod == "2")
        {
            ServiceTax = "3";
        }
        string svctax_str = ",svctax_rate=" + ServiceTax + ",cess_rate  =" + OtherTax + ",H_cess_rate=" + H_OtherTax + "";
        sql = "Select count(*) AS CNT_DKT from webx_MR_HDR where DOCKNO='" + Dockno + "' and DOCKSF= '" + Docksf + "' and MR_CANCEL='N' ";
       
        cmd = new SqlCommand(sql, conn);

        //conn.Open();

        sdr = cmd.ExecuteReader();
        if (sdr.Read())
        {
            CNT_DKT = Convert.ToInt16(sdr["CNT_DKT"]);
        }

        sdr.Close();
        if (CNT_DKT < 1)
        {
            UCGmrsno = Mrsno.Trim();
            sql = "Insert into webx_MR_HDR (ENTRYBY,ENTRYDT,MRSNO,MRSSF, MRSDT, MRSTYPE, MRSBR, MRBRNNM, DOCKNO, DOCKSF, DOCKDT, DOCKDLYDT, PTCD, PTNAME, PTPIN, PTTEL, PTADD, ORGNCD, DOCBKNM, DESTCD, DOCDLNM, NOPKGS, CHRGWT, PAYBAS, DELBASD, MRSAMT, NETAMT, DEDUCTION,MRS_CLOSED,ba_emp_cd,ba_emp_nm,REBOOK_FLAG,mrcollbrcd) values (" + empcd + ",getdate(), '" + Mrsno + "','.',getdate(), '1' , " + mrbrncd + ", " + mrbrnnm + ", '" + Dockno + "', '" + Docksf + "', '" + DOCKDT + "', " + docdeldt + ", " + ptycd + ", " + ptynm + ", " + ptypin + ", " + ptytel + ", " + ptyadd + ", " + docbkbrncd + ", " + docbkbrnnm + ", " + docdelbrncd + ", " + docdelbrnnm + ", " + nopckg + ", " + CHRGWT + ", " + delbas + ", " + delbasd + ", " + tot + ", " + netamt + ", " + deductamt + ",'N','0','" + empnm + "','" + REBOOK_FLAG + "', " + mrbrncd + ")";
            cmd = new SqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
            sql = "update webx_MR_HDR set Col_frt=" + totfrt + ",Col_oth=" + ot + ",col_stax=" + st + ",COL_DLYCHG=" + dc + ",DED_TDS=" + tds + ",DED_ONAC=" + acd + ",DED_OTH=" + otded + ",DIPLOMATCHG=" + DIPLOMATCHG + ",DELSERCHRG_DED=0,DIPLOMATCHG_DED=0,col_cess=" + col_cess + ",col_H_Cess=" + HEDU_CESS + "  " + svctax_str + " where mrsno='" + Mrsno + "'";
            cmd = new SqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
            sql = "Update WebX_Trans_Docket_Status set MR='Y' where DOCKNO='" + Dockno.Trim() + "' and DOCKSF='" + Docksf.Trim() + "'";
            cmd = new SqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
        }
      
        
        conn.Close();

       
        return Mrsno;
    }
}
