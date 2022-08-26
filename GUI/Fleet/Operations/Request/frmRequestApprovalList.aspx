<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmRequestApprovalList.aspx.cs" Inherits="Request_frmRequestApprovalList"%>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Requests >> Approval/Confirmation >> List</asp:Label>
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
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      
      
      
      <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="100%">
            
            <tr bgcolor="white">
                <td style="height:19px">
                     <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="1" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" OnItemDataBound="DataGrid1_ItemDataBound" >
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                        <Columns>
	                    <asp:TemplateColumn HeaderText="Select">
	                        <ItemTemplate>
	                            <asp:CheckBox ID="chksel"  runat="server"/>
	                        </ItemTemplate>
	                     </asp:TemplateColumn>
	                     
	                      <asp:TemplateColumn HeaderText="Req.ID">
	                        <ItemTemplate>
	                            <asp:TextBox ID="txtReqId" runat="server" BorderStyle="Groove" Width="90px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                        </ItemTemplate>
	                      </asp:TemplateColumn>
	                      
	                      <asp:TemplateColumn HeaderText="Req. By">
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
	                            <asp:TextBox ID="txtStDt" runat="server" BorderStyle="Groove" Width="60px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                        </ItemTemplate>
	                      </asp:TemplateColumn>
	                      
	                      <asp:TemplateColumn HeaderText="End date">
	                        <ItemTemplate>
	                            <asp:TextBox ID="txtEdDt" runat="server" BorderStyle="Groove" Width="60px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                        </ItemTemplate>
	                      </asp:TemplateColumn>
	                      
	                      <%-- <asp:TemplateColumn HeaderText="Passengers">
	                        <ItemTemplate>
	                            <asp:TextBox ID="txtPassNo" runat="server" BorderStyle="Groove" Width="30px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                        </ItemTemplate>
	                      </asp:TemplateColumn>--%>
	                      
	                      
	                       <asp:TemplateColumn HeaderText="Vehicle Type">
	                        <ItemTemplate>
	                            <asp:TextBox ID="txtVehType" runat="server" BorderStyle="Groove" Width="75px" ReadOnly="true" BorderColor="white" BorderWidth="0"></asp:TextBox>
	                        </ItemTemplate>
	                      </asp:TemplateColumn>
	             
	                    </Columns>
	                </asp:datagrid>&nbsp;
	                <asp:Label ID="lblError" runat=server ForeColor=red CssClass="blackfnt"></asp:Label>
		       </td>
            </tr>
        </table>
        <table border="0">
            <tr>
                <td>
                    <asp:Button ID="btnConfirm" runat="server" Text="Confirm" OnClick="SubmitData_Confirm" Width="87px" /><%--OnClick="btnSave_Click"--%>
                    <asp:Button ID="btnReject" runat="server" Text="Reject" OnClick="SubmitData_Reject"  Width="87px" />
               </td>
            </tr>
        </table>            
      
    <br />


</asp:Content> 


