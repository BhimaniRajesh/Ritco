<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoadingSheetSummaryList.aspx.cs" Inherits="GUI_Operations_LoadingSheet_ViewPrint_LoadingSheetSummaryList" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Loading Sheet View</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    
<br /><br />
<div align="center" style="width:10in">

<br />
                      <%--      SELECTION CRITERIA--%>

        <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="100%">
            <tr>
                <td align="right" style="width:50%" bgcolor="#ffffff" class="blackfnt"></td>
                <td bgcolor="#ffffff" style="width:50%" class="blackfnt">
                    <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="100%">
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td align="left" style="width:50%">LS No.</td>
                            <td align="left" class="bluefnt">
                                <asp:Label runat="server" Font-Bold="true" ID="lbllsno"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td align="left" style="width:50%">LS Date.</td>
                            <td align="left" class="bluefnt">
                                <asp:Label runat="server" Font-Bold="true" ID="lbldate"></asp:Label>
                            </td>
                        </tr>
                     </table>
                  </td>
             </tr>
                                <%--EMPTY ROW--%>
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td bgcolor="#ffffff" colspan="2" class="blackfnt">&nbsp;</td>
                        </tr>
                        
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td bgcolor="#ffffff" align="left" height="10px" style="vertical-align:middle;" class="blackfnt"><font face="verdana" size="3"><b>Loading Sheet</b></font></td>
                            <td bgcolor="#ffffff" align="left" class="blackfnt">LS Location
                                <asp:Label runat="server" CssClass="bluefnt" Font-Bold="true" ID="lbllsloc"></asp:Label>
                            </td>
                        </tr>
                        
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td bgcolor="#ffffff" align="center" colspan="2" class="blackfnt"><b>Loading Sheet Summary</b></td>
                        </tr>
                        
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td bgcolor="#ffffff" colspan="2" class="blackfnt">&nbsp;</td>
                        </tr>
                        
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td bgcolor="#ffffff" colspan="2" class="blackfnt">
                                <table align="center" bgcolor="#808080" class="boxbg" cellspacing="1" width="100%">
                                <tr bgcolor="#ffffff" class="blackfnt">
                                    <td align="left" style="width:25%">Vehicle No.</td>
                                    <td align="left" style="width:25%"> 
                                        <asp:Label runat="server" CssClass="bluefnt" Font-Bold="true" ID="lblvehno"></asp:Label>
                                    </td>
                                    <td align="left" style="width:25%">Route .</td>
                                    <td align="left" style="width:25%"> 
                                        <asp:Label runat="server" CssClass="bluefnt" Font-Bold="true" ID="lblroute"></asp:Label>
                                    </td>
                                </tr>
                                </table>
                            </td>    
                        </tr>
                        
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td bgcolor="#ffffff" colspan="2" class="blackfnt">&nbsp;</td>
                        </tr>
                        
                        
                         <tr bgcolor="#ffffff" class="blackfnt">
                            <td bgcolor="#ffffff" colspan="2" class="blackfnt">
                            
                                <%--LIST OF LOADING SHEET BEGINS--%>
                            
                            
                            
                                 
            <asp:GridView align="center" ID="gvlslist" runat="server" BorderWidth="0" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                            OnSelectedIndexChanged="gvlslist_SelectedIndexChanged"  Width="100%">
                <Columns >

                    <asp:TemplateField HeaderText="Sr.No." >
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                            </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="docket_no" HeaderText="Docket No">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>


                    <asp:BoundField DataField="bookingdt" HeaderText="Booking Date" >
                         <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt"  HorizontalAlign="Center"  />
                    </asp:BoundField>

                    <asp:BoundField DataField="bookinglocation" HeaderText="Booking Location" >
                         <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt"  HorizontalAlign="Center"  />
                    </asp:BoundField>

                    <asp:BoundField DataField="consignorname" HeaderText="Consignor/Consignee" >
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>

                    <asp:BoundField DataField="nextstop" HeaderText="Next Stop Location" >
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                             <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  />
                    </asp:BoundField>

                    <asp:BoundField DataField="deliverylocation" HeaderText="Delivery Location" >
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt"  HorizontalAlign="Center"  />
                    </asp:BoundField>

                    <asp:BoundField DataField="delydate" HeaderText="Delivery Date" >
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt"  HorizontalAlign="Center"  />
                    </asp:BoundField>
                    
                     <asp:BoundField DataField="packages_L_B" HeaderText="Packages L/B" >
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt"  HorizontalAlign="Right"  />
                    </asp:BoundField>
                     <asp:BoundField DataField="weight_L_B" HeaderText="Weight L/B" >
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                            <ItemStyle BackColor="White" CssClass="blackfnt"  HorizontalAlign="Right"  />
                    </asp:BoundField>
                    

                </Columns>
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                <HeaderStyle CssClass="bgbluegrey" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                />
                <FooterStyle CssClass="boxbg" />
                </asp:GridView>

<asp:Table CssClass="boxbg" runat="server" ID="tblgrid" style="display:none;width:100%" CellSpacing="1">
    <asp:TableRow CssClass="bgbluegrey">
        <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt">Sr. No.</asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt">Docket No.</asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" Wrap="true" CssClass="blackfnt">Booking Date</asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" Wrap="true" CssClass="blackfnt">Booking Location</asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" Wrap="true" CssClass="blackfnt">Consignor/Consignee</asp:TableCell>
        <asp:TableCell HorizontalAlign="Center" CssClass="blackfnt">Next Stop</asp:TableCell>
        <asp:TableCell HorizontalAlign="Center"  Wrap="true" CssClass="blackfnt">Delivery Date</asp:TableCell>
        <asp:TableCell HorizontalAlign="Center"  Wrap="true" CssClass="blackfnt">Packages L/B</asp:TableCell>
        <asp:TableCell HorizontalAlign="Center"  Wrap="true" CssClass="blackfnt">Weight L/B</asp:TableCell>
    </asp:TableRow>
    <asp:TableRow BackColor="white">
        <asp:TableCell ColumnSpan="9" CssClass="redfnt" HorizontalAlign="Center">No Records Found...</asp:TableCell>
    </asp:TableRow>
</asp:Table>
                            
                            
                            
                            
                                  <%--LIST OF LOADING SHEET ENDS--%>
                            
                </td>  <%--MAIN TALBE'S GRID--%>
            </tr>
            <tr bgcolor="#ffffff" class="blackfnt">
               <td bgcolor="#ffffff" colspan="2" class="blackfnt">
               <table align="center" bgcolor="#808080" class="boxbg" cellpadding="3" cellspacing="1" width="100%">
                        <tr bgcolor="#ffffff" class="blackfnt">
                            <td align="center">Staff Name</td>
                            <td align="center">Sign</td>
                            <td align="center">Prepared By</td>
                            <td align="center">At</td>
                            <td align="center">Date & Time</td>
                        </tr>
                        <tr bgcolor="#ffffff" class="bluefnt">
                            <td align="center">&nbsp;
                                <asp:Label ID="lblstaffname" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblsign" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblpreparedby" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lblat" runat="server"></asp:Label>
                            </td>
                            <td align="center">
                                <asp:Label ID="lbldatetime" runat="server"></asp:Label>
                            </td>
                        </tr>
                     </table>
               </td>
            </tr>
                        
                        
    </table> <%--LS NAME AND DATE COMPLETE--%>
                             
                         
</div>                    
                         
     </form>
</body>
</html>
                            
