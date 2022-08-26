<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CCM_DisplayResult.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_CCM_DisplayResult" Title="Customer Contract Master - Display Result" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <script language="javascript" type="text/javascript">
        
        function disableenter()
        {
        
        }
        
    </script>
    
    <div>
        
        <input type="hidden" id="HidContractID" runat="server" />
        <input type="hidden" id="HidCustCodeName" runat="server" />
        
        <table width="70%" border="0" cellpadding="0" cellspacing="0">
            <tr>
	            <td>
		            <label class="blackfnt" id="lblHeader" runat="server">
		            </label>
		            <hr align="center" size="1" color="#8ba0e5">
	            </td>
            </tr>
        </table>
        
        <br style="font-size: 6px;" />
           
        <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">
            <tr style="background-color: White">
                <td align="center" style="width: 25%;">
                    <label class="blackfnt">
                        Document Name
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt">
                        System Number
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt">
                        Manual Number
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt">
                        View & Print
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblCCM" runat="server">
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblCCMNo" runat="server">
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblManualCCMNo" runat="server">
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblVPCCM" runat="server">
                    </label>
                </td>
            </tr>
            
            <%--<tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <label class="blackfnt">
                        Your next step:
                    </label>    
                </td>
            </tr>--%>
        </table>
            
        <br style="font-size: 3px;" />    
            <%--<tr style="background-color: White">
                <td align="center" valign="middle" colspan="4">--%>
                    <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="left">
                                <label class="blackfnt">
                                    &nbsp;Your next step:
                                </label>    
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td align="center" valign="middle">
                                <font class="bluefnt" size="5">
                                    <b>
                                        .
                                    </b>
                                </font>
                            </td>
                        
                            <td align="left">
                                <label class="blackfnt">
                                    &nbsp;
                                    <a href="../../../GUI/admin/CustomerContractMaster/MainCustomerContractMaster.aspx">
	                                    <u>
	                                        Prepare more contract
	                                    </u>
	                                </a>
                                </label>
                            </td>
                        </tr>
                    
                        <tr style="background-color: White">
                            <td align="center" valign="middle">
                                <font class="bluefnt" size="5">
                                    <b>
                                        .
                                    </b>
                                </font>
                            </td>
                            
                            <td align="left">
                                <label class="blackfnt">
                                    &nbsp;
                                    <a href="../../../GUI/admin/CustomerContractMaster/MainCustomerContractMaster.aspx">
	                                    <u>
	                                        View & Print contract
	                                    </u>
	                                </a>
                                </label>
                            </td>
                        </tr>
                    </table>
                <%--</td>
            </tr>--%>
        <%--</table>--%>
        
    </div>
    
</asp:Content>
