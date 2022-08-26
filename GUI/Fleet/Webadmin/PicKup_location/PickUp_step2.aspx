<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PickUp_step2.aspx.cs" Inherits="GUI_WebAdmin_PicKup_location_PickUp_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr> 
		<td>&nbsp;</td>
	  </tr>
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
						<tr> 
						  
            <td height="30"><font class="blackfnt"><strong>
              Masters Module</strong></font>
              <font class="bluefnt"><strong> &gt; Pickup location Master</strong> </font></td>
						</tr>
						<tr> 
						  <td class="horzblue"></td>
						</tr>
						<tr> 
							  <td>  </td>
							</tr>

        					<tr> 
         					 <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
							 </tr>
        
      						 <tr> 
							  <td>  </td>
							</tr>
            </table></td>
        </tr>
      </table>
<center>

    <asp:GridView ID="gvVehicalPart" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="dgHeaderStyle" OnRowCommand="dg_RowCommand" DataKeyNames="pickup_loccode" CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="60%">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="pickup_loccode" DataNavigateUrlFormatString="PickUp_step1.aspx?id={0}" DataTextField="pickup_loccode" DataTextFormatString="- Edit -">
            <ItemStyle CssClass="bluelink" ForeColor="Blue" />
            </asp:HyperLinkField>
            <%--<asp:BoundField HeaderText="Pickup Location Code" DataField="pickup_loccode" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>--%>
            <asp:BoundField HeaderText="Pickup Location Name" DataField="pickup_locname" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
             <asp:BoundField HeaderText="City Name" DataField="City_Code" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Active" DataField="ActiveFlag" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
          <%-- <asp:TemplateField>
            <ItemTemplate>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                        Text="X" OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                                    </asp:LinkButton>
                                 </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Wrap="False" />
            </asp:TemplateField>--%>
        </Columns>
        <HeaderStyle CssClass="dgHeaderStyle" />
    </asp:GridView>
    &nbsp;</center>
</asp:Content>