<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SaleTarget_Companywise2.aspx.cs" Inherits="REPORT_SaleTarget_Companywise2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">

function OpenWindow(prospectcode)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "pros_reg_detail.aspx?prospectcode="+prospectcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        function OpenWindowSales(empcode)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "Employee_Reg_Detail.aspx?entryby="+empcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
</script>
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Sale Target Company Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
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
            <div align="left">
            <table border="0" cellpadding="3" colspan="2" width="55%" bgcolor="#ffffff" cellspacing="1" class="boxbg">
				<tr bgcolor="#ffffff">
						<td  align="left" width="30%" style="height: 25px">
							<font class="blackfnt"><b>Industry</b></font></td>
						<td  align="left" style="height: 25px">
							<font class="blackfnt">
							<asp:Label ID="lblIndustry" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>
					
					<tr bgcolor="#ffffff">
						<td  align="left" width="45%">
							<font class="blackfnt"><b>Prospect Status</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
							<asp:Label ID="lblStatus" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>

												
					<tr bgcolor="#ffffff">
						<td  align="left" width="42%">
							<font class="blackfnt"><b>Company</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
							<asp:Label ID="lblCompany" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>
					
					<tr bgcolor="#ffffff">
						<td  align="left" width="42%">
							<font class="blackfnt"><b>Period</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
							<asp:Label ID="lblPeriod" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>
					
					</table>
</div>
					<br />
            
    <div align="center">
    
    <asp:GridView ID="GridMonthly" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
    CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  Visible="false"
    AllowPaging="false" PageSize="100" OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false" Width="100%" >

   <Columns>
          <asp:TemplateField  HeaderText="SRNo."  ControlStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
          <ItemStyle CssClass="blackfnt" />
          <ItemTemplate>
          <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
          </asp:Label>
          </ItemTemplate>
          </asp:TemplateField>   
                                                                 
                                                                 
          <asp:TemplateField HeaderText="ProspectID" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
          <ItemStyle CssClass="blackfnt"  Font-Bold="true" HorizontalAlign="Left"/>
          <ItemTemplate>
          <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectId") %>')">                                   
          <%#DataBinder.Eval(Container.DataItem, "prospectcode1")%></a>
          </ItemTemplate>
          </asp:TemplateField>
          
          <asp:TemplateField HeaderText="Name Of Sale Person" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
          <ItemStyle CssClass="blackfnt"  Font-Bold="true"/>
          <ItemTemplate>
          <a href="JavaScript:OpenWindowSales('<%#DataBinder.Eval(Container.DataItem, "empcode") %>')">                                   
          <%#DataBinder.Eval(Container.DataItem, "empname")%></a>
          </ItemTemplate>
          </asp:TemplateField>
                                                                 
         <asp:BoundField DataField="ProspectStatus" HeaderText="Prospect Status"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true"/> 
         
         <asp:BoundField DataField="April" HeaderText="April"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="May" HeaderText="May"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="June" HeaderText="June"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="July" HeaderText="July"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="August" HeaderText="Aug"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="September" HeaderText="Sept"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="October" HeaderText="Oct"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="November" HeaderText="Nov"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="December" HeaderText="Dec"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="January" HeaderText="Jan"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="February" HeaderText="Feb"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="March" HeaderText="March"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="TotalMonthValue" HeaderText="Total"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         
          </Columns>
          
          </asp:GridView>
    
    
    
    
    <asp:GridView ID="GridQuartely" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
    CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  Visible="false"
    AllowPaging="false" PageSize="100" OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false" Width="100%" >

   <Columns>
          <asp:TemplateField  HeaderText="SRNo."  ControlStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
          <ItemStyle CssClass="blackfnt" />
          <ItemTemplate>
          <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
          </asp:Label>
          </ItemTemplate>
          </asp:TemplateField>   
                                                                 
                                                                 
          <asp:TemplateField HeaderText="ProspectID" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
          <ItemStyle CssClass="blackfnt"  Font-Bold="true" HorizontalAlign="Left"/>
          <ItemTemplate>
          <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectId") %>')">                                   
          <%#DataBinder.Eval(Container.DataItem, "prospectcode1")%></a>
          </ItemTemplate>
          </asp:TemplateField>
          
          <asp:TemplateField HeaderText="Name Of Sale Person" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
          <ItemStyle CssClass="blackfnt"  Font-Bold="true"/>
          <ItemTemplate>
          <a href="JavaScript:OpenWindowSales('<%#DataBinder.Eval(Container.DataItem, "empcode") %>')">                                   
          <%#DataBinder.Eval(Container.DataItem, "empname")%></a>
          </ItemTemplate>
          </asp:TemplateField>
                                                                 
         <asp:BoundField DataField="ProspectStatus" HeaderText="Prospect Status"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true"/> 
         
         <asp:BoundField DataField="Quater1" HeaderText="QuaterI"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="Quater2" HeaderText="QuaterII"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="Quater3" HeaderText="QuaterIII"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="Quater4" HeaderText="QuaterIV"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         
         <asp:BoundField DataField="TotalQuaterValue" HeaderText="Total"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         
          </Columns>
          
          </asp:GridView>
          
          
          
          <asp:GridView ID="GridYearly" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
    CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  Visible="false"
    AllowPaging="false" PageSize="100" OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false" Width="100%" >

   <Columns>
          <asp:TemplateField  HeaderText="SRNo."  ControlStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
          <ItemStyle CssClass="blackfnt" />
          <ItemTemplate>
          <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
          </asp:Label>
          </ItemTemplate>
          </asp:TemplateField>   
                                                                 
                                                                 
          <asp:TemplateField HeaderText="ProspectID" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
          <ItemStyle CssClass="blackfnt"  Font-Bold="true" HorizontalAlign="Left"/>
          <ItemTemplate>
          <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectId") %>')">                                   
          <%#DataBinder.Eval(Container.DataItem, "prospectcode1")%></a>
          </ItemTemplate>
          </asp:TemplateField>
          
          <asp:TemplateField HeaderText="Name Of Sale Person" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
          <ItemStyle CssClass="blackfnt"  Font-Bold="true" HorizontalAlign="Left"/>
          <ItemTemplate>
          <a href="JavaScript:OpenWindowSales('<%#DataBinder.Eval(Container.DataItem, "empcode") %>')">                                   
          <%#DataBinder.Eval(Container.DataItem, "empname")%></a>
          </ItemTemplate>
          </asp:TemplateField>
                                                                 
         <asp:BoundField DataField="ProspectStatus" HeaderText="Prospect Status"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true"/> 
         
         <asp:BoundField DataField="Year_no" HeaderText="Year"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         <asp:BoundField DataField="TotalYearValue" HeaderText="Total"  HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left" HeaderStyle-Font-Bold="true"/>
         
          </Columns>
          
          </asp:GridView>
    
    </div>
    </asp:Content>
