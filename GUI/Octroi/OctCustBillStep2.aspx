<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="OctCustBillStep2.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
      <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:50%"  align="center">
     <tr  bgcolor="white"  style="height:25px">
        <td style="width: 209px"> <font class="blackfnt">Customer</font> 
        </td>
       
        <td>
         <font class="blackfnt">
             <asp:Label ID="Label1" runat="server" Text="Label" Width="263px"></asp:Label></font></td>
     </tr>
     </table>
     
     <br />
     <br />
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:80%"  align="center">
     <tr  bgcolor="white"  style="height:25px">
        <td style="width: 111px"><font class="blackfnt">Bill Number</font> </td>
        <td style="width: 195px"><font class="blackfnt" color="red" >System Generated...</font></td>
        <td style="width: 188px"><font class="blackfnt">Bill Date</font></td>
        <td>
            <asp:TextBox ID="txtbgndt" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtbgndt"></asp:RequiredFieldValidator></td>
     </tr>
     <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Party name</font></td>
       <td>  <font class="blackfnt">
           <asp:Label ID="LblPTMSCD" runat="server" Text="Label" Width="257px"></asp:Label></font></td>
        <td><font class="blackfnt">Billing Party Address</font></td>
        <td></td>
     </tr>
     <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Generated at location</font></td>
       <td><font class="blackfnt"><%=Session["brcd"].ToString() %></font>
           </td>
        <td><font class="blackfnt">Bill Submission at</font></td>
         <td>
             <asp:TextBox ID="txtbillsubloc" runat="server"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txtbillsubloc"></asp:RequiredFieldValidator></td>
     </tr>
      <tr  bgcolor="white" style="height:25px">
      <td><font class="blackfnt">Generated for location</font></td>
       <td><font class="blackfnt"><%=Session["brcd"].ToString() %></font>
           </td>
        <td><font class="blackfnt">Bill Collection at</font></td>
         <td>
             <asp:TextBox ID="txtbillcolloc" runat="server"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtbillcolloc"></asp:RequiredFieldValidator></td>
     </tr>
      <tr  bgcolor="white" style="height:25px">
      <td style="height: 25px"><font class="blackfnt">Bill Amount</font></td>
       <td style="height: 25px">
           <asp:TextBox ID="txtbillamt" runat="server" Columns="10" MaxLength="10"></asp:TextBox></td>
        <td style="height: 25px"><font class="blackfnt">Due Date</font></td>
         <td style="height: 25px">
             <asp:TextBox ID="txtduedate" runat="server"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtduedate"></asp:RequiredFieldValidator></td>
     </tr>
      <tr  bgcolor="white" style="height:25px">
      <td style="height: 25px"></td>
       <td style="height: 25px"></td>
        <td style="height: 25px"></td>
         <td style="height: 25px"></td>
     </tr>
     </table>
      <br />
        &nbsp;<table border="0" cellpadding="1" cellspacing="1" class="boxbg"  align="center">
           
            <tr bgcolor="white">
               <td align="left" style="width: 91px; height: 40px;" ><font class="bluefnt">
                   Enter Row No *</font></td><td style="height: 40px" >
                   <asp:TextBox ID="roww" runat="server" Width="40px" BorderStyle="Groove" ></asp:TextBox></td><td style="width: 63px; height: 40px" >
                        <asp:LinkButton ID="btnAdd" runat="server" Text="Add Row" CausesValidation="false" OnClick="btnAdd_Grid">
                        </asp:LinkButton>
                   </td>
             </tr>
         </table>
          <br />
          <br />
            <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
                 <ContentTemplate>
                    <center>
                         <asp:datagrid id="DataGrid1" runat="server" AllowPaging="false" PageSize="1000" AutoGenerateColumns="False" CellPadding="1" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="90%">
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
			            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" />
                        <Columns>
				           <asp:TemplateColumn HeaderText="Sr. No.">
						        <ItemTemplate>
                                 <center>
                                  <font class="blackfnt"> <%# Container.ItemIndex+1 %></font>
                                 </center>
						        </ItemTemplate>
				            </asp:TemplateColumn>
				            <asp:TemplateColumn HeaderText="Dock NO">
						        <ItemTemplate>
						        <asp:TextBox ID="txtdockno" runat="server" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="OnDocketNOChange" Text='<%# DataBinder.Eval(Container.DataItem, "dockno")%>'></asp:TextBox>
						        
	                                <%--<atlas:AutoCompleteExtender runat="server" ID="Extender1">
                                   <%-- <atlas:AutoCompleteProperties Enabled="true"
                                   TargetControlID="txtdockno"
                                    ServiceMethod="GetOctroi_dockno_AutoComplete"
                                    ServicePath="../Services/AutoComplete.asmx" 
                                         MinimumPrefixLength="1"
                                         
                                    />
                                    
                                </atlas:AutoCompleteExtender>--%>
                                
                                <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server">
                            </ajaxToolkit:AutoCompleteExtender>
                                
                                        
						        </ItemTemplate>
				            </asp:TemplateColumn>
				             <asp:TemplateColumn HeaderText="Declared Value">
				                <ItemTemplate>
				                    <asp:label id="txtdeclval" runat="server" BorderStyle="Groove"   Width="30"  ></asp:label>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				              <asp:TemplateColumn HeaderText="Octroi AMt.">
				              <ItemTemplate>
                                    <asp:TextBox ID="txtoctamt" runat="server" BorderStyle="Groove"  Columns="8"  AutoPostBack="true" OnTextChanged="Onoctdatacal" ></asp:TextBox>						               </ItemTemplate>
				             </asp:TemplateColumn>
				             <asp:TemplateColumn HeaderText="Octroi(%)">
				                <ItemTemplate>
				                    <asp:TextBox ID="txtoctper" runat="server" BorderStyle="Groove" Columns="8" ></asp:TextBox>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				              
				              <asp:TemplateColumn HeaderText="Clearance Charges">
				                <ItemTemplate>
				                    <asp:TextBox ID="txtclearchrg" runat="server" BorderStyle="Groove" Columns="8"   AutoPostBack="true" OnTextChanged="Onoctdatacal" ></asp:TextBox>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				             <asp:TemplateColumn HeaderText="Processing Charges(%)">
				                <ItemTemplate>
				                    <asp:TextBox ID="txtprochrg_per" runat="server" BorderStyle="Groove" Columns="8"   AutoPostBack="true" OnTextChanged="Onoctdatacal" ></asp:TextBox>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				             <asp:TemplateColumn HeaderText="Processing Charges">
				                <ItemTemplate>
				                    <asp:TextBox ID="txtprochrg" runat="server" BorderStyle="Groove" Columns="8"   AutoPostBack="true" OnTextChanged="Onoctdatacal" ></asp:TextBox>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				             <asp:TemplateColumn HeaderText="Other Charges">
				                <ItemTemplate>
				                    <asp:TextBox ID="txtotchg" runat="server" BorderStyle="Groove" Columns="8"  AutoPostBack="true" OnTextChanged="Onoctdatacal" ></asp:TextBox>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				             <asp:TemplateColumn HeaderText="Total">
				                <ItemTemplate>
				                    <asp:TextBox ID="txttotalamt" runat="server" BorderStyle="Groove" Columns="8" ></asp:TextBox>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				             <asp:TemplateColumn HeaderText="Reciept NO">
				                <ItemTemplate>
				                    <asp:TextBox ID="txtrcptno" runat="server" BorderStyle="Groove"  Columns="10" ></asp:TextBox>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				             <asp:TemplateColumn HeaderText="Reciept Date ">
				                <ItemTemplate>
				                    <asp:TextBox ID="txtrcptdate" runat="server" BorderStyle="Groove" Columns="12"  ></asp:TextBox>
				                </ItemTemplate>
				             </asp:TemplateColumn>
				        </Columns>
				       </asp:datagrid>
                    </center>
              </ContentTemplate>   
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
              </Triggers>
        
               
            </asp:UpdatePanel>
                  <br />
                  <center>
            <asp:Button ID="Button11"  runat="server" Text="Submit" OnClick="Button11_Click"  /></center>
    </asp:Content>
