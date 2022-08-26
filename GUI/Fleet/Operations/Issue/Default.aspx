<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
  <table cellspacing="1" cellpadding="3" style="width: 95%" align="left" class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="left">
    
                
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                                        <asp:Label ID="lblError1"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                    </td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CLOSE/UPDATE VEHICLE ISSUE SLIP"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
            
              <td colspan=4 align=left style="background-color: white">   
                <%--<table border="1" cellpadding="1" cellspacing="0" class="boxbg" width="72%">

                <tr style="background-color: white">
                    <td align="left" >
                        <font class="bluefnt">Issue Slip Id</font>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblIssueNo" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="left">
                        <font class=bluefnt>Manual Tripsheet No.</font>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblManualNo" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>

            
              
            
             <tr style="background-color: white">
                <td align="left">
                <font class=bluefnt>Issue Slip Date</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueDt" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left" >
                  <font class="bluefnt">Issue Slip Close Date</font>
                </td>
                <td align="left">
                           <SControls:DateSelector ID="txtDateFrom" runat="server" /> 
                </td>
            </tr>
            
             <tr style="background-color: white">
                <td align="left" >
                  <font class="bluefnt">Starting Location</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblStartLoc" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
                <font class=bluefnt>End Location</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblEndLoc" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            
            
            
              <tr style="background-color: white">
                <td align="left" >
                  <font class="bluefnt">Category</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblCategory" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
             <asp:Label ID="lblCustCodeHead" runat="server" CssClass="bluefnt"  Text="Customer Code"  Visible="false"></asp:Label>
                <asp:Label ID="lblMarketHead" runat="server" CssClass="bluefnt"  Text="Market/Own"  Visible="false"></asp:Label>
                </td>
                <td align="left">
                  <asp:Label ID="lblCustcodeMarket" runat="server" CssClass="blackfnt"></asp:Label>
                  
                </td>
            </tr>
            <tr  style="background-color: white">
                <td >
                    <font class="bluefnt">Route</font>
                </td>
                <td colspan="3" >
                    <asp:Label ID="lblRoute" runat="server" CssClass="blackfnt"></asp:Label>
                </td> 
            </tr>
            
        
          <%if (lblCategory.Text=="External Usage")
                 { %>
                      <tr  style="background-color: white">
                        <td><font class="bluefnt">Enter no. of THCs</font></td>
                        <td colspan="3" ><font class="bluefnt"><asp:TextBox ID="txtAddTHCrow" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"
                        OnTextChanged="add_rowTHC" AutoPostBack="true"></asp:TextBox></font></td>
                      </tr>
                      <tr style="background-color: white">
                        <td colspan="4">
                        
                        <asp:DataGrid ID="dgTHC" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                    CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgTHCDet_ItemDataBound">
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                            <ItemTemplate>
                                                <center>
                                                    <%# Container.ItemIndex+1 %>
                                                    .
                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                </center>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="From">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtFrom" runat="server"   Width="150px"
                                                    BorderStyle="Groove" MaxLength="100" CssClass="input"></asp:TextBox>
                                                 <asp:RequiredFieldValidator ID="reqFrom" runat="server" Display="Dynamic" Text="!"
                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtFrom"></asp:RequiredFieldValidator>
                                        
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="To">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTo" runat="server" MaxLength="100" Width="150px"
                                                    BorderStyle="Groove" CssClass="input"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqTo" runat="server" Display="Dynamic" Text="!"
                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtTo"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        <asp:TemplateColumn HeaderText="THC No.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTHCNo" runat="server"   Width="100px"
                                                    BorderStyle="Groove" MaxLength="100" CssClass="input"></asp:TextBox>
                                                      <asp:RequiredFieldValidator ID="reqTHCNo" runat="server" Display="Dynamic" Text="!"
                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtTHCNo"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        <asp:TemplateColumn HeaderText="THC Date">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTHCDt" runat="server"   Width="65px"
                                                    BorderStyle="Groove" MaxLength="10" CssClass="input"></asp:TextBox>
                                                     <asp:RequiredFieldValidator ID="reqTHCDt" runat="server" Display="Dynamic" Text="!"
                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtTHCDt"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        <asp:TemplateColumn HeaderText="Freight Amount">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtFreightAmt" runat="server"   Width="60px"
                                                    BorderStyle="Groove" MaxLength="6" CssClass="input" AutoPostBack=true OnTextChanged="CalcTHCContractAmt"></asp:TextBox>
                                                    
                                                    
                                                     <asp:RequiredFieldValidator ID="reqFreightAmt" runat="server" Display="Dynamic" Text="!"
                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtFreightAmt"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegFreightAmt" runat="server" ErrorMessage="!"
                                        ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtFreightAmt"
                                        Display="Dynamic"></asp:RegularExpressionValidator>
                                                    
                                                    
                                                    
                                           </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        <asp:TemplateColumn HeaderText="Labour charge">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtLabourChrg" runat="server"   Width="60px"
                                                    BorderStyle="Groove" MaxLength="6" CssClass="input" AutoPostBack=true OnTextChanged="CalcTHCContractAmt"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqLabourChrg" runat="server" Display="Dynamic" Text="!"
                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtLabourChrg"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegLabourChrg" runat="server" ErrorMessage="!"
                                        ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtLabourChrg"
                                        Display="Dynamic"></asp:RegularExpressionValidator>
                                        
                                           </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        <asp:TemplateColumn HeaderText="Other charge" >
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtOtherChrg" runat="server"   Width="60px"
                                                    BorderStyle="Groove" MaxLength="6" CssClass="input" AutoPostBack=true OnTextChanged="CalcTHCContractAmt"></asp:TextBox>
                                                    
                                                    <asp:RequiredFieldValidator ID="reqOtherChrg" runat="server" Display="Dynamic" Text="!"
                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtOtherChrg"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegOtherChrg" runat="server" ErrorMessage="!"
                                        ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtOtherChrg"
                                        Display="Dynamic"></asp:RegularExpressionValidator>
                                        
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        <asp:TemplateColumn HeaderText="Total">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTHCTotalAmt" runat="server"   Width="60px"
                                                    BorderStyle="Groove" MaxLength="6" ReadOnly="true" CssClass="input"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        
                                    </Columns>
                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <ItemStyle ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey" Font-Italic="False"
                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                </asp:DataGrid>
                                
                        
                        
                        </td>
                      </tr>
                                                          
                   <tr style="background-color: white">
                    <td><font class="bluefnt"><b>Total Freight Amount</b></font></td>
                    <td><asp:Label ID="TotFreightChrg" runat=server CssClass="blackfnt" Font-Bold=true></asp:Label></td>
                    <td><font class="bluefnt"><b>Total Labour Charge</b</font></td>
                    <td><asp:Label ID="TotLabourChrg" runat=server CssClass="blackfnt" Font-Bold=true></asp:Label></td>
                   </tr>  
                   
                   <tr style="background-color: white">
                    <td><font class="bluefnt"><b>Total Other Amount</b</font></td>
                    <td><asp:Label ID="TotOtherChrg" runat=server CssClass="blackfnt" Font-Bold=true></asp:Label></td>
                    <td><font class="bluefnt"><b>Total Amount</b</font></td>
                    <td><asp:Label ID="TotChrg" runat=server CssClass="blackfnt" Font-Bold=true></asp:Label></td>
                   </tr> 
                                                             
            <%} %>
                                              
              </table>--%>
                 </td>
            </tr>
        
  <tr>
     <td colspan=4 align=left style="background-color: white">   
       <table border="1" cellpadding="1" cellspacing="0"  class="boxbg" width="72%">
       <tr style="background-color: white" >
              <td align="left" colspan="4" >
                  <font class="redfnt">
                      <asp:Label ID="lbl_Closing_KM_Err" runat="server" Text=""></asp:Label></font>
                </td>
            </tr>
       
       
         <tr style="background-color: white" >
              <td align="left"  >
                  <font class="bluefnt">Vehicle No.</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblVehno" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                
                <td align="left" >
                  <font class="bluefnt">Driver</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblDriverName" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                
            </tr>
            
            <tr style="background-color: white" >
              <td align="left"  >
                  <font class=bluefnt>Vehicle Type</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblFTLType" runat="server"CssClass="blackfnt"></asp:Label>
                </td>
                
                <td colspan="2">
                  
                </td>
                
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Driver License No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                        <asp:Label ID="lblLicno" runat="server" CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>License Valid upto</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:Label ID="lblValidDt" runat="server" CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Starting Km. Reading</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblStartKm" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left" >
                  <font class=bluefnt>Closing Km. Reading</font>
                </td>
                <td align="left"> 
          
               
                    <asp:TextBox ID="txtCloseKM" runat="server" BorderStyle="Groove" Width="100" MaxLength="6"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    CssClass="input" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="reqCloseKM" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo"     ControlToValidate="txtCloseKM"></asp:RequiredFieldValidator>

                </td>
                
                
                
                </tr>
                
                <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Fuel filled Ltrs.</font>
                </td>
                 <td align="left" >
                   <asp:Label ID="lblFuelFilled" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Fuel Filled enroute</font>
                </td>
                 <td align="left">
             
                 
                    <asp:TextBox ID="txtFuelFilledEnroute" runat="server"     ReadOnly="true" Text="0"   BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input" AutoPostBack="true"    OnTextChanged="txtFuelFilledEnroute_TextChanged"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="ReqFuelFilledEnroute"  ValidationGroup="VGDtFromTo"     runat="server" Display="Dynamic" Text="!" ControlToValidate="txtFuelFilledEnroute"></asp:RequiredFieldValidator>
                                              


                </td>
                </tr>
           
           
             <tr style="background-color: white">
             <td align="left" >
                  <font class=bluefnt>Total Kms.</font>
                </td>
                <td align="left"> 
                
              
                    <asp:TextBox ID="txtTotalKms" runat="server" BorderStyle="Groove" Width="100" MaxLength="6"    ReadOnly="true" CssClass="input"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo"     ControlToValidate="txtCloseKM"></asp:RequiredFieldValidator>
                                                   

              


                </td>
           
           <td  >
             <font class=bluefnt>Actual KMPL</font>
           
           
           
           
           
           </td>
           
           
          <td>
               
              <asp:TextBox ID="txtKMPL" CssClass="blackfnt" runat="server" BorderStyle="None" ></asp:TextBox>
           </td> 
           
           
           
           </tr>
           
                <tr style="background-color: white">
             <td align="left" >
                  <font class=bluefnt>Approved KMPL.</font>
                </td>
                <td align="left"> 
              
                    <asp:TextBox ID="txtApprKMPL"  BorderStyle="Groove" Width="100" MaxLength="6"   CssClass="blackfnt"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqtxtApprKMPL" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo"     ControlToValidate="txtApprKMPL"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegApprKMPL" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtApprKMPL" Display="Dynamic"></asp:RegularExpressionValidator>
              </td>
              <td colspan="2">
              </td>
              
              
              </tr>
              
              
               <tr style="background-color: white">
             <td align="left" >
                  <font class=bluefnt>Approved Diesel (liters)</font>
                </td>
                <td align="left"> 
                    
                    <asp:TextBox ID="txtApprovedDiesel" runat="server" CssClass="blackfnt" Text="" BorderStyle="None"  />              
                    <asp:HiddenField ID="hfKMPL" runat="server" />
              </td>
              <td colspan="2">
              </td>
              
              
              </tr>
              
              
              
               <tr style="background-color: white">
             <td align="left" >
                  <font class=bluefnt>Average Diesel Rate</font>
                </td>
                <td align="left"> 
                    <asp:Label ID="lblAverageDieselRate" runat="server" CssClass="blackfnt" Text=""></asp:Label>              
                </td>
              <td align="left" >
                  <font class=bluefnt>Approved Fuel Amount</font>
                </td>
                <td align="left"> 
                    <asp:TextBox ID="txtApprovedFuelAmt" CssClass="blackfnt" runat="server" BorderStyle="None" ></asp:TextBox>
                </td>
              
              
              </tr>
              
              
     
            
             <tr style="background-color: white">
                <td colspan=4 align="center">
            
                              <table border="0" Width="100%">
                                 <tr>
                                    <td style="text-align: left">
                                    
                                    <asp:DataGrid ID="dgAdvanceDet" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgAdvanceDet_ItemDataBound">
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Place">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAdvPlace"     runat="server"  ReadOnly="true"    CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqAdvPlace" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvPlace"></asp:RequiredFieldValidator>
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Advance Date (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAdvDt" runat="server" MaxLength="10"  ReadOnly="true"     Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                  <asp:RequiredFieldValidator ID="reqAdvDt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvDt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVAdvDt" runat="server" ControlToValidate="txtAdvDt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Amount">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtAdvAmt"  runat="server" CssClass="input"  ReadOnly="true"    Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqAdvAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvAmt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Branch Name">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBranchCode" runat="server"  ReadOnly="true"   CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqBranchCode" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtBranchCode"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Advance paid by">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSignature" runat="server"  ReadOnly="true"    CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqSignature" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtSignature"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
                                    
                                    
                                    
                                     
                                    </td>
                                 </tr>
                               </table>  
                                      
                                                        

                </td>
            </tr>
              
         </table>
        </td>
      </tr>              
            
            
            <tr class="bgbluegrey">
                <td colspan=4 align="center"><font class=blackfnt><b>HSD/OIL Expenses</b></font></td>
            </tr>
            
            <tr style="background-color: white">
                <td width="5%" nowrap><font class="blackfnt">Enter no. of rows</font></td>
                <td colspan="3" align="left"><asp:TextBox ID="txtAddRowOilExp" runat="server" MaxLength="3" Width="30"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" OnTextChanged="add_rowOil" AutoPostBack=true ></asp:TextBox></td>
            </tr>
            
             <tr style="background-color: white">
                <td colspan=4 align="center">

              <table border="0" Width="100%">
                 <tr>
                    <td style="text-align: left">
                     
                    <asp:DataGrid ID="dgHSD_OIL_EXP" runat="server" AutoGenerateColumns="False"
                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgHSD_OIL_EXP_ItemDataBound" >
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                            <ItemTemplate>
                                                <center>
                                                    <%# Container.ItemIndex+1 %>.
                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                </center>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        <asp:TemplateColumn HeaderText="Place">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtOilPlace" runat="server" CssClass="input" Width="80px" BorderStyle="Groove" MaxLength="50" Enabled=false ></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqOilPlace" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo" ControlToValidate="txtOilPlace"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        
                                        
                                        
                                           <asp:TemplateColumn HeaderText="Petrol Pump Name">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlPPName" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="50" Enabled=false></asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="reqPPName" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo"    ControlToValidate="ddlPPName"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                        
                                           <asp:TemplateColumn HeaderText="Brand">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlBrand" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="50" Enabled=false></asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="reqBrand" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo"   ControlToValidate="ddlBrand"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        
                                           <asp:TemplateColumn HeaderText="Fuel Type">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlFuelType" runat="server" CssClass="input" Width="70px" BorderStyle="Groove" Enabled=false></asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="reqFuelType" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo" ControlToValidate="ddlFuelType"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        
                                        
                                           <asp:TemplateColumn HeaderText="Last Km Reading">
                                            <ItemTemplate>
                                                <asp:Label ID="txtLKmRead" runat="server"  Width="20px"   ></asp:Label>

                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                        
                                         <asp:TemplateColumn HeaderText="KM Reading">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtKM_Reading" runat="server" CssClass="input" Width="60px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    BorderStyle="Groove" MaxLength="6" AutoPostBack="True" OnTextChanged="txtKM_Reading_TextChanged" Enabled=false></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqKM_Reading" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo" ControlToValidate="txtKM_Reading"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegKM_Reading" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtKM_Reading" Display="Dynamic"></asp:RegularExpressionValidator>
                                                  
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                         <asp:TemplateColumn HeaderText="Bill No.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtBillno" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="25" Enabled=false></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqBillno" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo"  ControlToValidate="txtBillno"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn> 
                                        
                                         <asp:TemplateColumn HeaderText="Bill Date (dd/mm/yyyy)">
                                            <ItemTemplate>
                                                  <asp:TextBox ID="txtBilldt" runat="server" MaxLength="10" Width="65" BorderStyle="Groove" Enabled=false></asp:TextBox>
                                                  <asp:RequiredFieldValidator ID="reqBilldt" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo"  ControlToValidate="txtBilldt"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="REVBilldt" runat="server" ControlToValidate="txtBilldt"
                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            Width="1px"></asp:RegularExpressionValidator>
                                        </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        <asp:TemplateColumn HeaderText="Diesel (Qtn. in litres)">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtDiesel_Ltr" runat="server" CssClass="input" Width="60px"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" MaxLength="6" OnTextChanged="Diesel_Oil_Calc" AutoPostBack=true Enabled=false></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqDiesel_Ltr" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo"   ControlToValidate="txtDiesel_Ltr"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegDiesel_Ltr" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtDiesel_Ltr" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                         <asp:TemplateColumn HeaderText="Diesel Rate/litres">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtDieselRate_Ltr" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    MaxLength="6" OnTextChanged="Diesel_Oil_Calc" AutoPostBack=true Enabled=false></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqDieselRate_Ltr" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo" ControlToValidate="txtDieselRate_Ltr"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegDieselRate_Ltr" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtDieselRate_Ltr" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                        <asp:TemplateColumn HeaderText="Amount">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  ReadOnly=true Enabled=false></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqAmt" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo" ControlToValidate="txtAmt"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        
                                         <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtExeAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   ReadOnly=false Enabled=false></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqExeAmt" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo" ControlToValidate="txtExeAmt"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegExeAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtExeAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        
                                        
                                        
                                        
                                            <asp:TemplateColumn HeaderText="By Card/Cash">
                                            <ItemTemplate>
                                            <asp:DropDownList ID="ddlPayment" runat="server" CssClass="input" Width="80px" BorderStyle="Groove" Enabled=false OnSelectedIndexChanged="CardNo_Dispaly" AutoPostBack=true>
                                               <asp:ListItem >select</asp:ListItem>
                                                <asp:ListItem >Cash</asp:ListItem>
                                                <asp:ListItem>Diesel Card</asp:ListItem>
                                            </asp:DropDownList>
                                            <BR>
                                            <asp:Label ID="FCCard" runat="server"></asp:Label>
                                                <asp:RequiredFieldValidator ID="reqPayment" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo" ControlToValidate="ddlPayment"></asp:RequiredFieldValidator>

                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                            <asp:TemplateColumn HeaderText="Remarks">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"  ReadOnly=false Enabled=false></asp:TextBox>
                                              
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                                                                              
                                           </Columns>
                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <ItemStyle ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                </asp:DataGrid>
                    
                    
                    
                     
                    </td>
                 </tr>
               </table>  
               
               
               </td>
               </tr>
               </table>
    </form>
</body>
</html>
