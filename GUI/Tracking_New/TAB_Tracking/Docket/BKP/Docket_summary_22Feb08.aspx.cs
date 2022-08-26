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
using System.ComponentModel;
using System.Drawing;
using System.Web.SessionState;
using System.Security;
using System.Data.SqlClient;

public partial class GUI_Tracking_New_TAB_Tracking_Docket_Docket_summary : System.Web.UI.Page
{
    public static string POD,call_dkt ,  status_doc,attech_doc,st_docdate,st_docname,st_docloc,st_docmadby,st_status, dockno, docksf, docket, origin, destcd, dockdt, dock_dt, curr_loc, Nextloc, from_loc, to_loc, Service_Class, pkgsno, chrgwt, PAYBASis, paybas, tranportmode, TRN_mod, Cnor, Cnee, CDELDT, dely_date, delivered, dept_dt, Arrv_dt, DATE_OF_Last_aatempt, NO_OF_aatempt, reason, cod_dod, declcodamt, codcollected, codno, codamt, POD_recDate, DocumentName, podtrack;
    public static SqlDataReader dr;
   

    MyFunctions fn = new MyFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        //dockno = Request.QueryString["dockno"].ToString();
        dockno = Request.QueryString.ToString();
        //Response.Write("<br>dockno 123 : " + dockno);

        call_dkt = Session["DocketCalledAs"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        //cn1 = new SqlConnection(Session["SqlProvider"].ToString().Trim()); 
        conn.Open();
        string sqlstr = "Webx_DOcket_TRack_summary";
        SqlCommand cmd = new SqlCommand(sqlstr, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand.Parameters.Add("@DOCKNO", SqlDbType.Text.ToString()).Value = dockno;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            dockno = dr["dockno"].ToString();
            docksf = dr["docksf"].ToString();
            docket = dr["docket"].ToString();
            origin = dr["origin"].ToString();
            destcd = dr["destcd"].ToString();
            dockdt = dr["dockdt"].ToString();
            dock_dt = dr["dock_dt"].ToString();
            curr_loc = dr["curr_loc"].ToString();
            Nextloc = dr["Nextloc"].ToString();
            from_loc = dr["from_loc"].ToString();
            to_loc = dr["to_loc"].ToString();
            Service_Class = dr["Service_Class"].ToString();
            pkgsno = dr["pkgsno"].ToString();
            chrgwt = dr["chrgwt"].ToString();
            PAYBASis = dr["PAYBASis"].ToString();
            paybas = dr["paybas"].ToString();
            tranportmode = dr["tranportmode"].ToString();
            TRN_mod = dr["TRN_mod"].ToString();
            Cnor = dr["Cnor"].ToString();
            Cnee = dr["Cnee"].ToString();
            CDELDT = dr["CDELDT"].ToString();
            dely_date = dr["dely_date"].ToString();
            delivered = dr["delivered"].ToString();
            dept_dt = dr["dept_dt"].ToString();
            Arrv_dt = dr["Arrv_dt"].ToString();
            DATE_OF_Last_aatempt = dr["DATE_OF_Last_aatempt"].ToString();
            NO_OF_aatempt = dr["NO_OF_aatempt"].ToString();
            reason = dr["reason"].ToString();
            cod_dod = dr["cod_dod"].ToString();
            declcodamt = dr["declcodamt"].ToString();
            codcollected = dr["codcollected"].ToString();
            codno = dr["codno"].ToString();
            codamt = dr["codamt"].ToString();
            POD_recDate = dr["POD_recDate"].ToString();
            DocumentName = dr["DocumentName"].ToString();
            podtrack = dr["podtrack"].ToString();

            if (dr["DocumentName"] is DBNull)
            {
                POD = "No POD Uploaded";
            }
            else
            {
                POD = "View Scanned POD";

            }
           
        }
        dr.Close();

        if (cod_dod == "Y")
        {
            tblcod.Visible = true;
        }
        else
        {
            tblcod.Visible = false;
        }



        string sql_STstus = " exec  webx_Docket_status '" + docket + "' ";
        SqlCommand cmd_STstus = new SqlCommand(sql_STstus, conn);
        SqlDataReader dr_STstus = cmd_STstus.ExecuteReader();

        String status_doc = "", st_docloc = "", attech_doc = "", st_docdate = "", st_docname = "", st_docmadby = ""; ;
        while (dr_STstus.Read())
        {
            status_doc = dr_STstus["OP_status"].ToString();
            attech_doc = dr_STstus["doc_no"].ToString();
            st_docdate = dr_STstus["doc_dt"].ToString();

          

            st_docname = dr_STstus["docname"].ToString();
            st_docloc = dr_STstus["curr_loc"].ToString();
            st_docmadby = dr_STstus["doc_PreBy"].ToString();

            st_status = status_doc + " - " + attech_doc;
            if (st_docname.ToUpper() == "DRS")
            {
                st_status = "<b>" + status_doc + "</b>   At <b>" + st_docloc + "</b>  by <a href=\"JavaScript:OpenWindowDRS('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";
            }
            if (st_docname.ToUpper() == "THC")
            {
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenWindowTHC('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";

            }
            if (st_docname.ToUpper() == "MF")
            {
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenWindow('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";

            }
            if (st_docname.ToUpper() == "LS")
            {
                st_status = "<b>" + status_doc + "</b>    by <a href=\"JavaScript:OpenPopupWindow1ls('" + attech_doc + ",0')\"><u>" + attech_doc + "</u></a>  on <b>" + st_docdate + "</b>";

            }
        }
        dr_STstus.Close();


        string sqlstr1 = "select d.dockno,d.docksf,doc_curloc=CURLOC+' : ' + (select top 1  locname from webx_location where loccode=d.CURLOC),d.nEXTLOC AS tohub_br,c.tcno,c.thcno,Arrv_dt=(CASE WHEN In_Out='I' THEN atad ELSE '' END) ,actarrv_dt=(case when In_Out is null then '-' when In_Out='I' then (convert(varchar,atad,6)+' '+convert(varchar,atad,108)) end),(select top 1  convert(varchar,actdept_dt,6)+ '  ' + actdept_tm from webx_thchdr  where thcno=c.thcno and sourcehb=d.CURLOC  ) actdept_dt,(select top 1 vehno from webx_thc_summary where thcno=c.thcno ) as vehno ,drs ,prs from WebX_Trans_Docket_Track d with(NOLOCK) left outer join VW_THC_TC_Dockets c with(NOLOCK) on d.dockno=c.dockno and tcbr=CURLOC left outer join WebX_Trans_Docket_Status s  with(NOLOCK) on d.dockno=s.dockno and Curr_loc=CURLOC where  d.dockno+d.docksf='" + docket + "' order by srno ";
        SqlCommand cmd1 = new SqlCommand(sqlstr1, conn);
        SqlDataAdapter sqlDA = new SqlDataAdapter(cmd1);
        DataSet ds = new DataSet();
        sqlDA.Fill(ds);
        rptBillDetails.DataSource = ds;
        rptBillDetails.DataBind();
    }
}
