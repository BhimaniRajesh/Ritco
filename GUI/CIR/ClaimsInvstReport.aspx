<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="ClaimsInvstReport.aspx.cs" Inherits="ClaimsInvstReport" %>
 


<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">CIR >CIR Entry >View Claims Investigation Report </asp:Label>
            </td>
           <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
          </td>    
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
     
       <br/>
           <br/>
            <br/>
        <table cellspacing="1" cellpadding="3"    width="90%" >
         <tr style="background-color: white" >
                <td   align="center">
                
                  <asp:Label ID="Label1" CssClass="bluefnt" Font-Bold="True" Font-Size="12"    runat="server">View Cliams Investigation Report</asp:Label> 
     </td>
     </tr>
          </table>
          <br/>
           <br/>
            
                <p align="center"> 
    <table cellspacing="1" cellpadding="3" class="boxbg" border="0">
    <tr style="background-color:White" align="center">
    <td align="center">
    
        <table cellspacing="1" cellpadding="2"    width="800px"  class="boxbg" border="0">
            
     <tr style="background-color: white" >
                <td   align="center" colspan="5">
                    <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                    </td>
                   </tr>
                                       <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CIR Details"></asp:Label></td>
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">CIR Preapared By:</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="lblCIRPreaparedBy" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">CIR Number:</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="lblCIRNumber" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left"  colspan="1" >
                  <font class="bluefnt">CIR Date:</font>                  <asp:Label ID="Label14" CssClass="blackfnt" runat="server" Text="(dd/mm/yy)"     ></asp:Label>
            <%--       <asp:RequiredFieldValidator ID="RFVOrderDate" runat="server" ControlToValidate="txtDate"
                                ErrorMessage="*" />--%>
