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

public partial class GUI_UNI_MIS_Login_View_Login_2 : System.Web.UI.Page
{

    public static string strpo,err="",pocd1="";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Date Range display preparation

            strpo = Request.QueryString["pcd"].ToString();
            DipsplayReport();
        }

        btn_csv.Attributes.Add("onclick", "javascript:return ch()");
        err = "";


    }


    public void DipsplayReport()
    {
        

        //  SqlConnection conn = new SqlConnection("data source=202.87.45.71;UID=sa;PWD=$rcpl@@p@$$;Database=RCPL_test2;");
        //SqlConnection conn = new SqlConnection("data source=202.87.45.69;UID=sa;PWD=!@ecfy#$;Database=Webxpress_new;");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string sql = "select pocode,convert(varchar,podate,106) as podt,(select vendorcd from webx_POASSET_HDR where pocode=m.pocode)as ven,(select assetname from webx_assetmaster where assetcd=m.assetcd) as assetnm,qty,rate,total,assetcd,narration from webx_POASSET_det m where activeflag='N' and exists (select pocode from webx_poasset_hdr d where m.pocode=d.pocode) and pocode='" + strpo + "' order by pocode  asc";
        //select pocode,convert(varchar,podate,106) as podt,(select assetname from webx_assetmaster where assetcd=m.assetcd) as assetnm,qty,rate,total,assetcd,narration from webx_POASSET_det m where activeflag='N' and exists (select pocode from webx_poasset_hdr d where m.pocode=d.pocode order by pocode  asc";
        //select pocode,convert(varchar,podate,106) as podt,qty,rate,total,assetcd,narration from webx_POASSET_det m where activeflag='N' and exists (select pocode from webx_poasset_hdr d where m.pocode=d.pocode and d.pocode='" + strpo + "') order by pocode  asc";



        conn.Open();

        SqlCommand cmd = new SqlCommand(sql, conn);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

        da.Fill(ds);



        GV_Booking.DataSource = ds;

        GV_Booking.DataBind();



        if (GV_Booking.Rows.Count == 0)
        {

        }
        if (GV_Booking.Rows.Count <= 25)
        {
            LinkButton1.Visible = false;
            LinkButton2.Visible = false;

        }



    }

    public void pgChange(object sender, GridViewPageEventArgs e)
    {
        GV_Booking.PageIndex = e.NewPageIndex;

        DipsplayReport();


    }

    public void lst(object sender, EventArgs e)
    {
        int i = GV_Booking.PageCount;
        GV_Booking.PageIndex = i;

        DipsplayReport();


    }
    public void fst(object sender, EventArgs e)
    {
        GV_Booking.PageIndex = 0;

        DipsplayReport();


    }





    public string getasstcd(string pref)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        conn.Open();
        string pre = pref;
        int l = pre.Length;
        string sql = "select Max(Right(allotcd,5)+1) from webx_FAALLOT_DET where substring(allotcd,1,"+l+")='"+pre+"'";
        //select Max(Right(allotcd,5)) from webx_FAALLOT_DET where   ";

        SqlCommand sqlcmd = new SqlCommand(sql, conn);

        string cd1 = Convert.ToString(sqlcmd.ExecuteScalar());

        //  string cd = Convert.ToString(cd1);
        double inc = 00001;
        string s = "";

        if (cd1 == "")
        {
            cd1 = "00001";
        }
        else
        {
            
        if (cd1.Length == 1)
        {

            s = "0000";
        }
        else if (cd1.Length == 2)
        {

            s = "000";
        }
        else if (cd1.Length == 3)
        {

            s = "00";
        }
        else if (cd1.Length == 4)
        {

            s = "0";
        }
        else if (cd1.Length >= 5)
        {

            s = "";
        }


            inc = Convert.ToDouble(cd1) + 1;
        }
       
        cd1 = pre+s + cd1;
        return cd1;


    }

    public string getnextgrn()
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string finyr = Session["FinYear"].ToString();
        finyr = finyr.Substring(2, 2);
        string s = "exec sp_get_next_FAGRN_code '" + Session["brcd"].ToString() + "','" + finyr + "'";

        conn.Open();
        
        SqlCommand cmd= new SqlCommand(s,conn);


        string gno = (string)cmd.ExecuteScalar();
        return gno;
       

    }

    protected void btn_csv_Click(object sender, EventArgs e)
    {

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        conn.Open();
        string sql = "";


        // string pocd = getnewcd();







        string grnno = getnextgrn();

        foreach (GridViewRow gridrow in GV_Booking.Rows)
        {

            CheckBox c = (CheckBox)gridrow.FindControl("chksrno");

            if (c.Checked == true)
            {

                TextBox txtbill = (TextBox)gridrow.FindControl("txtbill");
                TextBox txtdt = (TextBox)gridrow.FindControl("txtdt");

                string pocd = gridrow.Cells[1].Text;
                pocd1 = pocd;
                string asnm = gridrow.Cells[4].Text;
                string desc = gridrow.Cells[5].Text;
                
                string podt = gridrow.Cells[2].Text;
                string actcd = gridrow.Cells[3].Text;
                // string desc = gridrow.Cells[4].Text;
                string qt = gridrow.Cells[6].Text;
                string rt = gridrow.Cells[7].Text;
                string tot = gridrow.Cells[8].Text;
                string ven = gridrow.Cells[9].Text;


                string dtnow = System.DateTime.Now.ToString("MM/dd/yyyy");

                DateTime dt2 = Convert.ToDateTime(podt);
                string d2 = dt2.ToString("MM/dd/yyyy");

                //string[] strDtFrom = txtDateJoinOrg.Text.Split('/');
                //DateTime d1 = new DateTime(Convert.ToInt16(strDtFrom[2]), Convert.ToInt16(strDtFrom[1]), Convert.ToInt16(strDtFrom[0]));

               string sqli = "Insert into webx_fixedassets_hdr(FIXEDASSETCD,fixedassetDATE,vendorcd,totalqty,ENTRYBY,ENTRYON,POSTATUS,pocode,brcd,poamt) " +
                    "values('" + grnno + "',getdate(),'"+ven+"'," +qt+ ",'" +Session["empcd"].ToString()+"',getdate(),'S','"+pocd+ "','" +Session["brcd"].ToString()+"'," +tot+")";




                    try
                {
                    SqlCommand sqlcmd5 = new SqlCommand(sqli, conn);

                    sqlcmd5.ExecuteNonQuery();

                }
                catch (Exception e1)
                {
                   err += e1.Message;
                }

                sql = "Insert into webx_fixedassets_det(fixedassetcd,fixedassetdt,grpcd,billno,billdt,qty,rate,billamt,entryby,entrydt,balanceqty,location,assign)" +
                      "values('" + grnno + "','" + dtnow + "','"+actcd+"','" + txtbill.Text + "','" + dt2 + "'," + qt + "," + rt + "," + tot + ",'" + Session["EMPCD"].ToString() + "',getdate()," + qt + ",'" + Session["BRCD"].ToString() + "','N')";
             

                try
                {
                    SqlCommand sqlcmd = new SqlCommand(sql, conn);

                    sqlcmd.ExecuteNonQuery();

                }
                catch (Exception e1)
                {
                   err += e1.Message;
                }


                sql = "update webx_poasset_det set activeflag='Y' where pocode='" +pocd+ "' and assetcd='" + actcd + "'";


                try
                {
                    SqlCommand sqlcmd = new SqlCommand(sql, conn);

                    sqlcmd.ExecuteNonQuery();
                }
                catch (Exception e1)
                {
                    err += e1.Message;
                }


                string sqpre = "select prefix from webx_assetmaster where assetcd ='" + actcd + "'";

                SqlCommand sqlcmdp = new SqlCommand(sqpre, conn);

                string prefix = (string)sqlcmdp.ExecuteScalar();


               
                double finalamt = Convert.ToDouble(tot) / Convert.ToDouble(qt);
                for (int i = 0; i < Convert.ToDouble(qt); i++)
                {
                    string alcd = getasstcd(prefix);

                    string sql5 = "Insert into webx_faallot_det(allotcd,assetcd,loccode,entryby,entryon,FIXEDASSETCD,activeflag,billamt,description_detail,grpcd) values('" + alcd + "','" + actcd + "','" + Session["brcd"].ToString() + "','" + Session["empcd"].ToString() + "',getdate(),'" + grnno + "','N'," + finalamt + ",'"+desc+"','"+alcd+"')";


                    try
                    {
                        SqlCommand cmd5 = new SqlCommand(sql5, conn);

                        cmd5.ExecuteNonQuery();
                        
                       
                    }
                    catch (Exception e1)
                    {
                        err += e1.Message;
                    }
                }





            }







        }


     if(err=="")
     {
         Response.Redirect("Goods_RCPT_4.aspx?grnno="+grnno);
     }
     else
     {
         lblerr.Text = err;
         pnl1.Visible=false;
         plnerr.Visible=true;

     }


    }
    protected void btn_ok_Click(object sender, EventArgs e)
    {
        Response.Redirect("fa.aspx");
    }
}
