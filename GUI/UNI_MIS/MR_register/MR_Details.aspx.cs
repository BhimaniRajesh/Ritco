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

public partial class MR_Details : System.Web.UI.Page
{

  //  static string strConnection = "data source=202.87.45.72;UID=sa;PWD=ecfy@pra$$ana;Database=ASL_LIVE;";



    public int intTotalRecords = 0;

    public static string strQSParam;
    public static string strMode = "";
    public static string strReport_Branch = "";
    public static string strRegion = "";
    public static SqlDataReader dr;
    public string STRMRSNO;
    public string STRMRDT1;
    //string STRMRSDT =cstr(day(MRDT1)) + " " + Mid(cstr(monthname(month(MRDT1),mm)),1,3) + " " + cstr(year(MRDT1))
    public string STRMRSTYPE;
    public string STRMRSBR;
    public string STRMRBRNNM;
    public string STRDOCKNO;
    public string STRDOCSF;
    public string STRDOCDT1;
    // string STRDOCDT = mydate(DOCDT1)
    public string STRDOCKDLYDT1;

    public string STRPTCD;
    public string STRPTNAME;
    public string STRPTPIN;
    public string STRPTTEL;
    public string STRPTADD;
    public string STRORGNCD;
    public string STRDOCBKNM;
    public string STRDESTCD;
    public string STRDOCDLNM;
    public string STRNOPKGS;
    public string STRCHRGWT;
    public string STRPAYBAS;
    public string STRPAYBASD;
    public string STRMRSAMT;
    public string STRpaytype;
    public string STRMRSCASH;
    public string STRMRSCHQ;
		
    protected void Page_Load(object sender, EventArgs e)
    {

       // SqlConnection sqlConn = new SqlConnection(strConnection);
        SqlConnection sqlConn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


       sqlConn.Open();

       string strSQL = "select * from webx_mr_hdr where mrsno='MRPNQ00048'and mr_cancel='N' union select * from webx_mr_hdr_arch where mrsno='MRPNQ00048' and mr_cancel='N'";
        

        SqlCommand sqlCommand = new SqlCommand(strSQL, sqlConn);
        //dr= new SqlDataReader();



        dr = sqlCommand.ExecuteReader();


        while (dr.Read())
        {
     
         STRMRSNO = dr["MRSNO"].ToString();
        STRMRDT1 = dr["MRSDT"].ToString(); 
        //string STRMRSDT =cstr(day(MRDT1)) + " " + Mid(cstr(monthname(month(MRDT1),mm)),1,3) + " " + cstr(year(MRDT1))
        STRMRSTYPE = dr["MRSTYPE"].ToString();  
        STRMRSBR = dr["MRSBR"].ToString();  
        STRMRBRNNM = dr["MRBRNNM"].ToString();  
        STRDOCKNO = dr["DOCKNO"].ToString();  
         STRDOCSF = dr["DOCKSF"].ToString();  
         STRDOCDT1 = dr["DOCKDT"].ToString();  
       // string STRDOCDT = mydate(DOCDT1)
         STRDOCKDLYDT1 = dr["DOCKDLYDT"].ToString();  
		
         STRPTCD = dr["PTCD"].ToString();  
         STRPTNAME = dr["PTNAME"].ToString();  
         STRPTPIN = dr["PTPIN"].ToString();  
         STRPTTEL = dr["PTTEL"].ToString();  
         STRPTADD = dr["PTADD"].ToString();  
         STRORGNCD = dr["ORGNCD"].ToString();  
         STRDOCBKNM = dr["DOCBKNM"].ToString();  
         STRDESTCD = dr["DESTCD"].ToString();  
         STRDOCDLNM = dr["DOCDLNM"].ToString(); 
         STRNOPKGS = dr["NOPKGS"].ToString();  
         STRCHRGWT = dr["CHRGWT"].ToString();  
         STRPAYBAS = dr["PAYBAS"].ToString();  
         STRPAYBASD = dr["DELBASD"].ToString();  
         STRMRSAMT = dr["MRSAMT"].ToString(); 
         STRpaytype = dr["paymode"].ToString();
         STRMRSCASH = dr["MRSCASH"].ToString(); 
         STRMRSCHQ = dr["MRSCHQ"].ToString(); 
		
        }



       


    }
}
