<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectHistory2.aspx.cs" Inherits="REPORT_ProspectHistory2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect History" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
        </table>
        <br />
    
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" alt="" /></a>
                    </td>
                </tr>
            </table>
            <br />
            
            <table align="center" cellpadding="0" cellspacing="1" class="boxbg" width="85%">
            <tr class="bgbluegrey">
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Prospect History</strong></font></td>
            </tr>
        </table>
        <br />
        
        <table align="center" cellspacing="1" cellpadding="1" width="85%" border="0" class="boxbg" style="text-align: left">

               
                <tr bgcolor="white">
                    <td class="field1">
                        <font class="blackfnt">Prospect/Customer Id</font>
                    </td>
                    <td align="left" colspan="2">
                      <font class="blackfnt"><asp:Label ID="lblProspectId" runat="server"></asp:Label></font>  
                        
                    </td>
                    <td class="field1" >
                         <font class="blackfnt">Prospect/Customer Name</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><asp:Label ID="lblCustomerName" runat="server"></asp:Label></font> 
                        
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 180px">
                        <font class="blackfnt">Likely Order Date</font>
                    </td>
                    <td align="left" style="width: 558px" colspan="2">
                        <font class="blackfnt"><asp:Label ID="lblLikelyDt" runat="server"></asp:Label> </font>
                    </td>
                    <td class="field1" style="width: 180px">
                         <font class="blackfnt">Value per month</font>
                    </td>
                    <td align="left" style="width: 214px">
                        <font class="blackfnt"><asp:Label ID="lblValperMonth" runat="server"></asp:Label> </font> 
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 180px; height: 21px;">
                        <font class="blackfnt">Registration Date</font>
                    </td>
                    <td align="left" style="width: 558px; height: 21px;" colspan="2">
                      <font class="blackfnt">  <asp:Label ID="lblRegDt" runat="server"></asp:Label> </font> 
                    </td>
                    <td class="field1" style="width: 180px; height: 21px;">
                         <font class="blackfnt">Sales Person</font>
                    </td>
                    <td align="left" style="width: 214px; height: 21px;">
                       <font class="blackfnt"> <asp:Label ID="lblSalesPerson" runat="server"></asp:Label></font> 
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 180px">
                        <font class="blackfnt">Reassign Date</font>
                    </td>
                    <td align="left" style="width: 558px" colspan="2">
                       <font class="blackfnt"> <asp:Label ID="lblReassignDt" runat="server"></asp:Label> </font> 
                    </td>
                    <td class="field1" style="width: 180px">
                         <font class="blackfnt">Reassign To</font>
                    </td>
                    <td align="left" style="width: 214px">
                     <font class="blackfnt">   <asp:Label ID="lblReassignTo" runat="server"></asp:Label> </font> 
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 180px">
                        <font class="blackfnt">Total No of Calls</font>
                    </td>
                    <td align="left" style="width: 558px" colspan="2">
                        <font class="blackfnt"><asp:Label ID="lblTotalCall" runat="server"></asp:Label></font>
                        <asp:LinkButton ID="lnkCall" runat="server"></asp:LinkButton>
                    </td>
                    <td class="field1" style="width: 180px">
                         <font class="blackfnt">Contract Entry Date</font>
                    </td>
                    <td align="left" style="width: 214px">
                       <font class="blackfnt"> <asp:Label ID="lblContractEntryDt" runat="server"></asp:Label><font class="blackfnt">  
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 180px">
                        <font class="blackfnt">Submission Status</font>
                    </td>
                    <td align="left" style="width: 558px" colspan="2">
                     <font class="blackfnt">   <asp:Label ID="lblSubmissionStatus" runat="server"></asp:Label>  </font>
                    </td>
                    <td class="field1" style="width: 180px">
                         <font class="blackfnt">Submission Date</font>
                    </td>
                    <td align="left" style="width: 214px">
                        <font class="blackfnt"><asp:Label ID="lblSubmissionDt" runat="server"></asp:Label>  </font>
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 180px; height: 21px;">
                        <font class="blackfnt">Approval Status</font>
                    </td>
                    <td align="left" style="width: 558px; height: 21px;" colspan="2">
                        <font class="blackfnt"><asp:Label ID="lblApprovalStatus" runat="server"></asp:Label></font>  
                    </td>
                    <td class="field1" style="width: 180px; height: 21px;">
                         <font class="blackfnt">Approval Date</font>
                    </td>
                    <td align="left" style="width: 214px; height: 21px;">
                        <font class="blackfnt"><asp:Label ID="lblApprovalDt" runat="server"></asp:Label>  </font>
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 180px">
                        <font class="blackfnt">Customer Code</font>
                    </td>
                    <td align="left" style="width: 138px" colspan="4">
                       <font class="blackfnt"> <asp:Label ID="lblCustomerCode" runat="server"></asp:Label></font>  
                    </td>
                    
                    
                </tr>
                
        </table>
        <br />


</asp:Content>

