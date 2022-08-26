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

public partial class CommunicationExpenseBill_Entry : System.Web.UI.Page
{

    DataSet ds1;
    DataTable dt1;
    DataRow dr1;
    SqlDataAdapter da1;
    DataColumn dc1;
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["telecome"]);
    int thisrow = 0;
    Common_Database common1 = new Common_Database();
    string conName = "", sql1, scriptStr, bill_code = "";
    string vendor_code, location, region;
    
    SqlTransaction sqltrans;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        //set_clint_side_validation();
        //conName = txtbill_date.ClientID;
        //scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
        //txtbill_date.Attributes.Add("onclick", scriptStr);

        //conName = txtdue_date.ClientID;
        //scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
        //txtdue_date.Attributes.Add("onclick", scriptStr);

        //conName = txtbill_entry_date.ClientID;
        //scriptStr = "javascript:return popUpCalendar(this," + conName + ", 'dd mmm yyyy', '__doPostBack(\\'" + conName + "\\')')";
        //txtbill_entry_date.Attributes.Add("onclick", scriptStr);

        if (!IsPostBack)
        {
            conn.Open();
            String sqlstr = "select VendorName,VendorCode from webx_vendor_hdr WHERE Vendor_Type = 12";
            SqlCommand cmd = new SqlCommand(sqlstr, conn);
            SqlDataReader dread = cmd.ExecuteReader();
            {
                while (dread.Read())
                {
                    cboVendor.Items.Add(new ListItem(dread.GetValue(0).ToString(), dread.GetValue(1).ToString()));
                }
            }
            dread.Close();

            sqlstr = "select number1 from webx_device_master WHERE Vendor_Code = '" + cboVendor.SelectedItem.Value + "' ";
            cmd = new SqlCommand(sqlstr, conn);
            dread = cmd.ExecuteReader();
            {
                while (dread.Read())
                {
                    cboVendor.Items.Add(new ListItem(dread.GetValue(0).ToString()));
                }
            }
            dread.Close();
            conn.Close();

            region = Request.QueryString.Get("region");
            location = Request.QueryString.Get("location");
            vendor_code = Request.QueryString.Get("vendor");
            lblvendor.Text = common1.get_value("select vendorcode + ':' + vendorname from webx_vendor_hdr where vendorcode='" + vendor_code + "'");

            //common1.load_combo(ddldevice_no, "select device_code, number1 from webx_device_master where vendor_code='" + vendor_code + "' and ass_brcd='" + location + "'");



            ds1 = new DataSet();
            dt1 = ds1.Tables.Add("bill_entry");
            dc1 = dt1.Columns.Add("device_code");
            dc1.Caption = "Device Code";

            dc1 = dt1.Columns.Add("bill_no");
            dc1.Caption = "Bill No";
            
            dc1 = dt1.Columns.Add("billing_period");
            dc1.Caption = "Billing Period";

            dc1 = dt1.Columns.Add("bill_date");
            dc1.Caption = "Bill Date";

            dc1 = dt1.Columns.Add("due_date");
            dc1.Caption = "Due Date";

            dc1 = dt1.Columns.Add("amount");
            dc1.Caption = "Amount";

            dc1 = dt1.Columns.Add("service_tax");
            dc1.Caption = "Service Tax";

            dc1 = dt1.Columns.Add("cess");
            dc1.Caption = "Cess";

            dc1 = dt1.Columns.Add("tot_amount1");
            dc1.Caption = "Total Amount";

            grid1.DataSource = ds1;
            grid1.DataBind();

        }
        else
        {
            
        }
    }

    private void set_clint_side_validation()
    {

        //txtamount.Attributes.Add("onblur", "javascript:return check_for_number(" + txtamount.ClientID + "," + txtservice_tax.ClientID + "," + txtcess.ClientID + "," + txttot_amount1.ClientID + ")");
        //txtservice_tax.Attributes.Add("onblur", "javascript:return check_for_number(" + txtamount.ClientID + "," + txtservice_tax.ClientID + "," + txtcess.ClientID + "," + txttot_amount1.ClientID + ")");
        //txtcess.Attributes.Add("onblur", "javascript:return check_for_number(" + txtamount.ClientID + "," + txtservice_tax.ClientID + "," + txtcess.ClientID + "," + txttot_amount1.ClientID + ")");
        //txtbill_date.Attributes.Add("onblur", "javascript:return check_date(this)");
        //txtdue_date.Attributes.Add("onblur", "javascript:return check_date(this)");
        ////cmdAdd.Attributes.Add("onclick", "javascript:return validate()");
        //txttds_rate.Attributes.Add("onblur", "javascript:return tds_calculate(" + txttotal.ClientID + ", " + txttds_rate.ClientID + "," + txttds.ClientID + "," + txtnet_amount.ClientID + ")");
        //cmdAdd.Attributes.Add("onclick", "javascript:check_for_number(" + txttotal.ClientID + "," + txtservice_tax.ClientID + "," + txtcess.ClientID + "," + txttot_amount1.ClientID + ");return validate_detail(" + txttotal.ClientID + "," + txttds_rate.ClientID + "," + txttds.ClientID + "," + txtnet_amount.ClientID + ")");
        //fsubmit.Attributes.Add("onclick", "javascript:validate_header(" + txtbill_entry_date.ClientID + ")");

    }

    protected override void LoadViewState(object savestate)
    {
        base.LoadViewState(savestate);
        if (this.ViewState["dataset1"] == null)
        {
        }
        else
        {
            thisrow = Convert.ToInt32(this.ViewState["thisrow"]);
            ds1 = (DataSet)this.ViewState["dataset1"];

        }
    }

    protected override object SaveViewState()
    {
        //return new object();
        this.ViewState["dataset1"] = ds1;
        this.ViewState["thisrow"] = thisrow;
        return (base.SaveViewState());
    }

    protected void grid1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //Response.Write("test")
        if (((Control)e.CommandSource).ID == "DeleteButton")
        {
            thisrow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);
            ds1.Tables[0].Rows.RemoveAt(thisrow);
            grid1.DataSource = ds1;
            grid1.DataBind();
        }
        else if (((Control)e.CommandSource).ID == "EditButton")
        {
            thisrow = (((GridViewRow)((System.Web.UI.Control)e.CommandSource).Parent.Parent).RowIndex);

            ddldevice_no.Items.FindByValue(grid1.Rows[thisrow].Cells[2].Text).Selected = true;
            //lst.Selected=true;
            //foreach ( 
            //{
            //    //Response.Write(dr2[3]);
            //    sql1 = "insert into webx_telecome_billdet(bill_code, device_code, bill_no, billing_period, bill_date, due_date, amount, service_tax, cess, total) values('" + billno + "','" + dr2["device_code"] + "','" + dr2["bill_no"] + "','" + dr2["billing_period"] + "','" + dr2["bill_date"] + "','" + dr2["due_date"] + "'," + dr2["amount"] + "," + dr2["service_tax"] + "," + dr2["cess"] + "," + dr2["tot_amount1"] + ")";
            //    common1.cmd1 = new SqlCommand(sql1, common1.conn, sqltrans);
            //    common1.cmd1.ExecuteNonQuery();
            //}       
            txtbill_no.Text = grid1.Rows[thisrow].Cells[3].Text;
            txtbilling_period.Text = grid1.Rows[thisrow].Cells[4].Text;
            txtbill_date.Text = grid1.Rows[thisrow].Cells[5].Text;
            txtdue_date.Text = grid1.Rows[thisrow].Cells[6].Text;
            txtamount.Text = grid1.Rows[thisrow].Cells[7].Text;
            txtservice_tax.Text = grid1.Rows[thisrow].Cells[8].Text;
            txtcess.Text = grid1.Rows[thisrow].Cells[9].Text;
            txttot_amount1.Text = grid1.Rows[thisrow].Cells[10].Text;
            cmdAdd.Text = "Update";
            grid1.Enabled = false;
        }
    }

    private void clear_textbox()
    {
        ddldevice_no.SelectedIndex = 0;
        txtbill_no.Text = "";
        txtbilling_period.Text = "";
        txtbill_date.Text = "";
        txtdue_date.Text = "";
        txtamount.Text = "0";
        txtservice_tax.Text = "0";
        txtcess.Text = "0";
        txttot_amount1.Text = "0";
    }

    public string gen_billno(string loccode)
    {
        string billno = "", sql_max, pad = "";
        int max_no, pad_length;

        try
        {

            billno = loccode + "/BILL/";
            sql_max = "select max(right(bill_code,7)) from webx_telecome_billmst ";
            //conn.Open();
            common1.cmd1 = new SqlCommand(sql_max, common1.conn, sqltrans);
            common1.dtr1 = common1.cmd1.ExecuteReader();
            if (common1.dtr1.Read())
            {
                if (common1.dtr1[0] == System.DBNull.Value)
                {
                    billno = billno + "0000001";
                }
                else
                {
                    max_no = Convert.ToInt16(common1.dtr1[0]) + 1;
                    pad_length = 7 - Convert.ToString(max_no).Length;
                    while (pad.ToString().Length < pad_length)
                    {
                        pad = pad + "0";
                    }
                    billno = billno + pad + (Convert.ToDouble(common1.dtr1[0]) + 1);
                }

            }
            else
            {
                billno = billno + "0000001";

            }

            return billno;
        }
        catch (Exception ex)
        {
            billno = "Error";
            Console.WriteLine(ex.ToString());
            return billno;
        }
        finally
        {
            common1.dtr1.Close();
            //common1.conn.Close();
        }
    }

    protected void cmdAdd_Click(object sender, EventArgs e)
    {
        if (cmdAdd.Text == "Add")
        {

            txttot_amount.Text = Convert.ToString(Math.Round(Convert.ToDouble(txttot_amount.Text) + Convert.ToDouble(txtamount.Text), 2));
            txttot_service_tax.Text = Convert.ToString(Math.Round(Convert.ToDouble(txttot_service_tax.Text) + Convert.ToDouble(txtservice_tax.Text), 2));
            txttot_cess.Text = Convert.ToString(Math.Round(Convert.ToDouble(txttot_cess.Text) + Convert.ToDouble(txtcess.Text), 2));
            txttotal.Text = Convert.ToString(Math.Round(Convert.ToDouble(txttot_amount.Text) + Convert.ToDouble(txttot_service_tax.Text) + Convert.ToDouble(txttot_cess.Text), 2));
            txttot_amount1.Text = Convert.ToString(Math.Round(Convert.ToDouble(txtamount.Text) + Convert.ToDouble(txtservice_tax.Text) + Convert.ToDouble(txtcess.Text), 2));
            if (Math.Round(Convert.ToDouble(txttds_rate.Text)) > 0)
            {
                txttds.Text = Convert.ToString((Math.Round(Convert.ToDouble(txttotal.Text)) * Math.Round(Convert.ToDouble(txttds_rate.Text))) / 100);
            }
            txtnet_amount.Text = Convert.ToString(Math.Round(Convert.ToDouble(txttotal.Text)) - Math.Round(Convert.ToDouble(txttds.Text)));
           
            dr1 = ds1.Tables["bill_entry"].NewRow();
            
            dr1["device_code"] = ddldevice_no.Text;
            dr1["bill_no"] = txtbill_no.Text;
            dr1["billing_period"] = txtbilling_period.Text;
            dr1["bill_date"] = txtbill_date.Text;
            dr1["due_date"] = txtdue_date.Text;
            dr1["amount"] = txtamount.Text;
            dr1["service_tax"] = txtservice_tax.Text;
            dr1["cess"] = txtcess.Text;
            dr1["tot_amount1"] = txttot_amount1.Text;

            ds1.Tables["bill_entry"].Rows.Add(dr1);

            grid1.DataSource = ds1;
            grid1.DataBind();

            clear_textbox();

        }
        else if (cmdAdd.Text == "Update")
        {
            //grid1.Rows[thisrow].Cells[2].Text = txtbill_no.Text;
            grid1.Rows[thisrow].Cells[3].Text = txtbill_no.Text;
            grid1.Rows[thisrow].Cells[4].Text = txtbilling_period.Text;
            grid1.Rows[thisrow].Cells[5].Text = txtbill_date.Text;
            grid1.Rows[thisrow].Cells[6].Text = txtdue_date.Text;
            grid1.Rows[thisrow].Cells[7].Text = txtamount.Text;
            grid1.Rows[thisrow].Cells[8].Text = txtservice_tax.Text;
            grid1.Rows[thisrow].Cells[9].Text = txtcess.Text;
            grid1.Rows[thisrow].Cells[10].Text = txttot_amount1.Text;
            cmdAdd.Text = "Add";
            grid1.Enabled = true;

            clear_textbox();

        }
    }

    protected void fsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            common1.conn.Open();
            sqltrans = common1.conn.BeginTransaction();
            Session["loccode"] = "AMCH";
            string billno = gen_billno(Convert.ToString(Session["loccode"]));
            if (billno == "Error")
            {
                Response.Write("Error while generating bill ");
                Response.End();
            }
            sql1 = "insert into webx_telecome_billmst(bill_code, bill_entry_date, vendor_code, total_amount, tot_service_tax, tot_cess, tot_total, tds_rate, tot_tds, net_amount) values('" + billno + "','" + txtbill_entry_date.Text + "','" + lblvendor.Text + "'," + txttot_amount.Text + "," + txtservice_tax.Text + "," + txtcess.Text + "," + txttotal.Text + "," + txttds_rate.Text + "," + txttds.Text + "," + txtnet_amount.Text + ")";

            common1.cmd1 = new SqlCommand(sql1, common1.conn, sqltrans);
            common1.cmd1.ExecuteNonQuery();

            foreach (DataRow dr2 in ds1.Tables[0].Rows)
            {
                //Response.Write(dr2[3]);
                sql1 = "insert into webx_telecome_billdet(bill_code, device_code, bill_no, billing_period, bill_date, due_date, amount, service_tax, cess, total) values('" + billno + "','" + dr2["device_code"] + "','" + dr2["bill_no"] + "','" + dr2["billing_period"] + "','" + dr2["bill_date"] + "','" + dr2["due_date"] + "'," + dr2["amount"] + "," + dr2["service_tax"] + "," + dr2["cess"] + "," + dr2["tot_amount1"] + ")";
                common1.cmd1 = new SqlCommand(sql1, common1.conn, sqltrans);
                common1.cmd1.ExecuteNonQuery();
            }
            sqltrans.Commit();
            Response.Redirect("./bill_entry_done.aspx?bill_no=" + billno);
        }
        catch (Exception ex1)
        {
            sqltrans.Rollback();
            Response.Write("cannot insert  " + sql1 + "<br> " + ex1.ToString());
            //common1.cmd1 = new SqlCommand(");
        }
        finally
        {

            common1.conn.Close();
        }

    }
}
