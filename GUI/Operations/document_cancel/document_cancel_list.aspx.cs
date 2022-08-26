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

public partial class GUI_Operations_document_cancel_document_cancel_list : System.Web.UI.Page
{
    public string documentno, documenttype, sql, docno;
    protected void Page_Load(object sender, EventArgs e)
    {
        documentno = Request.QueryString["documentno"].ToString();
        documenttype = Request.QueryString["documenttype"].ToString();

        MyFunctions fn = new MyFunctions();
        if (documenttype == "Docket")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            //sql = "select dockno as doc_no,convert(varchar,a.dockdt,106) as doc_dt,curr_Loc as doc_loc from WebX_Trans_Docket_Status where dockno='" + documentno + "' and docksf='.' and Cancelled = 'N' and LS is null and MF is null";
            //sql = "select b.dockno as doc_no,convert(varchar,a.dockdt,106) as doc_dt,a.orgncd as doc_loc from WebX_Trans_Docket_Status b ,WEBX_docket a where b.dockno='" + documentno + "'and b.docksf='.' and b.Cancelled = 'N' and b.LS is null and b.MF is null and a.dockno=b.dockno";
            sql = "Select dockno as doc_no,Curr_Loc as doc_loc from WebX_Trans_Docket_Status where dockno='" + documentno + "'and docksf='.' and Cancelled = 'N' and LS is null and MF is null and DRS is NULL and PRS is NULL";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblDocType.Text = "Docket";
                docno = dr["doc_no"].ToString();
                string location = dr["doc_loc"].ToString();
                lblLocation.Text = location + ":" + fn.GetLocation(location);
            }
            else
            {
                btnSubmit.Visible = false;
            }
            dr.Close();
            conn.Close();
        }
        else if (documenttype == "Manifiest")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            sql = "select MF as doc_no,Curr_Loc as doc_loc from WebX_Trans_Docket_Status where MF='" + documentno + "' and MF is not NULL ";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblDocType.Text = "Manifiest";
                docno = dr["doc_no"].ToString();
                string location = dr["doc_loc"].ToString();
                lblLocation.Text = location + ":" + fn.GetLocation(location);
            }
            else
            {
                btnSubmit.Visible = false;
            }
            dr.Close();
            conn.Close();
        }
        else if (documenttype == "THC")
        {
            SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
            conn.Open();
            sql = "select THC as doc_no,Curr_Loc as doc_loc from WebX_Trans_Docket_Status where THC='" + documentno + "' and MF is not NULL ";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                lblDocType.Text = "TRUCK HIRE CHALLAN";
                docno = dr["doc_no"].ToString();
                string location = dr["doc_loc"].ToString();
                lblLocation.Text = location + ":" + fn.GetLocation(location);
            }
            else
            {
                btnSubmit.Visible = false;
            }
            dr.Close();
            conn.Close();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string empcd = Session["empcd"].ToString();
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        if (documenttype == "Docket")
        {
            //sql = "Update webx_Docket_Detain_Cancel set dkt_cancel='Y',dkt_cancel_on=getdate(),dkt_cancel_by='" + empcd + "' where DOCKNO='" + documentno + "'";
            //SqlCommand cmdUpdate = new SqlCommand(sql, conn);
            //cmdUpdate.ExecuteNonQuery();
            //sql_docket = "Update WebX_Trans_Docket_Status set Cancelled='Y',CancelledBy='" + empcd + "',CancelledOn=getdate() where DOCKNO='" + documentno + "'";
            //SqlCommand cmdcheckPaid = new SqlCommand(sql_docket, conn);
            //cmdUpdateTrans.ExecuteNonQuery();



            sql = "Update WebX_Trans_Docket_Status set Cancelled='Y',CancelledBy='" + empcd + "',CancelledOn=getdate() where DOCKNO='" + documentno + "'";
            SqlCommand cmdUpdateTrans = new SqlCommand(sql, conn);
            cmdUpdateTrans.ExecuteNonQuery();

            string final = "?doctype=" + documenttype;
            Response.Redirect("Document_Cancel_Done.aspx" + final);

        }
        else if (documenttype == "Manifiest")
        {
            sql = "Exec usp_Manifest_Do_Cancel '" + documentno + "','" + Session["empcd"].ToString().Trim() + "'";
            //sql = "Update WEBX_TCHDR set Cancelled='Y' where tcno='" + documentno + "'";
            SqlCommand cmdTC = new SqlCommand(sql, conn);
            cmdTC.ExecuteNonQuery();

            //sql = "update WebX_Trans_Docket_Status set MF=NULL where MF='" + documentno + "'";
            //SqlCommand cmdDKT = new SqlCommand(sql, conn);
            //cmdDKT.ExecuteNonQuery();

            string final = "?doctype=" + documenttype;
            Response.Redirect("Document_Cancel_Done.aspx" + final);

        }
        else if (documenttype == "THC")
        {
            sql = "Update WEBX_TCHDR set TFlag_YN = 'N',THCBR= NULL, THCNO = NULL,THCsf = NULL, THCDT=NULL,VEHNO=NULL where THCNO ='" + documentno + "' and thcsf='.'";
            SqlCommand cmdTCHDR = new SqlCommand(sql, conn);
            cmdTCHDR.ExecuteNonQuery();

            sql = "Update WebX_Trans_Docket_Status  SET THC = NULL where THC ='" + documentno + "'";
            SqlCommand cmdDKT = new SqlCommand(sql, conn);
            cmdDKT.ExecuteNonQuery();

            sql = "Update WEBX_THC_SUMMARY set Cancelled='Y',cancelled_dt=getdate(),cancelled_by='" + empcd + "' where THCNO='" + documentno + "' and THCSF='.'";
            SqlCommand cmdTHC = new SqlCommand(sql, conn);
            cmdTHC.ExecuteNonQuery();

            //string lsno1 = lsno.Text;
            string final = "?doctype=" + documenttype;
            Response.Redirect("Document_Cancel_Done.aspx" + final);
            //Response.Redirect();
        }
    }
}
