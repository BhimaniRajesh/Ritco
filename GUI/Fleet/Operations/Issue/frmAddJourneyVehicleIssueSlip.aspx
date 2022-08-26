<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmAddJourneyVehicleIssueSlip.aspx.cs" Inherits="Issue_frmAddJourneyVehicleIssueSlip" %>


<%--<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>--%>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


<script language="javascript">


function fnCheckSel(intObjId)
{
//ctl00_MyCPH1_DataGrid1_ctl02_chksel
 var strSceTypeId; 
 strSceTypeId = intObjId + "1"
 for (var i=1; i<document.forms(0).length; i++) 
  { 
     if(document.forms(0).elements[i].id )
      { 
        if(document.forms(0).elements[i].id.indexOf("chksel")!=-1)
         {
            //alert(document.forms(0).elements[i].id ); 
            /*if (document.forms(0).elements[i].id.indexOf("chksel")==-1)
             { 
                alert("hi")
                document.forms(0).elements[i].checked=false
              }*/
              document.forms(0).elements[i].checked=false
         }
      }
  } 
 document.getElementById(intObjId).checked=true
}


function fnCheckVal(intObjId)
{
 var found_it ;
 for (var i=1; i<document.forms(0).length; i++)   
   { 
      if(document.forms(0).elements[i].id )
       { 
        if(document.forms(0).elements[i].id.indexOf("chksel")!=-1) 
         {
            if (document.forms(0).elements[i].checked)
             {// Set the flag if any radio button is checked
                found_it = true;
                break;
             }
         }
       }
   } 
 
 if(!found_it)
 {
  alert("Select atleast one request");
  return false;
 }
 else 
 {
   return true;
 } 
}

</script>

 <p align="center">
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
      <table cellspacing="1" cellpadding="3" style="width: 95%" align=center class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor=red></asp:Label></td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="VEHICLE ISSUE SLIP FORM"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Issue Slip Id</font>
                </td>
                <td align="left">
                   <asp:DropDownList ID="cboIssueSlipNo" runat=server OnSelectedIndexChanged="DisplayIssueDt" AutoPostBack="true"></asp:DropDownList>
                   <asp:RequiredFieldValidator ID="ReqIssueSlipNo" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboIssueSlipNo"></asp:RequiredFieldValidator>
                </td>
                <td align="left">
                <font class=bluefnt>Issue Slip Date</font>
                </td>
                <td align="left">
               <%--<DateCalendar:header id="DtCal" runat="server" ></DateCalendar:header>--%>
               <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel3" Visible="true">
                                <asp:Label ID="lblIssueDt" runat=server CssClass="blackfnt"></asp:Label>
                        </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboIssueSlipNo" EventName="SelectedIndexChanged" />
                    </Triggers>
               </asp:UpdatePanel>
                </td>
            </tr>
            
            
            <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Vehicle No.</font>
                </td>
                <td align="left">
                <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel1" Visible="true">
                   <asp:Label ID="lblVehno" runat="server" CssClass="blackfnt"></asp:Label>
                   </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboIssueSlipNo" EventName="SelectedIndexChanged" />
                    </Triggers>
               </asp:UpdatePanel>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Driver</font>
                </td>
                <td align="left">
                <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel2" Visible="true">
                   <asp:Label ID="lblDriver" runat="server" CssClass="blackfnt"></asp:Label>
                   </asp:Panel>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboIssueSlipNo" EventName="SelectedIndexChanged" />
                    </Triggers>
               </asp:UpdatePanel>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Driver License No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                     <asp:UpdatePanel ID="UpdatePanel13" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="lblLicno" runat=server CssClass="balckfnt"></asp:Label>
                     </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboIssueSlipNo" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   </font>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>License Valid upto</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                   <asp:Label ID="lblValidDt" runat=server CssClass="balckfnt"></asp:Label>
                    </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboIssueSlipNo" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   </font>
                </td>
                
            </tr>
            
            
            
            <tr style="background-color: white">
                <td colspan=4 align=center>
                <br>
                <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="95%">
                    <tr bgcolor="white">
                        <td style="height:19px">
                             <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left OnItemDataBound="DataGrid1_ItemDataBound" >
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
	                            <asp:TemplateColumn HeaderText="Select">
	                                <ItemTemplate>
	                                    <asp:RadioButton ID="chksel"  runat="server" />
	                                </ItemTemplate>
	                             </asp:TemplateColumn>
        	                     
	                              <asp:TemplateColumn HeaderText="Req.ID" >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtReqId" runat="server" BorderStyle="Groove" Width="90px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="Req. By" HeaderStyle-HorizontalAlign=Left>
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtReqBy" runat="server" BorderStyle="Groove" Width="150px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                               <asp:TemplateColumn HeaderText="Req. Date">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtReqDt" runat="server" BorderStyle="Groove" Width="60px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="Orign City">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtOrgnCity" runat="server" BorderStyle="Groove" Width="75px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                               <asp:TemplateColumn HeaderText="Destn. City">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtDestnCity" runat="server" BorderStyle="Groove" Width="75px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="Start date">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtStDt" runat="server" BorderStyle="Groove" Width="90px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                              <asp:TemplateColumn HeaderText="End date">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtEdDt" runat="server" BorderStyle="Groove" Width="90px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
	                               <asp:TemplateColumn HeaderText="Passengers">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtPassNo" runat="server" BorderStyle="Groove" Width="30px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
        	                      
        	                      
	                               <asp:TemplateColumn HeaderText="Vehicle Type" >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtVehType" runat="server" BorderStyle="Groove" Width="75px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                            </Columns>
	                        </asp:datagrid>&nbsp;
	                        <asp:Label ID="lblDataError" runat=server ForeColor=red CssClass="blackfnt"></asp:Label>
		               </td>
                    </tr>
            </table>
         </td>
        </tr> 
        
        <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Journey Starting Km. Reading</font>
                </td>
                <td align="left" colspan=3>
                   <font class=blackfnt >
                     <asp:TextBox ID="txtStartKM" runat=server BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="reqStartKM" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtStartKM"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegStartKM" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtStartKM" Display="Dynamic"></asp:RegularExpressionValidator>
                    </font>
                </td>
                <%--<td align="left" >
                  <font class=bluefnt>Fuel Filled Ltrs.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:TextBox ID="txtFuel" runat=server BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="ReqFuel" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtFuel"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegFuel" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtFuel" Display="Dynamic"></asp:RegularExpressionValidator>
                    </font>
                </td>--%>
                </tr>
                <tr style="background-color: white"><td colspan=4 align=right>
                             <p align=right><asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="SubmitData" /></p>
                 </td>            
                 </tr>

        
     </table>
     </p>
        
       
  

</asp:Content> 