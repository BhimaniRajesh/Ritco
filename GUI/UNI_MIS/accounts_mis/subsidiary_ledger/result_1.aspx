<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_subsidiary_ledger_result" %>
<asp:Content ContentPlaceHolderID="MyCPH1" ID="sub_ledger" runat="server">
<div align="left">
<% 
    string acccode, accdesc, straccdesc;
    string FromDt = Request.QueryString["dateFrom"];
    string ToDt = Request.QueryString["dateTo"];
    string branch = Request.QueryString["branchText"];
    string DateRange = ToDt + "-" + ToDt;
    string mindividual = Request.QueryString["strdlstTranType"].ToString();
    string CustYN = Request.QueryString["cust"];
    string acctopening = "webx_acctopening_" + Session["YearVal"].ToString();
    //Response.Write "<br>CustYN :" & CustYN
	//Response.end
    DateFunction Daccess = new DateFunction();
    
    
    //accdesc = Daccess.getAccountDesc(acccode);
    
    string ledgerof = Request.QueryString["ledgerof"];
    straccdesc = "";
    if (ledgerof == "C")
    {
        acccode = "CDA0001";
        accdesc = Daccess.getAccountDesc(acccode);
        straccdesc = acccode + " : " + accdesc;
    }
    else if (ledgerof=="V")
    {
        acccode = Request.QueryString["vend_code"];
        accdesc = Daccess.getAccountDesc(acccode);
    }
    else if (ledgerof == "E")
    {
        acccode = Request.QueryString["emp_code"];
        accdesc = Daccess.getAccountDesc(acccode);
    }
    string LocDesc,LocCode,LocName;
    LocDesc = "All";
    //LocDesc=Request.QueryString[""];;
    //LocName = Request.QueryString[""];
    LocCode = Request.QueryString["branch"];
    LocName = Daccess.getLocationDesc(LocCode);
    
    if (LocCode != "" || LocCode != null)
    {
        LocDesc = LocCode + " : " + LocName;   
    }

    if (mindividual == "N")
    {
        LocDesc = LocDesc + " ( Cumulative ) ";
    }
    string custcd, custdesc, custName;
   
    custcd = Request.QueryString["cust_code"];
    custdesc = "All";
    if (custcd != "" || custcd != null)
    {
        custName =Daccess.getCustomer(custcd);
        if (custName != "")
        {
            custdesc = custcd + " : " + custName;
        }
    }
    string vendcd, VendName, venddesc;
    venddesc = "All";
    vendcd = Request.QueryString["vend_code"];
    if (vendcd != null)
    {
        VendName =Daccess.getvendor(vendcd);
        if (VendName != "")
        {
            venddesc = vendcd + " : " + VendName;
        }
    }
    string empcd, empName, empDesc;
    empcd = Request.QueryString["emp_code"];
    if (empcd != null)
    {
    if (empcd != "" || empcd != "All")
    {
        empName = Daccess.getEmpname(empcd);
        if (empName != "")
        {
           empDesc = empcd + " : " + empName;
        }
    }
    }
    
    string HOLedger_Hdr_var="webx_HOLedger_Hdr";
    string HOLedger_Det_var = "webx_HOLedger_Det";
    string brcd = Session["brcd"].ToString();
