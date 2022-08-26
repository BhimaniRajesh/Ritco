<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" EnableEventValidation="false" CodeFile="ListVendorContract.aspx.cs"
    Inherits="GUI_Admin_Vendor_contract_vendorContract_Step1" %>
    
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Assembly="Anthem.AutoSuggest" Namespace="Anthem" TagPrefix="Anthem" %>
<%@ Import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript">  
        
    </script>

    <div>
        <table>
            <tr>
                <td>
                    <br />  
                       
                    <table border="0" style="width: 7.0in" align="left" cellpadding="3" cellspacing="1"
                        class="boxbg">
                        <tr bgcolor="#ffffff">
                            <td class="bgbluegrey" colspan="2" align="left">
                                <font class="bluefnt"><b>Vendor Contract List</b></font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td>
                                <font class="blackfnt">Vendor</font></td>
                            <td>
                                <font class="blackfnt">
                                                                
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_VendDetail_1" runat="server" visible="true">
                            <td>
                                <font class="blackfnt">Select Add/Edit</font></td>
                            <td>
                                <font class="blackfnt">                                  
                                    <asp:RadioButton runat="server" ID="Rd_Add" Text="Add" GroupName="AddEdit" onclick="javascript:return FillVendor()"/>
                                    <asp:RadioButton runat="server" ID="Rd_Edit" Text="Edit" GroupName="AddEdit" onclick="javascript:return FillVendor()"/>                                                              
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_VendDetail_2" runat="server" visible="true">
                            <td>
                                <font class="blackfnt">Select Vendor</font></td>
                            <td>
                                <font class="blackfnt">
                                    <Anthem:AutoSuggestBox runat="server" ID="txtVedor" DataKeyField="vendorcode" TextBoxDisplayField="vendorname"
                                        ItemNotFoundMessage="No vendor found!" Required="false" OnTextChanged="txtVedor_TextChanged">
                                       <HeaderTemplate>
                                            <%-- <table border="0" cellpadding="2" cellspacing="0">
                                                <tr>
                                                    <td align="left">
                                                        <b>Code </b>
                                                    </td>
                                                    <td width="10"></td>
                                                    <td align="right">
                                                        <b>Location</b>
                                                    </td>
                                                </tr>
                                            </table>--%>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr class="blackfnt">
                                                    <td nowrap>
                                                        <%# ((DataRowView)Container.DataItem)["vendorcode"]%>
                                                    </td>
                                                    <td width="20" align="center" nowrap> : </td>
                                                    <td nowrap>
                                                        <%# ((DataRowView)Container.DataItem)["vendorname"]%>
                                                    </td>                    
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </Anthem:AutoSuggestBox>
                                </font>
                            </td>
                        </tr>
                        <tr class="bgbluegrey" id="TR_VendDetail" runat="server" visible="true">
                            <td colspan="2" align="left">
                                <font class="bluefnt"><b>Vendor Contract Type Details</b></font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_Attached" runat="server" visible="true">
                            <td>
                                <font class="blackfnt">Vendor Contract Type</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:RadioButton ID="Rd_Contract_Attached" GroupName="VednContract" runat="server"
                                        Text="Route based for VHC and Distance based for PRS/DRS" />
                                    <br />
                                    <asp:RadioButton ID="Rd_Contract_Attached1" GroupName="VednContract" runat="server"
                                        Text="Distance based for VHC/DRS/PRS" />
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_BA" runat="server" visible="true">
                            <td align="left">
                                <font class="blackfnt">Vendor Contract Type</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:Label ID="Lbl_BA" runat="server" CssClass="bluefnt" Font-Bold="true" Text="Docket Based Contracts " />
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_3PL" runat="server" visible="true">
                            <td>
                                <font class="blackfnt">Vendor Contract Type</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:Label ID="Lbl_3pl" runat="server" CssClass="bluefnt" Font-Bold="true" Text="3PL Contracts" />
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_ContrFor" runat="server" >
                            <td>
                                Select Contract For :
                            </td>
                            <td>
                                <asp:DropDownList ID="Ddl_Contract_For" runat="server" CssClass="blackfnt" >
                                    <asp:ListItem Value="1">Vendor</asp:ListItem>
                                    <asp:ListItem Value="2">FTL Type</asp:ListItem>
                                    <asp:ListItem Value="3">Vehicle Number</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="bgbluegrey" id="TR_VendDetail_3" runat="server" visible="true">
                            <td colspan="2" align="center">
                                <asp:Button ID="Btn_Submit" runat="server" CssClass="blackfnt" BorderStyle="groove"
                                    Text="Submit" OnClick="Step1_Click" OnClientClick="javascript:return OnSubmitCheck()" />
                            </td>
                        </tr>
                    </table>
                   
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
