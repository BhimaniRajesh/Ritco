<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CCMStep3.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_CCMStep3"
    Title="Untitled Page" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript">
    
    function btnmatrixClick()
    {
        if(!confirm("Current Changes will be Discarted. Are you want to continue ??"))
            return false;
        else
            return true;
    }
    
    
    function btnsubmitClick()
    {
        return true;
    }
    // Inner Function to Ropund upto defined decimal places, returns string
	function roundNumber(num, dec) 
	{
	
	    if(num=="." || num==".0" || num=="0" || num=="0." || num=="" || !num)
	        return "0.00";
	     
	    var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
	           
        var len=0;
        var number=result.toString();
        len=number.length;
        
        if(number=="." || number==".0" || number=="0" || number=="0." || num=="" || !num)
	        return "0.00";
	        
        if(number.indexOf('.') == parseInt(len - 2) && len>=2)
        {
            number=number + "0";
        }
        else if(number.indexOf('.') == parseInt(len - 1))
        {
            number = number + "00";
        }
        else if(number.indexOf('.')== -1)
        {
            number = number + ".00";
        }
        
        	return number;    
    }
    </script>
    <asp:Panel runat="server" Width="10in">
    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
        
    <cust:CustInfo runat="server" ID="cstheader" />
        <asp:Table ID="tblmain" runat="server" Width="100%" CssClass="boxbg" CellSpacing="1">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell Font-Bold="true" ColumnSpan="2">
                        Step-3 Other Charges
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite" runat="server" ID="trlist">
                <asp:TableCell Width="400px">
                    <asp:Label ID="lbllistname" runat="server" CssClass="blackfnt"></asp:Label>    
                </asp:TableCell>
                <asp:TableCell>
                    <asp:DropDownList ID="ddllist" OnSelectedIndexChanged="ddllist_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="blackfnt" DataValueField="codeid" DataTextField="codedesc"></asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite" runat="server" ID="TableRow1">
                <asp:TableCell Width="400px">
                    Charge at time of   
                </asp:TableCell>
                <asp:TableCell>
                    <asp:DropDownList ID="ddlchargetime" OnSelectedIndexChanged="ddllist_SelectedIndexChanged" AutoPostBack="true" runat="server" CssClass="blackfnt" DataValueField="codeid" DataTextField="codedesc">
                        <asp:ListItem Value="BKG">Booking</asp:ListItem>
                        <asp:ListItem Value="DEL">Delivery</asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trgrid" runat="server" CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Left">
                    <asp:GridView ID="grvcharges" runat="server" HorizontalAlign="Left" BorderWidth="0"
                        CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" Width="80%"
                        CssClass="boxbg" BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                        PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                        PagerSettings-LastPageText="[Last]" OnRowDataBound="grvcharges_RowDataBound"
                        EmptyDataText="No Records Found...">
                        <Columns>
                            <asp:TemplateField HeaderText="Charge Name" HeaderStyle-CssClass="blackfnt">
                                <HeaderStyle Font-Bold="true" />
                                <ItemStyle BackColor="White" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label ID="lblchargename" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"chargename") %>' CssClass="blackfnt"></asp:Label>
                                    (<asp:Label ID="Label1" runat="server" Font-Bold="true" Text='<%# DataBinder.Eval(Container.DataItem,"operator") %>' CssClass="blackfnt"></asp:Label>)
                                    <asp:HiddenField ID="hdnstatuscode" Value='<%# DataBinder.Eval(Container.DataItem,"activeflag") %>'
                                        runat="server" />
                                    <asp:HiddenField ID="hdncodeid" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode") %>'
                                        runat="server" />
                                </ItemTemplate>
                                <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                <FooterTemplate>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText="Charge Rate">
                                <ItemStyle BackColor="White" HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtcharge" Text='<%# DataBinder.Eval(Container.DataItem,"chargerate") %>'
                                        Style="text-align: right;" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                        runat="server" onblur="javascript:return this.value=roundNumber(this.value,2)" MaxLength="10" CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                     <asp:Button ID="btnmatrix" runat="server" Text="Matrix" CssClass="blackfnt" OnClick="btnmatrix_Click" OnClientClick="javascript:return btnmatrixClick()" />   
                                     <asp:HiddenField ID="hdnvarybyloc" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"varybyloc") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trsubmit" runat="server" CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                    <asp:Button ID="btnsubmit" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                        OnClientClick="javascript:return btnsubmitClick()" CssClass="blackfnt" OnClick="btnsubmit_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
                </ContentTemplate>
    </asp:UpdatePanel>

    </asp:Panel>
    <asp:HiddenField ID="hdnbasedon" runat="server" />
    <asp:HiddenField ID="hdncustcode" runat="server" />
    <asp:HiddenField ID="hdncontractid" runat="server" />
    
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
