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
using System.IO;

public partial class DocumentEntry : System.Web.UI.Page
{
    public MyFleetDataSet _dataSet = new MyFleetDataSet();
    int _lastEditedPage;    
    //int mDataCount = 0;
    //MyFleetDataSet.TYREREMOULDINGRow datarow_remould;
    //MyFleetDataSet.DocumentMstDetDataTable dt_DocuTypeMstDet = new MyFleetDataSet.DocumentMstDetDataTable();  
    SqlConnection conn = new SqlConnection();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (txtVehNo.Text == "")
            {
                Table3.Visible = true;
                Table1.Visible = false;
                //btn_Submit.Visible = false;
                Table5.Visible = true;
                btnSumit.Visible = true;
                Table4.Visible = false;
                ImageButton1.Visible = false;
            }
            btnPopupVehno.Attributes.Add("OnClick", "window.open('../../../GUI/Fleet/Document/Popup/VehicleNo.aspx?vehno=" + txtVehNo.ClientID.ToString() + "&VehType=" + hfVehType.ClientID.ToString() + "&vehid=" + hfVehIntId.ClientID.ToString() + "&km=" + hfKm.ClientID.ToString() + "',null,'left=300, top=150, height=300, width=300, status=no, resizable=no, scrollbars=yes, toolbar=no,location=no, menubar= no');return false;");
            txtVehNo.Attributes.Add("OnBlur", "javascript:checkVehNo(" + txtVehNo.ClientID.ToString() + "," + hfVehIntId.ClientID.ToString() + "," + hfKm.ClientID.ToString() + "," + hfVehType.ClientID.ToString() + ");");
            BindDropDown("USP_DOCUTYPE_LIST", "DOCU_TYPE", "DOCU_TYPE_ID", ddlDocumentType);
            //txtKm.Attributes.Add("OnFocus", "javascript:document.getElementById('" + ddlDocumentType.ClientID.ToString() + "').focus();");
            BindGrid();
            lbl_Page_Error.Text = "";
        }
    }
    private void BindGrid()
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        
        string sql = "usp_WEBX_FLEET_DOCUMENT_DET_SelectAll";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        if (hfDocId.Value != "")
        {
            cmd.Parameters.Add("@DOCU_ID", SqlDbType.Int).Value = Convert.ToInt32(hfDocId.Value);
        }
        else
        {
            cmd.Parameters.Add("@DOCU_ID", SqlDbType.Int).Value = 0;
        }
        DataSet ds = new DataSet();
        adp.Fill(ds);
        gvDocuTypeDet.DataSource = ds;
        gvDocuTypeDet.DataBind();
        
        if (Table4.Visible == true)
        {
            Table4.Width = "100%";
            LinkButton lnkbtnEdit = (LinkButton)gvDocuTypeDet.Rows[0].Cells[9].FindControl("LinkButton1");
            LinkButton lnkbtnDelete = (LinkButton)gvDocuTypeDet.Rows[0].Cells[9].FindControl("LinkButton2");
           
            if (lnkbtnEdit.Text == "Edit")
            {
                lnkbtnEdit.Text = "Add";
                lnkbtnEdit.Visible = true;
                lnkbtnDelete.Visible = false;
                Table4.Width = "70%";
            }
            else
            {
                Table4.Width = "100%";
            }
        }
        else
        {
            Table4.Width = "70%";
        }
        foreach (GridViewRow r in gvDocuTypeDet.Rows)
        {
            if (r.RowIndex == gvDocuTypeDet.Rows.Count - 1)
            {
                LinkButton LinkButton1 = (LinkButton)gvDocuTypeDet.Rows[r.RowIndex].Cells[9].FindControl("LinkButton1");
                LinkButton LinkButton2 = (LinkButton)gvDocuTypeDet.Rows[r.RowIndex].Cells[9].FindControl("LinkButton2");
                if (LinkButton1.Text == "Add")
                {
                    LinkButton1.Visible = true;
                    LinkButton2.Visible = false;
                }
                else
                {
                    LinkButton1.Visible = true;
                    LinkButton2.Visible = true;
                }
            }
        }
        
    }
  
    protected void gvDocuType_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton LinkButton1 = (LinkButton)e.Row.FindControl("LinkButton1");
            LinkButton LinkButton2 = (LinkButton)e.Row.FindControl("LinkButton2");
            HyperLink hyperView = (HyperLink)e.Row.FindControl("hyperView");
            if (e.Row.RowIndex == 0)
            {
                if (LinkButton1.Text == "Edit")
                {
                    LinkButton1.Visible = true;
                    LinkButton2.Visible = false;
                    hyperView.Text = "";
                }
                else
                {
                    LinkButton1.Visible = true;
                    LinkButton2.Visible = true;
                }
            }
            else
            {
                if (LinkButton1.Text == "Edit")
                {
                    if (hyperView.ToolTip == "")
                    {
                        hyperView.Text = "";
                    }
                }
            }


            
            if (LinkButton1.Text != "Edit")
            {

                //if (hyperView.ToolTip == "")
                //{
                //    hyperView.NavigateUrl = ""; 
                //}
                //Image img_CalendarSt = (Image)e.Row.FindControl("img_CalendarSt");
                //Image img_CalendarEx = (Image)e.Row.FindControl("img_CalendarEx");
                TextBox txtStartDt = (TextBox)e.Row.FindControl("txtStartDt");
                TextBox txtExpityDt = (TextBox)e.Row.FindControl("txtExpityDt");
                //img_CalendarSt.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtStartDt.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtStartDt.ClientID + @"\')')");
                //img_CalendarEx.Attributes.Add("OnClick", "javascript:return popUpCalendar(this," + txtExpityDt.ClientID + @", 'dd/mm/yyyy', '__doPostBack(\'" + txtExpityDt.ClientID + @"\')')");
                //DropDownList ddlStates = (DropDownList)e.Row.FindControl("ddlStates");
                CheckBoxList chklstState = (CheckBoxList)e.Row.FindControl("chklstState");

                //BindDropDown("USP_DOCMGT_STATE", "STNM", "STCD", ddlStates);
                BindCheckboxList("USP_DOCMGT_STATE", "STNM", "STCD", chklstState);
                
                //Label lblID = (Label)e.Row.FindControl("lblID");
                HiddenField hf_DocDetId = (HiddenField)e.Row.FindControl("hf_DocDetId");
                SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
                string SQL = "SELECT [APPLICABLE_STATE] FROM [WEBX_FLEET_DOCUMENT_DET] WHERE [DOCU_DET_ID] = " + Convert.ToInt32(hf_DocDetId.Value.ToString().Trim()) + "";
                conn.Open();
                SqlCommand cmd = new SqlCommand(SQL, conn);
                cmd.CommandType = CommandType.Text;
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        //ddlStates.SelectedValue = dr["APPLICABLE_STATE"].ToString();
                        string strStates = dr["APPLICABLE_STATE"].ToString();
                        string[] statearr = strStates.Split(',');
                        if (statearr.Length != 0)
                        {
                            for (int i = 0; i < chklstState.Items.Count; i++)
                            {
                                for (int j = 0; j < statearr.Length; j++)
                                {
                                    if (statearr[j].ToString() == chklstState.Items[i].Text)
                                    {
                                        chklstState.Items[i].Selected = true;
                                    }
                                }
                            }
                        }

                    }
                }
                dr.Close();
                conn.Close();

                ((TextBox)e.Row.FindControl("txtDocumnetNo")).Attributes.Add("OnBlur", "javascript:CheckDocNo(" + e.Row.DataItemIndex + "," + ((TextBox)e.Row.FindControl("txtDocumnetNo")).ClientID.ToString() + "," + hfVehIntId.ClientID.ToString() + "," + hfDoctype.ClientID.ToString() + "," + hfDocId.ClientID.ToString() + "," + hf_DocDetId.ClientID.ToString() + ");");
            }
            else if (LinkButton1.Text != "Update")
            {

            }
            if (hfStateWise.Value == "Yes") { gvDocuTypeDet.Columns[5].Visible = true; } else { gvDocuTypeDet.Columns[5].Visible = false; }
            if (hfCost.Value == "Yes") { gvDocuTypeDet.Columns[4].Visible = true; } else { gvDocuTypeDet.Columns[4].Visible = false; }
        }
    }

    public void BindDropDown(string strProc, string text, string value, DropDownList d)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                d.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }
    public void BindCheckboxList(string strProc, string text, string value, CheckBoxList l)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string STR = strProc;
        conn.Open();
        SqlCommand cmd = new SqlCommand(STR, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                l.Items.Add(new ListItem(Convert.ToString(dr[text]), Convert.ToString(dr[value])));
            }
        }
        dr.Close();
        conn.Close();
    }
    protected void btnSumit_Click(object sender, EventArgs e)
    {
        lblVehNo.Text = txtVehNo.Text;
        lblVehType.Text = hfVehType.Value;
        lblDocType.Text = ddlDocumentType.SelectedItem.Text.ToString();
        hfDoctype.Value = ddlDocumentType.SelectedValue; 
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_document_type_list";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        //SqlDataAdapter adp = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@DOCU_TYPE_ID", ddlDocumentType.SelectedValue);
        cmd.Parameters.AddWithValue("@DOCU_TYPE", "");
        //DataSet ds = new DataSet();
        //adp.Fill(ds);
        SqlDataReader dr = cmd.ExecuteReader();

        while (dr.Read())
        {
            lblDocDesc.Text = dr["DECS"].ToString();
            lblRenewAutu.Text = dr["RENEW_AUTH"].ToString(); 
        }
        conn.Close();
        


        conn.Open();
        string sql1 = "usp_WEBX_FLEET_DOCUMENT_MST_Insert";
        SqlCommand cmd1 = new SqlCommand(sql1, conn);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.AddWithValue("@VEH_NO", Convert.ToString(hfVehIntId.Value.ToString().Trim()));
        cmd1.Parameters.AddWithValue("@REMINDER_IN_DAYS","0");
        cmd1.Parameters.AddWithValue("@DOCU_TYPE_ID", Convert.ToInt32(ddlDocumentType.SelectedValue.ToString()));
        cmd1.ExecuteNonQuery();
        conn.Close();
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        conn.Open();
        string sql2 = "SELECT DOCU_ID,REMINDER_IN_DAYS FROM WEBX_FLEET_DOCUMENT_MST WHERE VEH_NO=" + hfVehIntId.Value + "  AND DOCU_TYPE_ID=" + ddlDocumentType.SelectedValue + " ";
        SqlDataAdapter adp = new SqlDataAdapter(sql2, conn);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count != 0)
        {
            hfDocId.Value = ds.Tables[0].Rows[0]["DOCU_ID"].ToString();
            txtReminderInDays.Text = ds.Tables[0].Rows[0]["REMINDER_IN_DAYS"].ToString();
        }

        conn.Close();

        if (txtVehNo.Text != "")
        {
            Table3.Visible = false;
            Table1.Visible = true;
            //btn_Submit.Visible = true;
            Table5.Visible = false;
            btnSumit.Visible = false;
            Table4.Visible = true;
            if (gvDocuTypeDet.Rows.Count > 0)
            {
                if (Table4.Visible == true)
                {
                    LinkButton lnkbtnEdit = (LinkButton)gvDocuTypeDet.Rows[0].Cells[8].FindControl("LinkButton1");
                    LinkButton lnkbtnDelete = (LinkButton)gvDocuTypeDet.Rows[0].Cells[8].FindControl("LinkButton2");
                    lnkbtnEdit.Visible = true;
                    lnkbtnEdit.Text = "Add";
                    lnkbtnDelete.Visible = false;
                }
            }
        }
        txtVehNo.Text = "";
        ImageButton1.Visible = true;
        BindGrid();
       
    }
    protected void gvDocuTypeDet_RowAdding(object sender,GridViewUpdateEventArgs e)
    {
        TextBox txtDocumnetNo = (TextBox)gvDocuTypeDet.Rows[e.RowIndex].FindControl("txtDocumnetNo");
        TextBox txtRenewAutuName = (TextBox)gvDocuTypeDet.Rows[e.RowIndex].FindControl("txtRenewAutuName");
        TextBox txtStartDt = (TextBox)gvDocuTypeDet.Rows[e.RowIndex].FindControl("txtStartDt");
        TextBox txtExpityDt = (TextBox)gvDocuTypeDet.Rows[e.RowIndex].FindControl("txtExpityDt");
        TextBox txtCost = (TextBox)gvDocuTypeDet.Rows[e.RowIndex].FindControl("txtCost");
        TextBox txtEnterBy = (TextBox)gvDocuTypeDet.Rows[e.RowIndex].FindControl("txtEnterBy");
        //DropDownList ddlStates = (DropDownList)gvDocuTypeDet.Rows[e.RowIndex].FindControl("ddlStates");
        CheckBoxList chklstState = (CheckBoxList)gvDocuTypeDet.Rows[e.RowIndex].FindControl("chklstState");
        HtmlInputFile FileUpload1 = (HtmlInputFile)gvDocuTypeDet.Rows[e.RowIndex].FindControl("FileUpload1");
        TextBox txtRamarks = (TextBox)gvDocuTypeDet.Rows[e.RowIndex].FindControl("txtRamarks");
        //Label lblID = (Label)gvDocuTypeDet.Rows[e.RowIndex].FindControl("lblID");
        HiddenField hf_DocDetId = (HiddenField)gvDocuTypeDet.Rows[e.RowIndex].FindControl("hf_DocDetId");
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        string strStateList = "";
        for(int i=0;i<chklstState.Items.Count;i++)
        {
            if (chklstState.Items[i].Selected == true)
            {
                strStateList = strStateList + chklstState.Items[i].Text + ",";
            }
        }
        if (strStateList == "")
        {
            strStateList = "0";
        }

        conn.Open();
        string sql="";
        if (e.RowIndex == 0)
        {
            sql = "usp_WEBX_FLEET_DOCUMENT_DET_Insert";
        }
        else
        {
            sql = "usp_WEBX_FLEET_DOCUMENT_DET_Update";
        }
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure; 
        cmd.Parameters.AddWithValue("@RENEWAL_AUTU_NAME", txtRenewAutuName.Text.ToString().Trim());
        cmd.Parameters.AddWithValue("@DOCUMENT_NO", txtDocumnetNo.Text.ToString().Trim());

        

        string[] Stdt = txtStartDt.Text.ToString().Trim().Split('/');
        DateTime stdt = new DateTime(Convert.ToInt32(Stdt[2].ToString()), Convert.ToInt32(Stdt[1].ToString()), Convert.ToInt32(Stdt[0].ToString()));
        string[] Exdt = txtExpityDt.Text.ToString().Trim().Split('/');
        DateTime exdt = new DateTime(Convert.ToInt32(Exdt[2].ToString()), Convert.ToInt32(Exdt[1].ToString()), Convert.ToInt32(Exdt[0].ToString()));
        
        cmd.Parameters.Add("@START_DT",SqlDbType.DateTime).Value = stdt;
        cmd.Parameters.Add("@EXPRITY_DT", SqlDbType.DateTime).Value = exdt; 
        cmd.Parameters.AddWithValue("@REMINDER_IN_DAYS", txtReminderInDays.Text);
        cmd.Parameters.AddWithValue("@APPLICABLE_STATE", strStateList.ToString().Trim().Substring(0,strStateList.Length-1));
        cmd.Parameters.AddWithValue("@DOCU_COST", txtCost.Text.ToString().Trim());
        cmd.Parameters.AddWithValue("@REMARKS", txtRamarks.Text.ToString().Trim());


        if (FileUpload1.PostedFile.FileName != "")
        {
            HttpPostedFile file = FileUpload1.PostedFile;
            cmd.Parameters.AddWithValue("@FILENAME", GetFileName(file));// strfilename[strfilename.Length-1]);
        }
        else
        {
            cmd.Parameters.AddWithValue("@FILENAME", "");// strfilename[strfilename.Length-1]);
        }
        cmd.Parameters.AddWithValue("@DOCU_ID", Convert.ToInt32(hfDocId.Value));

        if (e.RowIndex != 0)
        {
            //cmd.Parameters.AddWithValue("@DOCU_DET_ID", Convert.ToInt32(lblID.Text.ToString().ToString()));
            cmd.Parameters.AddWithValue("@DOCU_DET_ID", Convert.ToInt32(hf_DocDetId.Value.ToString().Trim()));
        }
        else
        {
            cmd.Parameters.Add("@ENTRY_BY", SqlDbType.VarChar, 50).Value = SessionUtilities.CurrentEmployeeID.ToString().Trim();
        }
        cmd.Parameters.Add("@ENTER_BY", SqlDbType.VarChar, 50).Value = txtEnterBy.Text;

        cmd.ExecuteReader();
        conn.Close();
        FileUpload(FileUpload1);
        System.Collections.Hashtable h = new System.Collections.Hashtable();

        foreach (System.Collections.DictionaryEntry x in e.NewValues)
        {
            h[x.Key] = x.Value;
        }
        gvDocuTypeDet.EditIndex = -1;
        BindGrid();
        //u2.Update();
        Table4.Width = "70%";
        //HideButton();
       
        
    }
    public void FileUpload(HtmlInputFile f)
    {
        HttpPostedFile file = f.PostedFile;
        if (file.FileName != "")
        {
            string filename = GetFileName(file);
            if (file.ContentType.IndexOf("excel") >= 0)
                file.SaveAs(Server.MapPath(@"~\GUI\Fleet\Document\Upload\Excel\" + filename));
            else if (file.ContentType.IndexOf("word") >= 0)
                file.SaveAs(Server.MapPath(@"~\GUI\Fleet\Document\Upload\Word\" + filename));
            else
                file.SaveAs(Server.MapPath(@"~\GUI\Fleet\Document\Upload\Other\" + filename));
        }
    }
    private string GetFileName(HttpPostedFile file)
    {
        int i = 0, j = 0;
        string filename;

        filename = file.FileName;
        do
        {
            i = filename.IndexOf(@"\", j + 1);
            if (i >= 0) j = i;
        } while (i >= 0);
        filename = filename.Substring(j + 1, filename.Length - j - 1);

        return filename;
    }

    protected void gvDocuTypeDet_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvDocuTypeDet.EditIndex = e.NewEditIndex;
        BindGrid();
        //u2.Update();
    }
    protected void gvDocuTypeDet_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvDocuTypeDet.EditIndex = -1;
        BindGrid();
        Table4.Width = "70%";
        //u2.Update();
    }
    protected void gvDocuTypeDet_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        BindGrid();
    }
    protected void gvDocuTypeDet_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_WEBX_FLEET_DOCUMENT_DET_Delete";
        //Label lblID = (Label)gvDocuTypeDet.Rows[e.RowIndex].FindControl("lblID");
        HiddenField hf_DocDetId = (HiddenField)gvDocuTypeDet.Rows[e.RowIndex].FindControl("hf_DocDetId");
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@DOCU_DET_ID", Convert.ToInt32(hf_DocDetId.Value.ToString().Trim()));
        cmd.ExecuteNonQuery();
        conn.Close();
        BindGrid();
        Table4.Width = "70%";
    }
    protected void ddlDocumentType_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        string sql = "usp_CapDocTypeDet";
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@DOCU_TYPE_ID", Convert.ToInt32(ddlDocumentType.SelectedValue));
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            hfStateWise.Value = dr["APPLICABLE_STATE"].ToString();
            hfCost.Value = dr["COST_CAPTURED"].ToString();
        }
        conn.Close();
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Table3.Visible = true;
        Table1.Visible = false;
        //btn_Submit.Visible = false;
        ddlDocumentType.SelectedIndex = -1;
        Table5.Visible = true;
        btnSumit.Visible = true;
        Table4.Visible = false;
        ImageButton1.Visible = false;
    }
}