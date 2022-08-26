<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmAddJourneyQuery.aspx.cs" Inherits="Issue_frmAddJourneyQuery" %>

<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Add Journey >> New</asp:Label>
               <%-- <hr align="center" size="1" color="#8ba0e5">--%>
            </td>
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/indicator.gif" />
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
                            <td colspan="4" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
	     <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label11" CssClass="bluefnt" runat="server" >Enter Journey start date:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                      <DateCalendar:header id="DtCal" runat="server" ></DateCalendar:header>
                                      <asp:DropDownList ID="cboStDt_HH" runat=server>
                                          <asp:ListItem Text="" Value=""></asp:ListItem>
                                          <asp:ListItem Text="00" Value="00"></asp:ListItem>
                                          <asp:ListItem Text="01" Value="01"></asp:ListItem>
                                          <asp:ListItem Text="02" Value="02"></asp:ListItem>
                                          <asp:ListItem Text="03" Value="03"></asp:ListItem>
                                          <asp:ListItem Text="04" Value="04"></asp:ListItem>
                                          <asp:ListItem Text="05" Value="05"></asp:ListItem>
                                          <asp:ListItem Text="06" Value="06"></asp:ListItem>
                                          <asp:ListItem Text="07" Value="07"></asp:ListItem>
                                          <asp:ListItem Text="08" Value="08"></asp:ListItem>
                                          <asp:ListItem Text="09" Value="09"></asp:ListItem>
                                          <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                          <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                          <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                         </asp:DropDownList>
                                         <asp:RequiredFieldValidator ID="ReqStDt_HH" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboStDt_HH"></asp:RequiredFieldValidator>

                                            :
                                         <asp:DropDownList ID="cboStDt_MM" runat=server>
                                          <asp:ListItem Text="" Value=""></asp:ListItem>
                                         <asp:ListItem Text="00" Value="00"></asp:ListItem>
                                          <asp:ListItem Text="01" Value="01"></asp:ListItem>
                                          <asp:ListItem Text="02" Value="02"></asp:ListItem>
                                          <asp:ListItem Text="03" Value="03"></asp:ListItem>
                                          <asp:ListItem Text="04" Value="04"></asp:ListItem>
                                          <asp:ListItem Text="05" Value="05"></asp:ListItem>
                                          <asp:ListItem Text="06" Value="06"></asp:ListItem>
                                          <asp:ListItem Text="07" Value="07"></asp:ListItem>
                                          <asp:ListItem Text="08" Value="08"></asp:ListItem>
                                          <asp:ListItem Text="09" Value="09"></asp:ListItem>
                                          <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                          <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                          <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                          <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                          <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                          <asp:ListItem Text="15" Value="15"></asp:ListItem>
                                          <asp:ListItem Text="16" Value="16"></asp:ListItem>
                                          <asp:ListItem Text="17" Value="17"></asp:ListItem>
                                          <asp:ListItem Text="18" Value="18"></asp:ListItem>
                                          <asp:ListItem Text="19" Value="19"></asp:ListItem>
                                          <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                          <asp:ListItem Text="21" Value="21"></asp:ListItem>
                                          <asp:ListItem Text="22" Value="22"></asp:ListItem>
                                          <asp:ListItem Text="23" Value="23"></asp:ListItem>
                                          <asp:ListItem Text="24" Value="24"></asp:ListItem>
                                          <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                          <asp:ListItem Text="26" Value="26"></asp:ListItem>
                                          <asp:ListItem Text="27" Value="27"></asp:ListItem>
                                          <asp:ListItem Text="28" Value="28"></asp:ListItem>
                                          <asp:ListItem Text="29" Value="29"></asp:ListItem>
                                          <asp:ListItem Text="30" Value="30"></asp:ListItem>
                                          <asp:ListItem Text="31" Value="31"></asp:ListItem>
                                          <asp:ListItem Text="32" Value="32"></asp:ListItem>
                                          <asp:ListItem Text="33" Value="33"></asp:ListItem>
                                          <asp:ListItem Text="34" Value="34"></asp:ListItem>
                                          <asp:ListItem Text="35" Value="35"></asp:ListItem>
                                          <asp:ListItem Text="36" Value="36"></asp:ListItem>
                                          <asp:ListItem Text="37" Value="37"></asp:ListItem>
                                          <asp:ListItem Text="38" Value="38"></asp:ListItem>
                                          <asp:ListItem Text="39" Value="39"></asp:ListItem>
                                          <asp:ListItem Text="40" Value="40"></asp:ListItem>
                                          <asp:ListItem Text="41" Value="41"></asp:ListItem>
                                          <asp:ListItem Text="42" Value="42"></asp:ListItem>
                                          <asp:ListItem Text="43" Value="43"></asp:ListItem>
                                          <asp:ListItem Text="44" Value="44"></asp:ListItem>
                                          <asp:ListItem Text="45" Value="45"></asp:ListItem>
                                          <asp:ListItem Text="46" Value="46"></asp:ListItem>
                                          <asp:ListItem Text="47" Value="47"></asp:ListItem>
                                          <asp:ListItem Text="48" Value="48"></asp:ListItem>
                                          <asp:ListItem Text="49" Value="49"></asp:ListItem>
                                          <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                          <asp:ListItem Text="51" Value="51"></asp:ListItem>
                                          <asp:ListItem Text="52" Value="52"></asp:ListItem>
                                          <asp:ListItem Text="53" Value="53"></asp:ListItem>
                                          <asp:ListItem Text="54" Value="54"></asp:ListItem>
                                          <asp:ListItem Text="55" Value="55"></asp:ListItem>
                                          <asp:ListItem Text="56" Value="56"></asp:ListItem>
                                          <asp:ListItem Text="57" Value="57"></asp:ListItem>
                                          <asp:ListItem Text="58" Value="58"></asp:ListItem>
                                          <asp:ListItem Text="59" Value="59"></asp:ListItem>
                                         </asp:DropDownList>
                                         <asp:RequiredFieldValidator ID="ReqStDt_MM" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboStDt_MM"></asp:RequiredFieldValidator>

                                          <asp:DropDownList ID="cboStDt_AMPM" runat=server>
                                           <asp:ListItem Text="" Value=""></asp:ListItem>
                                          <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                                          <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                                         </asp:DropDownList>
                                         <asp:RequiredFieldValidator ID="ReqStDt_AMPM" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboStDt_AMPM"></asp:RequiredFieldValidator>
                                         
                                         
                            </td>
                        </tr>

                        
                             <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="bluefnt" runat="server" >Select Origin City:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                        <asp:DropDownList ID="cboOrgnCity" runat=server OnSelectedIndexChanged="FillPickupLoc" AutoPostBack=true></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="ReqOrgnCity" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboOrgnCity"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        
                         <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label10" CssClass="bluefnt" runat="server" >Select Pickup location:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                            <ContentTemplate> 
                                <asp:Panel runat="server" ID="Panel1" Visible="true">
                                       <asp:DropDownList ID="cboOrgnLoc" runat=server ></asp:DropDownList>
                                       <%--<asp:RequiredFieldValidator ID="ReqOrgnLoc" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboOrgnLoc"></asp:RequiredFieldValidator>--%>
                                </asp:Panel>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cboOrgnCity" EventName="SelectedIndexChanged" />
                            </Triggers>
                            </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label9" CssClass="bluefnt" runat="server" >Select Vehicle Type:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                        <asp:DropDownList ID="cboVehType" runat=server ></asp:DropDownList>
                                        <%--<asp:RequiredFieldValidator ID="ReqVehType" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboVehType"></asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="bluefnt" runat="server" >No. of passengers:</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                        <asp:TextBox  ID="txtPassNo" runat="Server"  BorderStyle="Groove" MaxLength=3 Width="30px"></asp:TextBox>
                                        
                                        <%--<asp:RequiredFieldValidator ID="ReqPassNo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtPassNo"></asp:RequiredFieldValidator>--%>
                                        <asp:RegularExpressionValidator ID="RegPassNo" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtPassNo" Display="Dynamic"></asp:RegularExpressionValidator>
                            </td>
                        </tr>


                        
                        <tr style="background-color: white">
                            <td colspan="4" align="right">
                               <%-- <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>--%>
                                        <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit"  OnClick="btnShowMultipleRequest_Click" /> 
                                    <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                        
                    </table>
                          </td>
            </tr>
        </table>

<br />


</asp:Content> 
