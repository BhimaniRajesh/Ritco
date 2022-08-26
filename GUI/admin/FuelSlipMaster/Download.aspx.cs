using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using NReco.PdfGenerator;

public partial class GUI_admin_FuelSlipMaster_Download : System.Web.UI.Page
{
    public string DocNo, TYPE, Status;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["dbConnection"].ToString().Trim());
            try
            {
                DocNo = Request.QueryString["DocNo"];
                TYPE = Request.QueryString["TYPE"];
                Status = Request.QueryString["Status"];

                con.Open();
                if (Status == "Pending")
                {
                    SqlCommand cmd = new SqlCommand("USP_GET_IMS_FuelBillVendor", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BillNo", DocNo);

                    SqlDataReader dr = cmd.ExecuteReader();
                    grvgeneral.DataSource = dr;
                    grvgeneral.DataBind();


                }
                else
                {
                    SqlCommand cmd = new SqlCommand("Usp_FuelBillPayment_GetVoucherAndBillDetail_Ver2", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@VoucherNo", DocNo);
                    DataSet ds = new DataSet();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);

                    sda.Fill(ds);

                    DataTable dtVoucherDetail = new DataTable();
                    dtVoucherDetail = ds.Tables[1];

                    if (dtVoucherDetail.Rows.Count > 0)
                    {
                        lblVoucherNo.Text = dtVoucherDetail.Rows[0]["VoucherNo"].ToString();
                        lblVendorName.Text = dtVoucherDetail.Rows[0]["VendorName"].ToString();
                        lblVoucherDate.Text = dtVoucherDetail.Rows[0]["VoucherDate"].ToString();
                        lblInstrumentDate.Text = dtVoucherDetail.Rows[0]["InstrumentDate"].ToString();
                        lblTotalAmount.Text = dtVoucherDetail.Rows[0]["FinalTotalAmount"].ToString();
                        grvVoucher.DataSource = ds.Tables[0];
                        grvVoucher.DataBind();

                    }

                }

                //setBorderWidth();
                if (TYPE == "XLS")
                {
                    DownloadXLS();
                }
                else
                {
                    DownloadPDF();
                }
            }
            catch (Exception ex)
            {

                con.Close();
            }
            finally {
                con.Close();
            }
            
           
            //DownloadXLS();

        }
    }

    private void setBorderWidth()
    {
        if (Status == "Pending")
        {
            lblHeader.BorderWidth = 1;
            tblmain.BorderWidth = 1;
            grvgeneral.BorderWidth = 1;
        }
        else
        {
            
            tblVoucher.BorderWidth = 1;
            grvVoucher.BorderWidth = 1;
        }
        
    }
    private void DownloadXLS()
    {
        try
        {
            StringWriter stringWrite;
            HtmlTextWriter htmlWrite;
            HtmlForm frm = new HtmlForm();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=MISFUELVENDORBILLSLIP.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-xls";
            stringWrite = new System.IO.StringWriter();
            htmlWrite = new HtmlTextWriter(stringWrite);
            Controls.Add(frm);
            if (Status == "Pending")
            {
                frm.Controls.Add(tblmain);
            }
            else {
                frm.Controls.Add(tblVoucher);
            }
            frm.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    private void DownloadPDF()
    {
        try
        {
            //using (StringWriter sw = new StringWriter())
            //{
            //    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
            //    {
                    //if (Status == "Pending")
                    //{
                    //    //To Export all pages
                    //    grvgeneral.AllowPaging = false;
                    //    //this.BindGrid();

                    //    grvgeneral.RenderControl(hw);
                    //}
                    //else
                    //{
                    //    //To Export all pages
                    //    grvVoucher.AllowPaging = false;
                    //    //this.BindGrid();

                    //    grvVoucher.RenderControl(hw);
                    //}
                    HtmlToPdfConverter objHtmltoPDf = new NReco.PdfGenerator.HtmlToPdfConverter();
                    objHtmltoPDf.Orientation = PageOrientation.Portrait;
                    objHtmltoPDf.Size = NReco.PdfGenerator.PageSize.A4;
                    objHtmltoPDf.Margins = new PageMargins { Top = 5, Bottom = 5, Left = 1, Right = 1 };
                    //objHtmltoPDf.PageHeaderHtml = @"<div style='float:left''color:#53585F;font-size:16px;font-weight:bold;> Status of " + objRequest.awbno + " (" + objRequest.orderno + ")</div><div style='float:right;color:#53585F;font-size:16px;font-weight:bold;'> as on " + Convert.ToDateTime(objRequest.orderStatusDatetime).ToString("HH:mm, dd-MMM-yyyy") + "</div>";
                    //objHtmltoPDf.PageFooterHtml = @"<div style='float:left'><span style='color:#53585F;font-size:16px;font-weight:bold;float: left;margin-top: 10px;'>Powered by&nbsp;</span> <img src='http://beta.logicloud.in/Images/logo.png' alt='logo' title='logo'  style='float:left' width='170'  /></div><div style='float:right'> <span class=""page""></span> of <span class=""topage""></span></div>";
                    StringWriter stringWrite;
                    HtmlTextWriter htmlWrite;
                    HtmlForm frm = new HtmlForm();
                    stringWrite = new System.IO.StringWriter();
                    htmlWrite = new HtmlTextWriter(stringWrite);
                    Controls.Add(frm);
                    if (Status == "Pending")
                    {
                        frm.Controls.Add(tblmain);
                    }
                    else
                    {
                        frm.Controls.Add(tblVoucher);
                    }
                    frm.RenderControl(htmlWrite);
                    var pdfBytes = objHtmltoPDf.GeneratePdf(stringWrite.ToString());
                    Response.Clear();
                    MemoryStream ms = new MemoryStream(pdfBytes);
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=MISFUELVENDORBILLSLIP.pdf");
                    Response.Buffer = true;
                    ms.WriteTo(Response.OutputStream);
            Response.End();








            //HtmlForm frm = new HtmlForm();
            //Controls.Add(frm);
            //if (Status == "Pending")
            //{
            //    frm.Controls.Add(tblmain);
            //}
            //else
            //{
            //    frm.Controls.Add(tblVoucher);
            //}

            //frm.RenderControl(hw);
            //StringReader sr = new StringReader(sw.ToString());
            //Document pdfDoc = new Document(PageSize.A2, 10f, 10f, 10f, 0f);
            //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            //pdfDoc.Open();
            //htmlparser.Parse(sr);
            //pdfDoc.Close();

            //Response.ContentType = "application/pdf";
            //Response.AddHeader("content-disposition", "attachment;filename=MISFUELVENDORBILLSLIP.pdf");
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.Write(pdfDoc);
            //Response.End();

            //    }
            //}
        }
        catch (Exception Exc)
        {
            throw Exc;
        }
    }
}