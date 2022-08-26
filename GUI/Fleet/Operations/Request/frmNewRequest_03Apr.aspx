<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmNewRequest.aspx.cs" Inherits="Request_frmNewRequest" %>
<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language=javascript>




 function ClientValidate(source, arguments)
      {
         //alert(arguments.Value);
         var r, re;      //Declare variables.
         re = new RegExp(/^[1-9][0-9][0-9][0-9]$/);  //Create regular expression object.
         r = re.test(arguments.Value);  //Test for match.
         arguments.IsValid = r;    //Return results.
      }


function ValidateForm()
{
 alert(document.getElementById("ctl00$MyCPH1$DtCal$useDateCal").value);
 //return false;
}
  function nwOpen(mNo)
        {
            window.open("../Issue/popupcustcode.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }






</script>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Requests >> New Request</asp:Label>
              <%--  <hr align="center" size="1" color="#8ba0e5">--%>
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

<br />



<%

    


 %>

 
    <p align="center">
        <table cellspacing="1" cellpadding="3" style="width: 85%" class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor=red></asp:Label></td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="NEW VEHICLE REQUEST NOTE"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Request Id</font>
                </td>
                <td align="left">
                   <font class=blackfnt color=red>< System generated ></font>
                </td>
                <td align="left">
                <font class=bluefnt>Request Date</font>
                </td>
                <td align="left">
               <DateCalendar:header id="DtCal" runat="server" ></DateCalendar:header>
                </td>
            </tr>
            
             <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Manual Request No.</font>
                </td>
                <td align="left" colspan=3>
                   <asp:TextBox ID="txtManualRequestId" runat=server MaxLength="15" Width="120" BorderStyle="Groove"></asp:TextBox>
                </td>
              </tr>
                
            
            
            
            
                 <tr style="background-color: white">
                <td align="left" style="height: 46px" >
                  <font class="bluefnt">Category</font>
                </td>
                 <td align="left" style="height: 46px" >
                   <asp:DropDownList ID="ddlCategory" runat="server" CssClass="blackfnt" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                       <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                       <asp:ListItem Value="External Usage">External Usage</asp:ListItem>
                       <asp:ListItem Value="Internal Usage">Internal Usage</asp:ListItem>
                   </asp:DropDownList>
                   
                      <asp:RequiredFieldValidator ID="ReqCategory" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlCategory"></asp:RequiredFieldValidator>
                </td>
              <%--  <td colspan="2">
                <table id="tblCust" runat="server" visible="false">
                <tr>--%>
                
                <td align="left" >
                  <asp:UpdatePanel ID="upCurrLocationCode1" runat="server">
                        <ContentTemplate>
                <%--  <font class="bluefnt">Enter Customer Code</font>--%>
                  <asp:Label ID="lblCutcode" runat="server"  Text="Enter Customer Code" Visible="false" CssClass="bluefnt" />
                     <asp:Label ID="lblMarket_own" runat="server"  Text="Market\Own" Visible="false" CssClass="bluefnt" />
                  
                   </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                
                <td align="left">
                <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                        <ContentTemplate>
                <table id="Table1" runat="server" visible="false">
                <tr>
                                
                 <td align="left" colspan="1">
                  <%--  <asp:TextBox ID="txtCustCode" runat="server" BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input"></asp:TextBox>--%>
                            <asp:DropDownList  ID="ddlMarket"  runat="server" Visible="false" >
                               <asp:ListItem Selected="True" Value="">Select</asp:ListItem> 
                            <asp:ListItem>Market</asp:ListItem> 
                                <asp:ListItem  >Own</asp:ListItem>
                            </asp:DropDownList>
                                          <asp:RequiredFieldValidator ID="ReqMarket" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlMarket"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtCustCode" AutoPostBack="true"  runat="server" Width="100px"   
                                MaxLength="4" OnTextChanged="txtCustCode_TextChanged1" ></asp:TextBox>&nbsp;
                            <asp:Label ID="lblPopup"    Visible="false" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(2)">...</a>'
                                Width="14px"></asp:Label>
                                              <asp:RequiredFieldValidator ID="ReqCustCode" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCustCode"></asp:RequiredFieldValidator>
                            <asp:Label  id="lblErrorLocation1"   class="blackfnt"  ForeColor="red"  runat="server" 
                                visible="false">
                    
                            </asp:Label>
                     

                </td>
               
                </tr>
                
                
                   </table>
                       </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                                        <asp:AsyncPostBackTrigger ControlID="txtCustCode" EventName="TextChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                
         
                
                
                </tr>
            
            
            
            
            
            
            
            
            
             <tr style="background-color: white">
                
             <%--  <td align="left">
                <font class=bluefnt>Category</font>
                </td>
                <td align="left">
                  <asp:DropDownList ID="cboCategory" runat=server OnSelectedIndexChanged="FillRequestBy" AutoPostBack=true></asp:DropDownList>
                  <asp:RequiredFieldValidator ID="ReqCategory" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboCategory"></asp:RequiredFieldValidator>
                </td>
                --%>
                <td align="left" >
                  <font class="bluefnt">Requested By</font>
                </td>
                <td align="left">
              
                   <asp:TextBox ID="txtRequestBy"  runat="server" MaxLength="50" Width="240" BorderStyle="Groove"></asp:TextBox>
                            <%-- <asp:RequiredFieldValidator ID="reqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRequestBy"></asp:RequiredFieldValidator>--%>

                            <%--<asp:RequiredFieldValidator ID="ReqRequestBy" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboRequestBy"></asp:RequiredFieldValidator>--%>
                     
                </td>
                
                <td>
                </td>
                <td>
                </td>
               
            </tr>
            
            
            
             <tr style="background-color: white">
                <td align="center" colspan=2>
                  <font class=bluefnt><b>Origin</b></font>
                </td>
                <td align="center" colspan=2>
                <font class=bluefnt><b>Destination</b></font>
                </td>
            </tr>
            
              <tr style="background-color: white">
                <td align="left" valign="top">
                  <font class=bluefnt>Address</font>
                </td>
                <td align="left">
                  <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel4" Visible="true">
                            <asp:TextBox ID="txtOrgnAddr" runat=server TextMode="MultiLine" Rows="3" Columns="38" BorderStyle="Groove"></asp:TextBox>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                       <%-- <asp:AsyncPostBackTrigger ControlID="cboRequestBy" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="cboCategory" EventName="SelectedIndexChanged" />--%>
                        
                    </Triggers>
                  </asp:UpdatePanel>
                                              
                </td>
                <td align="left" valign="top">
                <font class=bluefnt>Address</font>
                </td>
                <td align="left">
                <asp:TextBox ID="txtDestnAddr" runat=server TextMode="MultiLine" Rows="3" Columns="38" BorderStyle="Groove"></asp:TextBox>
                </td>
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>City-Pin</font>
                </td>
                <td align="left">
                 <asp:DropDownList ID="cboOrgnCity" runat=server OnSelectedIndexChanged="FillPickupLoc" AutoPostBack=true></asp:DropDownList>
                 <asp:RequiredFieldValidator ID="ReqOrgnCity" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboOrgnCity"></asp:RequiredFieldValidator>
                 &nbsp;-&nbsp;
                 <asp:UpdatePanel ID="UpdatePanel7" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel7" Visible="true">
                            <asp:TextBox ID="txtOrgnPincode" runat=server MaxLength="6" Width="50" BorderStyle="Groove"></asp:TextBox>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                 <%--       <asp:AsyncPostBackTrigger ControlID="cboRequestBy" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="cboCategory" EventName="SelectedIndexChanged" />--%>
                    </Triggers>
                  </asp:UpdatePanel>
                  
                </td>
                <td align="left">
                <font class=bluefnt>City-Pin</font>
                </td>
                <td align="left">
                <asp:DropDownList ID="cboDestnCity" runat=server OnSelectedIndexChanged="FillPickupLoc" AutoPostBack=true></asp:DropDownList>
                 <asp:RequiredFieldValidator ID="ReqDestnCity" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboDestnCity"></asp:RequiredFieldValidator>
                 &nbsp;-&nbsp;
                 <asp:TextBox ID="txtDestnPincode" runat=server MaxLength="6" Width="50" BorderStyle="Groove"></asp:TextBox>

                </td>
            </tr>
            
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Location</font>
                </td>
                <td align="left">
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
                <td align="left">
                <font class=bluefnt>Location</font>
                </td>
                <td align="left">
                <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel2" Visible="true">
                            <asp:DropDownList ID="cboDestnLoc" runat=server ></asp:DropDownList>
                           <%-- <asp:RequiredFieldValidator ID="ReqDestnLoc" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboDestnLoc"></asp:RequiredFieldValidator>--%>
                        </asp:Panel>
                   </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboDestnCity" EventName="SelectedIndexChanged" />
                    </Triggers>
                 </asp:UpdatePanel>
                </td>
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Phone</font>
                </td>
                <td align="left">
                <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel5" Visible="true">
                            <asp:TextBox ID="txtOrgnTelno" runat=server MaxLength="50" Width="200" BorderStyle="Groove"></asp:TextBox>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                       <%-- <asp:AsyncPostBackTrigger ControlID="cboRequestBy" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="cboCategory" EventName="SelectedIndexChanged" />--%>
                    </Triggers>
                  </asp:UpdatePanel>
                  
                </td>
                <td align="left">
                <font class=bluefnt>Phone</font>
                </td>
                <td align="left">
                <asp:TextBox ID="txtDestnTelno" runat=server MaxLength="50" Width="200" BorderStyle="Groove"></asp:TextBox>
                </td>
            </tr>
            
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Email</font>
                </td>
                <td align="left">
                <asp:UpdatePanel ID="UpdatePanel6" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel6" Visible="true">
                            <asp:TextBox ID="txtOrgnEmail" runat=server MaxLength="50" Width="200" BorderStyle="Groove"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="ReguOrgnEmail" runat="server" ErrorMessage="!"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtOrgnEmail" Display='Dynamic'></asp:RegularExpressionValidator>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                      <%--  <asp:AsyncPostBackTrigger ControlID="cboRequestBy" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="cboCategory" EventName="SelectedIndexChanged" />--%>
                    </Triggers>
                  </asp:UpdatePanel>
                </td>
                <td align="left">
                <font class=bluefnt>Email</font>
                </td>
                <td align="left">
                <asp:TextBox ID="txtDestnEmail" runat=server MaxLength="50" Width="200" BorderStyle="Groove"></asp:TextBox>
                <asp:RegularExpressionValidator ID="ReguDestnEmail" runat="server" ErrorMessage="!"
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtDestnEmail" Display='Dynamic'></asp:RegularExpressionValidator>

                </td>
            </tr>
            
             
            
            <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Vehicle Criteria"></asp:Label></td>
            </tr>
             <tr style="background-color: white">
                <td colspan="4" align="left">
                    <table  cellspacing="1" cellpadding="3" style="width: 100%" class="boxbg" border="0">
                       <tr style="background-color: white">
                           <td><font class=blackfnt>Vehicle Type</font></td>
                           <td> <asp:DropDownList ID="cboVehType" runat=server ></asp:DropDownList>
                           <asp:RequiredFieldValidator ID="ReqVehType" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboVehType"></asp:RequiredFieldValidator>
                           </td>
                        </tr>
                       
                    </table>
                
                </td>
              </tr>  
            
                     
            
             <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Start date & time</font>
                </td>
                <td align="left">
                 <DateCalendar:header id="DtCalStDt" runat="server"></DateCalendar:header>
                 <asp:DropDownList ID="cboStDt_HH" runat=server>
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
                 :
                 <asp:DropDownList ID="cboStDt_MM" runat=server>
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
                 
                  <asp:DropDownList ID="cboStDt_AMPM" runat=server>
                  <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                  <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                 </asp:DropDownList>
                 
                </td>
                <td align="left">
                <font class=bluefnt>End date & time</font>
                </td>
                <td align="left">
                <DateCalendar:header id="DtCalEdDt" runat="server"></DateCalendar:header>
                <asp:DropDownList ID="cboEdDt_HH" runat=server>
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
                 :
                 <asp:DropDownList ID="cboEdDt_MM" runat=server>
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
                  <asp:DropDownList ID="cboEdDt_AMPM" runat=server>
                  <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                  <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                 </asp:DropDownList>
                </td>
            </tr>
            
           
        </table>
        
        <p align=center><asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="SubmitData" /></p><%--nClick="OnSubmit"--%>
    </p>
     
</asp:Content>            

