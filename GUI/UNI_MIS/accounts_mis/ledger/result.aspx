<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_ledger_result" EnableEventValidation="false" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="resultpg" runat="server">
    <div align="left">
        <table width="60%"  border="0" align="left" cellpadding="0" cellspacing="0">
            <%--<tr align="left">
                <td align="left" style="height: 30px">
                </td>--%>                
                <tr>
                    <td class="horzblue">
                        <img src="../../../images/clear.gif" width="2" height="1" alt="clear" /></td>
                </tr>
                <tr>
                    <td>
                        <img src="../../../images/clear.gif" width="15" height="10" alt="clear" /></td>
                </tr>
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../../images/back.gif" border="0" alt="Back" /></a></td>
                </tr>
                <tr>
                    <td>
                        <table id="table1" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="39%" valign="top">
                                    <table  width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="300" valign="top">
                                                <!--START-->
                                                <br />
                                                <div align="center">
                                                    <center>
                                                        <div align="center">
                                                            <center>
                                                                <table id="table2" runat="server" border="1" width="50%">
                                                                    <tr>
                                                                        <td bgcolor="#FFFFFF" align="left" colspan="3">
                                                                            <font class="blackfnt">Branch / Profit Center </font>
                                                                        </td>
                                                                        <td bgcolor="#FFFFFF" align="left" colspan="3">
                                                                            <font class="blackfnt">
                                                                                <asp:Label ID="lblBran" runat="server" CssClass="blackfnt"></asp:Label>
                                                                            </font>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td bgcolor="#FFFFFF"  colspan="3" width="25%" align="center">
                                                                            <div align="left">
                                                                                <font class="blackfnt">Date Range </font>
                                                                            </div>
                                                                        </td>
                                                                        <td bgcolor="#FFFFFF"  colspan="3"  width="75%" align="center">
                                                                            <div align="left">
                                                                                <font class="blackfnt">
                                                                                    <asp:Label ID="lblDate_Range" runat="server" CssClass="blackfnt"></asp:Label>
                                                                                </font>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td bgcolor="#FFFFFF"  colspan="3" width="25%" align="center">
                                                                            <div align="left">
                                                                                <font class="blackfnt">Accounts</font>
                                                                            </div>
                                                                        </td>
                                                                        <td bgcolor="#FFFFFF"  colspan="3" width="75%"  align="center">
                                                                            <div align="left">
                                                                                <font class="blackfnt">
                                                                                    <asp:Label ID="lblAccount" runat="server" CssClass="blackfnt"></asp:Label>
                                                                                </font>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <br />
                                                                <% 
                                                                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                    //DataAccess DA = new DataAccess();
                                                                    //double debtBal = 0;
                                                                    //double crdbal=0;
                                                                    //System.Data.SqlClient.SqlDataReader dtr;                                                                        
                                                                    //string strStartVal = "", strEndVal = "";
                                                                    //string yearval = Session["strStartVal"].ToString();
                                                                    //string mClosedt = Request.QueryString["dateTo"];
                                                                    //string mindividual = Request.QueryString["strdlstTranType"].ToString();
                                                                    //string branch = Request.QueryString["branch"];
                                                                    //DropDownList dlFinYear = (DropDownList)Master.FindControl("dlstFinYear");
                                                                    //string mAcctOpenTable = "webx_acctopening_" + Session["YearVal"].ToString();
                                                                    //string mAcctTransTable = "webx_acctrans_" + Session["YearVal"].ToString();
                                                                    ////if (dlFinYear != null)
                                                                    ////{
                                                                    ////    yearval = dlFinYear.SelectedItem.Text;
                                                                    ////}
                                                                    //string info1 = yearval;
                                                                    //string[] arInfo1 = new string[1];
                                                                    //char[] splitter1 = { '-' };
                                                                    //arInfo1 = info1.Split(splitter1);
                                                                    //for (int x1 = 0; x1 < arInfo1.Length; x1++)
                                                                    //{
                                                                    //    strStartVal = arInfo1[0];
                                                                    //    //strEndVal = arInfo1[1];
                                                                    //}
                                                                    //string Det;
                                                                    //string mODate = "1 Apr " + strStartVal;
                                                                    //string mAcctOpenTable1 = "webx_acctopening_" + Session["YearVal"].ToString();
                                                                    //string mdateDetCls1 = " and convert(varchar,t.transdate,106) between convert(datetime,'" + mODate + "',106) and convert(datetime,'" + mClosedt + "',106)";
                                                                    //if (mindividual == "N")
                                                                    //{
                                                                    //    Det = "SELECT convert(varchar,sum(t.debit)) as debit,convert(varchar,sum(t.credit)) as credit from " + mAcctTransTable + " t where t.voucher_cancel='N' " + mdateDetCls1 + " and t.acccode='" + acccode + "'";
                                                                    //}
                                                                    //else
                                                                    //{
                                                                    //    string branchcls = " and t.brcd='" + branch + "'";
                                                                    //    Det = "SELECT convert(varchar,sum(t.debit)) as debit,convert(varchar,sum(t.credit)) as credit from " + mAcctTransTable + " t  where  t.voucher_cancel='N' " + branchcls + mdateDetCls1 + " and t.acccode='" + acccode + "'";
                                                                    //}

                                                                    //string tranDebit="";
                                                                    //string tranCredit="";
                                                                    //dtr = DA.getreader(Det);
                                                                    //while (dtr.Read())
                                                                    //{
                                                                    //    tranDebit = dtr["debit"].ToString();
                                                                    //    tranCredit = dtr["credit"].ToString();
                                                                    //}
                                                                    //dtr.Close();
                                                                    //double inttranDebit, inttranCredit;
                                                                    //inttranDebit = Convert.ToDouble(tranDebit);
                                                                    //inttranCredit = Convert.ToDouble(tranCredit);
                                                                    ////double debtBal, crdbal;
                                                                    //if (inttranCredit < inttranDebit)
                                                                    //{
                                                                    //    debtBal = (inttranDebit - inttranCredit);
                                                                    //}
                                                                    //else if (inttranDebit < inttranCredit)
                                                                    //{
                                                                    //    crdbal = (inttranCredit - inttranDebit);
                                                                    //}
                                                                    //////////////////////////////////////////////////////////////////////////////////////////////////////

                                                                    DateFunction DFun = new DateFunction();
                                                                    DataAccess DAccess = new DataAccess();
                                                                    AccountTrans tran = new AccountTrans();
                                                                    System.Data.SqlClient.SqlDataReader dtr;
                                                                    string branText1 = "";
                                                                    string acccode = Request.QueryString["strdlstSalesAmount"];
                                                                    string branText = Request.QueryString["branText"];
                                                                    string info1 = branText;
                                                                    string[] arInfo1 = new string[1];
                                                                    char[] splitter1 = { ':' };
                                                                    arInfo1 = info1.Split(splitter1);
                                                                    for (int x1 = 0; x1 < arInfo1.Length; x1++)
                                                                    {
                                                                        branText1 = arInfo1[0];
                                                                    }
                                                                    //string acccode = Request.QueryString["strdlstSalesAmount"]; ;
                                                                    string fromdate = Request.QueryString["dateFrom"].ToString();//Session["FinYearStart"].ToString();
                                                                    string toDate = Request.QueryString["dateTo"];
                                                                    DateTime dt = Convert.ToDateTime(DFun.returnmmddyyyy_format(fromdate));
                                                                    dt = dt.AddDays(-1);
                                                                    string new_Date_temp = dt.ToString("dd/MM/yyyy");
                                                                    string new_Date = DFun.return_date(new_Date_temp);
                                                                    string loccode = Request.QueryString["branch"];
                                                                    string YearVal = "";
                                                                    DropDownList mpLabel = (DropDownList)Master.FindControl("dlstFinYear");
                                                                    if (mpLabel != null)
                                                                    {
                                                                        YearVal = mpLabel.SelectedItem.Value;
                                                                    }
                                                                    string openTable = "webx_acctopening_" + YearVal;
                                                                    string transTable = "webx_acctrans_" + YearVal;
                                                                    string indiual = Request.QueryString["strdlstTranType"].ToString();

                                                                    string opening = "";
                                                                    string tranjaction = "";
                                                                    string all_tranDr = "", all_tranCr = "";
                                                                    string all_openDr = "", all_openCr = "";
                                                                    double transactionDr = 0;
                                                                    double transactionCr = 0;
                                                                    double openDr = 0, openCr = 0;
                                                                    //double total_Debit = 0;
                                                                    //double total_Crebit = 0;
                                                                    if (indiual == "N")
                                                                    {
                                                                        tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + " where Acccode= '" + acccode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) < convert(datetime, '" + fromdate + "' ,106)";
                                                                        opening = "select isNull(sum(opendebit),0.00) as opendebit,isNull(sum(opencredit),0.00) as opencredit from " + openTable + " where brcd= '" + loccode + " ' and acccode= '" + acccode + "' ";

                                                                        dtr = DAccess.getreader(tranjaction);
                                                                        while (dtr.Read())
                                                                        {
                                                                            all_tranDr = dtr["Debit"].ToString();
                                                                            all_tranCr = dtr["Credit"].ToString();
                                                                        }
                                                                        dtr.Close();
                                                                        if (Convert.ToDouble(all_tranDr) < Convert.ToDouble(all_tranCr))
                                                                        {
                                                                            transactionCr = Convert.ToDouble(all_tranCr) - Convert.ToDouble(all_tranDr);
                                                                        }
                                                                        else if (Convert.ToDouble(all_tranDr) > Convert.ToDouble(all_tranCr))
                                                                        {
                                                                            transactionDr = Convert.ToDouble(all_tranDr) - Convert.ToDouble(all_tranCr);
                                                                        }

                                                                        dtr = DAccess.getreader(opening);
                                                                        while (dtr.Read())
                                                                        {
                                                                            all_openDr = dtr["opendebit"].ToString();
                                                                            all_openCr = dtr["opencredit"].ToString();
                                                                        }
                                                                        dtr.Close();
                                                                        if (Convert.ToDouble(all_openDr) < Convert.ToDouble(all_openCr))
                                                                        {
                                                                            openCr = Convert.ToDouble(all_openCr) - Convert.ToDouble(all_openDr);
                                                                        }
                                                                        else if (Convert.ToDouble(all_openDr) > Convert.ToDouble(all_openCr))
                                                                        {
                                                                            openDr = Convert.ToDouble(all_openDr) - Convert.ToDouble(all_openCr);
                                                                        }
                                                                        total_Debit = transactionDr + openDr;
                                                                        total_Crebit = transactionCr + openCr;
                                                                    }
                                                                    else
                                                                    {
                                                                        tranjaction = "Select isNull(sum(Credit),0.00) as Credit,isNull(sum(Debit),0.00) as Debit from " + transTable + " where brcd= '" + loccode + " ' and  Acccode= '" + acccode + "' and Voucher_Cancel='N' and convert(varchar,transdate,106) < convert(datetime, '" + fromdate + "' ,106)";
                                                                        opening = "select isNull(sum(opencredit_i),0.00) as opencredit_i,isNull(sum(opendebit_i),0.00) as opendebit_i from " + openTable + " where brcd= '" + loccode + " ' and acccode= '" + acccode + "'";
                                                                        dtr = DAccess.getreader(tranjaction);
                                                                        while (dtr.Read())
                                                                        {
                                                                            all_tranDr = dtr["Debit"].ToString();
                                                                            all_tranCr = dtr["Credit"].ToString();
                                                                        }
                                                                        dtr.Close();
                                                                        if (Convert.ToDouble(all_tranDr) < Convert.ToDouble(all_tranCr))
                                                                        {
                                                                            transactionCr = Convert.ToDouble(all_tranCr) - Convert.ToDouble(all_tranDr);
                                                                        }
                                                                        else if (Convert.ToDouble(all_tranDr) > Convert.ToDouble(all_tranCr))
                                                                        {
                                                                            transactionDr = Convert.ToDouble(all_tranDr) - Convert.ToDouble(all_tranCr);
                                                                        }
                                                                        dtr = DAccess.getreader(opening);
                                                                        while (dtr.Read())
                                                                        {
                                                                            all_openDr = dtr["opendebit_i"].ToString();
                                                                            all_openCr = dtr["opencredit_i"].ToString();
                                                                        }
                                                                        dtr.Close();
                                                                        if (Convert.ToDouble(all_openDr) < Convert.ToDouble(all_openCr))
                                                                        {
                                                                            openCr = Convert.ToDouble(all_openCr) - Convert.ToDouble(all_openDr);
                                                                        }
                                                                        else if (Convert.ToDouble(all_openDr) > Convert.ToDouble(all_openCr))
                                                                        {
                                                                            openDr = Convert.ToDouble(all_openDr) - Convert.ToDouble(all_openCr);
                                                                        }
                                                                        total_Debit = transactionDr + openDr;
                                                                        total_Crebit = transactionCr + openCr;
                                                                    }

                                                                    //string bal = tran.getOpeningBalance_onlyValue(acccode, fromdate, new_Date, loccode, openTable, transTable, indiual);
                                                                    //string bal = "";
                                                                    string DRCR = tran.getOpeningBalance_DRCR(acccode, fromdate, new_Date, loccode, openTable, transTable, indiual);

                                                                %>
                                                                <table  border="0" cellpadding="3" cols="1" width="98%" bgcolor="#808080" cellspacing="0"
                                                                    class="boxbg">
                                                                    <tr bgcolor="white"><td colspan="6">
                                                                    <%--<asp:Table ID="tab" runat="server">--%> 
                                                                    <table  border="1"  cellpadding="3"  width="100%"  cellspacing="0">
                                                                        
                                                                        <tr bgcolor="white">
                                                                            <td align="center" width="3%">
                                                                                <font class="blackfnt"><b>Sl.</b></font></td>
                                                                            <td align="center" width="18%">
                                                                                <font class="blackfnt"><b>Voucher No.</b></font></td>
                                                                            <td align="center" width="7%">
                                                                                <font class="blackfnt"><b>Date</b></font></td>
                                                                            <td align="center" width="15%">
                                                                                <font class="blackfnt"><b>Particular</b></font></td>
                                                                            <td align="right" width="7%">
                                                                                <font class="blackfnt"><b>Debit</b></font></td>
                                                                            <td align="right" width="7%">
                                                                                <font class="blackfnt"><b>Credit</b></font></td>
                                                                            <td align="center" width="22%">
                                                                                <font class="blackfnt"><b>Party</b></font></td>
                                                                            <td align="center" width="19%">
                                                                                <font class="blackfnt"><b>Narration</b></font></td>
                                                                        </tr>
                                                                    <%--</table>
                                                                    </td></tr>
                                                                    <tr bgcolor="white"><td>
                                                                    <table border="0" cellpadding="3" cols="1" width="98%" bgcolor="#808080" cellspacing="1"
                                                                        class="boxbg">--%>
                                                                        <tr bgcolor="white">
                                                                            <td align="left" colspan="8">
                                                                                <font class="blackfnt"><b>Account :
                                                                                    <asp:Label ID="lblbrantext" runat="server"></asp:Label>
                                                                                    <%--<%= branText1%>--%>
                                                                                </b></font>
                                                                            </td>
                                                                        </tr>
                                                                        <tr bgcolor="white">
                                                                            <td align="center" width="3%">
                                                                            </td>
                                                                            <td width="40%" align="left" colspan="3">
                                                                                <font class="blackfnt"><b>Opening Balance :</b></font></td>
                                                                            <%
                                                                                if (DRCR == "Dr")
                                                                                {

                                                                                    //double totalDr = Convert.ToDouble(bal);
                                                                                    DebitBal = string.Format("{0:0.00}", total_Debit).ToString();
                                                                                    CreditBal = string.Format("{0:0.00}", total_Crebit).ToString();
                                                                            %>
                                                                            <td align="right" width="7%">
                                                                                <font class="blackfnt"><b>
                                                                                    <%=DebitBal%>
                                                                                </b></font>
                                                                            </td>
                                                                            <td align="right" width="7%">
                                                                                <font class="blackfnt"><b>
                                                                                    <%=CreditBal%>
                                                                                </b></font>
                                                                            </td>
                                                                            <%
                                                                                }
                                                                            %>
                                                                            <%
                                                                                if (DRCR == "Cr")
                                                                                {
                                                                                    string DebitBal = string.Format("{0:0.00}", total_Debit).ToString();
                                                                                    string CreditBal = string.Format("{0:0.00}", total_Crebit).ToString();
                                                                                    //double totalCR = Convert.ToDouble(bal);
                                                                                    //string bal3 = string.Format("{0:.00}", totalCR).ToString();
                                                                            %>
                                                                            <td align="right" width="7%">
                                                                                <font class="blackfnt"><b>
                                                                                    <%=DebitBal%>
                                                                                </b></font>
                                                                            </td>
                                                                            <td align="right" width="7%">
                                                                                <font class="blackfnt"><b>
                                                                                    <%=CreditBal%>
                                                                                </b></font>
                                                                            </td>
                                                                            <%
                                                                                }
                                                                            %>
                                                                            <td align="center" width="22%">
                                                                                <font class="blackfnt">&nbsp;</font></td>
                                                                            <td align="center" width="19%">
                                                                            </td>
                                                                        </tr>
                                                                    <%--</table>
                                                                    </td></tr>--%>
                                                                    <asp:Repeater ID="RepeaterTran" runat="server">
                                                                        <ItemTemplate>
                                                                            <table border="0" cellpadding="3" width="98%" bgcolor="#808080" cellspacing="1" class="boxbg">
                                                                                <tr bgcolor="white">
                                                                                    <td align="center" width="3%" height="25px">
                                                                                        <font class="blackfnt">
                                                                                            <%# Container.ItemIndex+1 %>
                                                                                        </font>
                                                                                    </td>
                                                                                    <td align="center" width="18%" height="25px">
                                                                                        <font class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "voucherno")%>
                                                                                            &nbsp;</font></td>
                                                                                    <td align="center" width="7%" height="25px">
                                                                                        <font class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "transdate1")%>
                                                                                            &nbsp;</font></td>
                                                                                    <td align="left" width="15%" height="25px">
                                                                                        <font class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "oppaccount")%>
                                                                                            &nbsp;</font></td>
                                                                                    <td align="right" width="7%" height="25px">
                                                                                        <font class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "debit")%>
                                                                                            &nbsp;</font></td>
                                                                                    <td align="right" width="7%" height="25px">
                                                                                        <font class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "credit")%>
                                                                                            &nbsp;</font></td>
                                                                                    <td align="left" width="22%" height="25px">
                                                                                        <font class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "PROV")%>
                                                                                            &nbsp;</font></td>
                                                                                    <td align="left" width="19%" height="25px">
                                                                                        <font class="blackfnt">
                                                                                            <%#DataBinder.Eval(Container.DataItem, "narration")%>
                                                                                            &nbsp;</font></td>
                                                                                </tr>
                                                                            </table>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>
                                                                    <%--<tr bgcolor="white"><td>
                                                                    <table border="0" cellpadding="3" cols="1" width="98%" bgcolor="#808080" cellspacing="1"
                                                                        class="boxbg">--%>
                                                                         <tr bgcolor="white"> 
                                                                            <td align="center" width=3%><font class=blackfnt><b></b></font></td>
                                                                            <td align="left" width=40% colspan="3" ><font class=blackfnt><b>Total Transaction : 
                                                                            <asp:Label ID="lblMonth" runat="server"></asp:Label></b></font></td>
                                                                            <td align="right" width=7%><font class=blackfnt><b>
                                                                            <asp:Label ID="lblTotalDebit" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                            <td align="right" width=7%><font class=blackfnt><b>
                                                                            <asp:Label ID="lbltotalCredit" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                            <td align="center" width=22%><font class=blackfnt><b></b></font></td>
                                                                            <td align="center" width=19%><font class=blackfnt><b></b></font></td>
                                                                        </tr>
                                                                        <%--<tr bgcolor="white"> 
