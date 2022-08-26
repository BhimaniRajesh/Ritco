<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Citymaster_step2.aspx.cs" Inherits="GUI_WebAdmin_CityMaster_new_Citymaster_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    <div align="left" style="width: 10in">
    <div align="left">
    <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href="../company_structure.aspx"><font class="blklnkund"><b>Company Structure</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>City Master</b></font></div>
    <div align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></div> 
    <br />
    <table border="1" Width="66%" style="border:1px;border-color:#8ba0e5;background-color:#d4e0e7;">
    <tr bgcolor="white" class="balckfnt">
    <td class="blackfnt">
    Select The City Starting From :
    </td>
    <td>
    <asp:UpdatePanel runat="server" id ="Up1">
    <ContentTemplate >
    <asp:DropDownList ID="cmbfiltercity" AutoPostBack="true" runat="server" OnSelectedIndexChanged="cmbfiltercity_SelectedIndexChanged">
        <asp:ListItem>All</asp:ListItem> 
        <asp:ListItem>A</asp:ListItem>
        <asp:ListItem>B</asp:ListItem>
        <asp:ListItem>C</asp:ListItem>
        <asp:ListItem>D</asp:ListItem>
        <asp:ListItem>E</asp:ListItem>
        <asp:ListItem>F</asp:ListItem>
        <asp:ListItem>G</asp:ListItem>
        <asp:ListItem>H</asp:ListItem>
        <asp:ListItem>I</asp:ListItem>
        <asp:ListItem>J</asp:ListItem>
        <asp:ListItem>K</asp:ListItem>
        <asp:ListItem>L</asp:ListItem>
        <asp:ListItem>M</asp:ListItem>
        <asp:ListItem>N</asp:ListItem>
        <asp:ListItem>O</asp:ListItem>
        <asp:ListItem>P</asp:ListItem>
        <asp:ListItem>Q</asp:ListItem>
        <asp:ListItem>R</asp:ListItem>
        <asp:ListItem>S</asp:ListItem>
        <asp:ListItem>T</asp:ListItem>
        <asp:ListItem>U</asp:ListItem>
        <asp:ListItem>V</asp:ListItem>
        <asp:ListItem>W</asp:ListItem>
        <asp:ListItem>X</asp:ListItem>
        <asp:ListItem>Y</asp:ListItem>
        <asp:ListItem>Z</asp:ListItem>
    </asp:DropDownList>
    </ContentTemplate>
    </asp:UpdatePanel> 
    </td>
	
	<td >
            <asp:LinkButton ID="lnkBtnDownloadXLS" CssClass="blackfnt" runat="server" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton>
        </td>
	
	</tr>
    </table> 
    <br />
    <br />
    <asp:UpdatePanel runat ="server" ID ="up2">
    <ContentTemplate>
    <asp:GridView ID="gvVehicalPart" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="dgHeaderStyle" OnRowCommand="dg_RowCommand" DataKeyNames="Location" CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="60%">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Location" DataNavigateUrlFormatString="Citymaster_step1.aspx?id={0}" DataTextField="Location" DataTextFormatString="- Edit -">
            <ItemStyle CssClass="bluelink" ForeColor="Blue" />
            </asp:HyperLinkField>
            <%--<asp:BoundField HeaderText="Pickup Location Code" DataField="pickup_loccode" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>--%>
            <asp:BoundField HeaderText="City Name" DataField="Location" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
             <asp:BoundField HeaderText="State" DataField="State" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Zone" DataField="Zone" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
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
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="cmbfiltercity" EventName="SelectedIndexChanged" />  
    </Triggers> 
    </asp:UpdatePanel> 
    </div> 
</asp:Content>
