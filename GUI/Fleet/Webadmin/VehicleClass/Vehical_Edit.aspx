<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Vehical_Edit.aspx.cs" Inherits="GUI_WebAdmin_Class_Vihical_Master_Edit" %>

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
              <font class="bluefnt"><strong> &gt; Vehicle Class Master</strong> </font></td>
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

    <asp:GridView ID="gvVihical" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="dgHeaderStyle" OnRowCommand="dg_RowCommand" DataKeyNames="ClassId" CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="60%">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="ClassId" DataNavigateUrlFormatString="~/WebAdmin/Class/Vehical_Add.aspx?id={0}" DataTextField="ClassId" DataTextFormatString="- Edit -">
            <ItemStyle CssClass="bluelink" ForeColor="Blue" />
            </asp:HyperLinkField>
            <asp:BoundField HeaderText="Vehicle Class Code" DataField="ClassId" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Vehicle Class Name" DataField="Class_name" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Active" DataField="ActiveFlag" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle CssClass="dgHeaderStyle" />
    </asp:GridView>
    &nbsp;</center>
</asp:Content>