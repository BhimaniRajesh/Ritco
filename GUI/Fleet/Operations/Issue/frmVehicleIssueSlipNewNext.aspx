<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="frmVehicleIssueSlipNewNext.aspx.cs" Inherits="Issue_frmVehicleIssueSlipNewNext" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript" type="text/javascript">
       
        function nwOpen(mNo)
        {
            window.open("popupcustcode.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        
        </script>


<p align="center">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Issue New  with Request</asp:Label>
               <%-- <hr align="center" size="1" color="#8ba0e5">--%>
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
<p align="center">
      <table cellspacing="1" cellpadding="3" style="width: 95%" align=center class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor=red></asp:Label></td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="NEW TRIP SHEET FORM"></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Trip Sheets Id</font>
                </td>
                <td align="left">
                   <font class=blackfnt color=red>< System generated ></font>
                </td>
                <td align="left">
                <font class=bluefnt>Trip Sheet Date</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueDt" runat=server CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            
            <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Manual Trip Sheet No.</font>
                </td>
                <td align="left" colspan=3>
                   <font class=blackfnt >
                   <asp:Label ID="lblManualTripSheetNo" runat=server CssClass="blackfnt"></asp:Label>
                   </font>
                </td>
                </tr>
                
                
                
                
               <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt>Start Location</font>
                </td>
                 <td align="left" >
                  <font class=bluefnt>
                    <asp:TextBox ID="txtStartLoc" runat=server BorderStyle="Groove" Width="50" MaxLength="5" CssClass="input" ReadOnly=true></asp:TextBox>
                  </font>
                </td>
                
                 <td align="left" >
             <%--     <font class="blackfnt" color=red>*</font>--%> <font class=bluefnt>End Location</font>
                </td>
                 <td align="left" >
                  <font class=bluefnt>
                  <asp:TextBox ID="txtEndLoc" runat=server BorderStyle="Groove" Width="50" MaxLength="5" CssClass="input" OnTextChanged="CheckLocation" AutoPostBack="true"></asp:TextBox>
                  <input id="btnPopupLoc" type="button" value="..." name="custpup12" runat="server" />
                  <asp:UpdatePanel ID="UpdatePanelEndLoc" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="LblLocError" runat=server CssClass="balckfnt" ForeColor=red></asp:Label>
                     </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtEndLoc" EventName="TextChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                  
                  <asp:RequiredFieldValidator ID="ReqEndLoc" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtEndLoc"></asp:RequiredFieldValidator>
                  </font>
                </td>
                
            </tr>    
              
                
                
                
                
                
            
            <tr style="background-color: white">
                <td colspan=4 align=center>
                <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="100%">
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
	                                    <asp:RadioButton ID="chksel"  runat="server"/>
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
        	                      
	                               <%--<asp:TemplateColumn HeaderText="Passengers">
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtPassNo" runat="server" BorderStyle="Groove" Width="30px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>--%>
        	                      
        	                      
	                               <asp:TemplateColumn HeaderText="Vehicle Type" >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtVehType" runat="server" BorderStyle="Groove" Width="75px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>
	                              
	                              <%--<asp:TemplateColumn HeaderText="Vehicle No." >
	                                <ItemTemplate>
	                                    <asp:DropDownList ID="cboVehno" runat=server Width="90px"></asp:DropDownList>
	                                </ItemTemplate>
	                              </asp:TemplateColumn>--%>
        	             
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
                  <font class=bluefnt>Select Vehicle No.</font>
                </td>
                <td align="left"  colspan="3">
                   <font class=blackfnt >
                    <asp:DropDownList ID="cboVehno" runat=server  AutoPostBack="true"  OnSelectedIndexChanged="cboVehno_SelectedIndexChanged" ></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="ReqVehno" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboVehno" ValidationGroup="main"></asp:RequiredFieldValidator>
                   </font>
                </td>
                
               <%-- <td align="left" >
                  <font class=bluefnt>Select Driver</font>
                </td>
                <td align="left">
                     <asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                
                   <font class=blackfnt >
                    <asp:DropDownList ID="cboDriver" runat=server OnSelectedIndexChanged="RetrieveDriverDataInfo" AutoPostBack=true></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="ReqDriver" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboDriver"></asp:RequiredFieldValidator>
                   </font>
                   
                          </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboVehno" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   
                </td>--%>
                
            </tr>
            
            
            <tr style="background-color: white">
            
            <td align="left" >
                  <font class=bluefnt>Select Driver1</font>
                </td>
                <td align="left">
                     <asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                
                   <font class=blackfnt >
                    <asp:DropDownList ID="cboDriver1" runat=server OnSelectedIndexChanged="RetrieveDriverDataInfo1" AutoPostBack="true" ></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="ReqDriver1" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboDriver1" ValidationGroup="main"></asp:RequiredFieldValidator>
                   </font>
                   
                          </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboVehno" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   
                </td>
            
             <td align="left" >
                  <font class=bluefnt>Select Driver2</font>
                </td>
                <td align="left">
                     <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                
                   <font >
                    <asp:DropDownList ID="cboDriver2" runat=server    OnSelectedIndexChanged="RetrieveDriverDataInfo2" AutoPostBack="true"></asp:DropDownList>
              <%--      <asp:RequiredFieldValidator ID="ReqDriver2" runat="server" Display="Dynamic" Text="!" ControlToValidate="cboDriver2"></asp:RequiredFieldValidator>--%>
                   </font>
                   
                          </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboVehno" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   
                </td>
            
            </tr>
            
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Driver1 License No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                     <asp:UpdatePanel ID="UpdatePanel13" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="lblLicno" runat=server CssClass="balckfnt"></asp:Label>
                     </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboDriver1" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   </font>
                </td>
                
                
                
                 <td align="left" >
                  <font class=bluefnt>Driver2 License No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                     <asp:UpdatePanel ID="UpdatePanel5" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="lblLicnoD2" runat=server CssClass="balckfnt"></asp:Label>
                     </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboDriver2" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   </font>
                </td>
                
                </tr>
                
                
                
                
                
                
                
                 <tr style="background-color: white">
                <td align="left" >
                  <font class=bluefnt> Driver1 License Valid upto</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                   <asp:Label ID="lblValidDt" runat=server CssClass="balckfnt"></asp:Label>
                    </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboDriver1" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   </font>
                </td>
                  <td align="left" >
                  <font class=bluefnt> Driver2 License Valid upto</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:UpdatePanel ID="UpdatePanel6" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                   <asp:Label ID="lblValidDtD2" runat=server CssClass="balckfnt"></asp:Label>
                    </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboDriver2" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel> 
                   </font>
                </td>
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Starting Km. Reading</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                     <asp:TextBox ID="txtStartKM" runat=server BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="reqStartKM" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtStartKM" ValidationGroup="main"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegStartKM" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtStartKM" Display="Dynamic"></asp:RegularExpressionValidator>
                    </font>
                </td>
                <td align="left" >
                  <font class=bluefnt>Fuel Filled Ltrs.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:TextBox ID="txtFuel" runat=server BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="ReqFuel" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtFuel" ValidationGroup="main"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegFuel" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtFuel" Display="Dynamic"></asp:RegularExpressionValidator>

                   
                    </font>
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
                      <asp:RequiredFieldValidator ID="ReqCategory" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlCategory" ValidationGroup="main"></asp:RequiredFieldValidator>
                   
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
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
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
                                <asp:RequiredFieldValidator ID="ReqMarket" runat="server" Display="Dynamic" Visible="false"    Text="!" ControlToValidate="ddlMarket" ValidationGroup="main"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtCustCode" AutoPostBack="true"  runat="server" Width="100px"   
                                MaxLength="4" OnTextChanged="txtCustCode_TextChanged1" ></asp:TextBox>&nbsp;
                            <asp:Label ID="lblPopup"    Visible="false" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(2)">...</a>'
                                Width="14px"></asp:Label>
                                 <asp:RequiredFieldValidator ID="ReqCustCode" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCustCode" ValidationGroup="main"></asp:RequiredFieldValidator>
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
               
     </table>
     
       <br/>
      <table cellspacing="1" cellpadding="3" style="width: 95%" align=center class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan=4 align=center><font class=blackfnt><b>Details of Advance Taken</b></font></td>
            </tr>
            
            <%--<tr style="background-color: white">
                <td width="15%"><font class=blackfnt>Enter no. of rows</font></td>
                <td colspan=3><asp:TextBox ID="txtAddRowAdv" runat=server MaxLength="3" Text="1"  ReadOnly=true Width="30" BorderStyle="Groove" OnTextChanged="add_rowAdv" AutoPostBack=true></asp:TextBox></td>
            </tr>--%>
            
             <tr style="background-color: white">
                <td colspan=4 align=center>
                <%-- <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel1" Visible="true">--%>
                              <table border="0" Width="100%">
                                 <tr>
                                    <td>
                                    
                                    <asp:DataGrid ID="dgAdvanceDet" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" ><%--OnItemDataBound="dgAdvanceDet_ItemDataBound"--%>
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
                                                                
                                                                <asp:TextBox ID="txtAdvPlace" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <%--<asp:RequiredFieldValidator ID="reqAdvPlace" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvPlace"></asp:RequiredFieldValidator>--%>
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Advance Date (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAdvDt" runat=server MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                  <%--<asp:RequiredFieldValidator ID="reqAdvDt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvDt"></asp:RequiredFieldValidator>--%>
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
                                                            <asp:TextBox ID="txtAdvAmt" runat="server"  Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <%--<asp:RequiredFieldValidator ID="reqAdvAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvAmt"></asp:RequiredFieldValidator>--%>
                                                                <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                       <%-- <asp:TemplateColumn HeaderText="THC No.">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtTHCno" runat="server"  Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                <%--<asp:RequiredFieldValidator ID="reqTHCno" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtTHCno"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>--%>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Branch Code">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBranchCode" runat="server"  Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                <%--<asp:RequiredFieldValidator ID="reqBranchCode" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtBranchCode"></asp:RequiredFieldValidator>--%>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Advance Paid By">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSignature" runat="server"  Width="100px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <%--<asp:RequiredFieldValidator ID="reqSignature" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtSignature"></asp:RequiredFieldValidator>--%>
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
               <%-- </asp:Panel>
                   </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddRowAdv" EventName="TextChanged" />
                    </Triggers>
                 </asp:UpdatePanel>   --%>                                  
                                                        

                </td>
            </tr>
           </table>   
     
     
     
     <br/>
     
      <p align=center><asp:Button ID="btnBack" runat="server" Text="<< Back" OnClick="BackData" />
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="SubmitData" ValidationGroup="main" /></p>
     </p>
        


</asp:Content> 