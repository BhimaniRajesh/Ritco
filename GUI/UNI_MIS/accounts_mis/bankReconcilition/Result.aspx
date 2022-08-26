<%@ Page Language="C#" AutoEventWireup="true" Debug="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_bankReconciliationStatement_Result" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="resu" runat="server">
<br /><br />
    <table width="75%" border="0">
        <tr>
            <td width="10%">
                
            </td>
            <td width="90%">
                <div align="center">
                    <table border="0"  cellpadding="4" cellspacing="1" class="boxbg" width="500">
                        <tr bgcolor="white">
                        <% 
                            System.Data.SqlClient.SqlDataReader dtr;
                            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(Session["SqlProvider"].ToString().Trim());
                            string branText = Request.QueryString["branText"];
                            string strSalesAccountText = Request.QueryString["strSalesAccountText"];
                            string mindividual = Request.QueryString["TranType"].ToString();
                            string strFinYear = Request.QueryString["FinYear"].ToString();
                            %>
                            <td align="left"><font class="blackfnt">Prepared At</font></td>
                            <td align="left"><font class="blackfnt"><%= branText%></font></td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left"><font class="blackfnt">Account</font></td>
                            <td align="left"><font class="blackfnt"><%= strSalesAccountText %></font></td>
                        </tr>
                        <tr bgcolor="white">
                        <%
                            string DateF = Request.QueryString["dateFrom"];
                            string DateT = Request.QueryString["dateTo"];
                            string duration = DateF + " - " + DateT;
                             %>
                            <td align="left"><font class="blackfnt">Duration</font></td>
                            <td align="left"><font class="blackfnt"><%=duration%></font></td>
                        </tr>
                    </table>
                </div>
                <br /><br />
                <table border="0" align="center" width="700" class="boxbg" cellpadding="3" cellspacing="1">
                <tr bgcolor="white">
                    <td align="left" colspan="5"><font class="blackfnt"><strong>PARTICULARS</strong></font></td>
                    <td align="center"><font class="blackfnt"><strong>Amount</strong></font></td>
                </tr>
                <%
                    DateFunction Daccess = new DateFunction();
                    string acctcls = Request.QueryString["strdlstSalesAmount"];
                    string ToDt = Request.QueryString["dateTo"];
                    string AcctOpenTable = "webx_acctopening_" + strFinYear;
                    string AcctTransTable = "webx_acctrans_" + strFinYear;
                    string LocCode = Request.QueryString["branch"];
                    //mindividual = "Y";
                    ///////////////////////////////////////////////////////////////////////////////////////////////////
                    double opendebit1 = 0;
                    double opencredit1 = 0;
                    double currcredit1 = 0;
                    double currdebit1 = 0;
                    string ReturnCurrBalBC = "";


                    string openBal = "";
                    string stropendebit = "";
                    string stropencredit = "";
                    string strcurrcredit = "";
                    string strcurrdebit = "";
                    string sql = "";
                    string sql1 = "";
                    //string cbs_brcd = AccBrcd;
                    System.Data.SqlClient.SqlDataReader dtr2;


                    string tranType;

                    if (mindividual == "Y")
                    {
                        tranType = "(Individual)";
                    }
                    else
                    {
                        tranType = "(Cumulative)";
                    }
                    
                    
                    double opendebit, opencredit;
                    double closedebit, closecredit;

                    closedebit = 0;
                    closecredit = 0;
                    if (mindividual == "N")
                    {
                        sql = "select opendebit + opendebit_i as opendebit,opencredit + opencredit_i as opencredit from " + AcctOpenTable + " where acccode='" + acctcls + "' and brcd='" + LocCode + "'";
                    }
                    else
                    {
                        sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " + AcctOpenTable + " where acccode='" + acctcls + "' and brcd='" + LocCode + "'";
                    }
                    conn.Open();
                    stropendebit = "";
                    stropencredit = "";
                    dtr2 = Daccess.getreader(sql);
                    while (dtr2.Read())
                    {
                        stropendebit = dtr2["opendebit"].ToString() + "0";
                        opendebit1 = opendebit1 + Convert.ToDouble(stropendebit);
                        stropencredit = dtr2["opencredit"].ToString() + "0";
                        opencredit1 = opencredit1 + Convert.ToDouble(stropencredit);
                    }
                    dtr2.Close();
                    conn.Close();
                    string datefrom = "01 Jan 2000";
                    DateTime mdatefrom = Convert.ToDateTime("01/01/2000");
                    string DateValuemdateto = Daccess.returnmmddyyyy_format(ToDt);
                    DateTime Datefun = Convert.ToDateTime(DateValuemdateto);
                    if (mdatefrom <= Datefun)
                    {
                        
                    }
                    closedebit = opendebit1 + currdebit1;
                    closecredit = opencredit1 + currcredit1;

                   
                    /////////////////////////////////////////////////////////////////////////////////////////////////
                    string OpenBal = "0.00 Dr"; //ReturnCurrBalBC; //Daccess.getOpenBal_MIS(acctcls, ToDt, AcctOpenTable, AcctTransTable, LocCode, "Y");
                %>
                <tr bgcolor="white">
                    <td align="left" colspan="5"><font class="blackfnt"><strong>Balance As per Bank Book</strong></font></td>
                    <td align="right"><font class="blackfnt"><strong><%=ReturnCurrBalBC%></strong></font></td>
                </tr>
                 <tr bgcolor="white">
                    <td align="left" style="width: 64px"><font class="blackfnt">&nbsp;</font></td>
                    <td align="left" style="width: 59px"><font class="blackfnt">&nbsp;</font></td>
                    <td align="left"><font class="blackfnt">&nbsp;</font></td>
                    <td align="left"><font class="blackfnt">&nbsp;</font></td>
                    <td align="left"><font class="blackfnt">&nbsp;</font></td>
                    <td align="left"><font class="blackfnt">&nbsp;</font></td>
                </tr>
               <%
                    string accountName = Request.QueryString["strSalesAccountText"].ToString();
                %>
                
                <tr bgcolor="white">
                    <td colspan="6" align="left"><font class="blackfnt"><%=accountName%></font></td>
                </tr>
                 <tr class="bgbluegrey">
                    <td align="center" style="width: 64px"><font class="blackfnt"><strong>Date</strong></font></td>
                    <td align="center" style="width: 59px"><font class="blackfnt"><strong>Chq. No.</strong></font></td>
                    <td align="center"><font class="blackfnt"><strong>Name of the Party </strong></font></td>
                    <td align="center"><font class="blackfnt"><strong>Amount</strong></font></td>
                    <td align="center"><font class="blackfnt"><strong>Ch.Presented </strong></font></td>
                    <td><font class="blackfnt"><strong></strong></font></td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" colspan="6"><font class="blackfnt"><strong>Add : Cheques Issued but not presented</strong></font></td>
                </tr>
                <%
                    
                    
                    string bgbluegrey_var="bgbluegrey";
                    string bluefnt_var = "bluefnt";
                    string boxbg = "boxbg";
                    string FromDt = Request.QueryString["dateFrom"];
                   
                    string wheredtrange =" (convert(varchar,transdate,106))  ";
                    wheredtrange= wheredtrange + "  between convert(datetime,'" + FromDt + "',106) and convert(datetime,'" + ToDt + "',106)" ;
                    string mDateRange = FromDt + " - " + ToDt;
                    string selectedDate = Daccess.returnmmddyyyy_format(ToDt);                    
                    DateTime pri = DateTime.Parse(selectedDate);
                    pri = pri.AddDays(-1);
                    string strpri = pri.ToString("dd/MM/yyyy");
                    string strPriviousDate = Daccess.return_date(strpri);
                    string finyearstart = "01 Jan 2000";
                    string opendtrange = " (convert(varchar,transdate,106) between convert(datetime,'" + finyearstart + "',106) and convert(datetime,'" + strPriviousDate + "',106))";
                    string chqcleardaterange = " and convert(varchar,chqcleardate,106) > convert(datetime,'" + ToDt + "',106) or (chqcleardate is null)";
                    
                    
                    string AcctTable = "webx_acctinfo";
                    string GroupTable = "webx_groups";
                    
                    string branchcls = " and m.brcd='" + LocCode + "'";
                    
                    string locstr = "";
                    string accstr= "";
                    if (LocCode != "All")
                    {
                        locstr = "and brcd = '" + LocCode + "' " ;       
                    }
                    if (Session["mainbrcd"].ToString().Trim() == LocCode)
                    {
                        locstr = "and brcd = '" + LocCode + "' ";    
                    }
                    if (acctcls != "All")
                    {
                        accstr = "and Acccode = '" + acctcls + "' ";
                    }
			            
			        //string sql="";
                    //string sql1 = "";
                    string strcredit = "";
                    string strdebit = "";
                    sql = "select srno,voucherno,chqno as chqno,chqdate,isNull(convert(varchar,chqdate,6),' ') as chqdate1,transtype,chqcleardate,Narration,credit,debit,(pbov_code + ' : ' + pbov_name) as pbov_name,pbov_code  from " + AcctTransTable + " with (NOLOCK) where " + wheredtrange + locstr + accstr  + " and ((credit > 0) ) order by transdate,voucherno ";
                    
                    dtr = Daccess.getreader(sql);
                    conn.Open();
                    //System.Data.SqlClient.SqlDataReader dtr = (sql);
                    string strDate = "";
                    string strChequeNo = "";
                    string strparty = "";
                    string strAmt = "";
                    string strPresented = "";
                    string strTotalCredit = "";
                    double inttotal = 0;

                    string strTotalVal = "";
                    while (dtr.Read())
                    {
                        strDate = dtr["chqdate1"].ToString() + "";
                        strChequeNo = dtr["chqno"].ToString() + "";
                        strparty = dtr["pbov_name"].ToString();
                        strAmt = dtr["credit"].ToString();
                       
                        if (strChequeNo != "")
                        {
                            inttotal = inttotal + System.Convert.ToDouble(strAmt);
                        }
                        strTotalVal = string.Format("{0:0.00}", inttotal).ToString();
                        
                        strPresented = "";
                      
                        if (strDate != " ")
                        { 
                    %>
                    
                        
                        
                            <tr bgcolor="white">
                                <td align="center" style="width: 64px">
                                   <font class="blackfnt"><%=strDate %></font>
                                </td>
                                <td align="center" style="width: 59px">
                                    <font class="blackfnt"><%=strChequeNo%></font>
                                </td>
                                <td width="200" align="center">
                                    <font class="blackfnt"><%=strparty%></font>
                                </td>
                                <td width="100" align="right">
                                    <font class="blackfnt"><%=strAmt%></font>
                                </td>
                                <td width="100" align="center">
                                    <font class="blackfnt">-</font>
                                </td>
                                <td width="100" align="right">
                                    <font class="blackfnt"></font>
                                </td>
                            </tr>
                         

                    <%
                    }
                    }
                    dtr.Close();
                    conn.Close();
                    %>
                    <tr bgcolor="white">
                        <td colspan="3" align="right"><font class="blackfnt"><strong>Total</strong></font></td>
                        <td colspan="1" align="right"><font class="blackfnt"><%=strTotalVal%></font></td>
                        <td colspan="2"></td>
                    </tr>
                    <tr bgcolor="white">
                        <td colspan="3" align="right"><font class="blackfnt"></font></td>
                        <td colspan="1" align="right"><font class="blackfnt"></font></td>
                        <%
                            string info = OpenBal;
                            string strValueOP="";
                            string[] arInfo = new string[2];
                            char[] splitter = { ' ' };
                            arInfo = info.Split(splitter);
                            for (int x = 0; x < arInfo.Length; x++)
                            {
                                strValueOP = arInfo[0];
                            }
                            double add = Convert.ToDouble(strValueOP) + inttotal;

                            string strAdd = string.Format("{0:0.00}", add).ToString();
                        %>
                        <td colspan="2" align="right"><font class="blackfnt"><strong><%= strAdd%> Cr</strong></font></td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" colspan="6"><font class="blackfnt"><strong>Less : Cheque Deposited But Not Cleared </strong></font></td>
                    </tr>
                    <%
                    System.Data.SqlClient.SqlDataReader dtr1;
                    sql1 = "select srno,voucherno,isNull(chqno,'') as chqno,chqdate,isNull(convert(varchar,chqdate,6),' ') as chqdate1,transtype,chqcleardate,Narration,credit,debit,(pbov_code + ':' + pbov_name) as pbov_name,pbov_code  from " + AcctTransTable + "  with (NOLOCK) where " + wheredtrange + locstr + accstr + " and ((debit > 0)) order by transdate,voucherno ";                
                    dtr1 = Daccess.getreader(sql1);
                    conn.Open();
                    //System.Data.SqlClient.SqlDataReader dtr = (sql);
                    string strDate1 = "";
                    string strChequeNo1 = "";
                    string strparty1 = "";
                    string strAmt1 = "";
                    string strPresented1 = "";
                    string strTotalCredit1 = "";
                    double inttotal1 = 0;

                    string strTotalVal1 = "";
                    while (dtr1.Read())
                    {
                        strDate1 = dtr1["chqdate1"].ToString() + "";
                        strChequeNo1 = dtr1["chqno"].ToString();
                        strparty1 = dtr1["pbov_name"].ToString();
                        strAmt1 = dtr1["debit"].ToString();
                        if (strChequeNo1 != "")
                        {
                            inttotal1 = inttotal1 + System.Convert.ToDouble(strAmt1);
                        }
                        strTotalVal1 = string.Format("{0:0.00}", inttotal1).ToString();
                        strPresented1 = "";//dtr["credit"].ToString();

                        if (strChequeNo1 != "")
                        { 
                    %>
                    
                        
                        
                            <tr bgcolor="white">
                                <td align="center" style="width: 64px">
                                   <font class="blackfnt"><%=strDate1 %></font>
                                </td>
                                <td align="center" style="width: 59px">
                                    <font class="blackfnt"><%=strChequeNo1%></font>
                                </td>
                                <td width="30%" align="center">
                                    <font class="blackfnt"><%=strparty1%></font>
                                </td>
                                <td width="10%" align="right">
                                    <font class="blackfnt"><%=strAmt1%></font>
                                </td>
                                <td width="10%" align="center">
                                    <font class="blackfnt">-</font>
                                </td>
                                <td width="10%" align="right">
                                    <font class="blackfnt"></font>
                                </td>
                            </tr>
                         

                    <%
                    }
                    }
                    dtr1.Close();
                    conn.Close();
                    %>
                    <tr bgcolor="white">
                        <td colspan="3" align="right"><font class="blackfnt"><strong>Total</strong></font></td>
                        <td colspan="1" align="right"><font class="blackfnt"><%=strTotalVal1%></font></td>
                        <td colspan="2"></td>
                    </tr>
                    <tr bgcolor="white">
                        <td colspan="3" align="left"><font class="blackfnt"><strong>BALANCE AS PER BANK STATEMENT</strong></font></td>
                        <td colspan="1" align="right"><font class="blackfnt"></font></td>
                        <%
                            
                            double less = add - inttotal1;
                            
                            string strless = string.Format("{0:0.00}", less).ToString();
                        %>
                        <%
                            if (add == inttotal1)
                            {
                        %>
                        <td colspan="2" align="right"><font class="blackfnt"><strong><%= strless%> Dr</strong></font></td>
                        <%
                            }
                        %>
                        
                        <%
                            if (add > inttotal1)
                            {
                        %>
                        <td colspan="2" align="right"><font class="blackfnt"><strong><%= strless%> Cr</strong></font></td>
                        <%
                            }
                        %>
                        
                        <%
                            if (add < inttotal1)
                            {
                        %>
                        <td colspan="2" align="right"><font class="blackfnt"><strong><%= strless%> Dr</strong></font></td>
                        <%
                            }
                        %>
                        
                    </tr>
                    <tr bgcolor="white">
                        <td colspan="3" align="left"><font class="blackfnt"><strong>ACCOUNTANT</strong></font></td>
                        <td colspan="3" align="left"><font class="blackfnt"><strong>DGM (ACCOUNTS)</strong></font></td>
                        
                    </tr>
                    </table>  
            </td>
        </tr>
    </table>
    <br /><br />
</asp:Content>
