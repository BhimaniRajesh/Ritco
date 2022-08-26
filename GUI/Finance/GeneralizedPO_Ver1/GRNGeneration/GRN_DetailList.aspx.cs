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
using Microsoft.ApplicationBlocks.Data;


public partial class GUI_Finance_GeneralizedPO_GRNGeneration_GRN_DetailList : System.Web.UI.Page
{
    string POList = "", ReceiveDt = "" , PayLocation="";
    string VendorCode = "",VCode="" ,StrTyrecode="",StrTyreDesc="";
    string[] Temp = new string[10];
    string[] Temp2 = new string[10];
    DataTable dt = new DataTable("table1");
    MyFunctions fn = new MyFunctions();
    string Xml_SKUWise = "";
    public string GenXml
    {
        get
        {
            if (ViewState["Xml_SKU_Wise_TyreNo"] != null)
                return ViewState["Xml_SKU_Wise_TyreNo"] as string;
            else
                return "";
        }
        set
        {
            ViewState["Xml_SKU_Wise_TyreNo"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsCallback && !IsPostBack)
        {
            progressBackgroundFilter.Visible = false;
            processMessage.Visible = false;
            POList = Request.QueryString["POList"].ToString();
            VendorCode = Request.QueryString["VendorCode"].ToString();
            lblGRNLoc.Text = SessionUtilities.CurrentBranchCode;
            PayLocation = SessionUtilities.CurrentBranchCode.ToString();
            HidSysDate.Value = DateTime.Now.ToString("dd/MM/yyyy");
			txtChallandt.Text = DateTime.Now.ToString("dd/MM/yyyy");
	        ReceiveDt = DateTime.Now.ToString("dd/MM/yyyy");

            LblPONo.Text = Convert.ToString(Request.QueryString["POList"]);
            LblPODate.Text = Convert.ToString(Request.QueryString["PODate"]);
            LblVendor.Text = Convert.ToString(Request.QueryString["VendorCode"]);
            LblManualPONo.Text = Convert.ToString(Request.QueryString["ManualPO"]);
            LblPOType.Text = Convert.ToString(Request.QueryString["POType"]);
            LblPOAmount.Text = Convert.ToString(Request.QueryString["POAmount"]);
            BindData();
        }
        VendorCode = Request.QueryString["VendorCode"].ToString();
		txtMNGRNno.Attributes.Add("onblur", "DocBlur('" + txtMNGRNno.ClientID.ToString() + "')");

        ////***************** updated by vidya on 6/10/2012

        //foreach (GridViewRow GR in GV_Booking.Rows)
        //{
        //    TextBox txtTyreNo = (TextBox)GR.FindControl("txtTyreNo");
        //    TextBox Txt_Qty = (TextBox)GR.FindControl("txtQty");
        //    HiddenField hdfItemCode = (HiddenField)GR.FindControl("hdfItemCode");
        //    HiddenField hdfItemDesc = (HiddenField)GR.FindControl("hdfItemDesc");

        //    string MainString = Txt_Qty.Text.ToString();
        //    string SearchString = ".";
        //    int FirstChr = MainString.IndexOf(SearchString);
        //    string TempS = MainString.Substring(0, FirstChr);

        //    int tempN = Int32.Parse(TempS);
        //    StrTyrecode = hdfItemCode.Value;
        //    StrTyreDesc = hdfItemDesc.Value;
        //    hdfNo_Row.Value = Convert.ToString(tempN);
            
        //}
        
        //int count = 0;
        ////string strData = "a,b,c,d,e,f,g,h,i,j";
        //char[] separator = new char[] { '~' };
        //string[] strSplitArr = StrTyrecode.Split(separator);
        //string[] strSplitArr2 = StrTyreDesc.Split(separator);

        //for (count = 0; count <= strSplitArr.Length - 1; count++)
        //{
        //    Temp[count] = strSplitArr[count];
        //    // Response.Write(strSplitArr[count]);
        //    Temp2[count] = strSplitArr2[count];

        //}

        //hdfModel.Value = Temp[0];
        //hdfMFG.Value = Temp[1];
        //hdfCategory.Value = Temp[2];
        //hdfSize.Value = Temp[3];
        
        //hdfModelDesc.Value = Temp2[0];
        //hdfMFGDesc.Value = Temp2[1];
        //hdfCategoryDesc.Value = Temp[2];
        //hdfSizeDesc.Value = Temp2[3];
        

        //Response.Write(hdfCategory.Value);     
        //*********************

    }
    //Updated by vidya on 6/10/2012
    //protected void GV_TyreList_RowDataBound(object sender, GridViewRowEventArgs e)
    //{

    //    foreach (GridViewRow GR in GV_TyreList.Rows)
    //    {
    //        TextBox txtTyreNo = (TextBox)GR.FindControl("txtTyreNo");
    //        DropDownList ddlposition = (DropDownList)GR.FindControl("ddlposition");
          
    //        Label lblMFG = (Label)GR.FindControl("lblMFG");
    //        Label lblModel = (Label)GR.FindControl("lblModel");
    //        Label lblSize = (Label)GR.FindControl("lblSize");
    //        Label lblCategory = (Label)GR.FindControl("lblCategory");

    //        lblMFG.Text = hdfMFGDesc.Value;
    //        lblModel.Text = hdfModelDesc.Value;
    //        lblSize.Text = hdfSizeDesc.Value;
    //        lblCategory.Text = hdfCategoryDesc.Value;

    //        //string strSql = "SELECT CodeId,CodeDesc FROM Webx_Master_General WHERE CodeType='TYCAT' AND StatusCode='Y' and codeID='01' UNION SELECT '0','Select' FROM Webx_Master_General  ORDER BY CodeId";
    //        //DataTable DtDDLCat = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, strSql).Tables[0];
    //        //if (DtDDLCat.Rows.Count > 0)
    //        //{
    //        //    ddlTyreCategory.DataSource = DtDDLCat;
    //        //    ddlTyreCategory.DataTextField = "CodeDesc";
    //        //    ddlTyreCategory.DataValueField = "CodeId";
    //        //    ddlTyreCategory.DataBind();
    //        //}

    //        string Sql = "SELECT CodeId,CodeDesc FROM Webx_Master_General WHERE CodeType='TYPOS' AND StatusCode='Y 'UNION SELECT '0','Select' FROM Webx_Master_General  ORDER BY CodeId";
    //        DataTable DtDDLPos = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql).Tables[0];

    //        if (DtDDLPos.Rows.Count > 0)
    //        {
    //            ddlposition.DataSource = DtDDLPos;
    //            ddlposition.DataTextField = "CodeDesc";
    //            ddlposition.DataValueField = "CodeId";
    //            ddlposition.DataBind();
    //        }

    //        txtTyreNo.Attributes.Add("OnBlur", "javascript:checkTyreNo(" + txtTyreNo.ClientID.ToString() + ");");
    //    }
    //}

    private void BindData()
    {
        DataTable dt = new DataTable();
        string Qry = "";
        Qry = "EXEC USP_GENERAL_PO_LIST_FOR_GRN_Ver1 '" + POList + "'";
        dt = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Qry).Tables[0];
        GV_Booking.DataSource = dt;
        GV_Booking.DataBind();
    }
    public string getnewcd()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "exec WebX_SP_GetNextDocumentCode_FA   '" + Session["BRCD"].ToString() + "','" + Session["finyear"].ToString() + "','GGRN'";
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        string cd1 = (string)sqlcmd.ExecuteScalar();
        return cd1;
    }
    protected void btn_csv_Click(object sender, EventArgs e)
    {
        SqlTransaction trans, trans2;
        SqlConnection conn = new SqlConnection(SessionUtilities.ConnectionString);
        conn.Open();
        trans = conn.BeginTransaction();

        string Xml_ReqMST = "<root><GRNMst>", Xml_ReqDET = "<root>", MSTID = "", VendCd = "", VendNm = "";
        string[] Vend_Arr = null;
        try
        {
            if (VendorCode.ToString() != "")
            {
                string Vendor = VendorCode.ToString().Replace("&", "AND").Trim();
                Vend_Arr = Vendor.Split('~');
                VendCd = Vend_Arr[1].ToString();
                VendNm = Vend_Arr[0].ToString();
            }
            else if (POList != "")
            {
                if (VendorName(POList) != "")
                {
                    string Vendor = VendorName(POList).ToString().Replace("&", "AND").Trim();
                    Vend_Arr = Vendor.Split('~');
                    VendCd = Vend_Arr[1].ToString();
                    VendNm = Vend_Arr[0].ToString();
                }
            }
            else
            {
                VendCd = "";
                VendNm = "";
            }
            Xml_ReqMST = Xml_ReqMST + "<BBRCD>" + Session["brcd"].ToString() + "</BBRCD>";
            Xml_ReqMST = Xml_ReqMST + "<CHALLANDT>" + fn.Mydate(txtChallandt.Text.ToString()) + "</CHALLANDT>";
            Xml_ReqMST = Xml_ReqMST + "<RECEIVEDT>" + fn.Mydate(txtChallandt.Text.ToString()) + "</RECEIVEDT>";
            Xml_ReqMST = Xml_ReqMST + "<REMARK>" + txtRemark.Text.ToString() + "</REMARK>";
            Xml_ReqMST = Xml_ReqMST + "<ManualGRNNO>" + txtMNGRNno.Text.ToString() + "</ManualGRNNO>";
            Xml_ReqMST = Xml_ReqMST + "<PREPAREDBY>" + Session["empcd"].ToString() + "</PREPAREDBY>";
            Xml_ReqMST = Xml_ReqMST + "<GRN_LOC>" + lblGRNLoc.Text.ToString() + "</GRN_LOC>";
            Xml_ReqMST = Xml_ReqMST + "<PAY_LOC>" + PayLocation.ToString() + "</PAY_LOC>";
            Xml_ReqMST = Xml_ReqMST + "<VENDORCD>" + VendCd + "</VENDORCD>";
            Xml_ReqMST = Xml_ReqMST + "<VENDORNM>" + VendNm + "</VENDORNM>";
            Xml_ReqMST = Xml_ReqMST + "<ENTRYBY>" + Session["empcd"].ToString() + "</ENTRYBY>";
			Xml_ReqMST = Xml_ReqMST + "<COMPANYCODE>" + SessionUtilities.DefaultCompanyCode.ToString() + "</COMPANYCODE>";
            Xml_ReqMST = Xml_ReqMST + "</GRNMst></root>";
            foreach (GridViewRow GR in GV_Booking.Rows)
            {
                CheckBox chk = (CheckBox)GR.FindControl("chksrno");
                TextBox Txt_Qty = (TextBox)GR.FindControl("txtQty");
                HiddenField Hnd_per = (HiddenField)GR.FindControl("HidQty");
                HiddenField narration = (HiddenField)GR.FindControl("HDNNarration");
				HiddenField HidPoSrno = (HiddenField)GR.FindControl("HidPoSrno");
                HiddenField HdnFldTyre_Selection = (HiddenField)GR.FindControl("HdnFldTyre_Selection");
                string[] ICode_Arr = GR.Cells[0].Text.ToString().Split('~');
                string Item1 = "", Item2 = "", Item3 = "", Item4 = "";
                if (ICode_Arr.Length == 1)
                {
                    Item1 = ICode_Arr[0].ToString();
                }
                else
                {
                    Item1 = ICode_Arr[0].ToString();
                    Item2 = ICode_Arr[1].ToString();
                    Item3 = ICode_Arr[2].ToString();
                    Item4 = ICode_Arr[3].ToString();
                }
                if (HdnFldTyre_Selection.Value.ToString() == "Y")
                {
                    Xml_ReqDET = Xml_ReqDET + "<GRNdet>";
                    Xml_ReqDET = Xml_ReqDET + "<POCODE>" + LblPONo.Text.ToString() + "</POCODE>";
                    if (ICode_Arr.Length == 1)
                    {
                        Xml_ReqDET = Xml_ReqDET + "<ICODE>" + GR.Cells[0].Text.ToString() + "</ICODE>";
                        Xml_ReqDET = Xml_ReqDET + "<INAME>" + GR.Cells[1].Text.ToString() + "</INAME>";
                    }
                    else
                    {
                        Xml_ReqDET = Xml_ReqDET + "<ICODE>" + Item1.Trim() + "</ICODE>";
                        Xml_ReqDET = Xml_ReqDET + "<INAME>" + Item1.Trim() + "</INAME>";
                    }
                    Xml_ReqDET = Xml_ReqDET + "<TOTALQTY>" + GR.Cells[2].Text.ToString() + "</TOTALQTY>";
                    Xml_ReqDET = Xml_ReqDET + "<RECEQTY>" + Txt_Qty.Text.ToString() + "</RECEQTY>";
                    Xml_ReqDET = Xml_ReqDET + "<RATE>" + GR.Cells[3].Text.ToString() + "</RATE>";
                    Xml_ReqDET = Xml_ReqDET + "<TOTAL>" + LblPOAmount.Text.ToString() + "</TOTAL>";
                    Xml_ReqDET = Xml_ReqDET + "<ITEM1>" + Item1.Trim() + "</ITEM1>";
                    Xml_ReqDET = Xml_ReqDET + "<ITEM2>" + Item2.Trim() + "</ITEM2>";
                    Xml_ReqDET = Xml_ReqDET + "<ITEM3>" + Item3.Trim() + "</ITEM3>";
                    Xml_ReqDET = Xml_ReqDET + "<ITEM4>" + Item4.Trim() + "</ITEM4>";
                    Xml_ReqDET = Xml_ReqDET + "<narration>" + narration.Value + "</narration>";
					Xml_ReqDET = Xml_ReqDET + "<PoSrno>" + HidPoSrno.Value + "</PoSrno>";
                    Xml_ReqDET = Xml_ReqDET + "</GRNdet>";
                }
            }
            Xml_ReqDET = Xml_ReqDET + "</root>";
            GenXml = "<root>" + GenXml + "</root>";
            string GRNNo = getnewcd();
            string Sql = "EXEC [Usp_Insert_GRN_Data_Ver2] '" + Xml_ReqMST.Replace("&", "&amp;").Replace("–", "-").Replace("'", "").Trim() + "','" + Xml_ReqDET.Replace("&", "&amp;").Replace("–", "-").Replace("'", " ").Replace("'", "").Trim() + "','" + GenXml.Replace("&", "&amp;").Replace("–", "-").Trim() + "','" + SessionUtilities.CurrentBranchCode.ToString() + "','" + SessionUtilities.FinYear.ToString() + "','" + GRNNo + "','PO'";
            SqlDataReader DR = SqlHelper.ExecuteReader(SessionUtilities.ConnectionString, CommandType.Text, Sql);
            if (DR.Read())
                MSTID = DR[0].ToString();
            DR.Close();
            trans.Commit();
			//trans.Rollback();

            //**************************updated by vidya on 6/10/2012

            //trans2 = conn.BeginTransaction();
            //Double Amt = Convert.ToDouble(Request.QueryString["POAmount"]);
            //Double HDFAMT = Convert.ToDouble(hdfNo_Row.Value);
            //Double PAmt = (Amt / HDFAMT);

            //foreach (GridViewRow GR in GridView1.Rows)
            //{
            //    string sql2 = "USP_TYREMST_New";
            //    SqlCommand sqlcmd2 = new SqlCommand(sql2, conn, trans2);
            //    sqlcmd2.CommandType = CommandType.StoredProcedure;

            //    TextBox txtTyreNo = (TextBox)GR.FindControl("txtTyreNo");
            //    // DropDownList ddlSize = (DropDownList)GR.FindControl("ddlSize");
            //    DropDownList ddlposition = (DropDownList)GR.FindControl("ddlposition");
            //    //DropDownList ddlTyreModel = (DropDownList)GR.FindControl("ddlTyreModel");
            //    //DropDownList ddlTyreCategory = (DropDownList)GR.FindControl("ddlTyreCategory");
            //    //DropDownList ddlManufacturer = (DropDownList)GR.FindControl("ddlManufacturer");


            //    Label lblMFG = (Label)GR.FindControl("lblMFG");
            //    Label lblModel = (Label)GR.FindControl("lblModel");
            //    Label lblSize = (Label)GR.FindControl("lblSize");
            //    Label lblCategory = (Label)GR.FindControl("lblCategory");

            //    sqlcmd2.CommandType = CommandType.StoredProcedure;
            //    //sqlcmd2.Parameters.Add("@TYRE_ID", SqlDbType.VarChar).Value = ;
            //    if (txtTyreNo.Text != "")
            //    {
            //        sqlcmd2.Parameters.Add("@TYRE_NO", SqlDbType.VarChar).Value = txtTyreNo.Text.ToString().Trim();
            //        sqlcmd2.Parameters.Add("@TYRE_CATEGORY", SqlDbType.VarChar).Value = "01";
            //        //ddlTyreCategory.SelectedValue.ToString().Trim();
            //        sqlcmd2.Parameters.Add("@TYRE_SIZEID", SqlDbType.VarChar).Value = hdfSize.Value.ToString().Trim();
            //        //lblSize.Text.ToString().Trim();
            //        sqlcmd2.Parameters.Add("@MFG_ID", SqlDbType.VarChar).Value = hdfMFG.Value.ToString().Trim();
            //        sqlcmd2.Parameters.Add("@TYRE_PURDT", SqlDbType.VarChar).Value = LblPODate.Text.ToString().Trim();
            //        sqlcmd2.Parameters.Add("@TYRE_COST", SqlDbType.VarChar).Value = Convert.ToString(PAmt);
            //        sqlcmd2.Parameters.Add("@TYRE_LOCATION", SqlDbType.VarChar).Value = SessionUtilities.CurrentBranchCode;
            //        sqlcmd2.Parameters.Add("@TYRE_VENDOR", SqlDbType.VarChar).Value = Request.QueryString["VendorCode"].ToString();
            //        sqlcmd2.Parameters.Add("@TYRE_ENTRYBY", SqlDbType.VarChar).Value = SessionUtilities.CurrentEmployeeID;
            //        sqlcmd2.Parameters.Add("@TYRE_MODEL_ID", SqlDbType.VarChar).Value = hdfModel.Value.ToString().Trim();
            //        sqlcmd2.Parameters.Add("@TYREPOS_ID", SqlDbType.VarChar).Value = ddlposition.SelectedValue.ToString().Trim();

            //        sqlcmd2.ExecuteNonQuery();
            //    }
            //}

            //trans2.Commit();
            //**************************
            Response.Redirect("GRN_Done.aspx?Type=PO&GRNNO=" + MSTID, false);
        }
        catch (Exception ex)
        {
            trans.Rollback();
            string Err_Msg = ex.Message.ToString().Replace('\n', '_');
//            Response.Redirect("../../../ErrorPage.aspx?heading=Master Generation Error&detail1=Session TimeOut Occured&detail2=" + Err_Msg + "&suggestion2=Item Group Master");.
            Response.Redirect("../../../ErrorPage.aspx?PageHead=Master Generation Error&detail1=Session TimeOut Occured&ErrorMsg=" + Err_Msg + "&suggestion2=Item Group Master");

            
        }
        finally
        {
            conn.Close();
        }
    }
    //Tyre Related Portion
    protected void Show_SKUWise_TyreNo(object sender, EventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
        Tr_MultiView.Visible = true;

        LinkButton L1 = (LinkButton)sender;
        GridViewRow GR = L1.Parent.Parent as GridViewRow;

        foreach (GridViewRow gridrow in GV_Booking.Rows)
        {
            TextBox txtBalQty_1 = (TextBox)gridrow.FindControl("txtBalQty");
            HiddenField HdnBalQty_1 = (HiddenField)gridrow.FindControl("HdnBalQty");
            if (txtBalQty_1.Text != "")
            {
                txtBalQty_1.Text = HdnBalQty_1.Value;
            }
        }
        
        LinkButton linkbtn = (LinkButton)GR.FindControl("linkbtn");
        HiddenField hdfItemCode = (HiddenField)GR.FindControl("hdfItemCode");
        HiddenField hdfItemDesc = (HiddenField)GR.FindControl("hdfItemDesc");
        TextBox txtBalQty = (TextBox)GR.FindControl("txtBalQty");
        HiddenField HdnBalQty = (HiddenField)GR.FindControl("HdnBalQty");
	    TextBox txtQty = (TextBox)GR.FindControl("txtQty");
        HiddenField HidPoSrno = (HiddenField)GR.FindControl("HidPoSrno");

        HdnTyreQty.Value = txtQty.Text;
        hdnSelectedMaterial.Value = HidPoSrno.Value;
        txtBalQty.Text = HdnBalQty.Value;
        txtQty.Enabled = false;
        linkbtn.Enabled = false;

        StrTyrecode = hdfItemCode.Value;
        StrTyreDesc = hdfItemDesc.Value;
        string[] Code_Id = StrTyrecode.ToString().Split('~');
        string[] Code_Desc = StrTyreDesc.ToString().Split('~');


        hdfModel.Value = Code_Id[0].ToString();
        hdfMFG.Value = Code_Id[1].ToString();
        hdfCategory.Value = Code_Id[2].ToString();
        hdfSize.Value = Code_Id[3].ToString();

        hdfModelDesc.Value = Code_Desc[0].ToString();
        hdfMFGDesc.Value = Code_Desc[1].ToString();
        hdfCategoryDesc.Value = Code_Desc[2].ToString();
        hdfSizeDesc.Value = Code_Desc[3].ToString();
        
        ////for (int i = 0; i < Convert.ToInt32(txtQty.Text.ToString()); i++)
        ////{
        ////    dt.Rows.Add();
        ////}
        //*********************updated by vidya on 6/2/2013 

        string MainString = txtQty.Text.ToString();
        string SearchString = ".";
        int FirstChr = MainString.IndexOf(SearchString);
        string TempS = MainString.Substring(0, FirstChr);
        int tempN = Int32.Parse(TempS);       
        hdfNo_Row.Value = TempS;

        int maxrows = 0;
        if (hdfNo_Row.Value != "0")
        {
            try
            {
                maxrows = int.Parse(hdfNo_Row.Value);

                for (int i = 0; i < maxrows; i++)
                {
                    dt.Rows.Add();
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
        }

        

        GridView1.DataSource = dt;
        GridView1.DataBind();
        //dockdata_SelectedIndexChanged(sender, e);
        btn_csv.Visible = false;

    }
    protected void Save_SKUWise_SerialNo(object sender, EventArgs e)
    {
        Tr_MultiView.Visible = false;
        foreach (GridViewRow gridrow in GridView1.Rows)
        {
            TextBox txtTyreNo = (TextBox)gridrow.FindControl("txtTyreNo");
            DropDownList ddlposition = (DropDownList)gridrow.FindControl("ddlposition");
            string[] VendorCls = Request.QueryString["VendorCode"].ToString().Trim().Split('~');

            Xml_SKUWise = Xml_SKUWise + "<SKUWise_TyreNo>";
            Xml_SKUWise = Xml_SKUWise + "<TyreNo>" + txtTyreNo.Text.ToString() + "</TyreNo>";
            Xml_SKUWise = Xml_SKUWise + "<TyreSizeId>" + hdfSize.Value.ToString().Trim() + "</TyreSizeId>";
            Xml_SKUWise = Xml_SKUWise + "<TyreMFGId>" + hdfMFG.Value.ToString().Trim() + "</TyreMFGId>";
            Xml_SKUWise = Xml_SKUWise + "<TyreModelId>" + hdfModel.Value.ToString().Trim() + "</TyreModelId>";
            Xml_SKUWise = Xml_SKUWise + "<TyreCategory>" + hdfCategory.Value.ToString().Trim() + "</TyreCategory>";
            Xml_SKUWise = Xml_SKUWise + "<ENTRYBY>" + SessionUtilities.CurrentEmployeeID.ToString().Trim() + "</ENTRYBY>";
            Xml_SKUWise = Xml_SKUWise + "<Vendor>" + VendorCls[1].ToString().Trim() + "</Vendor>";
            Xml_SKUWise = Xml_SKUWise + "<Location>" + SessionUtilities.CurrentBranchCode.ToString().Trim() + "</Location>";
            Xml_SKUWise = Xml_SKUWise + "<Position></Position>";
            Xml_SKUWise = Xml_SKUWise + "</SKUWise_TyreNo>";
        }
        foreach (GridViewRow gridrow in GV_Booking.Rows)
        {
            LinkButton linkbtn = (LinkButton)gridrow.FindControl("linkbtn");
            HiddenField hdfItemCode = (HiddenField)gridrow.FindControl("hdfItemCode");
            TextBox txtQty = (TextBox)gridrow.FindControl("txtQty");
            HiddenField HdnFldTyre_Selection = (HiddenField)gridrow.FindControl("HdnFldTyre_Selection");
            HiddenField HidPoSrno = (HiddenField)gridrow.FindControl("HidPoSrno");

            string Tyrecode = hdfItemCode.Value;
            string[] CodeId = Tyrecode.ToString().Split('~');
            //if (CodeId[0].ToString() == hdfModel.Value.ToString())
            if (CodeId[0].ToString() == hdfModel.Value.ToString() && CodeId[1].ToString() == hdfMFG.Value.ToString()
                && CodeId[2].ToString() == hdfCategory.Value.ToString() && CodeId[3].ToString() == hdfSize.Value.ToString()
                && HdnTyreQty.Value == txtQty.Text && HidPoSrno.Value == hdnSelectedMaterial.Value)
            {
                HdnFldTyre_Selection.Value = "Y";
                linkbtn.Enabled = false;
                txtQty.Enabled = false;
            }
        }

        GenXml = GenXml + Xml_SKUWise.ToString();
        btn_csv.Visible = true;
    }
    public void TyreGridView_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtTyreNo = (TextBox)e.Row.FindControl("txtTyreNo");
            Label lblSize = (Label)e.Row.FindControl("lblSize");
            Label lblMFG = (Label)e.Row.FindControl("lblMFG");
            Label lblModel = (Label)e.Row.FindControl("lblModel");
            Label lblCategory = (Label)e.Row.FindControl("lblCategory");
            //DropDownList ddlposition = (DropDownList)e.Row.FindControl("ddlposition");
            lblSize.Text = hdfSizeDesc.Value;
            lblMFG.Text = hdfMFGDesc.Value;
            lblModel.Text = hdfModelDesc.Value;
            lblCategory.Text = hdfCategoryDesc.Value;

            //string Sql = "SELECT CodeId,CodeDesc FROM Webx_Master_General WHERE CodeType='TYPOS' AND StatusCode='Y 'UNION SELECT '0','Select' FROM Webx_Master_General  ORDER BY CodeId";
            //DataTable DtDDLPos = SqlHelper.ExecuteDataset(SessionUtilities.ConnectionString, CommandType.Text, Sql).Tables[0];

            //if (DtDDLPos.Rows.Count > 0)
            //{
            //    ddlposition.DataSource = DtDDLPos;
            //    ddlposition.DataTextField = "CodeDesc";
            //    ddlposition.DataValueField = "CodeId";
            //    ddlposition.DataBind();
            //}

            //txtTyreNo.Attributes.Add("OnBlur", "javascript:checkTyreNo(" + txtTyreNo.ClientID.ToString() + ");");
            txtTyreNo.Attributes.Add("OnBlur", "javascript:checkTyreNo(" + e.Row.RowIndex + "," + txtTyreNo.ClientID.ToString() + ");");

        }
    }
    //END********************************************

    public string VendorName(string PO)
    {
        object Obj = null;
        string Qry = "SELECT Vendorname+'~'+Vendorcode FROM webx_GENERAL_POASSET_HDR WHERE POCode='" + PO + "'";
        Obj = SqlHelper.ExecuteScalar(SessionUtilities.ConnectionString, CommandType.Text, Qry).ToString();
        return Obj.ToString();
    }
}