%>
        <table width="1000" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr align="left">
                <td height="30" align="left">
                    <a href="../../../welcome.aspx"></a>
                </td>
                <tr>
                    <td class="horzblue">
                        <img src="../../../images/clear.gif" width="2" height="1"></td>
                </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../../images/back.gif" border="0"></a></td>
            </tr>
            <tr>
                <td>
                    <table width="80%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="39%" valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="300" valign="top">
                                            <!--START-->
                                            <br>
                                            
                                            <div align="center">
                                                <center>
                                                    <div align="center">
                                                        <center>
                                                        
                                                            <table border="0" width="80%" bgcolor="#000000" cellspacing="1" cellpadding="2" class=boxbg>
								
								
								<tr>
									<td width="25%" bgcolor="#FFFFFF" align="left">
										<font class=blackfnt>Branch / Profit Center </font>
									</td>
									<td width="25%" bgcolor="#FFFFFF" align="left">
										<font class=blackfnt>
											<%=LocDesc%>
										</font>
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#FFFFFF" width="25%" align="center">
										<div align="left">
											<font class=blackfnt>Date Range </font>
										</div>
									</td>
									<td bgcolor="#FFFFFF" width="75%" align="center">
										<div align="left">
											<font class=blackfnt>
												<%=DateRange%>
											</font>
										</div>
									</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF" width="25%" align="center">
										<div align="left">
											<font class=blackfnt>Account Head</font>
										</div>
									</td>
									<td bgcolor="#FFFFFF" width="75%" align="center">
										<div align="left">
											<font class=blackfnt>
												<%=straccdesc%>
											</font>
										</div>
									</td>
								</tr>
								<tr>
								    <td bgcolor="#FFFFFF" width="25%" align="center">
										<%if (ledgerof=="C" )
                                            {
                                        %>
											<div align="left">
												<font class=blackfnt>Customer</font>
											</div>
			                            <% 
			                                }
			                            %>
										<%else if (ledgerof=="V")
                                            {
                                        %>
											<div align="left">
												<font class=blackfnt>Vendor</font>
											</div>
										<% 
			                                }
			                            %>
										<%else if (ledgerof=="E")
                                            {
                                        %>	
											<div align="left">
												<font class=blackfnt>Employee</font>
											</div>
										<% 
			                                }
			                            %>
										
									</td>
									
									<td bgcolor="#FFFFFF" width="75%" align="center">
										<% if (ledgerof == "C")
                                            {
                                        %>
											<div align="left">
												<font class=blackfnt>
													<%= custdesc %>
												</font>
											</div>
										<% 
			                                }
			                            %>
										<%else if (ledgerof=="V")
                                            {
                                        %>
											<div align="left">
												<font class=blackfnt>
													<%= venddesc%>
												</font>
											</div>
									    <% 
			                                }
			                            %>
			                            <%else if (ledgerof=="E")
                                            {
                                        %>
											<div align="left">
												<font class=blackfnt>
													
												</font>
											</div>
										<% 
			                                }
			                            %>
									</td>
								</tr>
							</table>
                            <br />
