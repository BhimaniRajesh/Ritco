<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ListAll.aspx.cs" Inherits="GUI_admin_VehicleMaster_ListAll" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%; height: 228px">
    	<tr> 
          <td style="height: 1px"><a href=""><font class="blklnkund"><strong>Module</strong></font></a>
		  
	        &gt; <a href=""><font class="blklnkund"><strong>Administrator </strong></font></a>

            &gt; <a href=""><font class="blklnkund"><strong>Business Partners</strong></font></a>

		  <font class="bluefnt"><strong> &gt; 
		  Vehicle Listing</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
        </tr>
        <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>--%>

        <tr> 
          <td align="right" style="height: 3px"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
        </tr>
          <tr>
              <td align="right" style="height: 392px">
              <br />
        
        <table border="0" cellspacing="1" cellpadding="3" align="center" class="boxbg">
            <tr bgcolor="#FFFFFF">
	        <td><font class="blackfnt"><b>Vehicle Listing : &nbsp;</b></font></td>
	        <td width="100"><font class="blackfnt">All</font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td><font class="blackfnt"><b>Download : &nbsp;</b></font></td>
                <td align="right">
                        <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True">XLS</asp:LinkButton>
                        </td>
            </tr>
        </table> 
        <br /><br />
        
        <table border="0" cellpadding="0" cellspacing="1" align="center" style="width: 783px" >
        <tr>
            <td >
                <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="true" AllowSorting="true"
                            AutoGenerateColumns="false" BorderColor="#8ba0e5" BorderWidth="1" CellPadding="5"
                            CellSpacing="1" EmptyDataText="No Records Found..." HeaderStyle-CssClass="dgHeaderStyle"
                            OnPageIndexChanging="pgChange" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="30" Width="100%" CssClass="blackfnt">
                            <Columns>
                                <asp:BoundField DataField="Sr. No" HeaderText="Sr. No">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vendorcode" HeaderText="Vendor Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VEHNO" HeaderText="Vehicle No.">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VEHMODEL" HeaderText="Vehicle Model">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VEHMADEBY" HeaderText="Vehicle Make">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <HeaderStyle CssClass="bgbluegrey" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                             
                            </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                </td>
        </tr>
        </table>       
              </td>
          </tr>
          <tr>
              <td align="right">
              </td>
          </tr>
          </table> 
         </td> 
         </tr> 
        </table>
        <br /> 
        <br /><br />

</asp:Content>

