<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmCloseVehicleIssueSlip1.aspx.cs" Inherits="Issue_frmCloseVehicleIssueSlip" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

        
        

<p align="center">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Close Trip Sheet</asp:Label>
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
    </p>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br/> 
      
      <P align="center">
 <%-- <asp:UpdatePanel ID="UpdatePanel3"       UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel3" Visible="true">--%>
      <table cellspacing="1" cellpadding="3" style="width: 95%" align=center class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor=red></asp:Label></td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CLOSE TRIP SHEET"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Trip Sheet No.</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueNo" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
                <font class=bluefnt>Trip Sheet Date</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueDt" runat=server CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            
            <tr style="background-color: white">
                <td colspan=4 align=center>
                <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="100%">
                    <tr bgcolor="white">
                        <td style="height:19px">
                             <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left  ><%--OnItemDataBound="DataGrid1_ItemDataBound"--%>
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                <asp:BoundColumn DataField="Request_Id" HeaderText="Req.ID">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="Request_By" HeaderText="Req. By">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Request_dt" HeaderText="Req. Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Orgn_city" HeaderText="Orign City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="Destn_city" HeaderText="Destn. City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <%--<asp:BoundColumn DataField="Destn_city" HeaderText="Destn. City">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>--%>
                                
                                <asp:BoundColumn DataField="Start_date_time" HeaderText="Start date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="End_dt_tm" HeaderText="End date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <%-- <asp:BoundColumn DataField="No_Passenger" HeaderText="Passengers">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>--%>
                                
                                
                                  <asp:BoundColumn DataField="Vehtype" HeaderText="Vehicle Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
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
                  <font class=bluefnt>Vehicle No.</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblVehno" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Driver</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblDriverName" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Driver License No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                        <asp:Label ID="lblLicno" runat=server CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>License Valid upto</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:Label ID="lblValidDt" runat=server CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Starting Km. Reading</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblStartKm" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left" >
                  <font class=bluefnt>Closing Km. Reading</font>
                </td>
                <td align="left">
                    <asp:TextBox ID="txtCloseKM" runat=server BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="reqCloseKM" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCloseKM"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegCloseKM" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtCloseKM" Display="Dynamic"></asp:RegularExpressionValidator>

                </td>
                </tr>
                
                <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Fuel filled Ltrs.</font>
                </td>
                 <td align="left" >
                   <asp:Label ID="lblFuelFilled" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Fuel Filled enroute</font>
                </td>
                 <td align="left">
                    <asp:TextBox ID="txtFuelFilledEnroute" runat=server BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="ReqFuelFilledEnroute" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtFuelFilledEnroute"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegFuelFilledEnroute" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtFuelFilledEnroute" Display="Dynamic"></asp:RegularExpressionValidator>

                </td>
                </tr>
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
              
              
              
              
            <tr class="bgbluegrey">
                <td colspan=4 align=center><font class=blackfnt><b>Details of Advance Taken</b></font></td>
            </tr>
            
            <tr style="background-color: white">
                <td width="15%"><font class=blackfnt>Enter no. of rows</font></td>
                <td colspan=3><asp:TextBox ID="txtAddRowAdv" runat=server MaxLength="3" Width="30" BorderStyle="Groove" OnTextChanged="add_rowAdv" AutoPostBack=true></asp:TextBox></td>
            </tr>
            
             <tr style="background-color: white">
                <td colspan="4" align="center">
                 <asp:UpdatePanel ID="UpdatePanel1"      UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel1" Visible="true">
                              <table border="0" Width="100%">
                                 <tr>
                                    <td>
                                    
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
                                                                <%--<asp:DropDownList ID="cboAdvPlace" runat=server>
                                                                  <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                                                </asp:DropDownList>--%>
                                                                
                                                                <asp:TextBox ID="txtAdvPlace" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqAdvPlace" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvPlace"></asp:RequiredFieldValidator>
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Advance Date (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAdvDt" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
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
                                                            <asp:TextBox ID="txtAdvAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
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
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="THC No.">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtTHCno" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqTHCno" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtTHCno"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Branch Code">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBranchCode" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqBranchCode" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtBranchCode"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Signature">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSignature" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
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
                </asp:Panel>
                   </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddRowAdv" EventName="TextChanged" />
                    </Triggers>
                 </asp:UpdatePanel>                                     
                                                        

                </td>
            </tr>
              
              
            
            
            <tr style="background-color: white">
                <td colspan=4 align=center><font class=blackfnt><b>HSD/OIL Expenses</b></font></td>
            </tr>
            
            <tr style="background-color: white">
                <td width="15%"><font class=blackfnt>Enter no. of rows</font></td>
                <td colspan=3><asp:TextBox ID="txtAddRowOilExp" runat=server MaxLength="3" Width="30" BorderStyle="Groove" OnTextChanged="add_rowOil" AutoPostBack=true></asp:TextBox></td>
            </tr>
            
             <tr style="background-color: white">
                <td colspan=4 align=center>
                 <asp:UpdatePanel ID="UpdatePanel4"     UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel4" Visible="true">
                              <table border="0" Width="100%">
                                 <tr>
                                    <td>
                                    
                                    <asp:DataGrid ID="dgHSD_OIL_EXP" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgHSD_OIL_EXP_ItemDataBound">
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
                                                                <asp:TextBox ID="txtOilPlace" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqOilPlace" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtOilPlace"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                          
                                                        <asp:TemplateColumn HeaderText="Petrol Pump Name">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtPPName" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqPPName" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtPPName"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="KM Reading">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtKM_Reading" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqKM_Reading" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtKM_Reading"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegKM_Reading" runat="server"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                    ControlToValidate="txtKM_Reading" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                         <asp:TemplateColumn HeaderText="Bill No.">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBillno" runat="server" CssClass="input" Width="80px" BorderStyle="Groove" MaxLength="25"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqBillno" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtBillno"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn> 
                                                        
                                                         <asp:TemplateColumn HeaderText="Bill Date (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtBilldt" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                  <asp:RequiredFieldValidator ID="reqBilldt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtBilldt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVBilldt" runat="server" ControlToValidate="txtBilldt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Diesel (Qtn. in litres)">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtDiesel_Ltr" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqDiesel_Ltr" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDiesel_Ltr"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegDiesel_Ltr" runat="server"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                    ControlToValidate="txtDiesel_Ltr" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Oil (Qtn. in litres)">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtOil_Ltr" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqOil_Ltr" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtOil_Ltr"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegOil_Ltr" runat="server"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                    ControlToValidate="txtOil_Ltr" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAmt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegAmt" runat="server"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                    ControlToValidate="txtAmt" Display="Dynamic"></asp:RegularExpressionValidator>
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
                </asp:Panel>
                   </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddRowOilExp" EventName="TextChanged" />
                    </Triggers>
                 </asp:UpdatePanel> 
                 
             </td></tr>
             
             
             <tr style="background-color: white">
                <td colspan=4>
                 <table cellspacing="1" cellpadding="3" style="width: 100%" align=center class="boxbg" border="0">
            
                    <tr style="background-color: white">
                        <td width="20%"><font class=blackfnt>Actual KMPL</font></td>
                        <td>
                            <asp:TextBox ID="txtActual_KMPL" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqActual_KMPL" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtActual_KMPL"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegActual_KMPL" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                ControlToValidate="txtActual_KMPL" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                        <td></td>
                        <td></td>
                         <td rowspan=4 align=center valign=middle width="20%"><font class=blackfnt>Amount</font></td>
                        <td rowspan=4 align=center>
                            <asp:TextBox ID="txtAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAmt"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegAmt" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                ControlToValidate="txtAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                        
                        </td>
                       </tr> 
                       
                       <tr style="background-color: white">
                        <td ><font class=blackfnt>Actual Approved</font></td>
                        <td>
                            <asp:TextBox ID="txtKMPL_Approved" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqKMPL_Approved" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtKMPL_Approved"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegKMPL_Approved" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                ControlToValidate="txtKMPL_Approved" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                        </td>
                        <td></td>
                        <td></td>
                        
                       </tr> 
                       
                         <tr style="background-color: white">
                        <td ><font class=blackfnt>Approved No. of litres</font></td>
                        <td>
                            <asp:TextBox ID="txtApprovedLtrs" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqApprovedLtrs" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtApprovedLtrs"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegApprovedLtrs" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                ControlToValidate="txtApprovedLtrs" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                        
                        </td>
                        <td width="20%"><font class=blackfnt>Approved @ of</font></td>
                        <td>

                            <asp:TextBox ID="txtApprovedRate" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqApprovedRate" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtApprovedRate"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegApprovedRate" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                ControlToValidate="txtApprovedRate" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                        
                        </td>
                         
                       </tr> 
                       
                         <tr style="background-color: white">
                        <td ><font class=blackfnt>Approved Amount</font></td>
                        <td>
                            <asp:TextBox ID="txtApprovedAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="ReqApprovedAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtApprovedAmt"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegApprovedAmt" runat="server"
                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                ControlToValidate="txtApprovedAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                        <td></td>
                        <td></td>
                       </tr> 
                  </table>  
                </td>
            </tr>     
                     
            
              
              
              
              <tr style="background-color: white">
                <td colspan=4 align=center><font class=blackfnt><b>Repair Expenses</b></font></td>
            </tr>
            
            <tr style="background-color: white">
                <td width="15%"><font class=blackfnt>Enter no. of rows</font></td>
                <td colspan=3><asp:TextBox ID="txtAddRowRepairExp" runat=server MaxLength="3" Width="30" BorderStyle="Groove" OnTextChanged="add_rowRepair" AutoPostBack=true></asp:TextBox></td>
            </tr>
            
             <tr style="background-color: white">
                <td colspan=4 align=center>
                <asp:UpdatePanel ID="UpdatePanel5"    UpdateMode="Conditional" RenderMode="Inline" runat="server">
                   <ContentTemplate> 
                     <asp:Panel runat="server" ID="Panel5" Visible="true">

                              <table border="0" Width="100%">
                                 <tr>
                                    <td>
                                                                                
                                        <asp:DataGrid ID="dgRepairExp" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgRepairExp_ItemDataBound">
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
                                                        
                                                        <asp:TemplateColumn HeaderText="Supplier">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSupplier" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqSupplier" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtSupplier"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Description">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDesc" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqDesc" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtDesc"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Qtn.">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtQtn" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqQtn" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtQtn"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegQtn" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtQtn" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Rate/Unit">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtRate_Unit" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqRate_Unit" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRate_Unit"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegRate_Unit" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtRate_Unit" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        <asp:TemplateColumn HeaderText="Bill No.">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRepairBillno" runat="server" CssClass="input" Width="80px" BorderStyle="Groove" MaxLength="25"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqRepairBillno" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRepairBillno"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn> 
                                                        
                                                         <asp:TemplateColumn HeaderText="Bill Date (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtRepairBilldt" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="reqRepairBilldt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRepairBilldt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVRepairBilldt" runat="server" ControlToValidate="txtRepairBilldt"
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
                                                            <asp:TextBox ID="txtRepairAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqRepairAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRepairAmt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegRepairAmt" runat="server"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                    ControlToValidate="txtRepairAmt" Display="Dynamic"></asp:RegularExpressionValidator>
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
                    </asp:Panel>
                   </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddRowRepairExp" EventName="TextChanged" />
                    </Triggers>
                 </asp:UpdatePanel> 
                 
             </td></tr>
             
             
             
             <tr style="background-color: white">
                <td colspan=4 align=center><font class=blackfnt><b>Incidental Deduction details</b></font></td>
            </tr>
            
            <tr style="background-color: white">
                <td width="15%"><font class=blackfnt>Enter no. of rows</font></td>
                <td colspan=3><asp:TextBox ID="txtAddRowIncidental" runat=server MaxLength="3" Width="30" BorderStyle="Groove" OnTextChanged="add_rowIncidental" AutoPostBack=true></asp:TextBox></td>
            </tr>
            
             <tr style="background-color: white">
                <td colspan=4 align=center>
                <asp:UpdatePanel ID="UpdatePanel6"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
                   <ContentTemplate> 
                     <asp:Panel runat="server" ID="Panel6" Visible="true">

                              <table border="0" Width="100%">
                                 <tr>
                                    <td>
                                    
                                    <asp:DataGrid ID="dgIncidental" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%"  OnItemDataBound="dgIncidental_ItemDataBound">
                                                    <Columns >
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
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Date">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtIncdt" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="reqIncdt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtIncdt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVIncdt" runat="server" ControlToValidate="txtIncdt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Trip Period From (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtIncTripFrom" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="reqIncTripFrom" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtIncTripFrom"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVIncTripFrom" runat="server" ControlToValidate="txtIncdt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Trip Period To (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtIncTripTo" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="reqIncTripTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtIncTripTo"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVIncTripTo" runat="server" ControlToValidate="txtIncdt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Voucher No.">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtVoucherNo" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="25"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqVoucherNo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtVoucherNo"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn> 
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Voucher Date (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtVoucherDt" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="reqVoucherDt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtVoucherDt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVVoucherDt" runat="server" ControlToValidate="txtVoucherDt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Recd. Date(dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtRecvDt" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                 <asp:RequiredFieldValidator ID="reqRecvDt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRecvDt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVRecvDt" runat="server" ControlToValidate="txtVoucherDt"
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
                                                            <asp:TextBox ID="txtIncAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqIncAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtIncAmt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegIncAmt" runat="server"
                                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                    ControlToValidate="txtIncAmt" Display="Dynamic"></asp:RegularExpressionValidator>
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
                    </asp:Panel>
                   </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddRowIncidental" EventName="TextChanged" />
                    </Triggers>
                 </asp:UpdatePanel> 
                 
             </td></tr>
              
                
                
                
                <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Spare Details"></asp:Label></td>
            </tr>
            
            
            <tr style="background-color: white">
                <td width="15%"><font class=blackfnt>Enter no. of rows</font></td>
                <td colspan=3><asp:TextBox ID="txtAddrow" runat=server MaxLength="3" Width="30" BorderStyle="Groove" OnTextChanged="add_row" AutoPostBack=true></asp:TextBox></td>
            </tr>
            
                <tr style="background-color: white">
                <td colspan=4 align=center>
                    <%--<asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Enter No. of rows"></asp:Label>
                    <asp:TextBox ID="txtAddrow" runat=server Text="1" BorderStyle="Groove" Width="30" MaxLength="3" CssClass="input" OnTextChanged="add_row" AutoPostBack=true></asp:TextBox>--%>
                     <asp:UpdatePanel ID="UpdatePanel3"       UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel3" Visible="true">
                                    <table border="0" Width="100%">
                                                    <tr>
                                                        <td>
                                                      
                                                        <asp:DataGrid ID="DataGrid2" runat="server" AutoGenerateColumns="False" OnItemDataBound="DataGrid2_ItemDataBound" 
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" ShowFooter=true>
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Partname">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="cboPartName" runat=server>
                                                                </asp:DropDownList>
                                                                <asp:RequiredFieldValidator ID="reqPartName" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboPartName"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Quantity">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtQty" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="6"  Text="0" OnTextChanged="SpareCalc"  AutoPostBack=true></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqQty" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtQty"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegQty" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtQty" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Rate">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRate" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="6" Text="0" OnTextChanged="SpareCalc" AutoPostBack=true></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqRate" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRate"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegtxtRate" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtRate" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAmt" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="6" Text="0" ReadOnly="true"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRate"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegtxtAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            
                                                            
                                                            </ItemTemplate>
                                                            
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                               <%-- <FooterTemplate>
                                                                    <asp:TextBox ID="txtTotalAmt" EnableViewState="true" CssClass="input" runat="server" BorderStyle="groove" Width="100px" ReadOnly ="true" > </asp:TextBox>
                                                                </FooterTemplate>--%>
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Remark">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemark" runat="server"  Width="250px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
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
                
                </asp:Panel>
                   </ContentTemplate>
                   <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddrow" EventName="TextChanged" />
                    </Triggers>
                 </asp:UpdatePanel>
                </td>
            </tr>
           
           
           
           

         
         
         
         
             <tr style="background-color: white">
                <td colspan=4 align=center><font class=blackfnt><b>Verifying Authorities</b></font></td>
            </tr>
            
            
             <tr style="background-color: white">
                <td colspan=4>
                 <table cellspacing="1" cellpadding="3" style="width: 100%" align=center class="boxbg" border="0">
            
                    <tr style="background-color: white">
                        <td align=center><asp:TextBox ID="txtPreparedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align=center><asp:TextBox ID="txtCheckedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align=center><asp:TextBox ID="txtApprovedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align=center><asp:TextBox ID="txtAuditedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                    </tr> 
                    
                    <tr style="background-color: white">
                        <td align=center><font class=blackfnt>Prepared By</font></td>
                        <td align=center><font class=blackfnt>Checked By</font></td>
                        <td align=center><font class=blackfnt>Apporved By</font></td>
                        <td align=center rowspan=2><font class=blackfnt>Audited By</font></td>
                    </tr> 
                    <tr style="background-color: white">
                        <td align=center><font class=blackfnt>Fleet Accounts</font></td>
                        <td align=center><font class=blackfnt>Fleet Manager</font></td>
                        <td align=center><font class=blackfnt><b>HOD</b></font></td>
                    </tr> 
                    
                  </table>
                </td>
               </tr>     
               
     </table>
    
     <%--</asp:Panel>
                   </ContentTemplate>
                   <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddrow" EventName="TextChanged" />
                    </Triggers>
                 </asp:UpdatePanel>--%>
     
    <%--  <p align="center">--%>
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="SubmitData" />
   <%--   </p>--%>
   
        </p>


</asp:Content> 