<td align="center" width=3%><font class=blackfnt><b></b></font></td>
<td align="left" width=40% ><font class=blackfnt><b>Closing balance for the Month : 
<asp:Label ID="Label1" runat="server"></asp:Label></b></font></td>
<td align="right" width=7%><font class=blackfnt><b>
<asp:Label ID="lblCDebit" runat="server" Text="0.00"></asp:Label></b></font></td>
<td align="right" width=7%><font class=blackfnt><b>
<asp:Label ID="lblCCredit" runat="server" Text="0.00"></asp:Label></b></font></td>
<td align="center" width=41%><font class=blackfnt><b></b></font></td>
</tr>--%>
                                                                        <tr bgcolor="white">
                                                                            <td align="center" width="3%">
                                                                                <font class="blackfnt"><b></b></font>
                                                                            </td>
                                                                            <td align="left" width="40%" colspan="3">
                                                                                <font class="blackfnt"><b>Total for A/C (Dr./Cr.) :
                                                                                    <asp:Label ID="Label2" runat="server"></asp:Label></b></font></td>
                                                                            <td align="right" width="7%">
                                                                                <font class="blackfnt"><b>
                                                                                    <asp:Label ID="lblTotalDebitAC" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                            <td align="right" width="7%">
                                                                                <font class="blackfnt"><b>
                                                                                    <asp:Label ID="lblTotalCridetAC" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                            <td align="center" width="22%">
                                                                                <font class="blackfnt"><b></b></font>
                                                                            </td>
                                                                            <td align="center" width="21%">
                                                                                <font class="blackfnt"><b></b></font>
                                                                            </td>
                                                                        </tr>
                                                                        <tr bgcolor="white"> 
