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

public partial class GUI_Tracking_FrmMenifestView : System.Web.UI.Page
{
    string billno,strqry;
    SqlConnection cn;
    decimal svctax, dkttot, dktamt, Cessamt;
    string Number;
    string deciml;
    string _number;
    string _deciml;
    string[] US = new string[1003];
    string[] SNu = new string[20];
    string[] SNt = new string[10];
    string amtword = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //cn.ConnectionString = "data source=202.87.45.69;UID=sa;PWD=!@ecfy#$;Database=Webxpress_new;";
        svctax = dkttot = Cessamt = dktamt = 0.0M;
        Initialize(); 
        cn = new SqlConnection(Session["SqlProvider"].ToString().Trim());
        billno = Request.QueryString["billno"];
        strqry = "select Convert(varchar,bgndt,106) as BGNDT ,Convert(varchar,bsbdt,106) as bsbdt ,Convert(varchar,bduedt,106) as bduedt ,Convert(varchar,bcldt,106) as bcldt ,* from webx_billmst where billno='" + billno + "'";
        SqlDataReader dr;
        SqlCommand cmd = new SqlCommand(strqry, cn);
        cmd.Connection.Open();
        dr = cmd.ExecuteReader();
        dr.Read(); 
        lblbillnumber.Text = billno;  
        lblbillgendate.Text = Convert.ToString(dr["bgndt"]);
        lblbillbranch.Text = Convert.ToString(dr["bbrcd"]) + ":" + Convert.ToString(dr["bbrnm"]);
        lblbillsubdt.Text = Convert.ToString(dr["bsbdt"]);
        if (Convert.ToString(dr["paybas"]) == "1")
        {
            lblbilltype.Text = "Paid";
        }
        else if (Convert.ToString(dr["paybas"]) == "2")
        {
            lblbilltype.Text = "TBB";
        }
        else if (Convert.ToString(dr["paybas"]) == "3")
        {
            lblbilltype.Text = "ToPay";
        }
        else if (Convert.ToString(dr["paybas"]) == "4")
        {
            lblbilltype.Text = "Misc";
        }
        else if (Convert.ToString(dr["paybas"]) == "5")
        {
            lblbilltype.Text = "Cancelled";
        }
        else if (Convert.ToString(dr["paybas"]) == "6")
        {
            lblbilltype.Text = "Octroi";
        }
        else if (Convert.ToString(dr["paybas"]) == "7")
        {
            lblbilltype.Text = "Supplimentry";
        }
        else if (Convert.ToString(dr["paybas"]) == "8")
        {
            lblbilltype.Text = "Trial TBB";
        }
        lblbillduedt.Text = Convert.ToString(dr["bduedt"]);
        lblpartyname.Text = Convert.ToString(dr["ptmscd"]) +" : "+ Convert.ToString(dr["ptmsnm"]);
        lblpaddress.Text = Convert.ToString(dr["ptmsaddr"]);
        lblpemail.Text = Convert.ToString(dr["ptmsemail"]);
        lblpphone.Text = Convert.ToString(dr["ptmstel"]);
        lblbillcollectdt.Text = Convert.ToString(dr["bcldt"]);
        lblbillgeneratedby.Text = Convert.ToString(dr["bgenempcd"]);
        lblbillcollectedby.Text = Convert.ToString(dr["bcolempcd"]);
        lblbillclosedby.Text = Convert.ToString(dr["bcbsempcd"]);
        lblbillsubmittedby.Text = Convert.ToString(dr["bsubempcd"]); 
        dr.Close();
        cmd.Connection.Close();
        cn.Open();
        strqry = "select M.DOCKNO + M.DOCKSF as Dockno ,M.ORGNCD As BookingBranch,M.reassign_destcd As DeliveryBranch,Convert(varchar,M.CDELDT,106) As CommitedDelDt,Convert(varchar,M.DELYDT,106) as actualdeldate,Convert(varchar,M.Dockdt,106) as bookdate,d.DKTTOT as dkttot,m.chrgwt as chargewt ,d.SVCtax as svctax,isnull(D.hedu_cess,0)+isnull(D.cess,0)+ISNULL(D.SBCess,0)+ISNULL(D.KKCess,0) as Tot_cess from webx_BILLDET M left outer join WebX_Master_Docket_Charges D on m.dockno=d.dockno where M.Billno in ('" + billno + "')";
        SqlDataAdapter da = new SqlDataAdapter(strqry, cn);
        DataSet ds = new DataSet();
        da.Fill(ds,"AreaView");
        GrdPaidFollow.DataSource = ds.Tables["AreaView"];
        GrdPaidFollow.DataBind();
        if (ds.Tables["AreaView"].Rows.Count > 0)
        {
            GrdPaidFollow.FooterRow.Cells[0].Text = "Total";
            GrdPaidFollow.FooterRow.Cells[7].Text = Convert.ToString(dktamt);
            GrdPaidFollow.FooterRow.Cells[8].Text = Convert.ToString(svctax);
            GrdPaidFollow.FooterRow.Cells[9].Text = Convert.ToString(Cessamt);
            GrdPaidFollow.FooterRow.Cells[10].Text = Convert.ToString(dkttot);
            GrdPaidFollow.FooterRow.CssClass = "blackfnt";
            GrdPaidFollow.FooterRow.HorizontalAlign = HorizontalAlign.Center;
            amtword = Convert.ToString(dkttot);
            string currency = "Rupees ";
            string _currency = " Paise Only";
            if (Convert.ToDouble(amtword) == 0)
            {
                lbltotalinword.Text = "Zero";
                //return;
            }
            if (Convert.ToDouble(amtword) < 0)
            {
                lbltotalinword.Text = "Invalid Value";
                //return;
            }
            Boolean a = amtword.Contains(".");
            if (a == false)
            {
                amtword = amtword + ".00";
            }
            string[] no = amtword.Split('.');
            if ((no[0] != null) && (no[1] != "00"))
            {
                Number = no[0];
                deciml = no[1];
                _number = (NameOfNumber(Number));
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = currency + _number.Trim() + " and " + _deciml.Trim() + _currency;
            }
            if ((no[0] != null) && (no[1] == "00"))
            {
                Number = no[0];
                _number = (NameOfNumber(Number));
                lbltotalinword.Text = currency + _number + "Only";
            }
            if ((Convert.ToDouble(no[0]) == 0) && (no[1] != null))
            {
                deciml = no[1];
                _deciml = (NameOfNumber(deciml));
                lbltotalinword.Text = _deciml + _currency;
            }
        }
    }
    public string NameOfNumber(string Number)
    {
        string GroupName = "";
        string OutPut = "";

        if ((Number.Length % 3) != 0)
        {
            Number = Number.PadLeft((Number.Length + (3 - (Number.Length % 3))), '0');
        }
        string[] Array = new string[Number.Length / 3];
        Int16 Element = -1;
        Int32 DisplayCount = -1;
        bool LimitGroupsShowAll = false;
        int LimitGroups = 0;
        bool GroupToWords = true;
        for (Int16 Count = 0; Count <= Number.Length - 3; Count += 3)
        {
            Element += 1;
            Array[Element] = Number.Substring(Count, 3);

        }
        if (LimitGroups == 0)
        {
            LimitGroupsShowAll = true;
        }
        for (Int16 Count = 0; (Count <= ((Number.Length / 3) - 1)); Count++)
        {
            DisplayCount++;
            if (((DisplayCount < LimitGroups) || LimitGroupsShowAll))
            {
                if (Array[Count] == "000") continue;
                {
                    GroupName = US[((Number.Length / 3) - 1) - Count + 1];
                }


                if ((GroupToWords == true))
                {
                    OutPut += Group(Array[Count]).TrimEnd(' ') + " " + GroupName + " ";

                }
                else
                {
                    OutPut += Array[Count].TrimStart('0') + " " + GroupName;

                }
            }

        }
        Array = null;
        return OutPut;

    }


    private string Group(string Argument)
    {
        string Hyphen = "";
        string OutPut = "";
        Int16 d1 = Convert.ToInt16(Argument.Substring(0, 1));
        Int16 d2 = Convert.ToInt16(Argument.Substring(1, 1));
        Int16 d3 = Convert.ToInt16(Argument.Substring(2, 1));
        if ((d1 >= 1))
        {
            OutPut += SNu[d1] + " hundred ";
        }
        if ((double.Parse(Argument.Substring(1, 2)) < 20))
        {
            OutPut += SNu[Convert.ToInt16(Argument.Substring(1, 2))];
        }
        if ((double.Parse(Argument.Substring(1, 2)) >= 20))
        {
            if (Convert.ToInt16(Argument.Substring(2, 1)) == 0)
            {
                Hyphen += " ";
            }
            else
            {
                Hyphen += " ";
            }
            OutPut += SNt[d2] + Hyphen + SNu[d3];
        }
        return OutPut;
    }

    private void Initialize()
    {

        SNu[0] = "";
        SNu[1] = "One";
        SNu[2] = "Two";
        SNu[3] = "Three";
        SNu[4] = "Four";
        SNu[5] = "Five";
        SNu[6] = "Six";
        SNu[7] = "Seven";
        SNu[8] = "Eight";
        SNu[9] = "Nine";
        SNu[10] = "Ten";
        SNu[11] = "Eleven";
        SNu[12] = "Twelve";
        SNu[13] = "Thirteen";
        SNu[14] = "Fourteen";
        SNu[15] = "Fifteen";
        SNu[16] = "Sixteen";
        SNu[17] = "Seventeen";
        SNu[18] = "Eighteen";
        SNu[19] = "Nineteen";
        SNt[2] = "Twenty";
        SNt[3] = "Thirty";
        SNt[4] = "Forty";
        SNt[5] = "Fifty";
        SNt[6] = "Sixty";
        SNt[7] = "Seventy";
        SNt[8] = "Eighty";
        SNt[9] = "Ninety";
        US[1] = "";
        US[2] = "Thousand";
        US[3] = "Million";
        US[4] = "Billion";
        US[5] = "Trillion";
        US[6] = "Quadrillion";
        US[7] = "Quintillion";
        US[8] = "Sextillion";
        US[9] = "Septillion";
        US[10] = "Octillion";
    }
    protected void PageIndexChanged_Click(object sender, GridViewPageEventArgs e)
    {
        //GrdPaidFollow.PageIndex = e.NewPageIndex;
        //BindTheData();
        //GrdPaidFollow.DataBind(); 
    }
    protected void GrdPaidFollow_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header) 
        {
            GridView oGridView = (GridView)sender;
            GridViewRow oGridViewRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell oTableCell = new TableCell();
            oTableCell.HorizontalAlign = HorizontalAlign.Center;
            //oTableCell.Font.Bold = true;
            oTableCell.Text = "Docket Details";
            oTableCell.ColumnSpan = 11;
            oTableCell.CssClass = "blackfnt";
            oGridViewRow.Cells.Add(oTableCell);
            oGridView.Controls[0].Controls.AddAt(0, oGridViewRow);
        }
        svctax = svctax + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "svctax") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "svctax"));
        dkttot = dkttot + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "dkttot") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "dkttot"));
        Cessamt = Cessamt + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Tot_cess") == System.DBNull.Value ? 0.00 : DataBinder.Eval(e.Row.DataItem, "Tot_cess"));
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            dktamt = dktamt + Convert.ToDecimal(((Label)e.Row.FindControl("lbldktamt")).Text);
        }
    }
}