<%--                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="blackfnt"
                                ErrorMessage="!" ControlToValidate="txtDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>--%>
                </td>
                <td align="left" colspan="4" >
                <%--  <asp:TextBox ID="txtCIRDate" CssClass="input" runat="server"      ></asp:TextBox>--%>
                   <DateCalendar:Header ID="txtDate" runat="server"></DateCalendar:Header>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Docket Number:</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblDocNumber" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Docket Date:</font>
                </td>
                <td align="left" colspan="4">
                <asp:Label ID="lblDocDate" CssClass="blackfnt" runat="server"      ></asp:Label> 
               <%--   <DateCalendar:Header ID="txtDate" runat="server"></DateCalendar:Header>--%>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Origin:</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblOrigin" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
            
             <tr style="background-color: white">
                <td align="left" colspan="1"  >
                  <font class="bluefnt">Destination:</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="lblDestination" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left"  colspan="1" >
                  <font class="bluefnt">Last Delivery Point:</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblLastDelPt" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
           
                                              <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Party Details"></asp:Label></td>
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Details</font>
                </td>
                <td align="left" colspan="2" >
                  <asp:Label ID="lblDetails1" CssClass="blackfnt" runat="server"   Text="Consignor"   ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
                
                <td align="left"  colspan="2">
                  <asp:Label ID="lblDetails2" CssClass="blackfnt" runat="server"    Text="Consignee"     ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Name</font>
                </td>
                <td align="left"  colspan="2">
                  <asp:Label ID="lblName1" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left"  colspan="2">
                  <asp:Label ID="lblName2" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left"  colspan="1" >
                  <font class="bluefnt">Address</font>
                </td>
                <td align="left" colspan="2" >
                  <asp:Label ID="lblAdd1" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="2" >
                  <asp:Label ID="lblAdd2" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Phone</font>
                </td>
                <td align="left" colspan="2" >
                  <asp:Label ID="lblPhone1" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="2" >
                  <asp:Label ID="lblPhone2" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Pin</font>
                </td>
                <td align="left" colspan="2">
                  <asp:Label ID="lblPin1" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               <td align="left" colspan="2">
                  <asp:Label ID="lblPin2" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            
           
                                            <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="lbl" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Claiming Party Details"></asp:Label></td>
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Claiming Party</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="lblCLParty" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Claiming Party Grade</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="lblPartyGrade" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left"  colspan="1" >
                  <font class="bluefnt">Claiming Party Name</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblPName" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Claiming Party Address</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblPAdd" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Claiming Party Pin</font>
                </td>
                <td align="left" colspan="4">
                  <asp:Label ID="lblPPin" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Claiming Party Phone</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblPPhone" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
            
                                                     <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Claim Details"></asp:Label></td>
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Type Of Claim</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="lblTClaim" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Claiming Amount(In Rs.)</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:TextBox ID="txtCAmt" CssClass="input" runat="server"      ></asp:TextBox>
               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCAmt"></asp:RequiredFieldValidator> 
                <asp:RangeValidator ID="RangeValidator3" runat="server" MinimumValue="0" MaximumValue="99999999" Display="Dynamic" ErrorMessage="Amount Should be in Numeric!" ControlToValidate="txtCAmt"></asp:RangeValidator> 
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left"  colspan="1" >
                  <font class="bluefnt">Type Of Package</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblTPackage" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Product Description</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblPDesc" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Risk</font>
                </td>
                <td align="left" colspan="4">
                  <asp:Label ID="lblRisk" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Basis of Booking</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblBooking" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
               
               
               <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Freight Amount(In Rs.)</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblFAmt" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
            <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Value Of Goods(In Rs.)</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblVGoods" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
           
           
                                                     <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Arrival Details at Last Delivery Point"></asp:Label></td>
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Last Delivery Location </font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="lblLDLoc" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Incoming From</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="lblIFrom" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="lblCAmt"></asp:RequiredFieldValidator> --%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left"  colspan="1" >
                  <font class="bluefnt">Last TC No.</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblTcNo" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Last THC No.</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblThcNo" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
              <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Last THC Date</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblTHCDt" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Vehicle No.</font>
                </td>
                <td align="left" colspan="4">
                  <asp:Label ID="lblVehicleNo" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Route/Market</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblRMarket" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
               
               
               <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Route Code & Name</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblRCName" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
            <tr style="background-color: white">
                <td align="left" colspan="1" >
                  <font class="bluefnt">Value Of Goods(In Rs.)</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="Label11" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
            
                                                     <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Claims Investigation Details"></asp:Label></td>
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Have We given Open Delivery by tallying the contents as per invoice </font>
                </td>
                <td align="left"  colspan="2">
                  <asp:RadioButton ID="rdTally1"    GroupName="Tally"   Text="Yes" CssClass="blackfnt" runat="server"      ></asp:RadioButton>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               <td align="left"  colspan="2">
                  <asp:RadioButton ID="rdTally2" GroupName="Tally" Text="No"  CssClass="blackfnt" runat="server"      ></asp:RadioButton>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            
            
            
                                    <tr class="bgbluegrey">
                <td   align="center" colspan="1">
                    <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Font-Bold="true" Text=" "></asp:Label>
                    </td>
                                      
                <td   align="center" colspan="2">
                    <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Name"></asp:Label>
                    </td>
                                        
                <td   align="center" colspan="2">
                    <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Valuation Amount (in Rs.)"></asp:Label>
                    </td>
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Surveyor appointed by Customer </font>
                </td>
                <td align="left"  colspan="2">
                  <asp:TextBox ID="txtCName" CssClass="input" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqRequestBy1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCName"></asp:RequiredFieldValidator>
                </td>
               <td align="left"  colspan="2">
                  <asp:TextBox ID="txtCValue" CssClass="input" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="reqRequestBy2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCValue"></asp:RequiredFieldValidator>
                 <asp:RangeValidator ID="RangeValidator5" runat="server"  MinimumValue="0"  MaximumValue="99999999" Display="Dynamic"  ErrorMessage="Value should be Numeric!"    ControlToValidate="txtCValue"></asp:RangeValidator>
               
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Surveyor appointed by Express Cargo Service</font>
                </td>
                <td align="left"  colspan="2">
                  <asp:TextBox ID="txtSName" CssClass="input" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqRequestBy3" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtSName"></asp:RequiredFieldValidator>
                </td>
               <td align="left"  colspan="2">
                  <asp:TextBox ID="txtSValue" CssClass="input" runat="server"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="reqRequestBy4" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtSValue"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="RangeValidator4" runat="server"  MinimumValue="0"  MaximumValue="99999999" Display="Dynamic" ErrorMessage="Value should be Numeric!" ControlToValidate="txtSValue"></asp:RangeValidator>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Express Cargo Service Employee </font>
                </td>
                <td align="left"  colspan="2">
                  <asp:TextBox ID="txtEName" CssClass="input" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="reqRequestBy5" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtEName"></asp:RequiredFieldValidator>
                </td>
               <td align="left"  colspan="2">
                  <asp:TextBox ID="txtEValue" CssClass="input" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqRequestBy10" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtEValue"></asp:RequiredFieldValidator> 
                <asp:RangeValidator ID="RangeValidator6" runat="server"  MinimumValue="0"  MaximumValue="99999999" Display="Dynamic" ErrorMessage="Value should be Numeric!"  ControlToValidate="txtEValue"></asp:RangeValidator>
                </td>
            </tr>
            
                                <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Customer Insuarance Policy Details"></asp:Label>
                    </td>
             
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Insuarance Co.Name </font>
                </td>
                <td align="left"  colspan="4">
                  <asp:TextBox ID="txtCoName" CssClass="input" runat="server"      ></asp:TextBox>
              <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCoName"></asp:RequiredFieldValidator>
            
            </tr>
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Insuarance Policy No. </font>
                </td>
                <td align="left"  colspan="4">
                  <asp:TextBox ID="txtPolNo" CssClass="input" runat="server"      ></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqRequestBy8" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtPolNo"></asp:RequiredFieldValidator>
                </td>
            
            </tr>
            
            
            
                                 <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Claim to be recovered from Vendor"></asp:Label>
                    </td>
             
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Select Trip Challan no.</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:DropDownList ID="ddlChallanNo" CssClass="input" runat="server" Width="131px"      ></asp:DropDownList>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </tr>
         
         
                         <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Business Details Of Claiming Party"></asp:Label>
                    </td>
             
            </tr>
           
             <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Monthly Business</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:TextBox ID="txtMBusiness" CssClass="input" runat="server"      ></asp:TextBox>
               <asp:RangeValidator ID="reqReques" runat="server" MinimumValue="0" MaximumValue="99999999" Display="Dynamic" Text="!" ControlToValidate="txtMBusiness"></asp:RangeValidator>
            
            </tr>
         
         <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Booking</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:TextBox ID="txtBooking" CssClass="input" runat="server"      ></asp:TextBox>
             <asp:RangeValidator ID="RangeValidator1" runat="server" MinimumValue="0" MaximumValue="99999999" Display="Dynamic" Text="!" ControlToValidate="txtBooking"></asp:RangeValidator>
            
            </tr>
            
            
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Delivery</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:TextBox ID="txtDelivery" CssClass="input" runat="server"      ></asp:TextBox>
              <asp:RangeValidator ID="RangeValidator2" runat="server" MinimumValue="0" MaximumValue="99999999" Display="Dynamic" Text="!" ControlToValidate="txtDelivery"></asp:RangeValidator>
            
            </tr>
            
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Nature Of Business</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:TextBox ID="txtNBusiness" CssClass="input" runat="server"      ></asp:TextBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </tr>
            
            
            
            
            
                           <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Documents Attached"></asp:Label>
                    </td>
             
            </tr>
           
             <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkPLetter"  runat="server"  Text="Party's Claims Letter"  cssclass="blackfnt"   ></asp:CheckBox> <asp:FileUpload ID="fileCLetter"   runat="server" />
                    &nbsp; &nbsp; &nbsp;
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
                
                <td align="left"  colspan="4">
                  <asp:CheckBox ID="chkICopy"  runat="server"   Text="Invoice Copy"  cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="fileICopy"  runat="server" />
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
            
            </tr>
         
          <tr style="background-color: white">
                 
                <td align="left"  colspan="1" style="height: 24px">
                  <asp:CheckBox ID="chkDPOD"  runat="server"  Text="Docket POD Copy"   cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="filePOD"   runat="server" />
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="4" style="height: 24px">
                  <asp:CheckBox ID="chkPhoto"  runat="server"   Text="Photocopy of TC & THC"  cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="fileTC"   runat="server" />
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
            
            </tr>
            
             <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkFIR"  runat="server"  Text="Copy Of FIR"   cssclass="blackfnt"  ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="fileFIR"   runat="server" />
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="4">
                  <asp:CheckBox ID="chkSReport" runat="server"  cssclass="blackfnt" Text="Surveyor Report(for claim > Rs.10,000)"   ></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="fileSRPT"   runat="server" />
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
            
            </tr>
            
             <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkPhotographs"  runat="server"  cssclass="blackfnt" Text="Photographs"></asp:CheckBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:FileUpload ID="filePhoto"  runat="server" />
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
               
             <td align="left"  colspan="4">
             </td>
             
            </tr>
           
            </table>



              <p align="center">
         <table cellspacing="1" cellpadding="2"    width="600px" >
             <tr align="center"  >
             <td align="center"  >
         <asp:Button ID="cmdApprove" runat="server" Text="Click here to approve" Width="113px" OnClick="cmdApprove_Click"  />
            </td>
            
              <td align="center" >
         <asp:Button ID="cmdCalcel" runat="server" Text="Cancel" OnClick="cmdCalcel_Click"  />
            </td>
            </tr>
            </table>
           

                                
                                </td>
                                </tr>
                                </table>
     </p> 
</asp:Content>            

