<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Part_Edit.aspx.cs" Inherits="GUI_WebAdmin_Part_Vehical_Part_Edit" %>

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
              Vehicle Part Master</strong></font>
              </td>
						</tr>
						<tr> 
						  <td class="horzblue"></td>
						</tr>
						<tr> 
							  <td>  </td>
							</tr>

        					<%--<tr> 
         					 <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../../images/back.gif" border="0" alt="" /></a></td>
							 </tr>--%>
        
      						 <tr> 
							  <td>  </td>
							</tr>
            </table></td>
        </tr>
      </table>
      <br>


    <asp:GridView  ID="gvVehicalPart" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="dgHeaderStyle" OnRowCommand="dg_RowCommand" DataKeyNames="PartId" CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="40%">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="PartId" DataNavigateUrlFormatString="~/GUI/Fleet/WebAdmin/VehiclePart/Part_Add.aspx?id={0}" DataTextField="PartId" DataTextFormatString="- Edit -">
            <ItemStyle CssClass="bluelink" ForeColor="Blue" />
            </asp:HyperLinkField>
            <asp:BoundField HeaderText="Part Code" DataField="PartId" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Part Name" DataField="PartName" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Active" DataField="ActiveFlag" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle CssClass="dgHeaderStyle" />
    </asp:GridView>
    
</asp:Content>