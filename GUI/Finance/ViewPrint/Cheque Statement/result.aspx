<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_chequemgt_result" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="cheque_result" runat="server">
<script language="javascript" type="text/javascript">
    function popup(obj)
    {
        //alert(objval.value)
        //debugger;
        var txt = obj.value;
        var FrmChild = window.open('popup-usage.aspx?id='+ txt + ',myWindow,height=285,width=800,resizable=yes,scrollbars=yes,left=310,top=15'); 
	       
        return false;
    }
</script>

<script language="javascript" type="text/javascript">
    
        function ViewPrint(arg1,arg2)
        {
            window.open("popup-usage.aspx?id=" + arg1 + "&mode=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        
    </script>
    <table width="75%" border="0"> 
        <tr>
            <td width="100%" align="right">
                <a href="Issuecheque_viewstep1.aspx">
                <img alt="back" src="../../../images/back.gif" border="0" /></a></td>
        </tr>
    </table>
    
    <table width="75%" border="0"> 
        <tr>
            <td width="10%">
            </td>
            <td width="90%" align="center" >
                <table>
                    <tr>
                        <td><font class="blackfnt"><strong>You Selected</strong></font></td>
                    </tr>
                </table>
                <br />
                <table runat="server" id="table1" border="0" style="display : none" cellpadding="1" cellspacing="1" class="boxbg" width="60%">
                    <tr bgcolor="white">
                        <td width="40%" align="left"><font class="blackfnt">&nbsp;<asp:Label ID="Label1" runat="server"></asp:Label></font></td>
                        <td width="60%" align="left"><font class="blackfnt">&nbsp;<asp:Label ID="lblEntryDate" runat="server"></asp:Label></font></td>
                    </tr>
                    <tr bgcolor="white">
                        <td width="40%" align="left"><font class="blackfnt">&nbsp;<asp:Label ID="Label2" runat="server" ></asp:Label></font></td>
                        <td width="60%" align="left"><font class="blackfnt">&nbsp;<asp:Label ID="lblParty" runat="server"></asp:Label></font></td>
                    </tr>
                    <tr bgcolor="white">
                        <td width="40%" align="left"><font class="blackfnt">&nbsp;<asp:Label ID="Label3" runat="server" ></asp:Label></font></td>
                        <td width="60%" align="left"><font class="blackfnt">&nbsp;<asp:Label ID="lblCS" runat="server"></asp:Label></font></td>
                    </tr>
                    <tr bgcolor="white">
                        <td width="40%" align="left"><font class="blackfnt">&nbsp;<asp:Label ID="Label4" runat="server"></asp:Label></font></td>
                        <td width="60%" align="left"><font class="blackfnt">&nbsp;<asp:Label ID="lblChqAmtStatus" runat="server"></asp:Label></font></td>
                    </tr>
                </table>
                <br />
                <table border="0" cellpadding="0" cellspacing="0" width="90%">
                    <tr>
                        <td>
                            <asp:DataGrid ID="myGrid" runat="server" AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="blackfnt" ShowFooter="True" OnItemDataBound="myGrid_ItemDataBound">
                                <FooterStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" />
                                <HeaderStyle BackColor="#D4E0E7" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" />
                                <Columns>
                                  <%-- <asp:TemplateColumn HeaderText="View Usage">
                                        <ItemTemplate>
                                            <input name="chk" type="radio" onclick="popup(this);" value='<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>' >
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>--%>
                                    <asp:TemplateColumn HeaderText="Cheque Number">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CHQNO") %>' ID="txt"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:BoundColumn DataField="CHQDTT" HeaderText="Cheque date">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="CHQAMT" HeaderText="Cheque Amount (A)">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="Issued_from" HeaderText="Issued from">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="PTMSPTNM" HeaderText="Issued to">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="BRCDLOC" HeaderText="Entry Location">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                   <%-- <asp:BoundColumn DataField="Entrydt" HeaderText="Entry Date">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>--%>
                                     <asp:TemplateColumn HeaderText="View & Print">
                                        <ItemTemplate>
                                         <a href="javascript:ViewPrint('<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>',0)">View</a> | <a href="javascript:ViewPrint('<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>',1)">Print</a>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="false" />
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                            
                            
                            <asp:DataGrid ID="DataGrid1" runat="server" AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="blackfnt" OnItemDataBound="DataGrid1_ItemDataBound" ShowFooter="True" Width="100%">
                            <FooterStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" />
                                <HeaderStyle BackColor="#D4E0E7" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" />
                                     <Columns>
                                      <%--<asp:TemplateColumn HeaderText="View Usage">
                                        <ItemTemplate>
                                            <input name=chk type=radio onclick="popup(this);" value='<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>' >
                                            
                                        </ItemTemplate>
                                    </asp:TemplateColumn>--%>
                                    
                                    <asp:BoundColumn DataField="CHQNO" HeaderText="Cheque Number">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="CHQDTT" HeaderText="Cheque date">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="CHQAMT" HeaderText="Cheque Amount (A)">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                         <asp:BoundColumn DataField="ADJUSTAMT" HeaderText="Accounted amount (B)">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:BoundColumn DataField="Unaccounted" HeaderText="Unaccounted amount (C=A-B)">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                    <asp:BoundColumn DataField="PTMSPTNM" HeaderText="Received from">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="DEPOFLAG" HeaderText="Cheque Status">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                         <asp:BoundColumn DataField="transdate" HeaderText="Deposit Date">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:BoundColumn DataField="voucherNo" HeaderText="Voucher No.">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:BoundColumn DataField="brcd" HeaderText="Entry Location">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:BoundColumn DataField="Entrydt" HeaderText="Entry Date">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:TemplateColumn HeaderText="View & Print">
                                        <ItemTemplate>
                                         <a href="javascript:ViewPrint('<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>',0)">View</a> | <a href="javascript:ViewPrint('<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>',1)">Print</a>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="false" />
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                            <asp:DataGrid ID="DataGrid2" runat="server" AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="1" CellSpacing="1" CssClass="blackfnt" OnItemDataBound="DataGrid1_ItemDataBound" ShowFooter="True" Width="100%">
                            <FooterStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" />
                                <HeaderStyle BackColor="#D4E0E7" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" />
                                     <Columns>
                                   <%-- <asp:TemplateColumn HeaderText="View Usage">
                                        <ItemTemplate>
                                            <input name=chk type=radio onclick="popup(this);" value='<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>' >
                                        </ItemTemplate>
                                    </asp:TemplateColumn>--%>
                                    
                                    <asp:BoundColumn DataField="CHQNO" HeaderText="Cheque Number">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="CHQDTT" HeaderText="Cheque date">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="CHQAMT" HeaderText="Cheque Amount (A)">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                         <asp:BoundColumn DataField="ADJUSTAMT" HeaderText="Accounted amount (B)">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:BoundColumn DataField="Unaccounted" HeaderText="Unaccounted amount (C=A-B)">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                    <asp:BoundColumn DataField="PTMSPTNM" HeaderText="Received from">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="DEPOFLAG" HeaderText="Cheque Status">
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:BoundColumn>
                                         <asp:BoundColumn DataField="transdate" HeaderText="Deposit Date">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:BoundColumn DataField="voucherNo" HeaderText="Voucher No.">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:BoundColumn DataField="Location" HeaderText="Location">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:BoundColumn DataField="Entrydt" HeaderText="Entry Date">
                                             <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                             <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                 Font-Underline="False" Wrap="False" />
                                         </asp:BoundColumn>
                                         <asp:TemplateColumn HeaderText="View & Print">
                                        <ItemTemplate>
                                         <a href="javascript:ViewPrint('<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>',0)">View</a> | <a href="javascript:ViewPrint('<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDTT")  %>',1)">Print</a>
                                        </ItemTemplate>
                                        <HeaderStyle Wrap="false" />
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

</asp:Content>
