<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="ClaimInvstReportView.aspx.cs" Inherits="ClaimInvstReportView" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">CIR>CIR Entry >Claim Report View   </asp:Label>
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
        <table cellspacing="1" cellpadding="3"    width="90%" >
         <tr style="background-color: white" >
                <td   align="center">
                
                  <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="True" runat="server">View Cliams Investigation Report</asp:Label> 
     </td>
     </tr>
          </table>
          <br/>
          <br/>
   <p align="center"> 
    
     <asp:UpdatePanel ID="UpdatePanel7" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
        <table cellspacing="1" cellpadding="2"    width="600px" >
            
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
                  <font class="bluefnt">CIR Date:</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblCIRDate" CssClass="blackfnt" runat="server"      ></asp:Label>
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
                  <asp:Label ID="lblCAmt" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="lblCAmt"></asp:RequiredFieldValidator> --%>
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
            <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="lblIFrom"></asp:RequiredFieldValidator> --%>
                </td>
               
            </tr>
             <tr style="background-color: white">
                <td align="left"  colspan="1" >
                  <font class="bluefnt">Last TC No.</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblTcNo" CssClass="blackfnt" runat="server"      ></asp:Label>
               <%--    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="lblTcNo"></asp:RequiredFieldValidator>--%>
                </td>
               
            </tr>
            
             <tr style="background-color: white">
                <td align="left" colspan="1">
                  <font class="bluefnt">Last THC No.</font>
                </td>
                <td align="left" colspan="4" >
                  <asp:Label ID="lblThcNo" CssClass="blackfnt" runat="server"      ></asp:Label>
             <%--      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="lblThcNo"></asp:RequiredFieldValidator>--%>
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
                  <asp:Label ID="lblTally1" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               <td align="left"  colspan="2">
                  <asp:Label ID="lblTally2" CssClass="blackfnt" runat="server"      ></asp:Label>
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
                <td align="center"  colspan="2">
                  <asp:Label ID="txtCName" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               <td align="center"  colspan="2">
                  <asp:Label ID="txtCValue" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Surveyor appointed by Speedage </font>
                </td>
                <td align="center"  colspan="2">
                  <asp:Label ID="txtSName" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               <td align="center"  colspan="2">
                  <asp:Label ID="txtSValue" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">SSpeedage Employee </font>
                </td>
                <td align="center"  colspan="2">
                  <asp:Label ID="txtEName" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                </td>
               <td align="center"  colspan="2">
                  <asp:Label ID="txtEValue" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
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
                  <asp:Label ID="txtCoName" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </tr>
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Insuarance Policy No. </font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="txtPolNo" CssClass="blackfnt" runat="server"      >-</asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
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
                  <asp:Label ID="lblChallanNo" CssClass="blackfnt" runat="server" Width="131px"      ></asp:Label>
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
                  <asp:Label ID="txtMBusiness" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </tr>
         
         <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Booking</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="txtBooking" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </tr>
            
            
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Delivery</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="txtDelivery" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </tr>
            
            <tr style="background-color: white">
                <td align="left"  colspan="1">
                  <font class="bluefnt">Nature Of Business</font>
                </td>
                <td align="left"  colspan="4">
                  <asp:Label ID="txtNBusiness" CssClass="blackfnt" runat="server"      ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            </tr>
            
            
            
            
            
                           <tr class="bgbluegrey">
                <td   align="center" colspan="5">
                    <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Document Attached"></asp:Label>
                    </td>
             
            </tr>
           
           <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
               <font class="bluefnt">Enclosures</font>
            </td>
                <td align="left"  colspan="1">
                <font class="bluefnt">Branch Office</font>
            </td>
               <td align="left"  colspan="1">
                  <font class="bluefnt">Area Office</font>
             </td>
               <td align="left"  colspan="2">
               <font class="bluefnt">Head Office</font>
            
            </td>
            </tr>
           
           
             <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:Label ID="chkPLetter"  runat="server"  Text="Party's Claims Letter"   cssclass="bluefnt"  ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="1">
                  <asp:Label ID="lblLetter"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                     <asp:CheckBox ID="chkletter"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkALetter"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
              <asp:Label ID="lblALetter"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
              <td align="left"  colspan="2">
                  <asp:CheckBox ID="chkHLetter"  runat="server" Visible="false"    cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            <asp:Label ID="lblHLetter"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
            </tr>
         
<tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:Label ID="lblICopy"  runat="server"  Text="Invoice Copy"   cssclass="bluefnt"  ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="1">
                  <asp:Label ID="lblCopy"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                      <asp:CheckBox ID="chkCopy"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkACopy"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
              <asp:Label ID="lblACopy"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
              <td align="left"  colspan="2">
                  <asp:CheckBox ID="chkHCopy"  runat="server" Visible="false"    cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            <asp:Label ID="lblHCopy"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
            </tr>
            
           <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:Label ID="lblDPOD"  runat="server"  Text="Docket POD Copy"   cssclass="bluefnt"  ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="1">
                  <asp:Label ID="lblPOD"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                 <asp:CheckBox ID="chkPOD"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
            
              <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkAPOD"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblAPOD"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
              <td align="left"  colspan="2">
                  <asp:CheckBox ID="chkHPOD"  runat="server" Visible="false"    cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblHPOD"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
            </tr>
            
             <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:Label ID="lblPTC"  runat="server"  Text="Photocopy of TC & THC"   cssclass="bluefnt"  ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="1">
                  <asp:Label ID="lblTC"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                  <asp:CheckBox ID="chkTC"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkATC"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblATC"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
              <td align="left"  colspan="2">
                  <asp:CheckBox ID="chkHTC"  runat="server" Visible="false"    cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblHTC"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
            </tr>
            
            <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:Label ID="lblCFIR"  runat="server"  Text="Copy OF FIR"   cssclass="bluefnt"  ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="1">
                  <asp:Label ID="lblFIR"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
               <asp:CheckBox ID="chkFIR"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkAFIR"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblAFIR"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
              <td align="left"  colspan="2">
                  <asp:CheckBox ID="chkHFIR"  runat="server" Visible="false"    cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblHFIR"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
            </tr>
            
            
             <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:Label ID="lblSReport"  runat="server"  Text="Surveyor's Of Report"   cssclass="bluefnt"  ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="1">
                  <asp:Label ID="lblReport"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                   <asp:CheckBox ID="chkReport"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkAReport"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblAReport"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
              <td align="left"  colspan="2">
                  <asp:CheckBox ID="chkHReport"  runat="server" Visible="false"    cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblHReport"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
            </tr>
            
            
             <tr style="background-color: white">
                 
                <td align="left"  colspan="1">
                  <asp:Label ID="Label24"  runat="server"  Text="Photographs"   cssclass="bluefnt"  ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
            
            
                <td align="left"  colspan="1">
                  <asp:Label ID="lblPhoto"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                 <asp:CheckBox ID="chkPhoto"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              
              <td align="left"  colspan="1">
                  <asp:CheckBox ID="chkAPhoto"  runat="server"  Visible="false"  cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
               <asp:Label ID="lblAPhoto"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
              <td align="left"  colspan="2">
                  <asp:CheckBox ID="chkHPhoto"  runat="server" Visible="false"    cssclass="blackfnt" ></asp:CheckBox>
              <%--     <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDocketNo"></asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblHPhoto"  runat="server"     Visible="false" cssclass="blackfnt" ></asp:Label>
            
            </tr>
           
            </table>



              <p align="center">
         <table cellspacing="1" cellpadding="2"    width="600px" >
             <tr align="center"  >
             <td align="center"  >
         <asp:Button ID="cmdApprove" runat="server" Text="Click here to approve" Width="113px"  />
            </td>
            
              <td align="center" >
         <asp:Button ID="cmdCalcel" runat="server" Text="Cancel"  />
            </td>
            </tr>
            </table>
           
    </ContentTemplate>
                                    <%--<Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cmdGo" EventName="Click" />
                                    </Triggers>--%>
                                </asp:UpdatePanel>
     </p> 
</asp:Content>            
