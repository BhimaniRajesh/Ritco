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

public partial class GUI_admin_AirportMaster_dyn_combo : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string result ="";
        string dno = Request.QueryString.Get("dno").Replace("'","''") ;
        //string rtype = Request.QueryString.Get("rtype").Replace("'", "''");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        SqlDataReader drchq;
        //string sql = "Select orgncd,D.dockno,D.docksf,dockdt,cdeldt,dly_loc,reassign_destcd, Tohub_br,Docket_Mode,Draft_YN,TCNO,THCNO,DKT_DLY,C.DKT_CANCEL,pkgsno,actuwt,trn_mod,cft_yn,csgnnm,csgenm,DOC_CURLOC,DLYPDCNO from vw_docket_charges_cnor_cnee D inner join webx_docket_detain_cancel C on D.dockno=C.dockno where D.dockno='" + dno + "'";// and D.docksf='.'
        string sql = "Select orgncd,D.dockno,D.docksf,dockdt,cdeldt,dly_loc,reassign_destcd, Tohub_br,Docket_Mode,ls as Draft_YN,mf as TCNO,THCNO,DKT_DLY,D.DKT_CANCEL,pkgsno,actuwt,trn_mod,cft_yn,csgnnm,csgenm,DOC_CURLOC,DLYPDCNO from VW_DOCKET_NET D where D.dockno='" + dno + "'";
        SqlCommand cmd = new SqlCommand(sql, conn);
        drchq = cmd.ExecuteReader();
        Int16 cnt = 0;
        if  (drchq.Read())
        {
            if (Convert.ToString(Session["brcd"]) != Convert.ToString(drchq["doc_curloc"]))
            {
                result = "This CNote does not lying at this location !!"; 
            }
            else if (Convert.ToString(drchq["dkt_cancel"]) == "Y")
            {
                result = "This CNote can not be reassigned since it is already cancelled !!"; 
            }
            else if (Convert.ToString(drchq["dkt_dly"]) == "Y")
            {
                result = "This CNote can not be reassigned since it is already delivered !!";
            }
            else if (Convert.ToString(drchq["THCNO"]) != "")
            {
                result = "This CNote can not be reassigned since it is attached in THC !!";
            }
            else if (Convert.ToString(drchq["TCNO"]) != "")
            {
                result = "This CNote can not be reassigned since it is attached in Manifest !!";
            }
            else if (Convert.ToString(drchq["draft_YN"]) != "")
            {
                result = "This CNote can not be reassigned since it is attached in Loading Sheet !!";
            }
            else 
            {
                result = "OK";
            }
        }
        
        else
        {
            result = "Invalid CNote";
        }

        drchq.Close();
        Response.Write(result);
    }
}
