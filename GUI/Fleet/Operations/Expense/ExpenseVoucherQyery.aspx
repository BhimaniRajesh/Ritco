<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"   CodeFile="ExpenseVoucherQyery.aspx.cs" Inherits="GUI_Fleet_Operations_Expense_ExpenseVoucherQyery" %>

 
<%@ Reference Control="~/LED/DateSelector.ascx" %>
<%@ Reference Control="~/LED/DateSelectorTo.ascx" %>
<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/LED/DateSelector.ascx" %>
<%@Register TagPrefix="SControlsTo" TagName="DateSelectorTo" src="~/LED/DateSelectorTo.ascx" %> 





<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>




    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">View/Print Expense Voucher>> Query</asp:Label>
             
            </td>
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>    
           
        </tr>
    </table>
<hr align="center" size="1" color="#8ba0e5">
 <br> 

 
 
 
 <table cellspacing="1" style="width: 100%">
            <tr align="center">
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 70%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Expense Voucher No.:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox CssClass="input" ID="txtVoucherNo" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove" OnTextChanged="CheckValid" AutoPostBack=true></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVoucherNo"
                                            ErrorMessage="*" ValidationGroup="VGRequestID" />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        
                        
                        <tr style="background-color: white">
                            <td colspan="3" align="right">
                                <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowSingle" runat="server" Text="Submit" ValidationGroup="VGRequestID" OnClick="btnShowMultiple_Click"
                                             />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="3">
                                <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                                </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left"  width="400px"  valign=top>
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Expense Voucher Date Range:</asp:Label>
                            </td>
                            <td align="left"  width="200px">
                                <asp:UpdatePanel ID="UpdatePanel6" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                            <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                            <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="txtVoucherNo" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                            <td valign="top" align="left">
                                <asp:UpdatePanel ID="UpdatePanel7" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:Label ID="Label7" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>  <SControls:DateSelector     ID="txtDateFrom" runat="server" />  <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Text="To :"></asp:Label>  <SControlsTo:DateSelectorTo ID="txtDateTo" runat="server" />                                     
                                 
                                            
                                    </ContentTemplate>
                                    <Triggers>
                                      <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                        <asp:AsyncPostBackTrigger ControlID="txtVoucherNo" EventName="TextChanged" /> 
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    
                    <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Select Type Of  Expense Voucher :</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                               <asp:DropDownList ID="cboType" runat="server">
                            <%--    <asp:ListItem Value="B" Text="Both"></asp:ListItem>--%>
                                <asp:ListItem Value="V" Selected="true"   Text="Variable"></asp:ListItem>
                                <asp:ListItem Value="F" Text="Fixed"></asp:ListItem>
                               </asp:DropDownList>
                          </td>
                        </tr>                        
                 
                 


                        
                        <tr style="background-color: white">
                            <td colspan="3" align="right">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowMultiple" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo" OnClick="btnShowMultiple_Click" /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
                          </td>
            </tr>
        </table>      
       
       

<br />
 <table cellspacing="1" style="width: 85%" align=center>
        <tr align="center">
            <td align="right">
                <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                     
                     
                     <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  OnItemDataBound="DataGrid1_ItemDataBound"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css"     CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left  ><%--OnItemDataBound="DataGrid1_ItemDataBound"--%>
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                
                                    <asp:BoundColumn DataField="Manual_Voucher_No" HeaderText="Manual Voucher No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="true" />
                                </asp:BoundColumn>
                                
                                
                                
                                <asp:BoundColumn DataField="VoucherNo" HeaderText="Voucher No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="VoucherDt" HeaderText="Voucher date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
 
                                
                             <%--   
                                <asp:BoundColumn DataField="VehicleNo" HeaderText="Vehicle No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>--%>
                           
                                
                                <asp:BoundColumn DataField="Type" HeaderText="Expense Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                
                                <asp:BoundColumn DataField="TotAmt" HeaderText="Toatl Amount Spent">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                
                                <asp:BoundColumn DataField="TotEAmt" HeaderText="Toatl Amount Approved">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:HyperLinkColumn       DataNavigateUrlField="VoucherNo" Target=_blank  DataNavigateUrlFormatString="VariableExpenseVoucherPrint.aspx?VNo={0}&PrintMode=0" Text="View" HeaderText="View" HeaderStyle-HorizontalAlign=Left>
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn>
                                       
                                <asp:HyperLinkColumn     Target=_blank DataNavigateUrlField="VoucherNo" DataNavigateUrlFormatString="VariableExpenseVoucherPrint.aspx?VNo={0}&PrintMode=1" Text="Print" HeaderText="Print" HeaderStyle-HorizontalAlign=Left>
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn>   
                       
                                          <asp:HyperLinkColumn     DataNavigateUrlField="VoucherNo" Target=_blank  DataNavigateUrlFormatString="ExpenseVoucherFixedAddPrint.aspx?VNo={0}&PrintMode=0" Text="View" HeaderText="View" HeaderStyle-HorizontalAlign=Left>
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn>
                                       
                                <asp:HyperLinkColumn     Target=_blank DataNavigateUrlField="VoucherNo" DataNavigateUrlFormatString="ExpenseVoucherFixedAddPrint.aspx?VNo={0}&PrintMode=1" Text="Print" HeaderText="Print" HeaderStyle-HorizontalAlign=Left>
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn>   
                                       
                                
	                            </Columns>
	                        </asp:datagrid>
                     
                     </ContentTemplate>
                    <Triggers>

                     <asp:AsyncPostBackTrigger ControlID="btnShowSingle" EventName="Click" />
                        
                          <asp:AsyncPostBackTrigger ControlID="btnShowMultiple" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                    
              </td>
         </tr>
    </table>    





</asp:Content> 