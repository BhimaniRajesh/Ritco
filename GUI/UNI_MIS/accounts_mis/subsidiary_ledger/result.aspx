<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_subsidiary_ledger_Result" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="resultpg" runat="server">
    <div align="left">
        <table width="1000" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr align="left">
                <td align="left" style="height: 30px"></td>
                <%--<tr>
                    <td class="horzblue"><img src="../../../images/clear.gif" width="2" height="1"></td>--%>
            </tr>
            <tr>
                <td><img src="../../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../../images/back.gif" border="0"></a></td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="39%" valign="top">
                                <table id="table" runat="server" width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td height="300" valign="top">
                                            <!--START-->
                                            <br>
                                            
                                            <div align="center">
                                                <center>
                                                    <div align="center">
                                                        <center>
                                                        
                                                            <table id="table1" runat="server" border="1" width="500">
                                                                <tr>
                                                                    
                                                                    <td width="25%" bgcolor="#FFFFFF" align="left" colspan="2">
                                                                        <font class="blackfnt">Branch / Profit Center </font>
                                                                    </td>
                                                                    <td width="25%" bgcolor="#FFFFFF" align="left">
                                                                        <font class="blackfnt">
                                                                            <asp:Label ID="lblBran" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </font>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    
                                                                    <td bgcolor="#FFFFFF" width="25%" align="center" colspan="2">
                                                                        <div align="left">
                                                                            <font class="blackfnt">Date Range </font>
                                                                        </div>
                                                                    </td>
                                                                    <td bgcolor="#FFFFFF" width="75%" align="center">
                                                                        <div align="left">
                                                                            <font class="blackfnt">
                                                                                <asp:Label ID="lblDate_Range" runat="server" CssClass="blackfnt"></asp:Label>
                                                                            </font>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    
                                                                    <td bgcolor="#FFFFFF" width="25%" align="center" colspan="2">
                                                                        <div align="left">
                                                                            <font class="blackfnt">Accounts</font>
                                                                        </div>
                                                                    </td>
                                                                    <td bgcolor="#FFFFFF" width="75%" align="center">
                                                                        <div align="left">
                                                                            <font class="blackfnt">
                                                                                <asp:Label ID="lblAccount" runat="server" CssClass="blackfnt"></asp:Label>
                                                                            </font>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    
                                                                    <td align="left" bgcolor="#ffffff" width="25%" colspan="2">
                                                                       <font class="blackfnt">
                                                                           <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="Label"></asp:Label></font></td>
                                                                    <td align="left" bgcolor="#ffffff" width="75%">
                                                                        <asp:Label ID="lblCustomer" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                </tr>
                                                                
                                                            </table>
                                                            <br />
                                                                <asp:Repeater ID="rpt" runat="server">
                                                                        <HeaderTemplate>
                                                                            <table  border=1 cellpadding=3 cols=1 width="98%">
                                                                                <tr bgcolor="white"> 
                                                                                  <td align="center" width=3%><font class=blackfnt><b>Sl.</b></font></td>
                                                                                  <td align="center" width=18%><font class=blackfnt><b>Voucher No.</b></font></td>
                                                                                  <td align="center" width=7%><font class=blackfnt><b>Date</b></font></td>
                                                                                  <td align="center" width=15%><font class=blackfnt><b>Particular</b></font></td>
	                                                                              <td align="center" width=7%><font class=blackfnt><b>Debit</b></font></td>
                                                                                  <td align="center" width=7%><font class=blackfnt><b>Credit</b></font></td>
                                                                                  <td align="center" width=22%><font class=blackfnt><b>Party</b></font></td>
		                                                                          <td align="center" width=18%><font class=blackfnt><b>Narration</b></font></td>
                                                                                </tr>
                                                                            </table>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                             <table  border=1 cellpadding=3 cols=1 width="98%">
                                                                                <tr bgcolor="white"> 
                                                                                  <td align="left"  colspan="8"><font class=blackfnt><b>Account : <%#DataBinder.Eval(Container.DataItem, "accdesc")%></b></font></td>
                                                                                </tr>
                                                                                <tr bgcolor="white"> 
                                                                                  <td align="center" width=3%></td>
                                                                                  <td align="left" colspan="3" width="40%"><font class=blackfnt><b>Opening Balance :</b></font></td>
	                                                                              <td align="right" width=7%><font class=blackfnt><b><%#DataBinder.Eval(Container.DataItem, "opendebit")%></b></font></td>
                                                                                  <td align="right" width=7%><font class=blackfnt><b><%#DataBinder.Eval(Container.DataItem, "opencredit")%></b></font></td>
                                                                                  <td align="center" width=22%><font class=blackfnt>&nbsp;</font></td>
		                                                                          <td align="center" width=18%></td>
                                                                                </tr>
                                                                                <%--<tr bgcolor="white"> 
                                                                                  <td align="center" width=3%><font class=blackfnt><b></b></font></td>
                                                                                  <td align="left" width=40% colspan="3" ><font class=blackfnt><b>Total for the Month : 
                                                                                      <asp:Label ID="lblMonth" runat="server"></asp:Label></b></font></td>
	                                                                              <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblTotalDebit" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                                  <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lbltotalCredit" runat="server" Text="0.00"></asp:Label></b></font></td>
		                                                                          <td align="center" width=40% colspan="2"><font class=blackfnt><b></b></font></td>
		                                                                          
                                                                                </tr>
                                                                                
                                                                                 <tr bgcolor="white"> 
                                                                                  <td align="center" width=3%><font class=blackfnt><b></b></font></td>
                                                                                  <td align="left" width=40% colspan="3"><font class=blackfnt><b>Closing balance for the Month : 
                                                                                      <asp:Label ID="Label1" runat="server"></asp:Label></b></font></td>
	                                                                              <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblCDebit" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                                  <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblCCredit" runat="server" Text="0.00"></asp:Label></b></font></td>
		                                                                          <td align="center" width=41% colspan="2"><font class=blackfnt><b></b></font></td>
                                                                                </tr>
                                                                                
                                                                                <tr bgcolor="white"> 
                                                                                  <td align="center" width=3%><font class=blackfnt><b></b></font></td>
                                                                                  <td align="left" width=40% colspan="3"><font class=blackfnt><b>Total for A/C : 
                                                                                      <asp:Label ID="Label2" runat="server"></asp:Label></b></font></td>
	                                                                              <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblTotalDebitAC" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                                  <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblTotalCridetAC" runat="server" Text="0.00"></asp:Label></b></font></td>
		                                                                          <td align="center" width=41% colspan="2"><font class=blackfnt><b></b></font></td>
                                                                                </tr>
                                                                            
                                                                            <tr bgcolor="white"> 
                                                                                  <td align="center" width=3%><font class=blackfnt><b></b></font></td>
                                                                                  <td align="left" width=40% colspan="3"><font class=blackfnt><b>Closing Balance : 
                                                                                      <asp:Label ID="Label3" runat="server"></asp:Label></b></font></td>
	                                                                              <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblCloD" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                                  <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblCloC" runat="server" Text="0.00"></asp:Label></b></font></td>
		                                                                          <td align="center" width=41% colspan="2"><font class=blackfnt><b></b></font></td>
                                                                                </tr>--%>
                                                                            </table>
                                                                            
                                                                        </ItemTemplate>
                                                                        </asp:Repeater>
                                                                <asp:Repeater ID="RepeaterTran" runat="server">
                                                                        <ItemTemplate>
                                                                             <table border=1 cellpadding="3"  width="98%">
                                                                                <tr bgcolor="white"> 
                                                                                  <td align="center" width=3% height="25px"><font class=blackfnt><%# Container.ItemIndex+1 %></font></td>
                                                                                  <td align="center" width=18% height="25px"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "voucherno")%>&nbsp;</font></td>
                                                                                  <td align="center" width=7% height="25px"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "transdate1")%>&nbsp;</font></td>
                                                                                  <td align="left" width=15% height="25px"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "oppaccount")%>&nbsp;</font></td>
	                                                                              <td align="right" width=7% height="25px"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "debit")%>&nbsp;</font></td>
                                                                                  <td align="right" width=7% height="25px"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "credit")%>&nbsp;</font></td>
                                                                                  <td align="left" width=22% height="25px"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "PROV")%>&nbsp;</font></td>
		                                                                          <td align="left" width=18% height="25px"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "narration")%>&nbsp;</font></td>
                                                                                </tr>
                                                                            </table>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>
                                                                    <table id="table2" runat="server" border=1 cellpadding=3 cols=1 width="98%">
                                                                                <tr bgcolor="white"> 
                                                                                  <td align="center" width=3%><font class=blackfnt><b></b></font></td>
                                                                                  <td align="left" width=40% colspan="3" ><font class=blackfnt><b>Total for the Month : 
                                                                                      <asp:Label ID="lblMonth" runat="server"></asp:Label></b></font></td>
	                                                                              <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblTotalDebit" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                                  <td align="right" width=7%><font class=blackfnt><b>
                                                                                      <asp:Label ID="lbltotalCredit" runat="server" Text="0.00"></asp:Label></b></font></td>
		                                                                          <td align="center" width=40% colspan="2"><font class=blackfnt><b></b></font></td>
		                                                                          
                                                                                </tr>
                                                                                
                                                                                 <tr bgcolor="white"> 
                                                                                  <td align="center" ><font class=blackfnt><b></b></font></td>
                                                                                  <td align="left"  colspan="3"><font class=blackfnt><b>Closing balance for the Month : 
                                                                                      <asp:Label ID="Label1" runat="server"></asp:Label></b></font></td>
	                                                                              <td align="right" ><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblCDebit" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                                  <td align="right" ><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblCCredit" runat="server" Text="0.00"></asp:Label></b></font></td>
		                                                                          <td align="center"  colspan="2"><font class=blackfnt><b></b></font></td>
                                                                                </tr>
                                                                                
                                                                                <tr bgcolor="white"> 
                                                                                  <td align="center" ><font class=blackfnt><b></b></font></td>
                                                                                  <td align="left"  colspan="3"><font class=blackfnt><b>Total for A/C : 
                                                                                      <asp:Label ID="Label2" runat="server"></asp:Label></b></font></td>
	                                                                              <td align="right" ><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblTotalDebitAC" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                                  <td align="right" ><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblTotalCridetAC" runat="server" Text="0.00"></asp:Label></b></font></td>
		                                                                          <td align="center"  colspan="2"><font class=blackfnt><b></b></font></td>
                                                                                </tr>
                                                                            
                                                                            <tr bgcolor="white"> 
                                                                                  <td align="center" ><font class=blackfnt><b></b></font></td>
                                                                                  <td align="left"  colspan="3"><font class=blackfnt><b>Closing Balance : 
                                                                                      <asp:Label ID="Label3" runat="server"></asp:Label></b></font></td>
	                                                                              <td align="right" ><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblCloD" runat="server" Text="0.00"></asp:Label></b></font></td>
                                                                                  <td align="right" ><font class=blackfnt><b>
                                                                                      <asp:Label ID="lblCloC" runat="server" Text="0.00"></asp:Label></b></font></td>
		                                                                          <td align="center"  colspan="2"><font class=blackfnt><b></b></font></td>
                                                                                </tr>
                                                                            </table>
                                                     </center></div></center></div></td></tr>
                                </table>
                                <br />                          
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