<%
    //DateFunction Daccess = new DateFunction();
    acccode = "CDA0001";
    string sql;
    string mGroupTable="webx_groups";
    string mAcctTable = "webx_acctinfo";
    string mAcctOpenTable = "webx_acctopening_" + Session["YearVal"].ToString();
    string mAcctTransTable = "webx_acctrans_" + Session["YearVal"].ToString();
    string finyearstart = "01 APR 04";
    string mTodt = Request.QueryString["dateFrom"];
    string mClosedt = Request.QueryString["dateTo"];
    string acccodeadded = "'";
    
    DateTime righnow = DateTime.Now;
    righnow = righnow.AddDays(-7);
    string strrightnow = righnow.ToString("dd/MM/yyyy");
    string selectedDate = Daccess.returnmmddyyyy_format(mClosedt);

    DateTime pri = DateTime.Parse(selectedDate);
    pri = pri.AddDays(-1);
    string strpri = pri.ToString("dd/MM/yyyy");
    string strPriviousDate = Daccess.return_date(strpri);
    string macctcls = "";
    string loccode = "";
    string mdateCls = " and convert(varchar,t.transdate,106) between convert(datetime,'" + mTodt + "',106) and convert(datetime,'" + strPriviousDate + "',106)";
    string mdateDetCls = " and convert(varchar,t.transdate,106) between convert(datetime,'" + mTodt + "',106) and convert(datetime,'" + mClosedt + "',106)";
    if (mindividual == "N")
    {
        sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,o.opendebit as opendebit ,o.opencredit as opendebit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
    }
	else
    {
        sql = "select g.groupcode,g.groupdesc as groupdesc,a.acccode,a.accdesc,o.opendebit_i as opendebit ,o.opencredit_i as opendebit from " + mGroupTable + " g, " + mAcctTable + " a," + mAcctOpenTable + "  o where a.acccode*=o.acccode and g.groupcode=a.groupcode  " + macctcls + " and o.brcd='" + loccode + "' and a.acccode='" + acccode + "' order by g.groupcode,a.accdesc";
    }
    string brcls = "";
    if (mindividual == "Y")
    {
        switch (CustYN)
        {
            case "Y":
                brcls = " and d.loccd ='" + loccode + "'";
                break;
            case "N":
                brcls = " and d.vendorbrcd ='" + loccode + "'";
                break;
        }
    }
    string agentcls = "";
	if (custcd != "")
    {
        agentcls= " and m.custcd ='"  + custcd + "'";
    }

    if (vendcd != "")
    {
        agentcls = " and m.vendorCode ='" + vendcd + "'";    
    }
    switch (ledgerof)
    {
        case "C":
            sql = "select m.custcd,custnm,sum(openDebit) as OpenDebit,Sum(OpenCredit) as OpenCredit from webx_Custhdr m where custcd is not null " + agentcls + " group by m.custcd,custnm "; 
            break;
        case "V":
            sql = "select m.vendorCode,m.vendorName ,sum(openDebit) as OpenDebit,Sum(OpenCredit) as OpenCredit from webx_vendor_hdr m where VendorCode Is NOT NULL " + agentcls + " group by m.VendorCode,VendorName";
            break;
        case "E":
            sql = "select m.Empcd,m.Empnm ,0 as OpenDebit,0 as OpenCredit from webx_empmst m where empcd='" + empcd + "'";
            break;
    }
    //string recFlag = "N";
    custcd = Request.QueryString["cust_code"];
    custName = Daccess.getCustomer(custcd);
