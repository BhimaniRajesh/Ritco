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

public partial class GUI_Fleet_Operations_Issue_Tripsheet_Adv_Check_For_Stock : System.Web.UI.Page
{
    MyFunctions fn = new MyFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {

        string TripNo = Request.QueryString["TripNo"].ToString();
        string TripLoc = Request.QueryString["TripLoc"].ToString();
        //string Value = Request.QueryString["Value"].ToString();
        string thcno = "", ErrMsg = "", arrived_yn = "",thcbr="",sourcehb="",actarrv_dt="",actdept_dt="",routename="";
        string allow_yes = "N";
        double rut_pat = 0;
        SqlConnection con = new SqlConnection(Session["SqlProvider"].ToString().Trim());

        string qry = "Exec usp_TripsheetAdv_Check_For_Stock_Update_Test '" + TripNo + "','" + TripLoc + "'";
        SqlCommand cmd = new SqlCommand(qry, con);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        int i = 0;


        //if (dr.Read())
        //{

        //    thcno = dr["thcno"].ToString();
        //    thcbr = dr["thcbr"].ToString();
        //    sourcehb = dr["sourcehb"].ToString();
        //    arrived_yn = dr["arrived_yn"].ToString();
        //    actarrv_dt = dr["actarrv_dt"].ToString();
        //    actdept_dt = dr["actdept_dt"].ToString();
        //    if (sourcehb == thcbr)
        //    {
        //        ErrMsg = "";
        //    }
        //    else
        //    {
        //        if (actarrv_dt == "")
        //        {
        //            ErrMsg = "The THC No. " + thcno + " is not yet arrived at " + sourcehb;
        //        }
        //        else
        //        {
        //            if (arrived_yn == "N")
        //            {
        //                ErrMsg = "The THC No. " + thcno + " is already arrived but stock is not yet updated";
        //            }
        //        }

        //    }

        //}

        //else
        //{
        //    ErrMsg = "This Trip sheet is not yet arrived at " + TripLoc + " .Please check !!!";
        //}


        //ErrMsg = "";

        //====================================
        
        //while (dr.Read())
        //{
        //    rut_pat = Convert.ToDouble(dr["rut_pat"].ToString());
        //    thcno = dr["thcno"].ToString();
        //    thcbr = dr["thcbr"].ToString();
        //    sourcehb = dr["sourcehb"].ToString();
        //    arrived_yn = dr["arrived_yn"].ToString();
        //    actarrv_dt = dr["actarrv_dt"].ToString();
        //    actdept_dt = dr["actdept_dt"].ToString();
        //    routename = dr["routename"].ToString();

        //    string[] RouteDescArr;
        //    RouteDescArr = routename.Split(new char[] { '-' });
        //    for (int j = 0; j < RouteDescArr.Length; j++)
        //    {
        //        if (TripLoc == RouteDescArr[j].Trim())
        //        {
        //            allow_yes = "Y";
        //        }
        //    }


        //        if (sourcehb == thcbr)
        //        {
        //            ErrMsg = "";
        //            if (Convert.ToDouble(rut_pat) > 0)
        //            {
        //                if (allow_yes == "Y")
        //                {
        //                    if (actarrv_dt == "" && arrived_yn == "N")
        //                    {
        //                        ErrMsg = "The THC No. " + thcno + " is not yet arrived at " + TripLoc;
        //                    }
        //                }
        //            }
        //        }
        //        else
        //        {
        //            if (Convert.ToDouble(rut_pat) > 0)
        //            {
        //                if (allow_yes == "Y")
        //                {
        //                    if (actarrv_dt == "")
        //                    {
        //                        ErrMsg = "The THC No. " + thcno + " is not yet arrived at " + sourcehb;
        //                    }
        //                    else
        //                    {
        //                        if (arrived_yn == "N")
        //                        {
        //                            ErrMsg = "The THC No. " + thcno + " is already arrived but stock is not yet updated";
        //                        }
        //                    }
        //                }  
        //            }
        //        }

        //}
        //=================================




        while (dr.Read())
        {
            arrived_yn = dr["arrived_yn"].ToString();
            thcno = dr["thcno"].ToString();
            if (arrived_yn == "N")
            {
                ErrMsg = "Whether THC No. " + thcno + " is not arrived OR stock is not yet updated.Please check !!!";
            }

        }






        dr.Close();
        Response.Write(ErrMsg);

    }

}