<td align="center" width=3%><font class=blackfnt><b></b></font></td>
<td align="left" width=41% colspan="3"><font class=blackfnt><b>Closing Balance : 
<asp:Label ID="Label3" runat="server"></asp:Label></b></font></td>
<td align="right" width=7%><font class=blackfnt><b>
<asp:Label ID="lblCloD" runat="server" Text="0.00"></asp:Label></b></font></td>
<td align="right" width=7%><font class=blackfnt><b>
<asp:Label ID="lblCloC" runat="server" Text="0.00"></asp:Label></b></font></td>
<td align="center" width=22%><font class=blackfnt><b></b></font></td>
<td align="center" width=21%><font class=blackfnt><b></b></font></td>
</tr>

                                                                    </table>
                                                                    </td></tr>
                                                               </table>
                                                            </center>
                                                        </div>
                                                    </center>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>                                    
                                </td>
                            </tr>
                        </table>    
                    </td>
                </tr>
                <tr bgcolor="white"><td>
                    <table border="0" cellpadding="3" width="98%" bgcolor="#808080" cellspacing="0" class="boxbg">
                        <tr bgcolor="white">
                            <td colspan="6" align="center"><asp:Button ID="downloadXLS" runat="Server" Text="Download XLS" OnClick="BtnDownload_clicked"/></td>
                        </tr>
                    </table>
                </td></tr>
        </table>
        
    </div>
    
</asp:Content>