%>
        <table border=0 cellpadding=3 cols=1 width="98%" bgcolor="#808080" cellspacing="1" class=boxbg>
            <tr class="bgbluegrey"> 
              <td align="center"><font class=blackfnt><b>S No</b></font></td>
              <td align="center"><font class=blackfnt><b>Voucher No.</b></font></td>
              <td align="center"><font class=blackfnt><b>Date</b></font></td>
              <td align="center"><font class=blackfnt><b>Particular</b></font></td>
	          <td align="center"><font class=blackfnt><b>Debit</b></font></td>
              <td align="center"><font class=blackfnt><b>Credit</b></font></td>
		      <td align="center" width=25%><font class=blackfnt><b>Narration</b></font></td>
            </tr>
            <tr class="bgbluegrey"> 
              <td align="left" colspan="7"><font class=blackfnt><b>Customer : <%= custName%></b></font></td>
              
            </tr>
        
        <%
            double totalopeningdebit;
            double totalopeningcredit;
           string OpenBal1;
           if (mindividual == "N")
           {
               string opendebit, opencredit;
               string strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
               System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(strdatabase);

               System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("select convert(varchar,isNull((sum(credit)),0.00)) as credit,convert(varchar,isNull((sum(debit)),0.00)) as debit from '" + acctopening + "' where acccode='" + acccode + " ' and  brcd='" + brcd + "'", con);
               con.Open();
               System.Data.SqlClient.SqlDataReader dtr = cmd.ExecuteReader();
               opendebit = "";
               opencredit = "";
               while (dtr.Read())
               {
                   opendebit = dtr["debit"].ToString();
                   opencredit = dtr["credit"].ToString();
               }
               dtr.Close();
               con.Close();
               if (opendebit == "")
               {
                   opendebit = "0.00";
               }
               if (opencredit == "")
               {
                   opencredit = "0.00";
               }
               
               string currentdebit, currentcridet;
               System.Data.SqlClient.SqlCommand cmd1 = new System.Data.SqlClient.SqlCommand("select convert(varchar,isNull((sum(credit)),0.00)) as credit,convert(varchar,isNull((sum(debit)),0.00)) as debit from '" + mAcctTransTable + "' where acccode='" + acccode + " ' and convert(varchar,transdate,106) between  convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + strPriviousDate + "',106) and  PBOV_CODE='" + custcd + "'", con);
               con.Open();
               System.Data.SqlClient.SqlDataReader dtr1 = cmd1.ExecuteReader();
               currentdebit = "";
               currentcridet = "";
               while (dtr1.Read())
               {
                   currentdebit = dtr1["debit"].ToString();
                   currentcridet = dtr1["credit"].ToString();
               }
               dtr1.Close();
               con.Close();
                totalopeningdebit = Convert.ToDouble(opendebit) + Convert.ToDouble(currentdebit);
                totalopeningcredit = Convert.ToDouble(opencredit) + Convert.ToDouble(currentcridet);
           }
            else
           {
               string opendebit, opencredit;
               string strdatabase = (string)(System.Web.HttpContext.Current.Session["SqlProvider"].ToString().Trim());
               System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(strdatabase);
               string sqlopen = "select convert(varchar,isNull((sum(opencredit_i)),0.00)) as credit,convert(varchar,isNull((sum(opendebit_i)),0.00)) as debit from " + acctopening + " where acccode='" + acccode + " ' and brcd='" + brcd + "'";
               System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sqlopen, con);
               con.Open();
               System.Data.SqlClient.SqlDataReader dtr = cmd.ExecuteReader();
               opendebit = "";
               opencredit = "";
               while (dtr.Read())
               {
                   opendebit = dtr["debit"].ToString();
                   opencredit = dtr["credit"].ToString();
               }
               dtr.Close();
               con.Close();
               if (opendebit == "")
               {
                   opendebit = "0.00";
               }
               if (opencredit == "")
               {
                   opencredit = "0.00";
               }

               string currentdebit, currentcridet;
               string sqlopen1 = "select convert(varchar,isNull((sum(credit)),0.00)) as credit,convert(varchar,isNull((sum(debit)),0.00)) as debit from " + mAcctTransTable + " where acccode='" + acccode + " ' and convert(varchar,transdate,106) between  convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + strPriviousDate + "',106) and PBOV_CODE='" + custcd + "' and brcd='" + LocCode + "'";
               System.Data.SqlClient.SqlCommand cmd1 = new System.Data.SqlClient.SqlCommand(sqlopen1, con);
               con.Open();
               System.Data.SqlClient.SqlDataReader dtr1 = cmd1.ExecuteReader();
               currentdebit = "";
               currentcridet = "";
               while (dtr1.Read())
               {
                   currentdebit = dtr1["debit"].ToString();
                   currentcridet = dtr1["credit"].ToString();
               }
               dtr1.Close();
               con.Close();
                totalopeningdebit = Convert.ToDouble(opendebit) + Convert.ToDouble(currentdebit);
                totalopeningcredit = Convert.ToDouble(opencredit) + Convert.ToDouble(currentcridet);
              
           }
           string tdebit = string.Format("{0:0.00}", totalopeningdebit).ToString();
           string tcredit = string.Format("{0:0.00}", totalopeningcredit).ToString();
           
         %>
          <tr bgcolor="#ffffff"> 
			<td width="36%" colspan=4 align="left"><font class=blackfnt><b>Opening Balance</b></font></td>
			<td align="right" colspan=2><font class=blackfnt><b><%= tdebit%></b></font></td>
			<td align="right"><font class=blackfnt>&nbsp;</font></td>
		</tr>
		<tr bgcolor="#ffffff">
			<td colspan=4 align="left"><font class=blackfnt><b>Closing Balance</b></font></td>
			<td align="right" colspan=2><font class=blackfnt><b><%= tcredit%></b></font></td>
			<td align="right"><font class=blackfnt>&nbsp;</font></td>
		</tr> 

</table>










                                                                
                                                                </div></div></td></tr></table>
                                                                <br />
                                                                
                                                       </td></tr></td>
                                    </tr>
                                </table>
                                
                                
    </div>
</asp:Content>
