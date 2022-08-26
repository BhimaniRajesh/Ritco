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

public partial class octroi_OctCustBillStep2 : System.Web.UI.Page
{
  
   //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["dbConnection"]);
   

    

    public DataSet1 _dataSet = new DataSet1();
    int _lastEditedPage;
    string custcd, octroipaid_by;
    string custcls = "";
    MyFunctions fn = new MyFunctions();
    public DataSet1.WorkExperianceDataRow datarow;
    public string dockno;
    public string bno = "";

    public string s1, s2, s3;

    protected void Page_Load(object sender, EventArgs e)
    {

        
        string billdate;

       

        Label1.Visible = false;
        txtservicetxtchrg.Enabled = false;
        txtservicetxtchrg.Text = "0";
        txtserchgper.Text = "0";
        //billdate = 
      
        txtbilldt.Text = System.DateTime.Now.ToString("MM/dd/yy");
        txtagntbilldt.Text = System.DateTime.Now.ToString("MM/dd/yy");

        //billdate //System.DateTime.Now.ToShortDateString();
         
       //octamt..Attributes.Add("onblur", "javascript:return check(" + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + ")");
        octamt.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");

        txtagnttax.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtothrchg.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtfrmcharg.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtclearchrg.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
       // txttotdue.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + ")");
        txtserchgper.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtservicetxtchrg.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtsundry.Attributes.Add("onblur", "javascript:return check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
        txtagntbillno.Attributes.Add("onblur", "javascript:tupper(this)");
        //txtagnttax.Attributes.Add("onblur", "javascript:return check(" + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + ")");
        //txtagnttax.Attributes.Add("onblur", "javascript:return check(" + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + ")");

       //btnAdd.Attributes.Add("onclick", "javascript:return check(" + roww.ClientID + "," + btnAdd.ClientID + ")");
        
      //      txtbillsubloc.Text = Session["brcd"].ToString();
       // txtbillcolloc.Text = Session["brcd"].ToString();
      //  txtbillamt = 0;
        if (!IsPostBack)
        {
            txtagnttax.Text = "0";
            roww.Text = "5";
            Inetialized();
          
            BindGrid();
            popAgnt();
            Validation();
        }
        else
        {
            ReverseBind();
        }
       

    }
    protected void BlankRow()
    {

        
    }

    private void Inetialized()
    {
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
        

    }
    private void BindGrid()
    {
        GV_D.DataSource = _dataSet.WorkExperianceData;
        GV_D.DataBind();
        _lastEditedPage = GV_D.PageIndex;
    }
    protected override void LoadViewState(object savedState)
    {
        base.LoadViewState(savedState);
        if ((!(this.ViewState["Data"] == null)))
        {
            _dataSet = ((DataSet1)(this.ViewState["Data"]));
        }
        if ((!(this.ViewState["LastEditedPage"] == null)))
        {
            _lastEditedPage = ((int)(this.ViewState["LastEditedPage"]));
        }
    }
    protected override object SaveViewState()
    {
        this.ViewState["Data"] = _dataSet;
        this.ViewState["LastEditedPage"] = _lastEditedPage;
        return (base.SaveViewState());
    }

    private void GV_D_PageIndexChanged(object source, System.Web.UI.WebControls.DataGridPageChangedEventArgs e)
    {
        GV_D.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    private void GV_D_ItemCommand(object source, System.Web.UI.WebControls.DataGridCommandEventArgs e)
    {
        if (((System.Web.UI.Control)(e.CommandSource)).ID == "DeleteRow")
        {
            _dataSet.WorkExperianceData.RemoveWorkExperianceDataRow(_dataSet.WorkExperianceData[e.Item.DataSetIndex]);
            if (((GV_D.PageCount - GV_D.PageIndex) == 1 & GV_D.Rows.Count == 1))
            {
                if ((GV_D.PageCount > 1))
                {
                    _lastEditedPage -= 1;
                }
                else
                {
                    _lastEditedPage = 0;
                }
            }
            GV_D.PageIndex = _lastEditedPage;
            BindGrid();
        }
    }

    
    private void ReverseBind()
    {
        DataSet1.WorkExperianceDataRow datarow;// = null;

        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            
            datarow = _dataSet.WorkExperianceData[gridrow.DataItemIndex];
           //// datarow.DOCKNO = ((TextBox)gridrow.FindControl("txtdockno")).Text;
           // //datarow.DECLVAL = ((TextBox)gridrow.FindControl("txtdockno")).Text;
           // datarow.OCTAMT = ((TextBox)gridrow.FindControl("txtoctamt")).Text;
           // datarow.OCTAMT_PER = ((TextBox)gridrow.FindControl("txtrcpno")).Text;
           // datarow.CLEAR_CHRG = ((TextBox)gridrow.FindControl("txtrcpdt")).Text;
           // _dataSet.WorkExperianceData[gridrow.DataSetIndex].ItemArray = datarow.ItemArray;
        }
    }
    void GV_D_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridCommandEventArgs e)
    {
        DataSet1.WorkExperianceDataRow datarow;
        if ((e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem))
        {
            datarow = ((DataSet1.WorkExperianceDataRow)((DataRowView)e.Item.DataItem).Row);

            ((TextBox)e.Item.FindControl("txtdockno")).Text = datarow.DOCKNO;
            ((TextBox)e.Item.FindControl("txtdockno")).Text = datarow.DECLVAL;
            ((TextBox)e.Item.FindControl("txtoctamt")).Text = datarow.OCTAMT;
            ((TextBox)e.Item.FindControl("txtrcpno")).Text = datarow.OCTAMT_PER;
            ((TextBox)e.Item.FindControl("txtrcpdt")).Text = datarow.CLEAR_CHRG; 
        }
    }
    protected void roww_TextChanged(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
        Validation();
    }

