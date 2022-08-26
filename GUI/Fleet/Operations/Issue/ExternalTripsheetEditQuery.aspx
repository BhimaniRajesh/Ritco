<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="ExternalTripsheetEditQuery.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalTripsheetEditQuery" %>
 
<%@ Reference Control="~/LED/DateSelector.ascx" %>
<%@ Reference Control="~/LED/DateSelectorTo.ascx" %>
<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/LED/DateSelector.ascx" %>
<%@Register TagPrefix="SControlsTo" TagName="DateSelectorTo" src="~/LED/DateSelectorTo.ascx" %> 
 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>
 

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">External Tripsheet Edit Module >> Query</asp:Label>
             
            </td>
            
             <td align="right">
                      
 <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../../images/loading.gif" alt="" />
                        </td>
                        <td>
                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                    opacity: .50; -moz-opacity: .50;" runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
         
          </td>    
           
        </tr>
    </table>
<hr align="center" size="1" color="#8ba0e5">
 <br/>  
 <table  align="center" cellspacing="1" style="width: 100%">
            <tr align="center">
                <td align="center">  
       <table align="center"  cellspacing="1" cellpadding="2" style="width: 70%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                         <td align="left">
                                
                                  <asp:DropDownList ID="ddlTripsheet" runat="server">
                                     <asp:ListItem Value="M" Text="Enter Manual TripSheet No.:" Selected="true"></asp:ListItem>
                                <asp:ListItem Value="T" Text="Enter Trip Sheet No.:"></asp:ListItem>
                             
 
                               </asp:DropDownList>
                            </td>
                            <td align="left" colspan="3">
                                <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox CssClass="input" ID="txtVIssueID" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove" OnTextChanged="CheckValid" AutoPostBack=true></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVIssueID"
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
                                        <asp:Button ID="btnShowSingleRequest" runat="server" Text="Submit" ValidationGroup="VGRequestID" OnClick="btnShowMultipleRequest_Click"
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
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Trip Sheet Date Range:</asp:Label>
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
                                        <asp:AsyncPostBackTrigger ControlID="txtVIssueID" EventName="TextChanged" />
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
                                        <asp:AsyncPostBackTrigger ControlID="txtVIssueID" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                  
                        <tr style="background-color: white">
                            <td colspan="3" align="right">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo" OnClick="btnShowMultipleRequest_Click" /> 
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
                     
                     
                     <asp:datagrid id="DataGrid1" runat="server"   AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left  ><%--OnItemDataBound="DataGrid1_ItemDataBound"--%>
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                
                                    <asp:BoundColumn DataField="Manual_TripsheetNo" HeaderText="Manual Trip Sheet No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                
                                
                                <asp:BoundColumn DataField="VSlipNo" HeaderText="Trip Sheet No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="VSlipDt" HeaderText="Trip Sheet Start date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>

                                 <asp:BoundColumn DataField="End_dt_tm" HeaderText="Trip Sheet Close date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                
                                
                                <asp:BoundColumn DataField="VehicleNo" HeaderText="Vehicle No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="DriverName" HeaderText="Driver">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="IssueStatus" HeaderText="Status">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo"   DataNavigateUrlFormatString="ExternalTripsheetEdit.aspx?id={0}" Text="Edit" HeaderText="Edit/Update" HeaderStyle-HorizontalAlign="Left">
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn>
                             
	                            </Columns>
	                        </asp:datagrid>
                     
                     </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowMultipleRequest" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnShowSingleRequest" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                    
              </td>
         </tr>
    </table>    





</asp:Content> 