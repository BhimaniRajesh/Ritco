<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="MR_Cancellation_1.aspx.cs" Inherits="GUI_Finance_MR_cancel_MR_Cancellation_1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <script type="text/javascript" language="javascript" src="../../../../GUI/images/CalendarPopup.js"></script>
    <script language=javascript type="text/javascript" >
        function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    
    <asp:UpdatePanel ID="UP1" runat="Server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 70%; height: 263px;" border="0">       
                <tr align="center">
                    <td style="height: 324px" align="center" colspan="3">
                        <table cellspacing="1" style="width: 90%" class="boxbg" border="0"> 
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Enter MR For Cancellation 
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left" style="height: 25px; width: 100px;">
                                    <asp:Label ID="lbl"  CssClass="blackfnt" Text="MR No :" runat="server" Width="102px"></asp:Label>    
                                </td>
                                <td align="left" style="height: 25px; width: 100px;">
                                    <asp:TextBox ID="txtmr" runat="server"></asp:TextBox>
                                </td>
                                
                                <td align="left" valign="top" style="height: 25px"> 
                                    <asp:Button  ID="submit2"   runat="server" OnClick="submit2_Click" Text="Submit"/>
                                </td>
                             <tr style="background-color: white">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="Label1" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        OR
                                    </asp:Label>
                                </td>
                             </tr>
                             <tr style="background-color: white">
                                <td align="left" style="height: 25px; width: 100px;">
                                    <asp:Label ID="Label9"  CssClass="blackfnt" Text="Docket No :" runat="server" Width="102px"></asp:Label>    
                                </td>
                       
                                <td align="left" style="height: 25px; width: 100px;">
                                    <asp:TextBox ID="txtdoc" runat="server"></asp:TextBox>
                                </td>
                                
                                <td align="left"  valign="top" style="height: 25px"> 
                                    <asp:Button  ID="Button2"   runat="server" OnClick="submit3_Click" Text="Submit"/>
                                </td>
                               
                             </tr>
                             <tr style="background-color: white">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="Label8" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        OR
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="Label2" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select MR For Cancellation 
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left" style="height: 25px; width: 100px;">
                                    <asp:Label ID="Label3"  CssClass="blackfnt" Text="Enter Customer :" runat="server" Width="102px"></asp:Label>    
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtcust" runat="server"></asp:TextBox>
                                    <asp:Label ID="Label7" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                    Width="14px"></asp:Label>
                                </td>
                                <td align="left" valign="top"> </td>
                             </tr>
                             <tr style="background-color: white">
                                <td align="left" style="height: 25px; width: 100px;">
                                    <asp:Label ID="Label4"  CssClass="blackfnt" Text="MR Type :" runat="server" Width="102px"></asp:Label>    
                                </td>
                                <td align="left" colspan="2" style="height: 25px; width: 100px;">
                                    <asp:DropDownList ID="ddlmrtype" runat="server">
                                        <asp:ListItem Value="0">All</asp:ListItem>
                                        <asp:ListItem Value="1">Paid</asp:ListItem>
                                        <asp:ListItem Value="3">To Pay</asp:ListItem>
                                        <%--<asp:ListItem Value="4">Misc.</asp:ListItem>--%>
                                        <asp:ListItem Value="4">OCTROI</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                             </tr>
                             <tr class="bgbluegrey">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="Label5" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select MR Generation Date Range  
                                    </asp:Label>       
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td valign="top" align ="left">
                                    <asp:Label ID="Label6"  CssClass="blackfnt" Text="Select Login Date" runat="server" Width="145px"></asp:Label>    
                                </td>
                                <td  align="left" style="width: 359px" valign="top">
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1" Width="244px">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList></td>
                                                        
                                <td valign="top" align="left" style="width: 359px">
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDateFrom, 'alnkDateFrom', 'dd/MM/yyyy'); return false;" id="alnkDateFrom">
                                    <img src="../../images/calendar.jpg" border="0" alt="" /></a>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDateTo, 'alnkDateFrom', 'dd/MM/yyyy'); return false;" id="a1">
                                    <img src="../../images/calendar.jpg" border="0" alt="" />
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only" OnServerValidate="daterange"></asp:CustomValidator>
                                                           <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
                                                                ErrorMessage="Date From Can Not Be Blank"></asp:RequiredFieldValidator>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
                                                                ErrorMessage="Date To Can Not Be Blank"></asp:RequiredFieldValidator>--%></td>
                              </tr>
                             </td>
                           </tr>
                           <tr style="background-color: white">
                             <td colspan="4">    
                                <asp:Button  ID="Button1"   runat="server" OnClick="submit1_Click" Text="Submit"/>
                             </td>
                           </tr>
                         </table>
                         <div id="divDate" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
                       </ContentTemplate>
                     </asp:UpdatePanel>
                
               </asp:Content>