    public void Validation()
    {
        foreach (GridViewRow gridrow in GV_D.Rows)
        {
            TextBox txtoctamt = ((TextBox)gridrow.FindControl("txtoctamt"));
            TextBox txtrcpno = ((TextBox)gridrow.FindControl("txtrcpno"));
            txtoctamt.Attributes.Add("onblur", "javascript:check(" + octamt.ClientID + "," + txtagnttax.ClientID + "," + txtothrchg.ClientID + "," + txtfrmcharg.ClientID + "," + txtclearchrg.ClientID + "," + txttotdue.ClientID + "," + txtserchgper.ClientID + "," + txtservicetxtchrg.ClientID + "," + txtsundry.ClientID + "," + h1.ClientID + ")");
            txtoctamt.Attributes.Add("onchange", "javascript:return Nagative_Chk_wDecimal(this)");
            txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");

        }
    }
    public void popGrd(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
    }

    

    public void btnAdd_Grid(object sender, EventArgs e)
    {
        _dataSet.WorkExperianceData.Clear();
        int rowno;
        rowno = Convert.ToInt32(roww.Text);       
        for (int i = 0; i < rowno; i++)
        {
            _dataSet.WorkExperianceData.AddWorkExperianceDataRow("", "", "", "", "", "", "", "", "", "", "");
            BindGrid();
        }
    }
    protected void BindGrid1()
    {
      

        DataView dv = _dataSet.WorkExperianceData.DefaultView;
        GV_D.DataSource = dv;
        GV_D.DataBind();
    }
    protected void OnDocketNOChange(object sender, EventArgs e)
    {

        GV_D.SelectedIndex = ((GridViewRow)((TextBox)sender).Parent.Parent).DataItemIndex;

  dockno = ((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).Text;
        
        //((TextBox)GV_D.SelectedRow.FindControl("txtoctamt")).Text = categoryName;
       

        //Response.Write(categoryName);


        string res = docket_validcheck(dockno,"dkt");

        if (res == "OK")
        {
            Label1.Visible = false;
            filldata();
            if (s1 == null)
            {
                s1 = "";

            }
            if (s2 == null)
            {
                s2 = "";

            }
            ((TextBox)GV_D.SelectedRow.FindControl("txtoctamt")).Text = s1;
            ((TextBox)GV_D.SelectedRow.FindControl("txtrcpno")).Text = s2;
            ((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).ForeColor = System.Drawing.Color.Black;



            if (s3 == null)
            {
                s3 = "";

            }
            else
            {


                ((TextBox)GV_D.SelectedRow.FindControl("txtrcpdt")).Text = Convert.ToDateTime(s3).ToString("MM/dd/yyyy");
            }


        }
        else
        {
            //((TextBox)GV_D.SelectedRow.FindControl("txtddd")).Visible = true;
            ((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).Text = "InValid Docket No.";
            ((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).ForeColor = System.Drawing.Color.Red;
            //((TextBox)GV_D.SelectedRow.FindControl("txtdockno")).Text = "";
            Label1.Visible = true;
            Label1.Text = "InValid Docket No.";
        }

        //GV_D.FooterRow.CssClass = "blackfnt";
        //GV_D.FooterRow.Font.Bold = true;
        


        //GV_D.FooterRow.Cells[1].Text = "Total";
        //GV_D.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Center;
 
       
    }
    
    private DataSet1.WorkExperianceDataRow GetDataRow(int rowIndex)
    {

       // foreach (DataGridItem gridrow in GV_D.Rows)
        //{

            DataSet1.WorkExperianceDataRow datarow;
            datarow = _dataSet.WorkExperianceData[rowIndex];
            //datarow.DOCKNO = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtdockno")).Text;
            //datarow.DECLVAL = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtdockno")).Text;
            //datarow.OCTAMT = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtoctamt")).Text;
            //datarow.OCTAMT_PER = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtrcpno")).Text;
            //datarow.CLEAR_CHRG = ((TextBox)GV_D.Rows[rowIndex].FindControl("txtrcpdt")).Text;
          
        
       
        
        // _dataSet.WorkExperianceData[gridrow.ItemIndex].ItemArray = datarow.ItemArray;

            return datarow;
        //}
    }
    
     


    //*****************for docket valid check*******************
    public string docket_validcheck(string dockno,string par)
    {
        string msg;

        

       // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string dno=dockno;
        string sql = "";
        if (par == "dkt")
        {
             sql = "select dockno from webx_docket where dockno='" + dno + "' and octroi='N'";
        }
        else if (par == "det")
        {
             sql = "select dockno from webx_oct_det  where dockno='" + dno + "'";
        }
        else
        {
        
        }


        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2 ;
        conn.Open();

        //dno2= cmd.ExecuteScalar().ToString();
SqlDataAdapter da=new SqlDataAdapter(cmd);

        DataSet ds=new DataSet();

        da.Fill(ds);



       if(ds.Tables[0].Rows.Count==0)
        {
            msg = "Invalid Docket No.";
        }
        else
        {
            msg="OK";
        }

        return msg;

        
 
    }


    public string GetDECVAL(string dockno)
    {
        string decval="";



        // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string dno = dockno;
  

        string sql = "select declval from webx_docket where dockno='" + dno + "' and docksf='.'";
        


        SqlCommand cmd = new SqlCommand(sql, conn);

        conn.Open();

          SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        da.Fill(ds);
        

        foreach (DataRow ddrr in ds.Tables[0].Rows)
        {
            if (ddrr["declval"] is DBNull)
            {
                decval = "0";
            }
            else
            {
                decval = ddrr["declval"].ToString();
            }

        }

         
        return decval;



    }



    //**********************************************************
    
    protected void Onoctdatacal(object sender, EventArgs e)
    {
        DataSet1.WorkExperianceDataRow datarow;

        foreach (DataGridItem gridrow in GV_D.Rows)
        {
            if (gridrow.ItemIndex != -1)
            {
                Inetialized();

                TextBox txtdockno2 = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtdockno2");
                TextBox txtdockno = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtdockno");
                TextBox txtrcpno = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtrcpno");
                TextBox txtoctamt = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtoctamt");
                TextBox txtrcpdt = (TextBox)GV_D.Rows[gridrow.ItemIndex].FindControl("txtrcpdt"); 

                datarow = _dataSet.WorkExperianceData[gridrow.ItemIndex];
                datarow = GetDataRow(gridrow.ItemIndex);

               
                _dataSet.WorkExperianceData[gridrow.ItemIndex].ItemArray = datarow.ItemArray;
            }
        }
    }







    public void OnAmtChg(object sender, EventArgs e)
    {
        //double tot=0.00;
        //foreach (GridViewRow gridrow in GV_D.Rows)
        //{
            
        //    TextBox txtoctamt = (TextBox)gridrow.FindControl("txtoctamt");

        //    if (txtoctamt.Text != "")
        //    {
        //        tot += Convert.ToDouble(txtoctamt.Text);
        //    }
        //}
        
        //((TextBox)GV_D.FooterRow.FindControl("txttot")).Text = tot.ToString();
        //octamt.Text = tot.ToString();
        //txttotdue.Text = tot.ToString();
        

    }

    public string getBillno()
    {
     
        
       // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


          SqlCommand sqlCommand = new SqlCommand();

        sqlCommand.Connection = conn;
        conn.Open();


        sqlCommand.CommandType = CommandType.StoredProcedure;


        sqlCommand.CommandText = "usp_next_vendorbillentry_code";

            //Input parameter for Billing Party
        sqlCommand.Parameters.AddWithValue("@brcd", Session["BRCD"]);
        sqlCommand.Parameters.AddWithValue("@transdate", System.DateTime.Now);


        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlCommand);
        da.Fill(ds);



        foreach (DataRow ddd in ds.Tables[0].Rows)
        {
            bno = ddd["NewCode"].ToString();
        }
        




        return bno;
    }
     
    public void popAgnt()
    {
       SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
       
       // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");
               
        conn.Open();
       // string strro = ddlro.SelectedValue.ToString();
        string sql = "select m.vendorcode c1,m.vendorname c2,* from webx_vendor_hdr m where vendor_type=1";
         
        SqlCommand sqlcmd = new SqlCommand(sql, conn);
        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(sqlcmd);


        da.Fill(ds, "tab1");
        ddlagnt.DataSource = ds;
        ddlagnt.DataTextField = "c2";
        ddlagnt.DataValueField = "c1";
        ddlagnt.DataBind();
    }



    protected void Button11_Click(object sender, EventArgs e)
    {

        string billno = getBillno();

        Session["billno"] = billno;



        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        conn.Open();
        foreach (GridViewRow gridrow in GV_D.Rows)
        {

           

            TextBox txtdockno = (TextBox)gridrow.FindControl("txtdockno");
            TextBox txtrcpno = (TextBox)gridrow.FindControl("txtrcpno");
            TextBox txtoctamt = (TextBox)gridrow.FindControl("txtoctamt");
            TextBox txtrcpdt = (TextBox)gridrow.FindControl("txtrcpdt");


            string dkno, rno,dt,amt;


            dkno = txtdockno.Text;
            rno = txtrcpno.Text;
            amt =txtoctamt.Text;
            dt = txtrcpdt.Text;
 
            
            if (dkno == "" || rno == "" || amt == "" || dt == "")
            {

            }
            else
            {
                string res1 = docket_validcheck(dkno, "det");
                
 
                string[] dt2 = dt.Split('/');



                DateTime dt3 = Convert.ToDateTime(dt2[0] + "/" + dt2[1] + "/" + dt2[2]);

                

                 double amt2 = Convert.ToDouble(amt);
                // SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

               

                 try
                 {

               

                     string sql = "";
                     string dval = GetDECVAL(dkno);

                     if (res1 != "OK")
                     {

                         sql = "insert into webx_oct_det(ocbillno,dockno,octamt,recptno,recptdt,DOCKSF, DECLVAL,oct_vendorcd,oct_vendornm,vendor_paiddt) values('" + billno + "','" + dkno + "'," + amt2 + ",'" + rno + "','" + dt3 + "','.','" + dval + "','" + ddlagnt.SelectedValue.ToString() + "','" + ddlagnt.SelectedItem.ToString() + "','" + txtagntbilldt.Text + "')";

                     }
                     else
                     {
                         sql = "Update webx_OCT_DET set ocbillno='" + billno + "', DOCKNO='" + dkno + "',OCTAMT=" + amt2 + ",RECPTNO='" + rno + "',RECPTDT='" + dt3 + "' where DOCKNO='" + dkno + "'";
                         

                     }




                     SqlCommand cmdd = new SqlCommand(sql, conn);

                     cmdd.ExecuteNonQuery();


                     

                     string sql2 = "update webx_docket set OCTROI='Y' where dockno='" + dkno + "'";

                     SqlCommand cmdd2 = new SqlCommand(sql2, conn);

                     cmdd2.ExecuteNonQuery();


                  
                     

                   
                 }
                 catch (Exception ee1)
                 {
                     lblQry.Text = ee1.Message;

                
                 }
 
            }
            

        }

       
        string sql3 = "INSERT INTO webx_OCT_HDR (OCBILLNO,OCBRCD,OCBILLDT, OCAGCD, OCAGNM, OCAGBILLDT, OCAGOCTAMT, OCAGBILLNO, OCAGOTHCHRG, OCAGSERCHRG,OCTOTALDUE, ENTRYBY, ENTRYDT, REMARK,OCDUEDT,ACTSERCHRG,servchargeper,sundrychrg,formchrg,clearchrg)VALUES ('" + billno + "','" + Session["BRCD"].ToString() + "','" + txtbilldt.Text + "','" + ddlagnt.SelectedValue.ToString() + "','" + ddlagnt.SelectedItem.ToString() + "','" + txtagntbilldt.Text + "'," +h1.Value + ",'" + txtagntbillno.Text + "'," + txtothrchg.Text + "," + txtagnttax.Text + "," + h1.Value + ",'" + Session["empcd"].ToString() + "','" + System.DateTime.Now + "','" + txtremarks.Text + "','" + txtduedate.Text + "'," + txtservicetxtchrg.Text + "," + txtserchgper.Text + "," + txtsundry.Text + "," + txtfrmcharg.Text + "," + txtclearchrg.Text + ")";



        SqlCommand cmdd3 = new SqlCommand(sql3, conn);

        cmdd3.ExecuteNonQuery();
         Response.Redirect("Agent_Bill_2.aspx");
    }

    public void filldata()
    {

        string msg;
      //  SqlConnection conn = new SqlConnection("data source=202.87.45.67;UID=sa;PWD=s@lc0nnect$;Database=UFL_VER2_TEST3;");

        SqlConnection conn = new SqlConnection(Session["SqlProvider"].ToString().Trim());


        string dno = dockno;

        string sql = "select * from webx_oct_det where dockno='" + dno + "'";

        SqlCommand cmd = new SqlCommand(sql, conn);

        string dno2;
        conn.Open();

        //dno2= cmd.ExecuteScalar().ToString();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();

        da.Fill(ds);


        foreach (DataRow ddr in ds.Tables[0].Rows)
        {
            s1 = ddr["octamt"].ToString();
            s2 = ddr["recptno"].ToString();
            s3 = ddr["recptdt"].ToString();
            
        }

 

    }

     
}
